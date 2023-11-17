-- 5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, 
-- projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem? 

-- porovnání percentuálního růstu potravin, mzdy a HDP

CREATE OR REPLACE VIEW t_tomas_pelikan_sql_paty_ukol_A as 
SELECT
base.*, b.percentualni_rust_GDP , c.percent_rust_mezd  
FROM tp_mezirocni_percentualni_rust_vsech_potravin base
JOIN tp_mezirocni_rozdil_GDP b
	ON base.rok = b.rok_B  
JOIN tp_percentulni_rust_mzdy c
	ON base.rok = c.rok_B  ;



-- tabulka pro percentualni rust GDP

CREATE OR REPLACE TABLE tp_mezirocni_rozdil_GDP 
SELECT
base.country AS nazev_zeme, base.rok, base.GDP ,
b.rok AS rok_B, b.GDP AS GDP_B,
round((b.GDP - base.GDP) / base.GDP * 100, 1) AS percentualni_rust_GDP
FROM t_tomas_pelikan_project_sql_secondary_final base
JOIN t_tomas_pelikan_project_sql_secondary_final b
	ON base.country = b.country 
	AND base.rok = b.rok - 1 
WHERE base.country = 'Czech republic'
ORDER BY base.rok;

-- tabulka pro percentualni rust mzdy

CREATE OR REPLACE TABLE tp_percentulni_rust_mzdy
SELECT
base.code , base.nazev , base.rok, base.prumerna_hodnota , base.hodnota ,
b.rok AS rok_B, b.prumerna_hodnota AS prumerna_hodnota_B, b.hodnota AS hodnota_B,
round ((b.prumerna_hodnota - base.prumerna_hodnota) / base.prumerna_hodnota * 100, 1) AS percent_rust_mezd
FROM t_tomas_pelikan_project_sql_primary_final base 
JOIN t_tomas_pelikan_project_sql_primary_final b 
	ON base.nazev = b.nazev 
	AND base.rok = b.rok - 1
WHERE base.hodnota = 'Kč/měsíc' AND base.code = 'ALL';

-- tabulka pro percentualni rust potravin

CREATE OR REPLACE TABLE tp_procentualni_mezirocni_narust_potraviny  
SELECT*,
round ((prumerna_hodnota - prumerna_hodnota_B) / prumerna_hodnota_B * 100, 1) AS percent_rust_potravin
FROM tp_mezirocni_porovnani_cen_potravin
ORDER BY nazev ;


-- porovnání cen potravin meziročně a získaný meziroční procentuální rozdíl v ceně potraviny.

CREATE OR REPLACE TABLE tp_procentualni_mezirocni_narust_potraviny 
SELECT
base.kod_potraviny  , base.Nazev_potraviny , base.rok, base.prumerna_cena_za_rok AS prumerna_cena_A, concat('Kč/unit') AS hodnota,  
a.rok AS nasleduji_rok ,a.prumerna_cena_za_rok AS prumerna_cena_B , concat('Kč/unit') AS hodnota_A,
round (((a.prumerna_cena_za_rok - base.prumerna_cena_za_rok) / base.prumerna_cena_za_rok ) * 100, 2) AS procentualni_mezirocni_narust 
FROM tp_prumerna_cena_potravin_v_danem_roce base
JOIN tp_prumerna_cena_potravin_v_danem_roce a
	ON base.Nazev_potraviny = a.Nazev_potraviny 
	AND base.rok = a.rok - 1
GROUP BY base.Nazev_potraviny, base.rok ;

-- pomocna tabulka pro usporadani a lepsi zobrazeni

CREATE OR REPLACE TABLE tp_mezirocni_percentualni_rust_vsech_potravin

SELECT
base.rok  AS rok , base.percent_rust_potravin  AS banany_percent_rust,
a.percent_rust_potravin AS chleb_percent_rust,
b.percent_rust_potravin AS pecivo_percent_rust,
c.percent_rust_potravin AS rice_percent_rust,
d.percent_rust_potravin AS psenice_percent_rust,
e.percent_rust_potravin AS testoviny_percent_rust,
f.percent_rust_potravin AS hovezi_percent_rust,
g.percent_rust_potravin AS veprove_percent_rust,
h.percent_rust_potravin AS kurata_percent_rust,
i.percent_rust_potravin AS sunk_salam_percent_rust,
j.percent_rust_potravin AS mleko_percent_rust,
k.percent_rust_potravin AS jogurt_percent_rust,
l.percent_rust_potravin AS eidam_percent_rust,
m.percent_rust_potravin AS vejce_percent_rust,
n.percent_rust_potravin AS maslo_percent_rust,
o.percent_rust_potravin AS rost_tuk_percent_rust,
p.percent_rust_potravin AS pomerance_percent_rust,
q.percent_rust_potravin AS jablka_percent_rust,
r.percent_rust_potravin AS rajska_jablka_percent_rust,
s.percent_rust_potravin AS papriky_percent_rust,
t.percent_rust_potravin AS mrkev_percent_rust,
u.percent_rust_potravin AS brambory_percent_rust,
v.percent_rust_potravin AS cukr_percent_rust,
w.percent_rust_potravin AS voda_percent_rust,
y.percent_rust_potravin AS pivo_percent_rust,
z.percent_rust_potravin AS kapr_percent_rust
FROM tp_procentualni_mezirocni_narust_potraviny base
JOIN tp_procentualni_mezirocni_narust_potraviny a
	ON base.rok = a.rok 
	AND base.rok_B  = a.rok_B 
JOIN tp_procentualni_mezirocni_narust_potraviny c
	ON base.rok = c.rok 
	AND base.rok_B  = c.rok_B
JOIN tp_procentualni_mezirocni_narust_potraviny d
	ON base.rok = d.rok
	AND base.rok_B = d.rok_B
JOIN tp_procentualni_mezirocni_narust_potraviny b
	ON base.rok = b.rok
	AND base.rok_B = b.rok_B 	
JOIN tp_procentualni_mezirocni_narust_potraviny e
	ON base.rok = e.rok
	AND base.rok_B = e.rok_B
JOIN tp_procentualni_mezirocni_narust_potraviny f
	ON base.rok = f.rok
	AND base.rok_B = f.rok_B
JOIN tp_procentualni_mezirocni_narust_potraviny g
	ON base.rok = g.rok
	AND base.rok_B = g.rok_B
JOIN tp_procentualni_mezirocni_narust_potraviny h
	ON base.rok = h.rok
	AND base.rok_B = h.rok_B 	
JOIN tp_procentualni_mezirocni_narust_potraviny i
	ON base.rok = i.rok
	AND base.rok_B = i.rok_B
JOIN tp_procentualni_mezirocni_narust_potraviny j
	ON base.rok = j.rok
	AND base.rok_B = j.rok_B	
JOIN tp_procentualni_mezirocni_narust_potraviny k
	ON base.rok = k.rok
	AND base.rok_B = k.rok_B
JOIN tp_procentualni_mezirocni_narust_potraviny l
	ON base.rok = l.rok
	AND base.rok_B = l.rok_B 	
JOIN tp_procentualni_mezirocni_narust_potraviny m
	ON base.rok = m.rok
	AND base.rok_B = m.rok_B
JOIN tp_procentualni_mezirocni_narust_potraviny n
	ON base.rok = n.rok
	AND base.rok_B = n.rok_B
JOIN tp_procentualni_mezirocni_narust_potraviny o
	ON base.rok = o.rok
	AND base.rok_B = o.rok_B
JOIN tp_procentualni_mezirocni_narust_potraviny p
	ON base.rok = p.rok
	AND base.rok_B = p.rok_B 	
JOIN tp_procentualni_mezirocni_narust_potraviny q
	ON base.rok = q.rok
	AND base.rok_B = q.rok_B
JOIN tp_procentualni_mezirocni_narust_potraviny r
	ON base.rok = r.rok
	AND base.rok_B = r.rok_B
JOIN tp_procentualni_mezirocni_narust_potraviny s
	ON base.rok = s.rok
	AND base.rok_B = s.rok_B
JOIN tp_procentualni_mezirocni_narust_potraviny t
	ON base.rok = t.rok
	AND base.rok_B = t.rok_B 	
JOIN tp_procentualni_mezirocni_narust_potraviny u
	ON base.rok = u.rok
	AND base.rok_B = u.rok_B
JOIN tp_procentualni_mezirocni_narust_potraviny v
	ON base.rok = v.rok
	AND base.rok_B = v.rok_B
JOIN tp_procentualni_mezirocni_narust_potraviny w
	ON base.rok = w.rok
	AND base.rok_B = w.rok_B
JOIN tp_procentualni_mezirocni_narust_potraviny y
	ON base.rok = y.rok
	AND base.rok_B = y.rok_B
JOIN tp_procentualni_mezirocni_narust_potraviny z
	ON base.rok = z.rok
	AND base.rok_B = z.rok_B
WHERE d.nazev = 'Pšeničná mouka hladká' AND c.Nazev = 'Rýže loupaná dlouhozrnná'
	AND a.Nazev = 'Chléb konzumní kmínový' AND b.nazev = 'Pečivo pšeničné bílé'
	AND e.Nazev = 'Těstoviny vaječné' AND f.Nazev = 'Hovězí maso zadní bez kosti'
	AND g.Nazev = 'Vepřová pečeně s kostí' AND h.Nazev = 'Kuřata kuchaná celá'
	AND i.Nazev = 'Šunkový salám' AND j.Nazev = 'Mléko polotučné pasterované'
	AND k.Nazev = 'Jogurt bílý netučný' AND l.Nazev = 'Eidamská cihla'
	AND m.Nazev = 'Vejce slepičí čerstvá' AND n.Nazev = 'Máslo'
	AND o.Nazev = 'Rostlinný roztíratelný tuk' AND p.Nazev = 'Pomeranče'
	AND q.Nazev = 'Jablka konzumní' AND r.Nazev = 'Rajská jablka červená kulatá'
	AND s.Nazev = 'Papriky' AND t.Nazev = 'Mrkev'
	AND u.Nazev = 'Konzumní brambory' AND v.Nazev = 'Cukr krystalový'
	AND w.Nazev = 'Přírodní minerální voda uhličitá' 
	AND y.Nazev = 'Pivo výčepní, světlé, lahvové' AND z.nazev = 'Kapr živý'
GROUP BY base.rok_B ;




