SELECT 
    *
FROM
    bank;

SELECT 
    job, MIN(balance) AS Minimo, MAX(balance) AS Maximo, SUM(balance) AS Balanco_Contabil, AVG(balance) AS Media_Contabil, MED
FROM
    bank
GROUP BY job;