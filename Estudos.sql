USE comunidade;

SELECT c.*, v.*,p.* 
FROM vendas v 
LEFT JOIN clientes c 
	ON v.cod_cliente = c.id_cliente 
LEFT JOIN produtos p
	ON v.produto = p.codigo_produto;