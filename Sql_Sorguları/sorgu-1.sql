-- Soru1 : departman göre , kaç çalışan var , kaçı işten çıkmış 

select 

		departman, 
		count(*) as toplam_kişi,
		round (avg(gunluk_ucret),2) as ortalama_gunluk_ucret,
		count(*) FILTER (where isten_ayrilma = 'Yes') as işten_ayrılan_kişi_sayısı,
		round(count(*) FILTER (where isten_ayrilma = 'Yes') * (100.0/count(*)) , 2) 
				as ayrılma_yüzdesi


from employee_attrition

group by departman

-- asc ve desc (ascending : artan-yükselen , descending : azalan-inen)