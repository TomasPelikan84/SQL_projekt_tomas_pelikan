-- Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?

-- rozdeleni do kategorii
CREATE OR REPLACE TABLE tp_kategorie_potravin 
SELECT *,
	CASE
		WHEN code LIKE '111%' THEN 'obiloviny'
		WHEN code LIKE '112%' THEN 'masne vyrobky'
		WHEN code LIKE '114%' or code LIKE '115%' THEN 'mlecne odvetvi'
		WHEN code LIKE '116%' THEN 'ovoce'
		WHEN code LIKE '117%' THEN 'zelenina'
		WHEN code LIKE '118%' THEN 'sladidla'
		WHEN code LIKE '122%' THEN 'napoje'
		WHEN code LIKE '212%' OR code LIKE '213%' THEN 'alkoholicke_napoje'
		ELSE 'ryby'
	END	AS kategorie_potravin
FROM t_tomas_pelikan_project_sql_primary_final ttppspf 
WHERE hodnota = 'Kč/unit'
;

-- cena potravin podle kategorii za rok

CREATE OR REPLACE TABLE tp_suma_potravin_kategorie_za_rok
SELECT
kategorie_potravin , rok, 
sum (prumerna_hodnota) AS suma_potravin
FROM tp_kategorie_potravin tkp
GROUP BY rok, kategorie_potravin ;

-- zjištění procentuálního nárustu meziročně v kategoriích 

CREATE OR REPLACE VIEW t_tomas_pelikan_sql_treti_ukol_B as
SELECT
base.kategorie_potravin, base.rok AS rok_A,base.suma_potravin AS suma_potravin_A,concat('Kč/unit') AS hodnota_A,  
a.rok AS rok_B ,a.suma_potravin AS suma_potravin_B  ,  concat('Kč/unit') AS hodnota_B,
round (((a.suma_potravin  - base.suma_potravin) / base.suma_potravin  ) * 100, 2) AS procentualni_mezirocni_narust 
FROM tp_suma_potravin_kategorie_za_rok base
JOIN tp_suma_potravin_kategorie_za_rok a
	ON base.kategorie_potravin  = a.kategorie_potravin  
	AND base.rok = a.rok - 1
GROUP BY base.kategorie_potravin , base.rok  
ORDER BY kategorie_potravin ;









































