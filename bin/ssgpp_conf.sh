#!/bin/bash
###############################################
# 1. java programinin tam yolu, orn. "/opt/jdk1.8.0_25/bin/java"
# java surumu en az 1.7 olmali
JAVA=java


###############################################
# 2. kindlegen programinin tam yolu, orn. "/opt/kindlegen_linux_2.6_i386_v2_9/kindlegen"
# indirmek icin: http://www.amazon.com/gp/feature.html?docId=1000765211
# bunun disinda ImageMagick'nin sagladigi convert ve identify komutlarinin PATH'de olmasi gerekiyor.
# indirmek icin: http://www.imagemagick.org/ (Linux dagitimlarinda paket yoneticisiyle de kurulabilir.)
# (mobi olusturan komutlar icin girilmesi zorunlu) 
KINDLEGEN_EXE=kindlegen


###############################################
# 3. calibre'nin calibre-smtp, ebook-convert programlarini iceren klasor PATH'de degilse eklenmeli
# indirmek icin: http://calibre-ebook.com/download
# export PATH=$PATH:~/calibre-bin/calibre


###############################################
# 4. mobi alim adresi
# (mobi gonderen komutlar icin girilmesi zorunlu) 
KINDLE_EMAIL=kullanici@kindle.com
# usttekinden farkli ise degistirin
DEBE_EMAIL=$KINDLE_EMAIL


###############################################
# 5. mobiler icin e-mail gonderme ayarlari
# Calibre'nin sagladigi calibre-smtp ve ebook-convert komutlarinin PATH'de olmasi gerekiyor.
# indirmek icin: http://calibre-ebook.com/download (Linux dagitimlarinda paket yoneticisiyle de kurulabilir.)
# (mobi gonderen komutlar icin girilmesi zorunlu) 
EMAIL_USERNAME=kullanici
EMAIL_PASSWD="sifreniz"
EMAIL_SENDER=kullanici@gmail.com
EMAIL_SMTP=smtp.gmail.com
EMAIL_PORT=587
EMAIL_ENCRYPTION=TLS


###############################################
# 6. (istege bagli) bir mesaji arguman olarak alan bir uyari komutu. orn. notify-send (Linux/GNOME ile kurulu geliyor.)
UYARMA_PROGRAMI=




###############################################
# burdan asagisina dokunmayin!
###############################################
# ssg++ betiklerinin oldugu klasoru bul
# onceden bulunmadiysa
if [ ! -n "$SSGPP_SCRIPTS_DIR" ]; then
	SOURCE="${BASH_SOURCE[0]}"
	while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
	  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
	  SOURCE="$(readlink "$SOURCE")"
	  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
	done
	DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

	SSGPP_SCRIPTS_DIR="$DIR"
fi
#echo 'SSGPP_SCRIPTS_DIR:' $SSGPP_SCRIPTS_DIR

SSGPP_JAR="$SSGPP_SCRIPTS_DIR/../ssgpp-cli-1.0-SNAPSHOT.jar"
SSGPP_WEB_JAR="$SSGPP_SCRIPTS_DIR/../ssgpp-web-1.0-SNAPSHOT.jar"
###############################################

