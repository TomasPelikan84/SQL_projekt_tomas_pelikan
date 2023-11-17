-- 4. Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

-- tabulka pro porovnání meziroční nárustu mezd a cen potravin

CREATE OR REPLACE TABLE tp_mezirocni_porovnani_cen_potravin_a_mzdy
SELECT *,
lag(rok,1) OVER (PARTITION BY code ORDER BY rok) AS rok_B,
LAG(prumerna_hodnota ,1) OVER (PARTITION BY code ORDER BY rok) AS prumerna_hodnota_B, concat('Kč/měsíc') AS hodnota_B 
FROM t_tomas_pelikan_project_sql_primary_final ttppspf

-- view pro procentuální růst mezd a cen potravin

CREATE OR REPLACE VIEW t_tomas_pelikan_sql_ctvrty_ukol as
SELECT *,
round ((prumerna_hodnota - prumerna_hodnota_B  ) / prumerna_hodnota_B  * 100, 1) AS procentualni_mezirocni_rust
FROM tp_mezirocni_porovnani_cen_potravin_a_mzdy tmpcpam ;






























