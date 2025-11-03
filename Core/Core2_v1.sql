
/***********************
 * 1. BANCO DE DADOS
 ***********************/
-- Criar banco de dados
CREATE DATABASE IF NOT EXISTS empresa;

-- Listar bancos existentes
SHOW DATABASES;

-- Selecionar banco
USE empresa;

-- Excluir banco
-- DROP DATABASE empresa;

/***********************
 * 2. TABELAS
 ***********************/
-- Criar tabela de funcionários
CREATE TABLE IF NOT EXISTS funcionarios (
    id INT AUTO_INCREMENT PRIMARY KEY,      -- Chave primária
    nome VARCHAR(100),                      -- Nome do funcionário
    cargo VARCHAR(50),                      -- Cargo
    salario DECIMAL(10,2),                  -- Salário
    data_admissao DATE                       -- Data de admissão
);

-- Criar tabela de departamentos
CREATE TABLE IF NOT EXISTS departamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50)
);

-- Visualizar estrutura das tabelas
DESCRIBE funcionarios;
DESCRIBE departamentos;

-- Alterar tabela: adicionar coluna
ALTER TABLE funcionarios ADD COLUMN departamento_id INT;

-- Adicionar chave estrangeira
ALTER TABLE funcionarios
    ADD CONSTRAINT fk_departamento
    FOREIGN KEY (departamento_id) REFERENCES departamentos(id);

-- Excluir tabela
-- DROP TABLE funcionarios;

/***********************
 * 3. INSERÇÃO DE DADOS
 ***********************/
-- Inserir departamentos
INSERT INTO departamentos (nome) VALUES ('TI'), ('Financeiro'), ('RH');

-- Inserir funcionários
INSERT INTO funcionarios (nome, cargo, salario, data_admissao, departamento_id)
VALUES
('Ana Souza', 'Analista', 5500.00, '2021-03-01', 1),
('Carlos Lima', 'Gerente', 8500.00, '2020-07-15', 2),
('João Pedro', 'Dev', 6200.00, '2022-01-10', 1),
('Mariana Alves', 'Analista', 5800.00, '2021-09-05', 3);

/***********************
 * 4. CONSULTAS SIMPLES
 ***********************/
-- Selecionar todos os dados
SELECT * FROM funcionarios;

-- Selecionar colunas específicas
SELECT nome, cargo FROM funcionarios;

-- Filtrar registros
SELECT * FROM funcionarios WHERE salario > 6000;

-- Ordenar resultados
SELECT * FROM funcionarios ORDER BY salario DESC;

-- Limitar resultados
SELECT * FROM funcionarios LIMIT 2;

-- Remover duplicatas
SELECT DISTINCT cargo FROM funcionarios;

/***********************
 * 5. JUNÇÕES (JOINS)
 ***********************/
-- INNER JOIN: retorna apenas registros correspondentes
SELECT f.nome, f.cargo, d.nome AS departamento
FROM funcionarios f
INNER JOIN departamentos d ON f.departamento_id = d.id;

-- LEFT JOIN: retorna todos da esquerda, mesmo sem correspondência
SELECT f.nome, f.cargo, d.nome AS departamento
FROM funcionarios f
LEFT JOIN departamentos d ON f.departamento_id = d.id;

/***********************
 * 6. FUNÇÕES DE AGREGACÃO
 ***********************/
-- Contagem de funcionários
SELECT COUNT(*) AS total_funcionarios FROM funcionarios;

-- Soma e média de salários
SELECT SUM(salario) AS soma_salarios, AVG(salario) AS media_salarios
FROM funcionarios;

-- Agrupar por cargo
SELECT cargo, COUNT(*) AS qtd, AVG(salario) AS media
FROM funcionarios
GROUP BY cargo;

-- Filtrar grupos
SELECT cargo, AVG(salario) AS media
FROM funcionarios
GROUP BY cargo
HAVING AVG(salario) > 6000;

/***********************
 * 7. FUNÇÕES NUMÉRICAS
 ***********************/
SELECT 
    salario,
    ROUND(salario, 0) AS arredondado,
    FLOOR(salario) AS para_baixo,
    CEIL(salario) AS para_cima,
    MOD(salario, 1000) AS resto_divisao
FROM funcionarios;

/***********************
 * 8. FUNÇÕES DE STRING
 ***********************/
SELECT
    nome,
    UPPER(nome) AS maiusculo,
    LOWER(nome) AS minusculo,
    LENGTH(nome) AS tamanho_bytes,
    CHAR_LENGTH(nome) AS tamanho_caracteres,
    CONCAT('Funcionário: ', nome) AS descricao,
    REPLACE(cargo, 'Analista', 'Dev') AS cargo_modificado
FROM funcionarios;

/***********************
 * 9. FUNÇÕES DE DATA E HORA
 ***********************/
SELECT
    nome,
    data_admissao,
    YEAR(data_admissao) AS ano,
    MONTH(data_admissao) AS mes,
    DAY(data_admissao) AS dia,
    DATEDIFF(CURDATE(), data_admissao) AS dias_na_empresa,
    DATE_ADD(data_admissao, INTERVAL 6 MONTH) AS daqui_6_meses
FROM funcionarios;

/***********************
 * 10. CONDICIONAIS
 ***********************/
-- IF simples
SELECT
    nome,
    salario,
    IF(salario > 6000, 'Acima da média', 'Abaixo da média') AS classificacao
FROM funcionarios;

-- CASE WHEN
SELECT
    nome,
    CASE
        WHEN salario >= 8000 THEN 'Alta renda'
        WHEN salario >= 5000 THEN 'Média'
        ELSE 'Baixa'
    END AS categoria
FROM funcionarios;

/***********************
 * 11. TRANSAÇÕES
 ***********************/
START TRANSACTION;

UPDATE funcionarios SET salario = salario * 1.10 WHERE cargo = 'Analista';

-- Para desfazer a alteração
-- ROLLBACK;

-- Para confirmar alteração
COMMIT;

/***********************
 * 12. VIEWS
 ***********************/
-- Criar view
CREATE OR REPLACE VIEW vw_funcionarios_ti AS
SELECT nome, cargo, salario
FROM funcionarios
WHERE departamento_id = 1;

-- Consultar view
SELECT * FROM vw_funcionarios_ti;

/***********************
 * 13. USUÁRIOS E PERMISSÕES
 ***********************/
-- Criar usuário
-- CREATE USER 'joao'@'localhost' IDENTIFIED BY 'senha123';

-- Conceder permissões
-- GRANT ALL PRIVILEGES ON empresa.* TO 'joao'@'localhost';
-- FLUSH PRIVILEGES;

/***********************
 * 14. ÍNDICES E CONSTRAINTS
 ***********************/
-- Criar índice
CREATE INDEX idx_salario ON funcionarios(salario);

-- Visualizar índices
SHOW INDEX FROM funcionarios;

/***********************
 * 15. ADMINISTRAÇÃO E DIAGNÓSTICO
 ***********************/
-- Ver plano de execução
EXPLAIN SELECT * FROM funcionarios WHERE salario > 6000;

-- Otimizar tabela
OPTIMIZE TABLE funcionarios;

