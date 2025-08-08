# 📍 Getir CBS Uzamsal Veritabanı Projesi

Bu proje, **PostgreSQL + PostGIS** altyapısı ve **Python** kütüphaneleri kullanılarak OpenStreetMap verileri üzerinden **konum tabanlı analiz**, **yakınlık sorguları** ve **harita görselleştirme** işlemlerini gerçekleştirmektedir.  

## 🚀 Proje Özellikleri

- OpenStreetMap (.osm) verilerini PostgreSQL/PostGIS veritabanına aktarma
- Adres girdisini koordinat verisine dönüştürme (**GeoPy – Nominatim**)
- Yakınlık (buffer) analizi ile 1000 metre çevresindeki binaları, yolları veya marketleri listeleme
- SQL sorgularının Python üzerinden çalıştırılması ve **GeoPandas + Matplotlib** ile görselleştirme
- Kuryeler için rota planlama ve yakın POI (Point of Interest) tespiti

---

## 🛠 Kullanılan Teknolojiler

- **Veritabanı:** PostgreSQL + PostGIS
- **Python Kütüphaneleri:**  
  - GeoPandas  
  - SQLAlchemy  
  - Matplotlib  
  - GeoPy (Nominatim)  
  - Shapely  

---

## 📂 Veri Kaynağı

- **OpenStreetMap** (.osm XML formatı)  
- **osm2pgsql** ile veritabanına aktarım

---

## 🔍 Örnek Sorgular

- İstanbul’daki ev ve apartmanları listeleme
- Market ve dağıtım yerlerini listeleme
- Kuryenin konumuna yakın yolları çıkarma
- Kullanıcının adresinden 1000m çevredeki binaları gösterme
- Adrese en yakın 25 marketi sıralama

---

## 📊 Görselleştirme

Python tarafında yapılan görselleştirme örnekleri:

- Kullanıcının konumu **kırmızı nokta**
- Binalar, marketler veya yollar **yeşil**
- 1000m analiz alanı **mavi çember**
- Katman isimleri legend üzerinde görüntülenir

---

## 📦 Kurulum

1. PostgreSQL ve PostGIS kurun
2. OSM verisini indirin  (https://download.geofabrik.de/europe/turkey-latest.osm.pbf)
3. osm2pgsql ile veriyi içe aktarın  
4. Python bağımlılıklarını yükleyin  (pip install geopandas sqlalchemy matplotlib geopy shapely psycopg2)
5. `config` kısmında veritabanı bağlantı bilgilerinizi düzenleyin
6. Python betiğini çalıştırın  

---

## 📌 Sonuç

Bu proje, **uzamsal veritabanı yönetimi** ve **Python tabanlı coğrafi veri analizi** alanlarında hem temel hem de ileri düzey teknikleri bir araya getirmiştir. Geliştirilecek mobil veya web tabanlı CBS projeleri için sağlam bir altyapı sunmaktadır.
