from fastapi import FastAPI
import joblib

import pandas as pd


from pydantic import BaseModel , Field
from typing import Literal



from fastapi.middleware.cors import CORSMiddleware



app = FastAPI(title="IBM HR FastAPI Uygulaması",version="1.0.0")


# bu alttaki kısmı yazmadan önce port farklılığından dolayı api'ye bağlanamadık (CORSMiddleware import ettik)
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # her porttan gelen isteğe izin ver
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)




model = joblib.load("ik_istifa_tahmin_modeli.joblib")
model_ozellikler = joblib.load("model_features.joblib")



class personel_verisi(BaseModel):

    yas: int = Field(ge = 18, le = 60)
    # isten_ayrilma:  Literal[0,1]. ---> bu bizim hedef değişkenimiz, zaten bunu tahmin edicez
    is_seyahati_sikligi: Literal["Nadir Seyahat","Seyahat Yok","Sık Seyahat"]
    gunluk_ucret :int = Field(ge = 102 , le = 1499)
    departman :  Literal["Satış","Ar-Ge","İnsan Kaynakları"]


    evden_uzaklik : int = Field(ge = 1, le = 29)
    egitim_seviyesi : int = Field(ge = 1, le =5)
    egitim_alani : Literal["Yaşam Bilimleri","Diğer","Sağlık","Pazarlama","Teknik Bölüm","İnsan Kaynakları"]
    calisan_sayisi : Literal[1]

    
    calisma_ortami_memnuniyeti : int = Field(ge = 1, le =4)
    cinsiyet : Literal["Erkek","Kadın"]
    saatlik_ucret : int = Field(ge = 30, le = 100)
    ise_baglilik : int = Field(ge = 1, le = 4)

    
    is_seviyesi : int = Field(ge = 1, le = 5)
    is_rolu : Literal["Satış Yöneticisi","Araştırma Uzmanı","Laboratuvar Teknisyeni","Üretim Direktörü","Sağlık Temsilcisi","Müdür","Satış Temsilcisi","Araştırma Direktörü","İnsan Kaynakları"]
    is_memnuniyeti : int = Field(ge = 1, le = 4)
    medeni_hal : Literal["Bekar","Evli","Boşanmış"]

    
    aylik_gelir : int = Field(ge = 1009, le = 19999)
    aylik_oran : int = Field(ge = 2094, le = 26999)
    calistigi_sirket_sayisi : int = Field(ge = 0, le = 9)
    fazla_mesai :Literal["Yes","No"]

    
    yuzdelik_maas_zammi	: int = Field(ge = 11, le = 25)
    performans_puani : int = Field(ge = 3, le = 4)
    iliski_memnuniyeti : int = Field(ge = 1, le = 4)
    standart_calisma_saatleri : Literal[80]

    
    hisse_senedi_seviyesi : int = Field(ge = 0, le = 3)
    toplam_calisma_yili : int = Field(ge = 0, le = 40)
    gecen_yil_egitim_sayisi : int = Field(ge = 0, le = 6)
    is_yasam_dengesi : int = Field(ge = 1, le = 4)

    
    sirketteki_yil_sayisi : int = Field(ge = 0, le = 40)
    mevcut_roldeki_yil_sayisi : int = Field(ge = 0, le = 18)
    son_terfiden_gecen_yil : int = Field(ge = 0, le = 15)
    mevcut_yoneticiyle_yil_sayisi : int = Field(ge = 0, le = 17)






@app.get("/")
def ana_sayfa():
    return {"message": "IBM HR FastAPI Uygulaması"}


# dump : indirme, kaydetme anlamına gelir.


@app.post("/tahmin")
def tahmin_fonksiyonu(veri: personel_verisi):
    df = pd.DataFrame([veri.model_dump()])  # model_dump() methodu pydantic'in kendisinindir, Pydantic modelinin verilerini bir sözlük olarak döndürür.
     # Pydantic'in eski sürümlerinde (v1) bunun yerine veri.dict() kullanılıyordu. Yeni sürümlerde güncel kullanım model_dump() şeklindedir.
     # Gelen jsonu da dataframe çevirdik , üzerinde işlem yapabilelim diye.
        
    # Encoding işlemleri
    # df["isten_ayrilma"] = df["isten_ayrilma"].map({"Yes": 1, "No": 0})
    df["fazla_mesai"] = df["fazla_mesai"].map({"Yes": 1, "No": 0})
    df["cinsiyet"] = df["cinsiyet"].map({"Erkek": 1, "Kadın": 0})

    seyahat_sozlugu = {
    "Seyahat Yok": 0,    
    "Nadir Seyahat": 1, 
    "Sık Seyahat": 2
    }

    df["is_seyahati_sikligi"] = df["is_seyahati_sikligi"].map(seyahat_sozlugu)
    df_hazir = pd.get_dummies(df, drop_first=True)
    df_hazir = df_hazir.astype(int)


    for i in model_ozellikler:
        if i not in df_hazir.columns:
            df_hazir[i] = 0

    df_hazir = df_hazir[model_ozellikler]

    esik_degeri = 0.35
    tahmin_oranı = (model.predict_proba(df_hazir)[0][1]) # Her sınıf için 0 ile 1 arasında bir değer döndürür. İki sınıf varsa (örneğin 0 ve 1), çıktı [0'ıncı sınıf olasılığı, 1'inci sınıf olasılığı] şeklinde bir liste olur ve bu iki olasılığın toplamı her zaman 1'e eşittir.
    tahmin = int(model.predict(df_hazir)[0])

    
    if tahmin_oranı >= esik_degeri:
       
        sonuc = "Ayrılma Olasılığı Yüksek"
   
    else:

        sonuc = "Ayrılma Olasılığı Düşük"

   
    return {

        "ayrılma_tahmin_oranı": round(tahmin_oranı,2),
        "tahmin": tahmin,
        "sonuc": sonuc
    }