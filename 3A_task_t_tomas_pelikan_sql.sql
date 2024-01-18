-- 3. Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?

-- vytvoření tabulky pro meziroční porovnání cen potravin 

CREATE OR REPLACE TABLE tp_mezirocni_porovnani_cen_potravin
SELECT *,
lag(rok ,1) OVER (PARTITION BY code ORDER BY rok) AS predchozi_rok,
LAG(prumerna_hodnota ,1) OVER (PARTITION BY code ORDER BY rok) AS prumerna_hodnota_predchozi_rok, concat('Kč/unit') AS hodnota_B 
FROM t_tomas_pelikan_project_sql_primary_final ttppspf 
WHERE hodnota = 'Kč/unit';

-- zjištění meziročního percentuálního nárustu potravin 

CREATE OR REPLACE VIEW t_tomas_pelikan_sql_treti_ukol_A as
SELECT *,
round(((prumerna_hodnota - prumerna_hodnota_predchozi_rok) / prumerna_hodnota_predchozi_rok  ) * 100, 1) AS percentualni_mezirocni_narust
FROM tp_mezirocni_porovnani_cen_potravin tmpcp
ORDER BY nazev ;


































