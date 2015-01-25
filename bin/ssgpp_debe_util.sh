#!/bin/bash
###############################################
# diger betiklerin ortak kullandigi fonksiyonlar
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

# daha cok debe_gonder gibi
mobi_gonder() {
    		echo "mobi dosyasını gönderiyor..."
 		"$SSGPP_SCRIPTS_DIR/send-file.sh" $DOSYA.mobi $DEBE_EMAIL
# for tests	
#		mv $DOSYA.mobi $DOSYA-sentToKindle.mobi
# 1- mobi dosyasini /shared/gezgin/kulucka/ssgpp_workspace/arsiv/debeler/mobi altina tasi.
 		mv $DOSYA-sentToKindle.mobi arsiv/debeler/mobi/
# 2- html ve resimleri /shared/gezgin/kulucka/ssgpp_workspace/arsiv/debeler/html altina tasi.
 		mv $DOSYA.htm arsiv/debeler/html/
 		mv cache/* arsiv/debeler/html/cache/
 		rm -rf cache
# 3- cron isi icin son-gonderilmis-debe.txt dosyasini yarat (girdinin id'si yazilacak sekilde degistirdim.)
 		"$JAVA" -cp $SSGPP_JAR net.sf.ssgpp.console.Shell yürüt istatistikknk [tip=debe] ! limitflt [adet=1] ! başlıkgirdileri ! alanseçici [alan=id] ! dosyabtk [dosya=son-gonderilmis-debe.txt]
# 4- kapak resmini sil
		rm debe-cover.png
# 5- kindlegen icin olusturulmus dosyalari sil.
		rm $DOSYA.opf toc-$TARIH.htm toc-$TARIH.ncx
}

############################################################
## copy to resimleri_kucult in ssgpp_debe_girdisi_to_kindle.sh ##

#numCalls=0
numBuyukResimler=-1

buyuk_resim_sayisi() {
    #    resimler=`ls -S cache`
    SAVEIFS=$IFS
    IFS=$(echo -en "\n\b")
    
    numBuyukResimler=0
    #for i in $resimler;
    files=cache/*
    for i in $files
    do
	widthResim=`identify -format "%w" "$i"`
	echo "$i : $widthResim"
	if (( widthResim >= 600 )); then
	    echo "*******************"
	    numBuyukResimler=$((numBuyukResimler+1)) # # $((EXPRESSION)) is arithmetic expansion.
	fi
    done
    echo "Buyuk resim sayisi: $numBuyukResimler"
    IFS=$SAVEIFS
}

# resimlerin icinde hem dosya boyutu en buyuk olup hem de genisligi 600'den buyuk bir resim bulup onu kucultup donuyor.
# mobi hala buyuk boyutta ise fonksiyon tekrar cagriliyor. muhtemelen baska genis bir resim (dosya boyutuna gore) kucultulerek devam ediyor.
# bu sekilde tek bir resme yuklenmeden mumkun olan en cok sayida resim 600 pikselden buyuk olarak birakilmaya calisiliyor.
# gerekli mobi boyutu gene de saglanamazsa 600'den daha kucuk olmalarina izin verilerek islem devam ediyor.
resimleri_kucult() {

#    if [ $((numBuyukResimler+1)) -eq 0 ]; then
    buyuk_resim_sayisi
#    fi
    
    numResimler=`ls cache | wc -l`
#    numCalls=$((numCalls+1))
    for i in `seq 1 $numResimler`;
    do
	buyukResim=`ls -S cache | head -n $i | tail -n 1`
	widthBuyukResim=`identify -format "%w" "cache/$buyukResim"`
	echo "$buyukResim : $widthBuyukResim"
	#	if (( (widthBuyukResim < 600) && (numCalls > numBuyukResimler) )) || (( widthBuyukResim >= 600 )); then
	if (( ((widthBuyukResim < 600) && (numBuyukResimler == 0)) || (widthBuyukResim >= 600) )); then	
	    echo "$buyukResim küçültülüyor..."
	    convert "cache/$buyukResim" -resize 50% "cache/$buyukResim"
	    status=$?
	    if [ $status -ne 0 ]; then
		echo "resim küçültmede hata! tanınmayan resim biçimi, silinecek!" >&2
		mkdir -p cache/error
		mv "cache/$buyukResim" cache/error
	    fi
	    break
	fi
    done
}

gifleri_teklestir() {
    echo "resimler tek kare haline getiriliyor..." # uzantisi olmayan gifler taninamadigi icin jpg de olsa tum resimler onceden tek kareli dahi olsa tekrar tek kareli hale getiriliyor.
    numResimler=`ls cache | wc -l`

    for i in `seq 1 $numResimler`;
    do
	gif=`ls cache | head -n $i | tail -n 1`
	echo "cache/$gif[0] >>-->> cache/$gif"
	convert "cache/$gif[0]" "cache/$gif"
    done
}

kapak_olustur() {
    #Address of the watermark file
    WATERMARK="tirelitarih.png"
    echo -n " $TARIH " | convert -background black -fill white -pointsize 100 -gravity center    label:@-   $WATERMARK
    #Retrieve size of the image and divide the lenght by 2
    image="$SSGPP_SCRIPTS_DIR/../res/debe-cover.template.png"   # 'lib/debe-cover.template.png'
    size=`identify -format %[fx:w/1.5] $WATERMARK`
    #Apply the watermark and create a new image in the "watermarked" subfolder
    #composite -gravity southeast -background none \( $WATERMARK -geometry ${size} \) ${image} watermarked/${image}
    composite -gravity north -background none \( $WATERMARK -geometry ${size} \) ${image} debe-cover.png
    rm $WATERMARK # debe-cover.png mobi olusturulduktan sonra silinecek.
    #done
}
########################
