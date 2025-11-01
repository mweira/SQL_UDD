-- Schema utilizado
USE mkt;

-- Boa prática : Estabelecer um limite de linhas
SELECT * FROM mkt.bank LIMIT 10;

-- Contagem de linhas da tabela
SELECT COUNT(*) AS Contagem FROM mkt.bank;

-- Contagem de empregos - O DISTINCT seleciona valores únicos
SELECT COUNT(DISTINCT job) As Contagem FROM mkt.bank;

-- Contagem de empregados por emprego
SELECT job, COUNT(job) AS Contagem
FROM bank
GROUP BY job;

-- Contagem de desempregados
SELECT job, COUNT(job) AS Contagem
FROM bank
WHERE job="unemployed";

SELECT job, COUNT(*) AS Contagem FROM bank WHERE job="unemployed";

-- Ao usar o AND ou o OR, importante sempre se lembrar dos () para definir qual informação deve ser lida primeiro

 -- USO DO AND - Contagem de desempregados em ABRIL 
SELECT * FROM bank WHERE job="unemployed" AND month="apr";  

SELECT COUNT(*) AS Contagem
FROM bank
WHERE job="unemployed" AND month="apr";

SELECT COUNT(*) AS Contagem FROM bank WHERE job="unemployed" AND month="apr";

-- Pessoas que estavam desempregadas, foram contatadas em abril e aceitaram nosso produto
SELECT * FROM bank WHERE job="unemployed" AND month="apr" AND y="yes";

SELECT COUNT(*) AS Contagem FROM bank
WHERE job="unemployed" AND month="apr" AND y="yes";

SELECT job, COUNT(*) AS Contagem FROM bank WHERE job="unemployed" AND month="apr" AND y="yes";

-- Uso do OR
-- Filtra emprego como desempregado OU estudante
SELECT * FROM bank WHERE job="unemployed" OR job="student";

-- Contagem do total
SELECT COUNT(*) AS Contagem
FROM bank
WHERE job="unemployed" OR job="student";

-- Contagem por categoria
SELECT job, COUNT(*) AS Contagem
FROM bank
WHERE job="unemployed" OR job="student"
GROUP BY job;

 -- Pessoas que estavam desempregadas OU eram estudantes, foram contatadas em abril e aceitaram nosso produto
SELECT * FROM bank WHERE (job="unemployed" OR job="student") AND month="apr" AND y="yes" ;

SELECT COUNT(job) AS Contagem FROM bank 
WHERE (job="unemployed" OR job="student")
AND month="apr" AND y="yes" ;

SELECT COUNT(*) AS Contagem FROM bank WHERE (job="unemployed" OR job="student") AND month="apr" AND y="yes";

-- Pessoas que nasceram em Janeiro e nao aceitaram nosso produto OU as pessoas que nasceram em Fevereiro e aceitaram nosso produto
SELECT * FROM mkt.bank WHERE (month = 'jan' AND y='no') OR (month = 'feb' AND y = 'yes');

SELECT * FROM mkt.bank
WHERE (month = 'jan' AND y='no') OR (month = 'feb' AND y = 'yes');

-- Utilização do IN () depois do WHERE, filtra todos empregos entre parênteses
SELECT * FROM bank 
WHERE job IN ("unemployed","student","blue-collar");

-- Contagem total dos empregos
SELECT job, COUNT(*) AS Contagem FROM bank 
WHERE job IN ("unemployed","student","blue-collar");

-- Contagem total dos empregos POR CATEGORIA
SELECT job, COUNT(*) AS Contagem FROM bank 
WHERE job IN ("unemployed","student","blue-collar")
GROUP BY job;
