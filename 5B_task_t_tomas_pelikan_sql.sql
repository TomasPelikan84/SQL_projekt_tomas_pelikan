-- 5. Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, 
-- projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem? 

-- porovnání cen potravin, mzdy a zmeny HDP

CREATE OR REPLACE VIEW t_tomas_pelikan_sql_paty_ukol_B as
SELECT
base.rok, b.prumerna_hodnota AS banany, c.prumerna_hodnota AS cukr, 
d.prumerna_hodnota AS eidamska_cihla, e.prumerna_hodnota AS hovezi,
f.prumerna_hodnota AS chleb, g.prumerna_hodnota AS jablka,
h.prumerna_hodnota AS jogurt, i.prumerna_hodnota AS kapr,
j.prumerna_hodnota AS brambory, k.prumerna_hodnota AS kurata,
l.prumerna_hodnota AS maslo, m.prumerna_hodnota AS mleko,
n.prumerna_hodnota AS mrkev, o.prumerna_hodnota AS papriky,
p.prumerna_hodnota AS pecivo, q.prumerna_hodnota AS pivo,
r.prumerna_hodnota AS pomerance, s.prumerna_hodnota AS mineralni_voda,
t.prumerna_hodnota AS mouka, u.prumerna_hodnota AS rajska_jablka,
v.prumerna_hodnota AS tuk, w.prumerna_hodnota AS ryze,
x.prumerna_hodnota AS salam, y.prumerna_hodnota AS testoviny,
z.prumerna_hodnota AS vejce, zz.prumerna_hodnota AS veprova_pecene,
a.prumerna_hodnota AS prumerna_mzda, base.GDP, 
LAG(base.GDP ,1) OVER (PARTITION BY country  ORDER BY rok) AS GDP_predchozi_rok
FROM t_tomas_pelikan_project_sql_secondary_final base
JOIN t_tomas_pelikan_project_sql_primary_final a
	ON base.rok = a.rok
JOIN t_tomas_pelikan_project_sql_primary_final b
	ON base.rok = b.rok
JOIN t_tomas_pelikan_project_sql_primary_final c
	ON base.rok = c.rok
JOIN t_tomas_pelikan_project_sql_primary_final d
	ON base.rok = d.rok
JOIN t_tomas_pelikan_project_sql_primary_final e
	ON base.rok = e.rok
JOIN t_tomas_pelikan_project_sql_primary_final f
	ON base.rok = f.rok 
JOIN t_tomas_pelikan_project_sql_primary_final g
	ON base.rok = g.rok
JOIN t_tomas_pelikan_project_sql_primary_final h
	ON base.rok = h.rok
JOIN t_tomas_pelikan_project_sql_primary_final i
	ON base.rok = i.rok
JOIN t_tomas_pelikan_project_sql_primary_final j
	ON base.rok = j.rok
JOIN t_tomas_pelikan_project_sql_primary_final k
	ON base.rok = k.rok	
JOIN t_tomas_pelikan_project_sql_primary_final l
	ON base.rok = l.rok
JOIN t_tomas_pelikan_project_sql_primary_final m
	ON base.rok = m.rok	
JOIN t_tomas_pelikan_project_sql_primary_final n
	ON base.rok = n.rok
JOIN t_tomas_pelikan_project_sql_primary_final o
	ON base.rok = o.rok
JOIN t_tomas_pelikan_project_sql_primary_final p
	ON base.rok = p.rok
JOIN t_tomas_pelikan_project_sql_primary_final q
	ON base.rok = q.rok
JOIN t_tomas_pelikan_project_sql_primary_final r
	ON base.rok = r.rok	
JOIN t_tomas_pelikan_project_sql_primary_final s
	ON base.rok = s.rok	
JOIN t_tomas_pelikan_project_sql_primary_final t
	ON base.rok = t.rok	
JOIN t_tomas_pelikan_project_sql_primary_final u
	ON base.rok = u.rok	
JOIN t_tomas_pelikan_project_sql_primary_final v
	ON base.rok = v.rok	
JOIN t_tomas_pelikan_project_sql_primary_final w
	ON base.rok = w.rok
JOIN t_tomas_pelikan_project_sql_primary_final x
	ON base.rok = x.rok	
JOIN t_tomas_pelikan_project_sql_primary_final y
	ON base.rok = y.rok	
JOIN t_tomas_pelikan_project_sql_primary_final z
	ON base.rok = z.rok	
JOIN t_tomas_pelikan_project_sql_primary_final zz
	ON base.rok = zz.rok
WHERE base.country = 'Czech republic' AND base.rok >= '2006' AND base.rok <= '2018'
AND b.nazev = 'Banány žluté' AND c.nazev = 'Cukr krystalový' AND d.nazev = 'Eidamská cihla'
AND e.nazev = 'Hovězí maso zadní bez kosti' AND f.nazev = 'Chléb konzumní kmínový' AND g.nazev = 'Jablka konzumní'
AND h.nazev = 'Jogurt bílý netučný' AND i.nazev = 'Kapr živý' AND j.nazev = 'Konzumní brambory' 
AND k.nazev = 'Kuřata kuchaná celá' AND l.nazev = 'Máslo' AND m.nazev = 'Mléko polotučné pasterované'
AND n.nazev = 'Mrkev' AND o.nazev = 'Papriky' AND p.nazev = 'Pečivo pšeničné bílé' AND q.nazev = 'Pivo výčepní, světlé, lahvové'
AND r.nazev = 'Pomeranče' AND s.nazev = 'Přírodní minerální voda uhličitá' AND t.nazev = 'Pšeničná mouka hladká'
AND u.nazev = 'Rajská jablka červená kulatá' AND v.nazev = 'Rostlinný roztíratelný tuk' AND w.nazev = 'Rýže loupaná dlouhozrnná'
AND x.nazev = 'Šunkový salám' AND y.nazev = 'Těstoviny vaječné' AND z.nazev = 'Vejce slepičí čerstvá'
AND zz.nazev = 'Vepřová pečeně s kostí'
GROUP BY base.rok;




