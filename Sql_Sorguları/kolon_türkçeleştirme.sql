-- employee_attrition tablosunun kolonlarını Türkçeleştirme
-- SQL'de tablonun kolon isimlerini türkçeleştirmek için ALTER TABLE ... RENAME COLUMN ... TO ...; komutu.
ALTER TABLE employee_attrition 
    RENAME COLUMN "age" TO yas;

ALTER TABLE employee_attrition 
    RENAME COLUMN "attrition" TO isten_ayrilma;

ALTER TABLE employee_attrition 
    RENAME COLUMN "businesstravel" TO is_seyahati_sikligi;

ALTER TABLE employee_attrition 
    RENAME COLUMN "dailyrate" TO gunluk_ucret;

ALTER TABLE employee_attrition 
    RENAME COLUMN "department" TO departman;

ALTER TABLE employee_attrition 
    RENAME COLUMN "distancefromhome" TO evden_uzaklik;

ALTER TABLE employee_attrition 
    RENAME COLUMN "education" TO egitim_seviyesi;

ALTER TABLE employee_attrition 
    RENAME COLUMN "educationfield" TO egitim_alani;

ALTER TABLE employee_attrition 
    RENAME COLUMN "employeecount" TO calisan_sayisi;

ALTER TABLE employee_attrition 
    RENAME COLUMN "employeenumber" TO calisan_numarasi;

ALTER TABLE employee_attrition 
    RENAME COLUMN "environmentsatisfaction" TO calisma_ortami_memnuniyeti;

ALTER TABLE employee_attrition 
    RENAME COLUMN "gender" TO cinsiyet;

ALTER TABLE employee_attrition 
    RENAME COLUMN "hourlyrate" TO saatlik_ucret;

ALTER TABLE employee_attrition 
    RENAME COLUMN "jobinvolvement" TO ise_baglilik;

ALTER TABLE employee_attrition 
    RENAME COLUMN "joblevel" TO is_seviyesi;

ALTER TABLE employee_attrition 
    RENAME COLUMN "jobrole" TO is_rolu;

ALTER TABLE employee_attrition 
    RENAME COLUMN "jobsatisfaction" TO is_memnuniyeti;

ALTER TABLE employee_attrition 
    RENAME COLUMN "maritalstatus" TO medeni_hal;

ALTER TABLE employee_attrition 
    RENAME COLUMN "monthlyincome" TO aylik_gelir;

ALTER TABLE employee_attrition 
    RENAME COLUMN "monthlyrate" TO aylik_oran;

ALTER TABLE employee_attrition 
    RENAME COLUMN "numcompaniesworked" TO calistigi_sirket_sayisi;

ALTER TABLE employee_attrition 
    RENAME COLUMN "over18" TO on_sekiz_yas_ustu;

ALTER TABLE employee_attrition 
    RENAME COLUMN "overtime" TO fazla_mesai;

ALTER TABLE employee_attrition 
    RENAME COLUMN "percentsalaryhike" TO yuzdelik_maas_zammi;

ALTER TABLE employee_attrition 
    RENAME COLUMN "performancerating" TO performans_puani;

ALTER TABLE employee_attrition 
    RENAME COLUMN "relationshipsatisfaction" TO iliski_memnuniyeti;

ALTER TABLE employee_attrition 
    RENAME COLUMN "standardhours" TO standart_calisma_saatleri;

ALTER TABLE employee_attrition 
    RENAME COLUMN "stockoptionlevel" TO hisse_senedi_seviyesi;

ALTER TABLE employee_attrition 
    RENAME COLUMN "totalworkingyears" TO toplam_calisma_yili;

ALTER TABLE employee_attrition 
    RENAME COLUMN "trainingtimeslastyear" TO gecen_yil_egitim_sayisi;

ALTER TABLE employee_attrition 
    RENAME COLUMN "worklifebalance" TO is_yasam_dengesi;

ALTER TABLE employee_attrition 
    RENAME COLUMN "yearsatcompany" TO sirketteki_yil_sayisi;

ALTER TABLE employee_attrition 
    RENAME COLUMN "yearsincurrentrole" TO mevcut_roldeki_yil_sayisi;

ALTER TABLE employee_attrition 
    RENAME COLUMN "yearssincelastpromotion" TO son_terfiden_gecen_yil;

ALTER TABLE employee_attrition 
    RENAME COLUMN "yearswithcurrmanager" TO mevcut_yoneticiyle_yil_sayisi;