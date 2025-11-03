-- Schema utilizado
USE mkt;

-- Boa prática : Estabelecer um limite de linhas
SELECT * FROM mkt.bank LIMIT 10;

-- Contagem de linhas da tabela
SELECT COUNT(*) AS Contagem FROM mkt.bank;wwww

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

-- Campanha herdeiro

-- Correria
-- Usando o Between
SELECT * FROM mkt.bank
WHERE y = 'yes' AND job in ('unemployed', 'student') AND age BETWEEN 18 AND 30;

-- Usando o NOT
SELECT * FROM mkt.bank
WHERE NOT  y = 'yes' AND job NOT in ('unemployed', 'student') AND age BETWEEN 18 AND 30;

-- WHERE age IS NULL / WHERE job IS NOT NULL

-- FILTRO DE STRINGS
CREATE TABLE mkt.nomes (
    primeiro_nome VARCHAR(50),
    ultimo_nome VARCHAR(50)
);

INSERT INTO mkt.nomes (primeiro_nome, ultimo_nome) VALUES 
('Ana', 'Silva'),
('Antônio', 'Costa'),
('Aline', 'Machado'),
('André', 'Lima'),
('Alice', 'Santos'),
('Alberto', 'Oliveira'),
('Amanda', 'Pereira'),
('Alex', 'Martins'),
('Aurora', 'Souza'),
('Arthur', 'Rocha'),
('Augusto', 'Almeida'),
('Ariel', 'Barros'),
('Anita', 'Carvalho'),
('Anderson', 'Dias'),
('Aurélio', 'Fernandes'),
('Afonso', 'Gonçalves'),
('Alessandra', 'Henriques'),
('Alan', 'Ishida'),
('Alana', 'Jardim'),
('Alexandre', 'Kuwabara');

SELECT * FROM mkt.nomes;

-- Filtro de string
-- Uso do UPPER
SELECT * FROM mkt.nomes
WHERE UPPER(primeiro_nome) = 'ANA'; -- filtra Ana, ANA, ana 

-- Filtro com nome que contem ___
SELECT * FROM mkt.nomes 
WHERE UPPER(primeiro_nome) LIKE '%GUSTO%';

-- BETWEEN com STRING
-- AB AC AD ... AR
SELECT * FROM mkt.nomes 
WHERE UPPER(primeiro_nome) BETWEEN 'AB' AND 'AR';

