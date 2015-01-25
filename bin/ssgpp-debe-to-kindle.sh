#!/bin/bash
###############################################
# eksi sozluk'teki dunun en begenilen entry'lerini mobi yapip kindle'a gonderir.
# 
# Argumanlari:
# - ilk arguman olarak "test" verilirse, sadece mobi dosyasi olusturulur, e-mail gonderilmez.
#
# Gereksinimler:
# - imagemagick (composite, convert programlari)
# - ssgpp_conf.sh dosyasindaki 
#   - kindlegen programi (KINDLEGEN_EXE)
#   - mobi alicisi adresi (KINDLE_EMAIL)
#   - e-mail gondermekle ilgili degiskenler (EMAIL_*), 
#   - ssg++ komut satiri arayuzu (SSGPP_JAR) ve onun yapilandirilmasi (~/.ssgpp/conf/app.properties)
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

# resim kucultme icin
source $SSGPP_SCRIPTS_DIR/ssgpp_debe_util.sh

TARIH=`date +%Y-%m-%d`
DOSYA=debe-$TARIH

###############################################
# ssg++ cli calisma alani
mkdir -p "$SSGPP_SCRIPTS_DIR/../ssgpp_cli_workspace"
cd "$SSGPP_SCRIPTS_DIR/../ssgpp_cli_workspace"

###############################################


ssgpp_debe_to_kindle_main() {

if [ ! -f $DOSYA.htm ]; then # if [ ! -f $DOSYA.xml ]; then
    echo "$JAVA -cp $SSGPP_JAR net.sf.ssgpp.console.Shell yürüt istatistikknk [tip=debe] ! başlıkgirdileri ! debetocgzc  ! dosyabtk [dosya=$DOSYA.htm]"
# debetocgzc template dosyalarindan toc-$TARIH.htm ve toc-$TARIH.ncx dosyalarini olusturuyor.
    "$JAVA" -cp $SSGPP_JAR net.sf.ssgpp.console.Shell yürüt istatistikknk [tip=debe] ! başlıkgirdileri ! debetocgzc ! dosyabtk [dosya=$DOSYA.htm]
fi


if [ -f $DOSYA.htm ]; then
# generate mobi with amazon's KindleGen
# first create debe-$TARIH.opf file that contains the mobi metadata
    "$JAVA" -cp $SSGPP_JAR net.sf.ssgpp.console.OpfGeneratorMain #lib/debe.template.opf
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
	if [ "$1" != "test" ]; then
	    mobi_gonder
	else
	    echo "mobi dosyası oluşturuldu, gönderilmedi."
	fi
    else
    	echo 'HATA: mobi oluşturulurken bir hata oluştu!'
    fi
else
    echo 'HATA: debe html indirilirken bir hata oluştu!'
fi

}

ssgpp_debe_to_kindle_main "$@"

