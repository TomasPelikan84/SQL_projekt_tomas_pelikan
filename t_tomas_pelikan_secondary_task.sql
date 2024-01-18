

CREATE OR REPLACE TABLE t_tomas_pelikan_project_sql_secondary_final
SELECT
e.country ,e.`year` AS rok,e.population ,e.GDP ,e.gini ,e.taxes ,e.fertility ,
e.mortaliy_under5 ,c.avg_height,c.life_expectancy,c.median_age_2018 , c.capital_city 
FROM economies e 
JOIN countries c 
	ON e.country = c.country 
WHERE c.continent = 'Europe' AND e.`year` >= '2006' AND e.`year` <= '2018';





