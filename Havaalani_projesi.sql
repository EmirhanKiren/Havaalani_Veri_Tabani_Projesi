-- 1. HAVAALANI TABLOSU
CREATE TABLE Havaalani (
    Havaalani_Kodu VARCHAR2(10) PRIMARY KEY,
    Sehir VARCHAR2(100),
    Ulke VARCHAR2(100)
);

-- 2. UÇAK TABLOSU
CREATE TABLE Ucak (
    Kuyruk_No VARCHAR2(20) PRIMARY KEY,
    Model VARCHAR2(50),
    Kapasite NUMBER
);

-- 3. UÇUŞ TABLOSU
CREATE TABLE Ucus (
    Ucus_No VARCHAR2(20) PRIMARY KEY,
    Kalkis_Zamani DATE,
    Varis_Zamani DATE,
    Ucak_Kuyruk_No VARCHAR2(20) REFERENCES Ucak(Kuyruk_No),
    Kalkis_Havaalani VARCHAR2(10) REFERENCES Havaalani(Havaalani_Kodu),
    Varis_Havaalani VARCHAR2(10) REFERENCES Havaalani(Havaalani_Kodu)
);

-- 4. YOLCU TABLOSU
CREATE TABLE Yolcu (
    Yolcu_ID NUMBER PRIMARY KEY,
    Ad VARCHAR2(50),
    Soyad VARCHAR2(50),
    Pasaport_No VARCHAR2(20)
);

-- 5. BİLET TABLOSU
CREATE TABLE Bilet (
    Bilet_No NUMBER PRIMARY KEY,
    Kesim_Tarihi DATE,
    Yolcu_ID NUMBER REFERENCES Yolcu(Yolcu_ID),
    Ucus_No VARCHAR2(20) REFERENCES Ucus(Ucus_No)
);

-- 6. ÇALIŞAN TABLOSU 
CREATE TABLE Calisan (
    Calisan_ID NUMBER PRIMARY KEY,
    Ad VARCHAR2(50),
    Soyad VARCHAR2(50),
    Yonetici_ID NUMBER REFERENCES Calisan(Calisan_ID)
);

-- 7. PİLOT TABLOSU 
CREATE TABLE Pilot (
    Calisan_ID NUMBER PRIMARY KEY REFERENCES Calisan(Calisan_ID),
    Lisans_No VARCHAR2(50)
);

-- 8. KABİN MEMURU TABLOSU 
CREATE TABLE Kabin_Memuru (
    Calisan_ID NUMBER PRIMARY KEY REFERENCES Calisan(Calisan_ID),
    Yabanci_Dil VARCHAR2(100)
);

-- 9. ÖDEME TABLOSU
CREATE TABLE Odeme (
    Odeme_ID NUMBER PRIMARY KEY,
    Tutar NUMBER,
    Tarih DATE,
    Bilet_No NUMBER REFERENCES Bilet(Bilet_No),
    Odeme_Tipi VARCHAR2(20) 
);

-- ==========================================
-- DML, UPDATE VE ALTER TABLE İŞLEMLERİ
-- ==========================================

-- 1. ALTER TABLE İÇEREN İFADE
-- Ucak tablosuna Uretim_Yili adinda yeni bir kolon ekliyoruz
ALTER TABLE Ucak ADD Uretim_Yili NUMBER;

-- 2. UPDATE İÇEREN İFADE
-- ID'si 1 olan yolcunun pasaport numarasini guncelliyoruz
UPDATE Yolcu 
SET Pasaport_No = 'TR9876543' 
WHERE Yolcu_ID = 1;

-- 3. ALT SORGU (SUBQUERY) İÇEREN İFADE
-- Bilet almis olan yolcularin Ad ve Soyadlarini listeleme
SELECT Ad, Soyad 
FROM Yolcu 
WHERE Yolcu_ID IN (SELECT Yolcu_ID FROM Bilet);

-- 4. JOIN İÇEREN İFADE
-- Ucus numaralari ile o ucusu yapacak ucaklarin modellerini yan yana getirme
SELECT Ucus.Ucus_No, Ucak.Model 
FROM Ucus 
JOIN Ucak ON Ucus.Ucak_Kuyruk_No = Ucak.Kuyruk_No;

-- 5. GROUP BY İÇEREN İFADE
-- Hangi kalkis havaalanindan toplam kac ucus yapildigini bulma
SELECT Kalkis_Havaalani, COUNT(*) AS Toplam_Ucus_Sayisi 
FROM Ucus 
GROUP BY Kalkis_Havaalani;

-- 6. DATE İŞLEVİ İÇEREN İFADE
-- Kesim tarihi bugunden (SYSDATE) once olan biletleri listeleme
SELECT Bilet_No, Kesim_Tarihi 
FROM Bilet 
WHERE Kesim_Tarihi < SYSDATE;

-- 7. CHARACTER İŞLEVİ İÇEREN İFADE
-- Yolcularin adlarini tamamen buyuk harfle, soyadlarini ise kucuk harfle listeleme
SELECT UPPER(Ad) AS Buyuk_Ad, LOWER(Soyad) AS Kucuk_Soyad 
FROM Yolcu;