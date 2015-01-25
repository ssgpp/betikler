ssg++'yı kullanan faydalı betikler
==================================

### Yapılandırma

 * [ssg++] (http://ssgpp.github.io/indir.html)'yı edinin. 
 * [ssgpp_conf.sh] (https://github.com/ssgpp/betikler/blob/master/bin/ssgpp_conf.sh) dosyasında belirtilen düzenlemeleri yapın.
 * bin klasörünü PATH'e ekleyin. örn. `export PATH=$PATH:/home/user/Downloads/ssg++-1.0/bin`

### Kullanım

* Günün DEBE mobisini kindle'a gönderme ([çıktı örnekleri](http://ssgpp.github.io/mobi.html))

``
$ ssgpp-debelen
``

* Badilerin henüz okumadığınız girdilerinden mobi oluşturup kindle'a gönderme

``
$ ssgpp-badilen
``

* ssg++ komut satırı arayüzünü çalıştırma örneği ([komutlarla ilgili yardım](http://ssgpp.github.io/#sec-3-2))

``
$ ssg++ bugün

$ ssg++ yürüt başlıkknk \[başlık=sözlükçülerin en iyi 10 dizi listesi\] ! başlıkgirdileri ! girdibkzları ! histogram ! grafikbtk
``

* ssg++ web arayüzü sunucusu: başlatma|kapatma|yeniden başlatma|durumunu öğrenme

``
$ ssgppd start|stop|restart|status
``

* başlık izleme örneği

``
$ ssgpp-izle-baslik "6 ağustos 2014 beşiktaş feyenoord maçı"
``

* başlık akışını (sol frame'i) canlı izle

``
$ ssgpp-izle-bugun
``

* yazarın girdilerinin favorilenme sayılarındaki değişiklikleri görme

``
$ ssgpp-diff-fav
``

* bir başlığın youtube bağlantılarından çalma listesi oluşturma ([mpsyt](https://github.com/np1/mps-youtube/) programına bağımlıdır.)

``
ssgpp-mpsyt insanı mutlu eden şarkılar
``

