-- Soru 2: fazla_mesai durumunun istifa sayılarına ve oranına etkisi nedir

select 
		fazla_mesai,
		count(*) as toplam_kişi,
		SUM (case when isten_ayrilma = 'Yes' THEN 1 else 0 END) as istifa_eden_toplam_kişi,
		round(CAST(SUM(case when isten_ayrilma = 'Yes' THEN 1 else 0 END) * (100.0 / count(*)),2) AS numeric) as yüzde_oranı


from employee_attrition
group by fazla_mesai 
			