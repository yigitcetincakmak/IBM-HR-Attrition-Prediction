-- Soru 3: İş memnuniyeti seviyelerine göre çalışan sayısı, ortalama maaş ve istifa edenler.

select 
		is_memnuniyeti,
		count(*) as toplam_kişi,
		round(avg(aylik_gelir),2) as ortalama_gelir,
		sum (case 
				  when isten_ayrilma = 'Yes' then 1 else 0 end) as ayrılan_toplam_kişi,
		round((sum(case when isten_ayrilma = 'Yes' then 1 else 0 end)) * 100.0/count(*),2) as yüzdelik_oran
		
from employee_attrition
group by is_memnuniyeti

order by yüzdelik_oran desc