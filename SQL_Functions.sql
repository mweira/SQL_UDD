# -- 1) Cria tabela de exemplo
CREATE TABLE sales (
    sale_id     INTEGER PRIMARY KEY,    -- id da venda
    salesperson TEXT NOT NULL,         -- vendedor
    region      TEXT NOT NULL,         -- região
    product     TEXT NOT NULL,         -- produto
    quantity    INTEGER NOT NULL,      -- quantidade vendida
    unit_price  DECIMAL(10,2) NOT NULL,-- preço unitário
    sale_date   DATE NOT NULL
);

-- 2) Insere dados de exemplo
INSERT INTO sales (sale_id, salesperson, region, product, quantity, unit_price, sale_date) VALUES
(1,  'Ana',    'Sul',    'Caneta',   10, 1.50, '2025-01-05'),
(2,  'Bruno',  'Norte',  'Caderno',  5,  8.00, '2025-01-06'),
(3,  'Carla',  'Sul',    'Lápis',    20, 0.80, '2025-01-07'),
(4,  'Ana',    'Sul',    'Caneta',   7,  1.50, '2025-01-10'),
(5,  'Diego',  'Leste',  'Caderno',  3,  8.00, '2025-01-11'),
(6,  'Bruno',  'Norte',  'Caneta',   12, 1.50, '2025-01-12'),
(7,  'Carla',  'Sul',    'Caderno',  4,  8.00, '2025-01-15'),
(8,  'Edu',    'Oeste',  'Agenda',   2, 12.00, '2025-01-16'),
(9,  'Ana',    'Sul',    'Agenda',   1, 12.00, '2025-01-17'),
(10, 'Diego',  'Leste',  'Lápis',    30, 0.80, '2025-01-18'),
(11, 'Fátima', 'Norte',  'Caneta',   6,  1.50, '2025-01-19'),
(12, 'Bruno',  'Norte',  'Agenda',   1, 12.00, '2025-01-20');

SELECT * FROM sales;

-- 3) Exemplos básicos de agregação
-- Total de itens vendidos (soma de quantity)
SELECT SUM(quantity) AS total_items_sold FROM sales;

-- Total em receita (soma de quantity * unit_price)
SELECT SUM(quantity * unit_price) AS total_revenue FROM sales;

-- Preço médio por unidade (AVG sobre unit_price)
SELECT AVG(unit_price) AS avg_unit_price FROM sales;

-- Quantidade média por venda
SELECT AVG(quantity) AS avg_quantity_per_sale FROM sales;

-- Contagem de vendas (número de linhas)
SELECT COUNT(*) AS total_sales FROM sales;

-- Contagem de vendedores distintos
SELECT COUNT(DISTINCT salesperson) AS distinct_salespeople FROM sales;

-- Menor e maior quantidade vendida em uma venda
SELECT MIN(quantity) AS min_quantity, MAX(quantity) AS max_quantity FROM sales;

-- Desvio padrão e variância da receita por venda (alguns SGBDs usam STDDEV_POP/STDDEV_SAMP)
-- Standard SQL: STDDEV_POP / STDDEV_SAMP (Postgres); MySQL: STDDEV_POP ou STDDEV_SAMP pode variar
SELECT
  STDDEV_POP(quantity * unit_price) AS stddev_revenue_per_sale, 
  VAR_POP(quantity * unit_price) AS var_revenue_per_sale
FROM sales;

-- 4) Agregações com GROUP BY (por vendedor)
SELECT
  salesperson,
  COUNT(*)                AS sales_count,
  SUM(quantity)           AS total_items,
  SUM(quantity * unit_price) AS revenue,
  AVG(quantity)           AS avg_quantity
FROM sales
GROUP BY salesperson
ORDER BY revenue DESC;

-- 5) GROUP BY com HAVING (filtrar grupos)
-- Ex.: vendedores com receita total > 30
SELECT salesperson, SUM(quantity * unit_price) AS revenue
FROM sales
GROUP BY salesperson
HAVING SUM(quantity * unit_price) > 30;

-- 6) Agregação por região e produto
SELECT region, product, SUM(quantity) AS total_qty
FROM sales
GROUP BY region, product
ORDER BY region, total_qty DESC;

-- 7) Agregação com DISTINCT dentro de agregada (soma de preços distintos, exemplo)
-- Nem todo SGBD aceita SUM(DISTINCT ...) (mas a maioria aceita COUNT(DISTINCT ...))
SELECT COUNT(DISTINCT product) AS distinct_products_sold FROM sales;

-- 8) Usando window functions (soma cumulativa / média por vendedor)
-- Soma da receita por vendedor em cada linha (não colapsa linhas)
SELECT
  sale_id,
  salesperson,
  region,
  product,
  quantity,
  unit_price,
  quantity * unit_price AS sale_revenue,
  SUM(quantity * unit_price) OVER (PARTITION BY salesperson) AS revenue_by_salesperson,
  AVG(quantity) OVER (PARTITION BY salesperson) AS avg_quantity_by_salesperson
FROM sales
ORDER BY salesperson, sale_id;

-- Maior venda (em valor) por vendedor - versão MySQL 8+
WITH ranked AS (
  SELECT
    salesperson,
    sale_id,
    quantity * unit_price AS sale_revenue,
    ROW_NUMBER() OVER (PARTITION BY salesperson ORDER BY quantity * unit_price DESC) AS rn
  FROM sales
)
SELECT
  salesperson,
  sale_id,
  sale_revenue
FROM ranked
WHERE rn = 1;

-- Alternative portable: use ROW_NUMBER() to get top sale per salesperson
WITH ranked AS (
  SELECT *,
    ROW_NUMBER() OVER (PARTITION BY salesperson ORDER BY quantity * unit_price DESC) AS rn
  FROM sales
)
SELECT * FROM ranked WHERE rn = 1;

-- 10) String aggregation (concatenar produtos vendidos por vendedor)
-- Postgres: string_agg(product, ', ')
-- MySQL: GROUP_CONCAT(product ORDER BY product SEPARATOR ', ')
-- SQLite: group_concat(product, ', ')
-- Portable example (Postgres syntax shown):
SELECT
  salesperson,
  GROUP_CONCAT(DISTINCT product ORDER BY product SEPARATOR ', ') AS products_sold
FROM sales
GROUP BY salesperson;

-- 11) Exemplos com CASE dentro do aggregate (portável)
SELECT
  region,
  SUM(quantity * unit_price) AS total_revenue,
  SUM(CASE WHEN product = 'Agenda' THEN quantity * unit_price ELSE 0 END) AS agenda_revenue,
  SUM(CASE WHEN product = 'Caneta' THEN quantity ELSE 0 END) AS caneta_total_units
FROM sales
GROUP BY region;