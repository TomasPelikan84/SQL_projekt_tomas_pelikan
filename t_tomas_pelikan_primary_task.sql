-- vytvoření tabulky pro průměrnou měsíční mzdu v letech 2006 až 2018

CREATE OR REPLACE TABLE tp_prumerna_mesicni_mzda_2006_2018
SELECT 
cpib.code, cpib.name AS nazev , cp.payroll_year AS rok, 
round (avg (value), 1) AS prumerna_hodnota, CONCAT('Kč/měsíc') AS hodnota 
FROM czechia_payroll cp
JOIN czechia_payroll_industry_branch cpib 
	ON cp.industry_branch_code = cpib.code 
WHERE value_type_code = '5958' AND value_type_code IS NOT NULL AND industry_branch_code IS NOT NULL
AND calculation_code = '100' AND payroll_year >= '2006' AND payroll_year <= '2018' 
GROUP BY industry_branch_code, payroll_year;

-- vytvoření tabulky pro průměrnou cenu potravin v letech 2006 až 2018

CREATE OR REPLACE TABLE tp_prumerna_cena_potravin_v_roce
SELECT 
cpc.code AS code, cpc.name AS nazev, YEAR (cp.date_from) AS rok,  
round (avg (value), 1) AS prumerna_hodnota, concat('Kč/unit') AS hodnota
FROM czechia_price cp 
JOIN czechia_price_category cpc 
	ON cp.category_code = cpc.code 
GROUP BY category_code , YEAR (date_from)
ORDER BY cpc.name,cp.date_from  ;

-- VYTVOŘENÍ HLAVNÍ TABULKY

CREATE OR REPLACE TABLE t_tomas_pelikan_project_SQL_primary_final 
SELECT *
FROM tp_prumerna_mesicni_mzda_2006_2018 tpmm2 
UNION all
SELECT 
concat('ALL') AS code, concat('Vsechna odvetvi') AS nazev, rok , 
round (avg (prumerna_hodnota), 1) AS prumerna_hodnota, hodnota 
FROM tp_prumerna_mesicni_mzda_2006_2018 tpmm 
GROUP BY rok
UNION all
SELECT *
FROM tp_prumerna_cena_potravin_v_roce tpcpvr ;



