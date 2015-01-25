#!/bin/bash
###############################################
# debe girdilerini listeleyen bir girdi ile gecmise donuk debe mobisi olusturmayi saglar.
# eksi sozluk'teki dunun en begenilen entry'lerini mobi yapip kindle'a gonderir.
# 
# Argumanlari:
# - ilk arguman debe girdilerini listeleyen entry id, e.g. #36252692
# - ikinci arguman tarih, e.g., 2013-09-29
# - ucuncu arguman olarak "test" verilirse, sadece mobi dosyasini olusturur ama e-mail olarak gondermez.
# ssgpp_debe_girdisi_to_kindle.sh \#36252692 2013-09-01 test
# ssgpp_debe_girdisi_to_kindle.sh \#36252692 2013-09-01
#
# author: oderin at users sourceforge net
###############################################

###############################################
# ssg++ betiklerinin oldugu klasoru bul
SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

SSGPP_SCRIPTS_DIR="$DIR"
#echo 'SSGPP_SCRIPTS_DIR:' $SSGPP_SCRIPTS_DIR
###############################################

###############################################
# yapilandirma dosyasini oku.
if [ -f ~/.ssgpp/conf/ssgpp_conf.sh ]; then
	source ~/.ssgpp/conf/ssgpp_conf.sh
else
	source $SSGPP_SCRIPTS_DIR/ssgpp_conf.sh
fi
###############################################

###############################################
# ssg++ cli calisma alani
#cd ~/kulucka/ssgpp_workspace 
mkdir -p "$SSGPP_SCRIPTS_DIR/../ssgpp_cli_workspace"
cd "$SSGPP_SCRIPTS_DIR/../ssgpp_cli_workspace"

###############################################

#TARIH=`date +%Y-%m-%d`
TARIH=$2
DOSYA=debe-$TARIH

# resim kucultme icin
source "$SSGPP_SCRIPTS_DIR/ssgpp_debe_util.sh"

if [ ! -f $DOSYA.htm ]; then # if [ ! -f $DOSYA.xml ]; then
#    "$JAVA" -cp $SSGPP_JAR net.sf.ssgpp.console.Shell yürüt istatistikknk [tip=debe] ! başlıkgirdileri ! fork ! dosyabtk [dosya=$DOSYA.xml] \& girdiresimleribtk
    "$JAVA" -cp $SSGPP_JAR net.sf.ssgpp.console.Shell -l yürüt başlıkknk [başlık=$1] ! başlıkgirdileri ! girdibkzları ! genelflt [alan=baslik, değer=ekşi sözlük beta\'ya direniş ekibi, eleme=uyan] ! başlıkgirdileri ! dosyabtk [dosya=$DOSYA.htm]
#istatistikknk [tip=debe] ! başlıkgirdileri ! dosyabtk [dosya=$DOSYA.htm]
fi

if [ -f $DOSYA.htm ]; then
# generate mobi with amazon's KindleGen
# first create debe-$TARIH.opf file that contains the mobi metadata
    "$JAVA" -cp $SSGPP_JAR net.sf.ssgpp.console.OpfGeneratorMain $TARIH    #lib/debe.template.opf $TARIH
# gunun tarihini iceren kapak resmini olustur.
    kapak_olustur
# animasyonlu gif'lerin ilk karesini al.
    gifleri_teklestir
# mobi yarat
    $KINDLEGEN_EXE $DOSYA.opf

# gmail 8MB'den buyuk dosya gonderimine izin vermiyor.
    boyut=`stat -c '%s' $DOSYA.mobi`
    while [ $boyut -ge 6000000 ] # if [ $boyut -ge 6000000 ]; then # 8000000
    do
	echo "UYARI: Dosya boyutu ($boyut) 6 MB'dan büyük. Resimler küçültülecek."; 
	resimleri_kucult
	$KINDLEGEN_EXE $DOSYA.opf		
	boyut=`stat -c '%s' $DOSYA.mobi`
    done

    if [ -f $DOSYA.mobi ]; then
	if [ "$3" != "test" ]; then
	    mobi_gonder
	else
	    echo "mobi dosyası oluşturuldu, gönderilmedi."
	fi
    else
    	echo 'HATA: mobi oluşturulurken bir hata oluştu!'
    fi
else
    echo 'HATA: debe indirilirken bir hata oluştu!'
fi

exit -1;

