CREATE TABLE Compras (
    Id INT,
    Primeiro_Nome VARCHAR(50),
    Ultimo_Nome VARCHAR(50),
    Idade INT,
    UF VARCHAR(2),
    Data_Compra DATE,
  	Valor_Compra FLOAT
);

INSERT INTO Compras (Id, Primeiro_Nome, Ultimo_Nome, Idade, UF, Data_Compra, Valor_Compra) VALUES
(1, 'João', 'Silva', 28, 'SP', '2024-01-10', 13.50),
(2, 'Maria', 'Fernandes', 34, 'RJ', '2024-01-11', 10.40),
(3, 'Lucas', 'Moura', 23, 'MG', '2024-01-12', 95),
(1, 'João', 'Silva', 28, 'SP', '2024-01-13', 15.50),
(4, 'Paula', 'Barros', 22, 'RS', '2024-01-14', 27.40),
(2, 'Maria', 'Fernandes', 34, 'RJ', '2024-01-15', 33),
(5, 'Ana', 'Costa', 30, 'BA', '2024-01-16', 45),
(6, 'Ricardo', 'Almeida', 31, 'PE', '2024-01-17', 55),
(3, 'Lucas', 'Moura', 23, 'MG', '2024-01-18', 60.15),
(1, 'João', 'Silva', 28, 'SP', '2024-01-19', 75),
(7, 'Sofia', 'Cardoso', 27, 'ES', '2024-01-20', 15.75),
(8, 'Carlos', 'Dutra', 29, 'MT', '2024-01-21', 35.99),
(2, 'Maria', 'Fernandes', 34, 'RJ', '2024-01-22', 40),
(4, 'Paula', 'Barros', 22, 'RS', '2024-01-23', 55),
(9, 'Fernando', 'Pereira', 33, 'SC', '2024-01-24', 60),
(10, 'Camila', 'Gonçalves', 25, 'PR', '2024-01-25', 35.50),
(5, 'Ana', 'Costa', 30, 'BA', '2024-01-26', 46),
(1, 'João', 'Silva', 28, 'SP', '2024-01-27', 40.99),
(11, 'Luiza', 'Freitas', 21, 'GO', '2024-01-28', 55),
(6, 'Ricardo', 'Almeida', 31, 'PE', '2024-01-29', 56.99),
(12, 'Tiago', 'Rocha', 24, 'TO', '2024-01-30', 55.56),
(7, 'Sofia', 'Cardoso', 27, 'ES', '2024-01-31', 60);

SELECT * FROM Compras LIMIT 10;


-- SQL SERVER VS MYSQL
 
-- No MYSQL funciona:
SELECT Id, Primeiro_Nome, AVG(Valor_Compra) AS AVG_Valor
FROM Compras
GROUP BY 1, 2;


-- No SQL Server não funciona
SELECT Id, Primeiro_Nome, AVG(Valor_Compra) AS AVG_Valor
FROM Compras
GROUP BY 1, 2;


-- A ORDEM DO WHERE
-- Group by vem depois do Where, olha isso:

-- Funciona ok:
SELECT Id, Primeiro_Nome, AVG(Valor_Compra) AS AVG_Compra
FROM Compras
GROUP BY Id, Primeiro_Nome;

-- Não funciona:
SELECT Id, Primeiro_Nome, AVG(Valor_Compra) AS AVG_Compra
FROM Compras
GROUP BY Id, Primeiro_Nome
WHERE avg_compra > 55;

-- Não funciona:
SELECT Id, Primeiro_Nome, AVG(Valor_Compra) AS AVG_Compra
FROM Compras
WHERE avg_compra > 55
GROUP BY Id, Primeiro_Nome
;

-- Funciona ok:
SELECT Id, Primeiro_Nome, AVG(Valor_Compra) AS AVG_Compra
FROM Compras
WHERE Idade > 40
GROUP BY Id, Primeiro_Nome
;

-- Funciona Ok
SELECT Id, Primeiro_Nome, AVG(Valor_Compra) AS AVG_Compra
FROM Compras
WHERE Valor_Compra * 2 < 50
GROUP BY Id, Primeiro_Nome
;

-- Funciona ok:

SELECT Id, Primeiro_Nome, AVG(Valor_Compra) AS AVG_Compra
FROM Compras
WHERE 2*Valor_Compra > 40
GROUP BY 1,2
HAVING AVG_Compra > 40
ORDER BY AVG_Compra ASC
;
