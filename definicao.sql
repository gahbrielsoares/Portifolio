use restaurante;

create table funcionarios(
	id_funcionario int primary key auto_increment,
    nome varchar(255),
    cpf varchar(14),
    data_nascimento date,
    endereco varchar(255),
    telefone varchar(15),
    email varchar(100),
    cargo varchar(100),
    salario decimal(10,2),
	data_admissao date
    );
    
create table clientes(
	id_cliente int primary key auto_increment,
    nome varchar(255),
    cpf varchar(14),
    data_nascimento date,
    endereco varchar(255),
    telefone varchar(15),
    email varchar(100),
    data_cadastro date
);

create table produtos(
	id_produto int primary key auto_increment,
    nome varchar(255),
    descricao text,
    preco decimal(10,2),
    categoria varchar(100)
);

create table pedidos(
	id_pedido int primary key auto_increment,
    id_cliente int, 
    foreign key (id_cliente) references clientes (id_cliente),
    id_funcionario int, 
    foreign key (id_funcionario) references funcionarios (id_funcionario),
    id_produto int, 
    foreign key (id_produto) references produtos (id_produto),
    quantidade int,
    preco decimal(10,2),
    data_pedido date,
    situacao varchar(50)
);

create table info_prdutos(
	id_info int primary key auto_increment,
    id_produto int,
    foreign key (id_produto) references produtos (id_produto),
    ingredientes text,
    fornecedor varchar(255)
);




