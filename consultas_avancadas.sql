-- selecionar banco
USE restaurante;

-- criar tabelas

CREATE TABLE funcionarios (
    id_funcionario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255),
    cpf VARCHAR(14),
    data_nascimento DATE,
    endereco VARCHAR(255),
    telefone VARCHAR(15),
    email VARCHAR(100),
    cargo VARCHAR(100),
    salario DECIMAL(10,2),
    data_admissao DATE
    -- sem comentários aqui, pois são colunas
);

CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255),
    cpf VARCHAR(14),
    data_nascimento DATE,
    endereco VARCHAR(255),
    telefone VARCHAR(15),
    email VARCHAR(100),
    data_cadastro DATE
);

CREATE TABLE produtos (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(255),
    descricao TEXT,
    preco DECIMAL(10,2),
    categoria VARCHAR(100)
);

CREATE TABLE pedidos (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT, 
    FOREIGN KEY (id_cliente) REFERENCES clientes (id_cliente),
    id_funcionario INT, 
    FOREIGN KEY (id_funcionario) REFERENCES funcionarios (id_funcionario),
    id_produto INT, 
    FOREIGN KEY (id_produto) REFERENCES produtos (id_produto),
    quantidade INT,
    preco DECIMAL(10,2),
    data_pedido DATE,
    situacao VARCHAR(50)
);

-- alterar nome da tabela de info_prdutos para info_produtos  
CREATE TABLE info_produtos (
    id_info INT PRIMARY KEY AUTO_INCREMENT,
    id_produto INT,
    FOREIGN KEY (id_produto) REFERENCES produtos (id_produto),
    ingredientes TEXT,
    fornecedor VARCHAR(255)
);

-- selecionar tabela
SELECT * FROM funcionarios;

-- inserir registros de forma organizada (dados ficticios respeitando a LGPD)
INSERT INTO funcionarios (nome, cpf, data_nascimento, endereco, telefone, email, cargo, salario, data_admissao) VALUES
('Ricardo Sousa', '111.222.333-44', '1992-05-12', 'Rua Harmonia 157, São Paulo', '11987651234', 'ricardo.sousa@email.com', 'Chefe de Cozinha', 6000.00, '2019-03-15'),
-- continues...
('Sofia Alves', '000.111.222-33', '1995-06-01', 'Rua Consolação 1235, São Paulo', '11987661234', 'sofia.alves@email.com', 'Recepcionista', 2400.00, '2023-01-01');

-- Remover funcionario CPF 222.333.444-55
DELETE FROM funcionarios WHERE id_funcionario = 2;

-- selecionar tabela
SELECT * FROM clientes;

INSERT INTO clientes (nome, cpf, data_nascimento, endereco, telefone, email, data_cadastro) VALUES
('Lucas Silva', '123.456.789-01', '1990-01-15', 'Av. Brigadeiro Faria Lima, 1571, São Paulo', '11987651234', 'lucas.silva@email.com', '2023-01-12'),
-- continues...
('Priscila Ribeiro', '994.345.678-90', '1983-07-28', 'Rua Bandeira Paulista, 982, São Paulo', '11987680123', 'priscila.ribeiro@email.com', '2023-01-12');

-- selecionar tabela
SELECT * FROM produtos;

INSERT INTO produtos (nome, descricao, preco, categoria) VALUES
('Feijoada', 'Feijoada completa com arroz, farofa, couve e laranja.', 29.90, 'Prato Principal'),
-- continues...
('Pudim de Leite', 'Pudim de leite condensado com calda de caramelo.', 10.00, 'Sobremesa');

-- selecionar tabela
SELECT * FROM info_produtos;

INSERT INTO info_produtos (id_produto, ingredientes, fornecedor) VALUES
(1, 'Feijão preto, carne seca, costelinha, linguiça, arroz, farinha, couve, laranja', 'Distribuidora Central'),
-- continues...
(20, 'Leite condensado, ovos, açúcar', 'Laticínios Vale do Sereno');

-- selecionar tabela
SELECT * FROM pedidos;

INSERT INTO pedidos (id_cliente, id_funcionario, id_produto, quantidade, data_pedido, situacao) VALUES
(1, 4, 1, 2, '2024-07-01', 'Concluído'),
-- continues...
(10, 4, 11, 3, '2024-07-06', 'Pendente');

-- atualização funcionário de CPF 444.555.666-77, com o cargo de 'Garçonete' e salário de 2700.
UPDATE funcionarios 
SET cargo = 'Garçonete', salario = '2700'
WHERE id_funcionario = 4;

-- atualização todos os pedidos
UPDATE pedidos 
SET situacao = 'concluido'
WHERE data_pedido < '2024-07-06';

-- nome e a categoria dos produtos que tenham o preço superior a 30
SELECT nome, categoria 
FROM produtos 
WHERE preco > 30;

-- nome, telefone e data de nascimento dos clientes que nasceram antes do ano de 1985
SELECT nome, telefone, data_nascimento 
FROM clientes 
WHERE YEAR(data_nascimento) < 1985;

-- id do produto e os ingredientes de informações do produto para os ingredientes que contenham a palavra “carne”
SELECT id_produto, ingredientes FROM info_produtos WHERE ingredientes = 'carne';
SELECT id_produto, ingredientes FROM info_produtos WHERE ingredientes LIKE 'car%';

-- nome e a categoria dos produtos ordenados em ordem alfabética por categoria, para cada categoria deve ser ordenada pelo nome do produto
SELECT nome, categoria FROM produtos ORDER BY categoria, nome ASC;

-- Selecione os 5 produtos mais caros do restaurante
SELECT nome, preco FROM produtos ORDER BY preco DESC LIMIT 5;

-- selecionar 2 produtos da categoria 'Prato Principal' e pular 6 registros (offset = 5)
SELECT nome, categoria, preco 
FROM produtos 
WHERE categoria LIKE 'prato prin%' 
LIMIT 2 OFFSET 5;

-- backup dos dados da tabela solicitada com o nome de backup_pedidos
CREATE TABLE backup_pedidos AS SELECT * FROM pedidos;
DESC pedidos;
DESC backup_pedidos;

-- Selecione todos os pedidos que do id funcionário igual a 4 e status é igual a 'Pendente'
SELECT * FROM pedidos;
SELECT * FROM pedidos
WHERE id_funcionario = 4 
  AND situacao = 'Pendente';

-- Selecione todos os pedidos cujo status não é igual a 'Concluído'
SELECT * FROM pedidos
WHERE NOT situacao = 'Concluído';

-- Selecione os pedidos que contenham os id produtos: 1, 3, 5, 7 ou 8
SELECT * FROM pedidos
WHERE id_produto IN (1, 3, 5, 7, 9);

-- Selecione os clientes que começam com a letra c
SELECT * FROM clientes;
SELECT * FROM clientes 
WHERE nome LIKE 'C%';

-- Selecione as informações de produtos que contenham ingredientes 'carne' ou 'frango'
SELECT * FROM info_produtos
WHERE ingredientes LIKE '%carne%' 
   OR ingredientes LIKE '%frango%';

-- Selecione os produtos com o preço entre 20 a 30
SELECT * FROM produtos
WHERE preco BETWEEN 20 AND 30;

-- Atualizar id pedido 6 da tabela pedidos para status = NULL
UPDATE pedidos
SET situacao = NULL
WHERE id_pedido = 6;

-- Selecione os pedidos com status nulos
SELECT * FROM pedidos
WHERE situacao IS NULL;

-- Selecionar o id pedido e o status da tabela pedidos, porém para todos os status nulos, mostrar 'Cancelado'
SELECT id_pedido, IFNULL(situacao, 'Cancelado') AS status
FROM pedidos;

-- Selecione o nome, carga, salário dos funcionários e adicione um campo chamado media_salario, que irá mostrar 'Acima da média', para o salário > 3000, senão 'Abaixo da média'
SELECT nome, cargo, salario,
  CASE 
    WHEN salario > 3000 THEN 'Acima da média'
    ELSE 'Abaixo da média'
  END AS media_salario
FROM funcionarios;

-- Calcular a quantidade de pedidos
SELECT COUNT(*) AS total_pedidos
FROM pedidos;

-- Calcule a quantidade de clientes únicos que realizaram pedidos
SELECT COUNT(DISTINCT id_cliente) AS clientes_unicos
FROM pedidos;

-- Calcular a média de preço dos produtos
SELECT AVG(preco) AS media_preco
FROM produtos;

-- Calcular o mínimo e máximo do preço dos produtos
SELECT 
  MIN(preco) AS preco_minimo,
  MAX(preco) AS preco_maximo
FROM produtos;

-- Selecione o nome e o preço do produto e faça uma classificação dos 5 produtos mais caros
SELECT nome, preco
FROM produtos
ORDER BY preco DESC
LIMIT 5;

-- Selecione a média dos preços dos produtos agrupados por categoria
SELECT 
  categoria,
  ROUND(AVG(preco), 2) AS media_preco
FROM produtos
GROUP BY categoria;

-- Selecionar o fornecedor e a quantidade de produtos que vieram daquele fornecedor da informações de produtos
SELECT 
  fornecedor,
  COUNT(*) AS quantidade_produtos
FROM info_produtos
GROUP BY fornecedor;

-- Selecionar os fornecedores que possuem mais de um produto cadastrado
SELECT 
  fornecedor,
  COUNT(*) AS quantidade_produtos
FROM info_produtos
GROUP BY fornecedor
HAVING COUNT(*) > 1;

-- Selecionar os clientes que realizaram apenas 1 pedido
SELECT 
  id_cliente,
  COUNT(*) AS quantidade_pedidos
FROM pedidos
GROUP BY id_cliente
HAVING COUNT(*) = 1;

-- Selecionar: produtos: id, nome e descrição. E info_produtos: ingredientes
SELECT 
  p.id_produto,
  p.nome,
  p.descricao,
  i.ingredientes
FROM produtos p
JOIN info_produtos i ON p.id_produto = i.id_produto;

-- Selecionar: pedidos: id, quantidade e data. E clientes: nome e email
SELECT 
  p.id_pedido,
  p.quantidade,
  p.data_pedido,
  c.nome,
  c.email
FROM pedidos p
JOIN clientes c ON p.id_cliente = c.id_cliente;

-- Selecionar: pedidos: id, quantidade e data, clientes: nome e email, funcionarios: nome
SELECT 
  p.id_pedido,
  p.quantidade,
  p.data_pedido,
  c.nome,
  c.email,
  f.nome
FROM pedidos p
JOIN clientes c ON p.id_cliente = c.id_cliente
JOIN funcionarios f ON p.id_funcionario = f.id_funcionario;

-- Selecionar: pedidos: id, quantidade e data, clientes: nome e email, funcionarios: nome, produtos: nome e preco
SELECT 
  p.id_pedido,
  p.quantidade,
  p.data_pedido,
  c.nome AS nome_cliente,
  c.email,
  f.nome AS nome_funcionario,
  pr.nome AS nome_produto,
  pr.preco
FROM pedidos p
JOIN clientes c ON p.id_cliente = c.id_cliente
JOIN funcionarios f ON p.id_funcionario = f.id_funcionario
JOIN produtos pr ON p.id_produto = pr.id_produto;

-- Selecionar o nome dos clientes com os pedidos com status ‘Pendente’ e exibir por ordem descendente de acordo com o id do pedido
SELECT 
  c.nome AS nome_cliente,
  p.id_pedido,
  p.situacao
FROM pedidos p
JOIN clientes c ON p.id_cliente = c.id_cliente
WHERE p.situacao = 'Pendente'
ORDER BY p.id_pedido DESC;

-- Selecionar clientes sem pedidos
SELECT 
  c.nome AS nome_cliente
FROM clientes c
LEFT JOIN pedidos p ON c.id_cliente = p.id_cliente
WHERE p.id_pedido IS NULL;

-- Selecionar o nome do cliente e o total de pedidos de cada cliente
SELECT 
  c.nome AS nome_cliente,
  COUNT(p.id_pedido) AS total_pedidos
FROM clientes c
LEFT JOIN pedidos p ON c.id_cliente = p.id_cliente
GROUP BY c.id_cliente
ORDER BY total_pedidos DESC;

-- Selecionar o preço total (quantidade * preco) de cada pedido
SELECT 
  p.id_pedido,
  (p.quantidade * pr.preco) AS preco_total
FROM pedidos p
JOIN produtos pr ON p.id_produto = pr.id_produto;

-- Crie uma view chamada resumo_pedido do join entre essas tabelas
CREATE OR REPLACE VIEW resumo_pedido AS
SELECT 
  p.id_pedido,
  p.quantidade,
  p.data_pedido,
  c.nome AS nome_cliente,
  c.email,
  f.nome AS nome_funcionario,
  pr.nome AS nome_produto,
  pr.preco,
  (p.quantidade * pr.preco) AS total
FROM pedidos p
JOIN clientes c ON p.id_cliente = c.id_cliente
JOIN funcionarios f ON p.id_funcionario = f.id_funcionario
JOIN produtos pr ON p.id_produto = pr.id_produto;

SELECT * FROM resumo_pedido;

-- Selecione o id do pedido, nome do cliente e o total (quantidade * preco) de cada pedido da view resumo_pedido
SELECT 
  rp.id_pedido,
  rp.nome_cliente,
  rp.total
FROM resumo_pedido rp;

-- Repita a consulta da questão 3, utilizando o campo total adicionado
SELECT 
  rp.id_pedido,
  rp.nome_cliente,
  rp.total
FROM resumo_pedido rp;

-- Repita a consulta da pergunta anterior, com uso do EXPLAIN para verificar e compreender o JOIN que está oculto na nossa query
EXPLAIN
SELECT 
  rp.id_pedido,
  rp.nome_cliente,
  rp.total
FROM resumo_pedido rp;

DROP FUNCTION IF EXISTS BuscaIngredientesProduto;

-- Crie uma função chamada ‘BuscaIngredientesProduto’, que irá retornar os ingredientes da tabela info produtos, quando passar o id de produto como argumento (entrada) da função.
DELIMITER $$

CREATE FUNCTION BuscaIngredientesProduto(id_prod INT)
RETURNS TEXT
DETERMINISTIC
BEGIN
  DECLARE ingredientes TEXT;

  -- Usando GROUP_CONCAT para concatenar os ingredientes em uma única linha
  SELECT GROUP_CONCAT(ingredientes SEPARATOR ', ')
  INTO ingredientes
  FROM info_produtos
  WHERE id_produto = id_prod;

  RETURN ingredientes;
END $$

DELIMITER ;

SELECT BuscaIngredientesProduto(10);

-- Crie uma função chamada 'mediaPedido' que retornará uma mensagem dizendo que o total do pedido é acima, abaixo ou igual a média de todos os pedidos, quando passar o id do pedido como argumento da função
DROP FUNCTION IF EXISTS mediaPedido;

DELIMITER $$

CREATE FUNCTION mediaPedido(pedido_id INT)
RETURNS VARCHAR(50)
DETERMINISTIC
BEGIN
  DECLARE total_pedido DECIMAL(10,2);
  DECLARE media_total DECIMAL(10,2);
  DECLARE resultado VARCHAR(50);

  -- calcular total do pedido
  SELECT (p.quantidade * pr.preco)
  INTO total_pedido
  FROM pedidos p
  JOIN produtos pr ON p.id_produto = pr.id_produto
  WHERE p.id_pedido = pedido_id;

  -- calcular média de todos os pedidos
  SELECT AVG(p.quantidade * pr.preco)
  INTO media_total
  FROM pedidos p
  JOIN produtos pr ON p.id_produto = pr.id_produto;

  -- comparação e retorno
  IF total_pedido > media_total THEN
    SET resultado = 'Acima da média';
  ELSEIF total_pedido < media_total THEN
    SET resultado = 'Abaixo da média';
  ELSE
    SET resultado = 'Igual à média';
  END IF;

  RETURN resultado;
END $$

DELIMITER ;

SELECT mediaPedido(5);
SELECT mediaPedido(6);

