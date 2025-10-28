-- CREATE DATABASE comunidade;
USE comunidade;

DROP TABLE IF EXISTS vendas;
CREATE TABLE vendas(
	id INT,
    cod_cliente INT,
    produto INT,
    qtd_vendidada INT,
    data_venda DATE
);

DROP TABLE IF EXISTS clientes;
CREATE TABLE clientes (
	id_cliente INT,
    nome VARCHAR(100),
    sobrenome VARCHAR(100),
    sexo CHAR(1),
    data_nascimento VARCHAR(10)
);

DROP TABLE IF EXISTS produtos;
CREATE TABLE produtos(
	codigo_produto INT,
    nome_produto VARCHAR(100),
    marca VARCHAR(100),
    categoria VARCHAR(100),
    preco_unitario FLOAT(5)
);

INSERT INTO vendas VALUES (1,1,1,2,'2024-01-01'),
						  (2,5,3,2, '2024-01-02'),
                          (3,1,3,1, '2024-01-01'),
                          (4,3,1,1, '2024-01-01'),
                          (5,4,2,1, '2024-01-01'),
                          (6,6,3,2, '2024-01-02'),
                          (7,2,2,3, '2024-01-02'),
                          (8,1,1,4, '2024-01-01'),
                          (9,2,2,1, '2024-01-01'),
                          (10,4,1,5, '2024-01-01');
                          
INSERT INTO clientes VALUES (1, 'Gustavo', 'Guanabara', 'M', '1980-02-24'),
							(2, 'Fernanda', 'Guimarães', 'F', '1985-03-24'),
                            (3, 'Victor', 'Khrun', 'M', '1990-03-20'),
                            (4, 'Igor', 'Valverde', 'M', '1994-03-20'),
                            (5, 'Isabella', 'Fernandes', 'F', '1995-03-07'),
                            (6, 'Natasha', 'Kromanov', 'F', '1993-03-24'),
                            (7, 'Lucas', 'da Silva', 'M', '1999-07-24'),
                            (8, 'Paloma', 'Rocha', 'F', '1985-03-10'),
                            (9, 'Gabriella', 'Quinteiro', 'F', '1996-11-12'),
                            (10, 'Matthew', 'Andrade', 'M', '1994-12-10');

INSERT INTO produtos VALUES (1, 'Notebook', 'Acer', 'Tecnologia', 3480),
							(2, 'TV Smart', 'LG', 'Tecnologia', 5500),
                            (3, 'Case', 'Bahger', 'Papelaria', 150),
                            (4, 'Sofá', 'Italyan', 'Casa', 3500),
                            (5, 'Cook top', 'Italinia', 'Casa', 4150.50);

INSERT INTO produtos VALUES (10, 'Notebook', 'Acer', 'Tecnologia', 3480);

SELECT * FROM produtos;
SELECT * FROM clientes;
SELECT * FROM vendas;

# O Group BY agrupa linhas de uma tabela que têm os mesmos valores em uma ou mais colunas - Remove duplicatas de um mesmo dado
SELECT *
	FROM produtos
GROUP BY nome_produto;

# Para saber quantas vezes esse dado se repete, use o COUNT(*)
SELECT nome_produto, COUNT(*)
	FROM produtos
GROUP BY nome_produto;

SELECT *
FROM clientes 
LEFT JOIN vendas 
ON clientes.id_cliente = vendas.cod_cliente;

SELECT
	v.id, v.cod_cliente, v.data_venda, v.produto
    , c.nome, c.sobrenome, COUNT(*) AS Repeticoes
   FROM vendas v
   LEFT JOIN clientes c
	ON v.cod_cliente = c.id_cliente
GROUP by cod_cliente;

SELECT 
	v.id, v.cod_cliente, v.data_venda, v.produto
    , c.nome, c.sobrenome
    , p.nome_produto
FROM vendas v
LEFT JOIN clientes c
	ON v.cod_cliente = c.id_cliente
LEFT JOIN produtos p
	ON v.produto = p.codigo_produto;



SELECT 
	v.id, v.cod_cliente, v.data_venda, v.produto
    , c.nome, c.sobrenome
    , p.nome_produto
    , COUNT(*) AS Repeticoes
FROM vendas v
LEFT JOIN clientes c
	ON v.cod_cliente = c.id_cliente
LEFT JOIN produtos p
	ON v.produto = p.codigo_produto
GROUP BY v.id, v.cod_cliente, v.data_venda, v.produto, c.nome, c.sobrenome, p.nome_produto;


# Alterar algum dado (UPDATE)
UPDATE produtos SET codigo_produto = 1;

/*
	UPDATE <tabela>
	SET coluna = valor
	FROM <tabela>
*/



SELECT * FROM produtos;

ALTER TABLE produtos ENGINE = InnoDB;

SET autocommit=0;
START TRANSACTION;

UPDATE produtos
SET marca = 'Acer';

SELECT * FROM produtos;

ROLLBACK;

SHOW CREATE TABLE produtos;
SELECT * FROM produtos;

UPDATE produtos
SET marca = 'Acer'
WHERE codigo_produto = 10;

SELECT * FROM produtos;

ROLLBACK;


/* 
START TRANSACTION;

UPDATE vendas
SET produto = 1;

ROLLBACK;
*/

# Deletar alguma informação (DELETE)
DELETE FROM produtos
WHERE codigo_produto = 10;

SELECT * FROM produtos;

# Subquery - Dado duplicado 
SELECT a.nome_produto, a.marca, a.categoria, a.Duplicado
	, CASE WHEN a.Duplicado > 1 THEN 'Sim'
		   WHEN a.Duplicado = 1 THEN 'Não'
	  END AS Duplicado
FROM 
(
	SELECT 
		nome_produto, marca, categoria, 
		COUNT(*) AS Duplicado
	FROM produtos
	GROUP BY nome_produto, marca, categoria
) a
WHERE Duplicado > 1
GROUP BY a.Duplicado, a.nome_produto, a.marca, a.categoria;

# Condicionamento (IF) do GROUP BY - HAVING (Pode usar funções como SUM, AVG, COUNT)
SELECT 
	 nome_produto
    , marca
    , categoria
    , COUNT(*) AS Duplicado
FROM produtos
GROUP BY nome_produto, marca, categoria
HAVING	
	COUNT(*) > 1;

# Uso do GROUP BY E DO COUNT
SELECT nome_produto
	,  COUNT(*) AS Registros_Totais
FROM produtos
GROUP BY nome_produto;

# Remover/Filtrar Duplicatas - DISTINCT

SELECT DISTINCT nome_produto FROM PRODUTOS;

SELECT 
	   nome_produto
	,  COUNT(DISTINCT preco_unitario) AS Registros_Totais
FROM produtos
GROUP BY nome_produto;

-- limpeza dos dados

# Concatenar dados - CONCAT
SELECT 
	id_cliente, 
    CONCAT(nome , ' ', sobrenome) AS Nome_Completo,
    CASE 
		WHEN sexo = 'M' THEN 'Masculino'
        WHEN sexo = 'F' THEN 'Feminino'
	END AS sexo,
    EXTRACT(YEAR FROM data_nascimento) AS Ano_Nascimento,
    EXTRACT(MONTH FROM data_nascimento) AS Mes_Nascimento,
    EXTRACT(YEAR from CURRENT_DATE) - EXTRACT(YEAR FROM data_nascimento) AS Idade
FROM clientes;


-- 
SELECT
	v.data_venda AS Data_Venda
    
    -- CATEGORIA QUE MAIS VENDE
    , SUM(CASE WHEN p.categoria LIKE 'Tecnologia' THEN p.preco_unitario
		  ELSE 0
          END) AS TEC_AMOUNT
          
	, SUM(CASE WHEN p.categoria LIKE 'Papelaria' THEN p.preco_unitario
		  ELSE 0
          END) AS PAPER_AMOUNT
          
	-- CASA É CATEGORIA QUE MENOS VENDE
	, SUM(CASE WHEN p.categoria LIKE 'Casa' THEN p.preco_unitario
		  ELSE 0
          END) AS HOME_AMOUNT
	, CONCAT(c.nome,' ',c.sobrenome) AS 'Nome Completo'
FROM vendas v
LEFT JOIN produtos p
	ON v.produto = p.codigo_produto
LEFT JOIN clientes c
	ON v.cod_cliente = c.id_cliente
GROUP BY v.data_venda, p.nome_produto, p.preco_unitario
ORDER BY v.data_venda






