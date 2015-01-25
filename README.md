ssg++'yı kullanan faydalı betikler
==================================

Her ne kadar ssg++ ile tek bir satırda pek çok iş yapılabiliyor olsa da, tek satırın yetmediği ya da başka programlarla bir arada kullanılmasının gerektiği durumlarda betik oluşturmak gerekiyor. Bu alanda farklı amaçlar için yazılmış bazı betikleri bulabilirsiniz.

Bu alana kendi betiklerinizle katkıda bulunabilirsiniz. Özellikle mevcut betiklerin Windows karşılıklarına ihtiyaç var.

### Yapılandırma

 * [ssg++] (http://ssgpp.github.io/indir.html)'yı edinin. 
 * [ssgpp_conf.sh] (https://github.com/ssgpp/betikler/blob/master/bin/ssgpp_conf.sh) dosyasında belirtilen düzenlemeleri yapın.
 * bin klasörünü PATH'e ekleyin. örn. `export PATH=$PATH:/home/user/Downloads/ssg++-1.0/bin >> ~/.bashrc; bash`

### Kullanım

* Günün debe mobisini kindle'a gönderme ([çıktı örnekleri](http://ssgpp.github.io/mobi.html))

``
$ ssgpp-mobi-debe
``

* Badilerin henüz okumadığınız girdilerinden mobi oluşturup kindle'a gönderme

``
$ ssgpp-mobi-badi
``

* Verilen başlığın girdilerinden mobi oluşturup kindle'a gönderme örnekleri

``
$ ssgpp-mobi-baslik javascript\'in ilkokullarda zorunlu ders olması
``

```
$ ssgpp-mobi-baslik \#6260334
```

```
$ ssgpp-mobi-baslik evrim teorisi/@derinsular
```

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

* bir başlığın girdilerinde verilen youtube bağlantılarından çalma listesi (playlist) oluşturma ([mpsyt](https://github.com/np1/mps-youtube/) programına bağımlıdır.)

``
ssgpp-mpsyt insanı mutlu eden şarkılar
``

* ssg++ komut satırı arayüzünü çalıştırma örnekleri ([komutlarla ilgili yardım](http://ssgpp.github.io/#sec-3-2))

``
$ ssg++ bugün
``

``
$ ssg++ yürüt başlıkknk [başlık=sözlükçülerin en iyi 10 dizi listesi] ! başlıkgirdileri ! girdibkzları ! histogram ! grafikbtk
``

* ssg++ web arayüzü sunucusu: başlatma | kapatma | yeniden başlatma | durumunu öğrenme

``
$ ssgppd start|stop|restart|status
``

