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

* Verilen başlığın girdilerinden mobi oluşturup kindle'a gönderme örneği

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

* ssg++ komut satırı arayüzünü çalıştırma örneği ([komutlarla ilgili yardım](http://ssgpp.github.io/#sec-3-2))

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


<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons Lisansı" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br /><a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/ssgpp/betikler" property="cc:attributionName" rel="cc:attributionURL">Onur Derin</a> isimli yazarın <span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">ssg++ betikleri</span> başlıklı eseri bu <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"> Creative Commons Atıf-Gayriticari-LisansDevam 4.0 Uluslararası Lisansı </a> ile lisanslanmıştır.<br /><a xmlns:dct="http://purl.org/dc/terms/" href="http://ssgpp.github.io" rel="dct:source">http://ssgpp.github.io</a> bağlantısındaki esere dayalı olarak.<br />Bu lisansın kapsamı dışındaki izinler <a xmlns:cc="http://creativecommons.org/ns#" href="http://ssgpp.github.io/index.html#sec-7" rel="cc:morePermissions">http://ssgpp.github.io/index.html#sec-7</a> adresinde mevcut olabilir.

<a rel="license" href="http://creativecommons.org/licenses/by/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by/4.0/88x31.png" /></a><br /><span xmlns:dct="http://purl.org/dc/terms/" property="dct:title">ssg++ betikleri</span> by <a xmlns:cc="http://creativecommons.org/ns#" href="https://github.com/ssgpp/betikler" property="cc:attributionName" rel="cc:attributionURL">Onur Derin</a> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by/4.0/">Creative Commons Attribution 4.0 International License</a>.<br />Based on a work at <a xmlns:dct="http://purl.org/dc/terms/" href="http://ssgpp.github.io" rel="dct:source">http://ssgpp.github.io</a>.<br />Permissions beyond the scope of this license may be available at <a xmlns:cc="http://creativecommons.org/ns#" href="http://ssgpp.github.io/index.html#sec-7" rel="cc:morePermissions">http://ssgpp.github.io/index.html#sec-7</a>.
