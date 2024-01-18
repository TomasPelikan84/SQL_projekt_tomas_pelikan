-- 2. Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?


-- vytvoreni tabulky s prumernou cenou mleka, chleba v letech 2006, 2018

CREATE OR REPLACE TABLE tp_prumerna_cena_mleka_chleba_2006_2018
sELECT 
base.rok,base.nazev , base.prumerna_hodnota, base.hodnota  
FROM t_tomas_pelikan_project_sql_primary_final base
JOIN t_tomas_pelikan_project_sql_primary_final b
	ON base.prumerna_hodnota = b.prumerna_hodnota
	AND base.nazev = b.nazev
	AND base.rok = b.rok
WHERE base.rok IN ('2006', '2018')AND base.nazev IN ('Mléko polotučné pasterované', 'Chléb konzumní kmínový');

-- vytvoření tabulky s prumernou mzdou ve vsech odvetvi

CREATE OR REPLACE TABLE tp_prumerna_mzda_vsechna_odvetvi_2006_2018
SELECT 
b.rok, b.nazev , b.prumerna_hodnota, b.hodnota  
FROM t_tomas_pelikan_project_sql_primary_final base
JOIN t_tomas_pelikan_project_sql_primary_final b
	ON base.prumerna_hodnota = b.prumerna_hodnota
	AND base.nazev = b.nazev
	AND base.rok = b.rok
WHERE base.rok IN ('2006', '2018')AND base.nazev IN ('Vsechna odvetvi');

-- množství mléka a chleba, které koupíme za průměrnou mzdu

CREATE OR REPLACE VIEW t_tomas_pelikan_sql_druhy_ukol as
SELECT
base.rok, b.nazev ,b.prumerna_hodnota ,b.hodnota ,
base.nazev AS produkt, base.prumerna_hodnota AS prumerna_hodnota_B ,base.hodnota AS hodnota_B,
round (b.prumerna_hodnota / base.prumerna_hodnota) AS mnozstvi_za_prumernou_mzdu
FROM tp_prumerna_cena_mleka_chleba_2006_2018 base
JOIN tp_prumerna_mzda_vsechna_odvetvi_2006_2018 b
	ON base.rok = b.rok
ORDER BY base.rok;




