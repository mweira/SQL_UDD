SELECT * FROM bank;

SELECT job, MIN(balance) AS Minimo, MAX(balance) AS Maximo, SUM(balance) AS Balanco_Contabil, AVG(balance) AS Media_Contabil
FROM mkt.bank
GROUP BY job;

SELECT marital, COUNT(marital) AS Contagem FROM bank GROUP BY marital;

SELECT job, housing FROM bank GROUP BY job;