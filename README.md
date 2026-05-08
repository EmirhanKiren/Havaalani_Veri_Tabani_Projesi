# Havaalanı Veritabanı Yönetim Sistemi

## 📌 Proje Tanımı
Bu proje, modern bir havaalanı işletmesinin operasyonel ihtiyaçlarını karşılamak üzere tasarlanmış kapsamlı bir ilişkisel veritabanı yönetim sistemidir. Sistem; uçuş planlamasından yolcu biletleme süreçlerine, personel yönetiminden ödeme takibine kadar geniş bir yelpazeyi kapsayan bir veri modeli sunar.

## 🏗️ Veritabanı Mimarisi ve Senaryo Detayları
Proje, karmaşık iş süreçlerini veritabanı seviyesinde modellemek için çeşitli ileri düzey veritabanı tekniklerini kullanmaktadır.

### Temel Varlıklar (Entities)
Sistem aşağıdaki ana varlıklar üzerine inşa edilmiştir:
* **Havaalanı:** Operasyonların gerçekleştiği lokasyonları (Şehir, Ülke, Kod) tanımlar.
* **Uçak:** Uçuşlarda kullanılan fiziksel araçların kapasite ve model bilgilerini tutar.
* **Uçuş:** Kalkış/varış zamanları ve rotaları yönetir.
* **Yolcu & Bilet:** Kişisel bilgiler ile uçuş eşleşmelerini ve bilet kesim süreçlerini yönetir.
* **Çalışan:** Organizasyon şemasındaki personeli tanımlar.
* **Ödeme:** Finansal işlem detaylarını saklar.

### İleri Düzey Modelleme Özellikleri
Sistemin ayırt edici özellikleri, gerçek dünya senaryolarını yansıtan şu yapılardır:

1.  **Üst Tür-Alt Tür (Super-type/Sub-type):**
    `Çalışan` varlığı bir üst tür olarak tanımlanmıştır. Personel rolleri, çalışanların ortak özelliklerini (Ad, Soyad vb.) ana tabloda tutarken; `Pilot` (Lisans No) ve `Kabin Memuru` (Yabancı Dil) gibi alt türler aracılığıyla role özgü verileri ayrıştırır.

2.  **Yay (Arc - Exclusive OR) İlişkisi:**
    `Ödeme` süreçlerinde bir biletin ödemesi ya *Kredi Kartı* ya da *Nakit* üzerinden gerçekleştirilebilir. Bu yapı, bir işlemin aynı anda iki farklı yöntemle yapılmasını engelleyen bir mantıksal kısıtlama (Arc) ile modellenmiştir.

3.  **Hiyerarşik (Recursive) Yapı:**
    Organizasyonel hiyerarşiyi yönetmek adına `Çalışan` tablosunda "Kendi Kendine İlişki" kullanılmıştır. Her çalışan, yine aynı tabloda yer alan bir yöneticiye bağlıdır; bu da sınırsız derinlikte bir yönetim şeması oluşturulmasına olanak tanır.

4.  **Devredilemez (Non-transferable) İlişki:**
    `Yolcu` ve `Bilet` arasındaki bağ, biletin kesildikten sonra başka bir yolcuya devredilemeyeceği kuralı üzerine kurulmuştur. Bu, veri bütünlüğünü koruyan kritik bir iş kuralıdır.

## 🛠️ Teknik Altyapı
Sistem, ilişkisel veritabanı standartlarına uygun olarak tasarlanmış; Primary Key (Birincil Anahtar) ve Foreign Key (Yabancı Anahtar) bağlantılarıyla tablolar arası veri tutarlılığı maksimum seviyeye çıkarılmıştır. Fiziksel uygulama katmanında **Oracle APEX** platformu tercih edilerek profesyonel bir veritabanı yönetim ortamı oluşturulmuştur.
