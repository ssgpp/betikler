#!/bin/bash
###############################################
# Her sabah bilgisayari uyandirma-uyutma betigi
#
# root kullanicisinin crontab'ina her gun 05:59'da calistirilacak sekilde eklenmesi gerekiyor.
# 59 5 * * *      /opt/ssgpp-scripts/ssgpp-debelen-uyan-uyu.sh >/dev/null 2>&1
#
# ilk uyanmayi elle asagidaki komutu calistirarak yapmak gerekiyor. (her reboot'tan sonra gerekli.)
# sudo rtcwake -m no -l -t $(date +%s -d 'tomorrow 05:58')
#
# bilgisayar uyandiginda baska bir cron job'u olarak 06:00'da calistirilan ssgpp-mobi-debe betiginin
# mobi dosyasini uretmesini bekliyor. 
# uretildiginde sonraki gun icin uyanma alarmini kurup uyuyor.
#
# sabah uyanik kalma suresi degisebilir. ssgpp-mobi-debe her ceyrek saatte calistirilan bir betik.
# debe henuz yayinlanmamissa ssgpp-mobi-debe betigi mobi'yi gonderene kadar bilgisayar uyanik kalir.
#
# kurulu uyanma alarmini gormek icin: sudo rtcwake -m show 
#
# Gereksinimleri:
# - rtcwake
# - pm-suspend
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
# ssg++ cli calisma alani
mkdir -p "$SSGPP_SCRIPTS_DIR/../ssgpp_cli_workspace"
cd "$SSGPP_SCRIPTS_DIR/../ssgpp_cli_workspace"

###############################################

TARIH=`date +%Y-%m-%d`
DOSYA=debe-$TARIH

while [ ! -f "arsiv/debeler/mobi/$DOSYA-sentToKindle.mobi" ]
do
#    echo "henuz debe gonderilmemis."
    sleep 1m
done

#echo "debe gonderilmis. yarin icin alarm kurup uyumaya devam edilecek."
# -m mem ile gun icinde bilg. acildiginda ertesi gunun alarmini unutuyor. o yuzden -m no ve pm-suspend yaptim.
sudo rtcwake -m no -l -t $(date +%s -d 'tomorrow 05:58')
sudo pm-suspend

