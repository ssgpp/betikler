#!/bin/bash
#
###############################################
# Argumanlar:
# $1 : dosya adi, orn. path/xxx.pdf,.mobi,.txt
# $2 : alicinin e-mail adresi, orn. abc@kindle.com
#
# Gereksinimler:
# - calibre-smtp (calibre ile gelen bir komut satiri programi)
# - ssgpp_conf.sh dosyasindaki e-mail gondermekle ilgili degiskenler (EMAIL_*)
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
# dosyayi gonder
EMAIL_RECEIVER="$2"
DOSYA_NAME_WITH_FULL_PATH="$1"
DOSYA_NAME_WITH_EXT="${DOSYA_NAME_WITH_FULL_PATH##*/}"
DOSYA_EXT="${DOSYA_NAME_WITH_FULL_PATH##*.}"
DOSYA_NAME_NO_EXT="${DOSYA_NAME_WITH_EXT%.*}"
DOSYA_PATH="$(dirname "$DOSYA_NAME_WITH_FULL_PATH")"

#echo 'DOSYA_NAME_WITH_FULL_PATH:' $DOSYA_NAME_WITH_FULL_PATH
#echo 'DOSYA_NAME_WITH_EXT:' $DOSYA_NAME_WITH_EXT
#echo 'DOSYA_EXT:' $DOSYA_EXT
#echo 'DOSYA_NAME_NO_EXT:' $DOSYA_NAME_NO_EXT
#echo 'DOSYA_PATH:' $DOSYA_PATH

calibre-smtp --attachment "$DOSYA_NAME_WITH_FULL_PATH" --subject "$DOSYA_NAME_NO_EXT" --relay "$EMAIL_SMTP" --port $EMAIL_PORT --username "$EMAIL_USERNAME" --password "$EMAIL_PASSWD" --encryption-method "$EMAIL_ENCRYPTION" "$EMAIL_SENDER" "$EMAIL_RECEIVER" ""
mv "$DOSYA_NAME_WITH_FULL_PATH" "$DOSYA_PATH/$DOSYA_NAME_NO_EXT-sentToKindle.$DOSYA_EXT"
###############################################
