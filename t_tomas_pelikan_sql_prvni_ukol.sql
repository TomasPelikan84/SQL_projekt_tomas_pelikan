-- 1. Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

CREATE OR REPLACE VIEW t_tomas_pelikan_sql_prvni_ukol as
SELECT *,
LAG(prumerna_hodnota ,1) OVER (PARTITION BY code ORDER BY rok) AS prumerna_hodnota_predchozi_rok,
concat('Kč/měsíc') AS hodnota_B
FROM t_tomas_pelikan_project_sql_primary_final ttppspf
WHERE hodnota = 'Kč/měsíc';



















