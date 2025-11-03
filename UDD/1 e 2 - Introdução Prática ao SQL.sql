/*
Para inserir um comentário
*/

-- Isso também é um comentário

# Isso também kkkkkkkkk VAMBORA

# Criar o banco (CREATE DATABASE)
CREATE DATABASE comunidade;

# Qual banco você está utilizando 
USE comunidade;

TRUNCATE TABLE aluno;
TRUNCATE TABLE cursos;

# Descrição da tabela (DESC)
DESC aluno;

# Desfazer a tabela caso ela já exista (DROP TABLE IF EXISTS)
DROP TABLE IF EXISTS aluno;

# Criar a tabela (CREATE TABLE) 
CREATE TABLE aluno(
	matricula INT NOT NULL AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    nascimento DATE,
    PRIMARY KEY (matricula)
);


# Inserir dados na tabela (INSERT INTO table_name (column1, column2, column3, ...) VALUES (value1, value2, value3, ...) 
INSERT INTO aluno (nome, nascimento) VALUES ('Naruto Uzumaki', '1994-02-15'),
											('Matheus de Almeida', '1994-07-20'),
											('Igor da Fonseca', '1988-02-20'),
											('Beatriz Godoi', '1996-02-15'),
											('Ross Geller', '1970-02-15');

INSERT INTO aluno (nome, nascimento) VALUES ('Fernando da Silva', '1994-02-15'),
											('Grazi Lacerda', '1994-07-20'),
											('Vitor Fábio', '1988-02-20'),
											('Lucas Silva e Silva', '1996-02-15'),
											('Gabriella Damácio', '1970-02-15');

# Extrair todas informações da tabela (SELECT) 
SELECT * FROM aluno;

# Extrair uma informação espécifica da tabela (WHERE) 
SELECT * FROM aluno WHERE nome = 'Naruto Uzumaki';

# AND 
SELECT * FROM aluno WHERE nome = 'Naruto Uzumaki' AND nascimento = '1994-02-15';

# OR
SELECT * FROM aluno WHERE nome = 'Naruto Uzumaki' OR nascimento = '1994-07-20';

# Extrair mais de uma informação/linha da tabela (IN) 
SELECT * FROM aluno WHERE nome IN ('Matheus de Almeida', 'Beatriz Godoi');

# Encontrar um padrão especificado (LIKE)
# O sinal de porcentagem (%) representa zero, um ou vários caracteres.
# O sinal de sublinhado (_) representa um único caractere.

# i no início
SELECT * FROM aluno WHERE nome LIKE 'i%';

# i no fim
SELECT * FROM aluno WHERE nome LIKE '%i';

# i em qualquer posição 
SELECT * FROM aluno WHERE nome LIKE '%i%';

SELECT nome, nascimento, DAYOFWEEK(nascimento) AS 'Dia da Semana' FROM aluno WHERE DAYOFWEEK(nascimento) BETWEEN 2 AND 6;

# Extrair uma coluna específica da tabela 
SELECT nome FROM aluno;

# Extrair informações em ordem alfabética/crescente (ORDER BY)
# Crescente (ASC) - Não há obrigatoriedade em utilizá-lo
SELECT * FROM aluno ORDER BY nome;
SELECT * FROM aluno ORDER BY nascimento ASC;

# Decrescente (DESC)
SELECT * FROM aluno ORDER BY nome DESC;
SELECT * FROM aluno ORDER BY nascimento DESC;

# Contagem de dados/número de linhas (COUNT) 
SELECT COUNT(*) FROM aluno;
SELECT COUNT(*) FROM cursos;

SELECT
	COUNT(*) AS 'Registros'
FROM aluno;

/* Extrair informações específicas (EXTRACT) */

 -- Se fosse um VARCHAR(100) --> EXTRACT(YEAR FROM CAST(nascimento IN REAL))

SELECT CURRENT_DATE;
SELECT NOW();

SELECT 
	nome, nascimento,
EXTRACT(YEAR FROM nascimento) AS 'Ano_Nascimento',
EXTRACT(MONTH FROM nascimento) AS 'Mês_Nascimento',
EXTRACT(DAY FROM nascimento) AS 'Dia_Nascimento',
DAYOFWEEK(nascimento) AS 'Dia_da_Semana', -- Variável categórica 
	CASE
		WHEN DAYOFWEEK(nascimento) = 1 THEN 'Domingo'
		WHEN DAYOFWEEK(nascimento) = 2 THEN 'Segunda'
		WHEN DAYOFWEEK(nascimento) = 3 THEN 'Terça'
		WHEN DAYOFWEEK(nascimento) = 4 THEN 'Quarta'
		WHEN DAYOFWEEK(nascimento) = 5 THEN 'Quinta'
		WHEN DAYOFWEEK(nascimento) = 6 THEN 'Sexta'
		WHEN DAYOFWEEK(nascimento) = 7 THEN 'Sábado'
    END AS 'Dia_da_Semana'
FROM aluno 
WHERE nome = 'Naruto Uzumaki';

SELECT 
	nome, nascimento,
EXTRACT(YEAR FROM nascimento) AS 'Ano_Nascimento',
EXTRACT(MONTH FROM nascimento) AS 'Mês_Nascimento',
EXTRACT(DAY FROM nascimento) AS 'Dia_Nascimento',
DAYOFWEEK(nascimento) AS 'Dia_da_Semana', -- Variável categórica 
	CASE
		WHEN DAYOFWEEK(nascimento) = 1 THEN 'Domingo'
		WHEN DAYOFWEEK(nascimento) = 2 THEN 'Segunda'
		WHEN DAYOFWEEK(nascimento) = 3 THEN 'Terça'
		WHEN DAYOFWEEK(nascimento) = 4 THEN 'Quarta'
		WHEN DAYOFWEEK(nascimento) = 5 THEN 'Quinta'
		WHEN DAYOFWEEK(nascimento) = 6 THEN 'Sexta'
		WHEN DAYOFWEEK(nascimento) = 7 THEN 'Sábado'
    END AS 'Dia_da_Semana'
FROM aluno 
ORDER BY nascimento;

# A palavra-chave LEFT JOIN retorna todos os registros da tabela esquerda (tabela1) e os registros correspondentes (se houver) da tabela direita (tabela2).
SELECT nome, c.* FROM aluno LEFT JOIN cursos c ON aluno.matricula = c.matricula;

# A palavra-chave INNER JOIN seleciona registros que têm valores correspondentes em ambas as tabelas.
SELECT nome, c.* FROM aluno INNER JOIN cursos c ON aluno.matricula = c.matricula;
SELECT nome, c.* FROM aluno JOIN cursos c ON aluno.matricula = c.matricula;

# A palavra-chave RIGHT JOIN retorna todos os registros da tabela direita (tabela2) e os registros correspondentes (se houver) da tabela esquerda (tabela1).
SELECT nome, c.* FROM aluno RIGHT JOIN cursos c ON aluno.matricula = c.matricula;

-- Criação de Views
CREATE VIEW view_aluno AS
SELECT
	matricula, nome,
DAYOFWEEK(nascimento) AS 'Dia da Semana',
EXTRACT(YEAR FROM nascimento) AS 'Ano_Nascimento' ,
	CASE -- categórica
		WHEN DAYOFWEEK(nascimento) = 1 THEN 'Domingo'
		WHEN DAYOFWEEK(nascimento) = 2 THEN 'Segunda'
		WHEN DAYOFWEEK(nascimento) = 3 THEN 'Terça'
		WHEN DAYOFWEEK(nascimento) = 4 THEN 'Quarta'
		WHEN DAYOFWEEK(nascimento) = 5 THEN 'Quinta'
		WHEN DAYOFWEEK(nascimento) = 6 THEN 'Sexta'
		WHEN DAYOFWEEK(nascimento) = 7 THEN 'Sábado'
	END AS 'Dia_da_Semana',
EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM nascimento) AS 'Idade'
FROM aluno
WHERE DAYOFWEEK(nascimento) BETWEEN 2 AND 6; -- Excluir sábado e domingo

SELECT * FROM view_aluno;

-- Cálculo da Idade
SELECT EXTRACT(YEAR FROM CURRENT_DATE) AS 'Ano_Atual'
	,  EXTRACT(YEAR FROM nascimento) AS "Ano_Nascimento"
    ,  EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM nascimento) AS 'Idade'
FROM aluno
;

/*
1 = Domingo, 
2 = Segunda,
3 = Terça,
4 = Quarta,
5 = Quinta,
6 = Sexta
7 = Sábado

CASE
    WHEN DAYOFWEEK(nascimento) = 1 THEN "Domingo"
    WHEN DAYOFWEEK(nascimento) = 2 THEN "Segunda"
    ...
    WHEN DAYOFWEEK(nascimento) = 7 THEN "Sábado"
END AS 'Dia_da_Semana'
*/

DESC cursos;

DROP TABLE IF EXISTS cursos;

CREATE TABLE cursos(
	cod_curso VARCHAR(50) NOT NULL,
    nome_curso VARCHAR(100),
    materia VARCHAR(50),
    matricula INT
    -- FOREIGN KEY (matricula) 
	-- REFERENCES aluno(matricula)
	-- ON DELETE CASCADE
);

INSERT INTO cursos (cod_curso, nome_curso, materia, matricula) VALUES ('ENGQ120241', 'Engenharia Química', 'Processos', 2),
																	  ('COMP120241', 'Ciência da Computação', 'Inteligência Artificial', 3),
                                                                      ('FIS120241','Física','Mecânica',5),
                                                                      ('FIS120241','Física','Mecânica',1),
                                                                      ('GEO120241','Paleontologia','Evolução',10);

INSERT INTO cursos (cod_curso, nome_curso, materia, matricula) VALUES ('DADOS120241', 'Ciência de Dados', 'Estrutura de Dados', 7),
																	  ('MAT120241', 'Matemática Bacharel', 'Álgebra Linear', 9),
                                                                      ('LICMAT120241','Matemática Licenciatura', 'Didádica',8);
                                                                      
/* Extrair todas as informações da tabela cursos */
SELECT * FROM cursos;

/* Extrair uma coluna específica da tabela cursos */
SELECT nome_curso FROM cursos;
