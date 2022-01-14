CREATE DATABASE if not exists tarefa3;
use tarefa3;

create table Cliente(
	idCliente INT UNSIGNED NOT NULL PRIMARY KEY,
    nome TEXT NOT NULL,
    telefone INT NOT NULL,
    dataDeNasc DATE,
    cpf BIGINT,
    endereco TEXT
)engine=InnoDB;

create table Fornecedor(
	idFornecedor INT PRIMARY KEY,
    empresa TEXT,
    CNPJ_CPF BIGINT,
    endereco TEXT,
    telefone INT,
    email VARCHAR(255)
)engine=InnoDB;

create table Produtos(
	idProdutos int not null primary key,
    nome text,
    quantidade int unsigned,
    idFornecedor int not null,
    foreign key (idFornecedor) references Fornecedor (idFornecedor)
)engine=InnoDB;

create table vendas(
	idVendas int not null primary key,
    quantidade bigint unsigned,
    idCliente int unsigned not null,
    idProdutos int not null,
    foreign key (idCliente) references Cliente (idCliente),
    foreign key (idProdutos) references Produtos (idProdutos)
)engine=InnoDB;

create user 'Gustavo'@'localhost' identified by '12345678';

grant select, insert, update, delete 
on tarefa3.* to Gustavo@localhost
with grant option;