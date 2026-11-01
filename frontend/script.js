//  element.addEventListener(olayTürü, çalıştırılacakFonksiyon, [seçenekler]);

document.getElementById("tahmin-form").addEventListener("submit", async function(e) {
    e.preventDefault(); // sayfanın yenilenmesini engelle

    const submitBtn = document.getElementById("submitBtn");
    submitBtn.innerText = "Hesaplanıyor...";
    submitBtn.disabled = true;

    // formdaki tüm verileri toplama
    const personelVerisi = {

        // veri tabanı bağlantısı yap 

        yas: parseInt(document.getElementById("yas").value),
        is_seyahati_sikligi : document.getElementById("is_seyahati_sikligi").value,
        gunluk_ucret : parseInt(document.getElementById("gunluk_ucret").value),
        departman : document.getElementById("departman").value,


        evden_uzaklik : parseInt(document.getElementById("evden_uzaklik").value),
        egitim_seviyesi : parseInt(document.getElementById("egitim_seviyesi").value),
        egitim_alani : document.getElementById("egitim_alani").value,
        calisan_sayisi : parseInt(document.getElementById("calisan_sayisi").value),


        calisma_ortami_memnuniyeti : parseInt(document.getElementById("calisma_ortami_memnuniyeti").value),
        cinsiyet : document.getElementById("cinsiyet").value,
        saatlik_ucret : parseInt(document.getElementById("saatlik_ucret").value),
        ise_baglilik : parseInt(document.getElementById("ise_baglilik").value),


        is_seviyesi : parseInt(document.getElementById("is_seviyesi").value),
        is_rolu : document.getElementById("is_rolu").value,
        is_memnuniyeti : parseInt(document.getElementById("is_memnuniyeti").value),
        medeni_hal : document.getElementById("medeni_hal").value,


        aylik_gelir : parseInt(document.getElementById("aylik_gelir").value),
        aylik_oran : parseInt(document.getElementById("aylik_oran").value),
        calistigi_sirket_sayisi : parseInt(document.getElementById("calistigi_sirket_sayisi").value),
        fazla_mesai : document.getElementById("fazla_mesai").value,


        yuzdelik_maas_zammi : parseInt(document.getElementById("yuzdelik_maas_zammi").value),
        performans_puani : parseInt(document.getElementById("performans_puani").value),
        iliski_memnuniyeti : parseInt(document.getElementById("iliski_memnuniyeti").value),
        standart_calisma_saatleri : parseInt(document.getElementById("standart_calisma_saatleri").value),


        hisse_senedi_seviyesi : parseInt(document.getElementById("hisse_senedi_seviyesi").value),
        toplam_calisma_yili : parseInt(document.getElementById("toplam_calisma_yili").value),
        gecen_yil_egitim_sayisi : parseInt(document.getElementById("gecen_yil_egitim_sayisi").value),
        is_yasam_dengesi : parseInt(document.getElementById("is_yasam_dengesi").value),


        sirketteki_yil_sayisi : parseInt(document.getElementById("sirketteki_yil_sayisi").value),
        mevcut_roldeki_yil_sayisi : parseInt(document.getElementById("mevcut_roldeki_yil_sayisi").value),
        son_terfiden_gecen_yil : parseInt(document.getElementById("son_terfiden_gecen_yil").value),
        mevcut_yoneticiyle_yil_sayisi : parseInt(document.getElementById("mevcut_yoneticiyle_yil_sayisi").value)

    };




    try {
        const response = await fetch("http://127.0.0.1:8000/tahmin" , {
           
            method : "POST",
            headers : {
                "Content-Type" : "application/json" // content : içerik
            },

            body : JSON.stringify(personelVerisi) // body, api'ye gönderilen asıl veridir. personel verisi js için bir nesnedir , bu nesneyi JSON metnine dönüştürür.

        });

        if(!response.ok){
            throw new Error("api hatası : ${response.status}");
        }



        const veri =  await response.json();

        // gelen sonuçları ekrana yazdırma 

        document.getElementById("tahmin").classList.remove("gizli");
        document.getElementById("tahmin-oran").innerText = veri.ayrılma_tahmin_oranı;
        document.getElementById("tahmin-text").innerText = veri.tahmin;
        document.getElementById("sonuc").innerText = veri.sonuc;

        
        if(veri.sonuc.includes("Yüksek")){
            document.getElementById("sonuc").style.color = "red";
        } else {
            document.getElementById("sonuc").style.color = "green";
        }




    
    } catch (error) {
   
         alert("Sunucuya bağlanılamadı");
         console.error("Hata detayı:", error);
    
    } finally{
    
        submitBtn.innerText = "Risk Analizini Başlat";
        submitBtn.disabled = false;

     }


});
