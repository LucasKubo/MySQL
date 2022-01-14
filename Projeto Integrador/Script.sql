create database projetobd2;
use projetobd2;

-- Criando tabelas
create table funcionario(
	id_funcionario int primary key not null auto_increment,
    nome varchar(45),
    cpf varchar(11) unique,
    rg varchar(9) unique,
    telefone varchar(11),
    salario decimal(8,2)
)engine=InnoDB;

create table endereco_funcionario(
	id_funcionario int primary key not null,
	cep varchar(8),
    numero int,
    constraint fk_endereco_funcionario
	foreign key (id_funcionario) references funcionario (id_funcionario)
    on delete cascade 
    on update cascade
)engine=InnoDB;

create table historico_funcionario(
	id_funcionario_demitido int primary key,
    nome varchar(45),
    cpf varchar(11),
    telefone varchar(11)
)engine = InnoDB;

create table vendedor(
	id_vendedor int primary key not null auto_increment,
    id_funcionario int not null, 
    nome varchar(45),
    cpf varchar(11),
    rf varchar(9),
    telefone varchar(11),
    salario decimal(8,2),
    index fk_funcionario (id_funcionario ASC),
    constraint fk_funcionario_vendedor
		foreign key (id_funcionario)
        references funcionario (id_funcionario)
        on delete cascade
        on update cascade
)engine=innoDB;

create table cliente(
	id_cliente int primary key not null auto_increment,
    nome varchar(45),
    telefone varchar(11)
)engine=innoDB;

create table endereco_cliente (
	id_cliente int primary key not null auto_increment,
    cep varchar(8),
    numero int,
	constraint fk_cliente_endereco_cliente
		foreign key (id_cliente)
        references cliente (id_cliente)
        on delete cascade
        on update cascade
)engine=innoDB;

create table fornecedor(
	id_fornecedor int primary key not null auto_increment,
    nome varchar(60),
    cnpj varchar(11),
    localizacao varchar(60)
)engine=innoDB;

create table estoque(
	id_estoque int primary key not null auto_increment,
    quantidade int
)engine=innoDB;

create table notebook(
	id_notebook int primary key not null auto_increment,
    id_fornecedor int not null,
    id_estoque int not null,
    nome varchar(45),
    marca varchar(45),
    modelo varchar(45),
    preco decimal(7,2),
    index fk_fornecedor (id_fornecedor asc),
    index fk_estoque (id_estoque asc),
    constraint fk_notebook_fornecedor
		foreign key (id_fornecedor)
        references fornecedor (id_fornecedor)
        on update cascade
        on delete cascade,
	constraint fk_notebook_estoque
		foreign key (id_estoque)
        references estoque (id_estoque)
        on update cascade
        on delete cascade
)engine=InnoDB;

create table venda(
	id_venda int primary key not null auto_increment,
	data_venda date,
    id_notebook int,
    id_cliente int,
    id_vendedor int,
    index fk_venda_notebook (id_notebook asc),
    index fk_venda_cliente (id_cliente asc),
    index fk_venda_vendedor (id_vendedor asc),
    constraint fk_venda_notebook
		foreign key (id_notebook) references notebook (id_notebook)
		on update cascade on delete cascade,
	constraint fk_venda_cliente
		foreign key (id_cliente) references cliente (id_cliente)
		on update cascade on delete cascade,
	constraint fk_venda_vendedor
		foreign key (id_vendedor) references vendedor (id_vendedor)
		on update cascade on delete cascade
)engine=InnoDB;

-- inserindo dados
insert into funcionario (nome,cpf,rg,telefone,salario) values ("Lucas","1100111110","124523423","82739286142",4000);
insert into funcionario (nome,cpf,rg,telefone,salario) values ("Leonardo","1111011100","224522323","95273958613",3700);
insert into funcionario (nome,cpf,rg,telefone,salario) values ("Joao","1011111000","164123423","92729286142",3000);
insert into funcionario (nome,cpf,rg,telefone,salario) values ("Davi","1110110000","193523423","97739286142",3800);
insert into funcionario (nome,cpf,rg,telefone,salario) values ("Victor","1101100000","104523423","99739286142",3900);
insert into funcionario (nome,cpf,rg,telefone,salario) values ("Alexandre","66760949080","275420061","99181700306",4400);
insert into funcionario (nome,cpf,rg,telefone,salario) values ("Rodrigo","26851456052","432859937","99153885177",4900);
insert into funcionario (nome,cpf,rg,telefone,salario) values ("Evandro","17206014020","273307319","93785567496",3500);

insert into endereco_funcionario values((select id_funcionario from funcionario where cpf="1100111110"),"98263726",410);
insert into endereco_funcionario values((select id_funcionario from funcionario where cpf="1111011100"),"38263726",110);
insert into endereco_funcionario values((select id_funcionario from funcionario where cpf="1011111000"),"48253726",982);
insert into endereco_funcionario values((select id_funcionario from funcionario where cpf="1110110000"),"88265726",182);
insert into endereco_funcionario values((select id_funcionario from funcionario where cpf="1101100000"),"18264726",1902);
insert into endereco_funcionario values((select id_funcionario from funcionario where cpf="66760949080"),"69307070",126);
insert into endereco_funcionario values((select id_funcionario from funcionario where cpf="26851456052"),"52165460",623);
insert into endereco_funcionario values((select id_funcionario from funcionario where cpf="17206014020"),"96202050",256);

-- Corrigindo campo (rg) da tabela vendedor
alter table vendedor
change rf rg varchar(9);

insert into vendedor (id_funcionario,nome,cpf,rg,telefone,salario) values (1,"Lucas","1100111110","124523423","82739286142",4000);
insert into vendedor (id_funcionario,nome,cpf,rg,telefone,salario) values (3,"Leonardo","1111011100","224522323","95273958613",3700);

alter table cliente add column cpf varchar(11) unique;
insert into cliente (nome,cpf,telefone) values("Davi","1300131210","95270058113");
insert into cliente (nome,cpf,telefone) values("Edson","3405121262","99270058196");
insert into cliente (nome,cpf,telefone) values("Rodrigo","2230431217","92575068133");
insert into cliente (nome,cpf,telefone) values("Robson","6420151213","94272358165");
insert into cliente values(null,"Carlos","27608357070","95705678589");
insert into cliente values(null, "Ricardo","35079895063","92472515296");
insert into cliente values(null, "Gilvan", "52680573080", "95985247213");
insert into cliente values(null,"Antonio","52902168047","92969817719");

insert into endereco_cliente values(1,"88263727",450);
insert into endereco_cliente values(2,"28263325",611);
insert into endereco_cliente values(3,"15254722",122);
insert into endereco_cliente values(4,"52235726",582);
insert into endereco_cliente values(5,"59133325",234);
insert into endereco_cliente values(6,"64217085",982);
insert into endereco_cliente values(7,"69050084",3827);
insert into endereco_cliente values(8,"35701306",2981);

alter table fornecedor modify column cnpj varchar(14);
insert into fornecedor (nome,cnpj,localizacao) values("Samsung","41225480000176","São Paulo");
insert into fornecedor (nome,cnpj,localizacao) values("Acer","39846322000191","Rio de Janeiro");
insert into fornecedor (nome,cnpj,localizacao) values("LeNovo","00137646000115","Belo Horizonte");
insert into fornecedor (nome,cnpj,localizacao) values("LG","33166434000115","Pará");

-- removendo tabela estoque
alter table notebook drop constraint fk_notebook_estoque;
alter table notebook drop column id_estoque;
drop table estoque;

-- adicionando campo de quantidade ao notebook
alter table notebook add column quantidade smallint;

-- removendo campo marca de notebook
alter table notebook drop column marca;

insert into notebook (id_fornecedor,nome,modelo,preco,quantidade) values (1, "BookIntel","H6274",3500,13);
insert into notebook (id_fornecedor,nome,modelo,preco,quantidade) values (1, "BookIntel 6","H6284",4500,19);
insert into notebook (id_fornecedor,nome,modelo,preco,quantidade) values (1, "BookIntel +","H6294",5000,22);
insert into notebook (id_fornecedor,nome,modelo,preco,quantidade) values (3, "Ideapad Flex 5","H6284",4500,12);
insert into notebook (id_fornecedor,nome,modelo,preco,quantidade) values (3, "Ideapad Flex 8","H6294",7000,22);
insert into notebook (id_fornecedor,nome,modelo,preco,quantidade) values (2, "Nitro 5","H6284",5500,23);
insert into notebook (id_fornecedor,nome,modelo,preco,quantidade) values (4, "LG 1 +","H6294",2000,16);

insert into venda (data_venda,id_notebook,id_cliente,id_vendedor) values ("2021-03-12",2,1,2);
insert into venda (data_venda,id_notebook,id_cliente,id_vendedor) values ("2021-03-12",3,2,2);
insert into venda (data_venda,id_notebook,id_cliente,id_vendedor) values ("2021-03-14",5,3,1);
insert into venda (data_venda,id_notebook,id_cliente,id_vendedor) values ("2021-03-16",6,2,1);
insert into venda (data_venda,id_notebook,id_cliente,id_vendedor) values ("2021-03-13",1,4,1);

-- alterando tabela de venda (adicionando campo de quantidade)
alter table venda add column quantidade int unsigned;
update venda set quantidade = 4 where id_venda = 1;
update venda set quantidade = 1 where id_venda = 2;
update venda set quantidade = 2 where id_venda = 3;
update venda set quantidade = 1 where id_venda = 4;
update venda set quantidade = 3 where id_venda = 5;
update venda set quantidade = 1 where id_venda = 6;

-- Criando Views 
create view funcionario_endereco as
select f.id_funcionario,nome, cep, numero from funcionario f 
join endereco_funcionario e on f.id_funcionario = e.id_funcionario;

create view cliente_endereco as
select nome, telefone, cep, numero as 'numero da residencia' from cliente c 
join endereco_cliente e on c.id_cliente = e.id_cliente;

create view resumo_vendas as
select v.data_venda as 'data da venda', v.quantidade , n.nome 'notebook' , c.nome as 'cliente', ven.nome as 'Vendedor'  from venda v 
left join notebook n on n.id_notebook = v.id_notebook
left join cliente c on c.id_cliente = v.id_cliente
left join vendedor ven on ven.id_vendedor = v.id_vendedor;

-- Criando triggers
DELIMITER $
create trigger tgr_venda_insert after insert on venda
for each row
begin
	update notebook set quantidade = quantidade - new.quantidade where id_notebook = new.id_notebook;
end $
DELIMITER ;

DELIMITER $
create trigger tgr_funcionario_delete before delete on funcionario
for each row
begin
	insert into historico_funcionario values(old.id_funcionario,old.nome,old.cpf,old.telefone);
end $ 
DELIMITER ;

DELIMITER $
create trigger tgr_funcionario_update before update on funcionario
for each row
begin
	update vendedor set telefone = new.telefone where telefone = old.telefone;
end $ 
DELIMITER ;

-- testando triggers
insert into venda values (null, "2021-03-25" , 2, 4, 1, 2);
delete from funcionario where id_funcionario = 4;
update funcionario set telefone = "95273944499" where id_funcionario = 2;

-- Criando functions
delimiter //
create function fn_verifica_estoque (quantidade int)
	returns varchar(40) deterministic
    begin
		if quantidade <= 10 then return 'Baixo';
			elseif quantidade <= 20 then return 'Médio';
            else return 'cheio';
        end if;
	end //;
delimiter ;

delimiter //
create function fn_calc_distancia (localizacao varchar(60))
	returns varchar(40) deterministic
    begin
		if localizacao = "São Paulo" then return '10 km';
			elseif localizacao = "Pará" then return '1500 km';
            elseif localizacao = "Belo Horizonte" then return '624 km';
            elseif localizacao = "Rio de Janeiro" then return '467km';
            else return 'Não definido';
        end if;
	end //;
delimiter ;

delimiter //
create function calc_imposto(salario decimal(10,0))
	returns decimal(10,2) deterministic
	begin
		declare valor_imposto decimal(10,2);
		if salario <= 3200 then set valor_imposto = salario * 7/100;
			elseif salario <= 2800 then set valor_imposto = salario * 9/100;
            elseif salario <= 3500 then set valor_imposto = salario * 10/100;
			elseif salario <= 4000 then set valor_imposto = salario * 12/100;
			else set valor_imposto = 4500 * 14/100;
		end if;
		return valor_imposto;
	end //;
delimiter ;

-- Criando procedures
create procedure bonificar_funcionario (aumento decimal)
update funcionario set salario = salario + salario * aumento/100 where salario < 4000;
   
create procedure cortar_gastos (salario decimal (10,2))
delete from funcionario where salario > 5500;   

create procedure verificar_compras_do_dia ()
select * from venda where data_venda = curdate();

-- inserindo mais vendas
insert into venda (data_venda,id_notebook,id_cliente,id_vendedor,quantidade) values ("2021-03-20",1,5,1,2);
insert into venda (data_venda,id_notebook,id_cliente,id_vendedor,quantidade) values ("2021-03-22",3,7,2,3);
insert into venda (data_venda,id_notebook,id_cliente,id_vendedor,quantidade) values ("2021-03-23",2,6,2,4);
insert into venda (data_venda,id_notebook,id_cliente,id_vendedor,quantidade) values ("2021-03-19",4,8,1,1);
insert into venda (data_venda,id_notebook,id_cliente,id_vendedor,quantidade) values ("2021-03-28",2,7,2,2);

-- Realizando consultas
-- Visualizar tudo de todas tabelas
select * FROM cliente;
select * FROM endereco_cliente;
select * from endereco_funcionario;
select * from fornecedor;
select * from funcionario;
select * from historico_funcionario;
select * from notebook;
select * from venda;
select * from vendedor;
-- Buscar informações do funcionário Lucas
select * from funcionario where nome="Lucas";
-- Buscar Id das vendas realizadas por Leonardo no dia 12/03/2021. Informe também, o cpf do funcionário.
select id_venda, cpf as "cpf do vendedor" from venda 
join vendedor on venda.id_vendedor = vendedor.id_vendedor 
where vendedor.nome = "Leonardo" and data_venda = "2021-03-12";
-- Buscar cliente que tem o cpf 3405121262
select * from cliente where cpf = 3405121262;
-- Buscar nome do vendedor que já vendeu para o cliente Carlos
select vdor.nome as "Vendedor que já vendeu para Carlos" from vendedor vdor 
join venda vda on vda.id_vendedor = vdor.id_vendedor
join cliente c on vda.id_cliente = c.id_cliente
where c.nome = "Carlos";
-- Buscar nome e cpf do funcionário com maior salário
select nome as "Funcionario com maior salário", cpf from funcionario where salario >= all (select salario from funcionario);
-- Qual é o nome do vendedor que vendeu a maior quantidade de produtos ?
select nome as "Vendedor que mais vendeu produtos" from
(select  nome, sum(quantidade) as "produtos_vendidos" from venda join vendedor 
on venda.id_vendedor = vendedor.id_vendedor group by venda.id_vendedor) as t1
where t1.produtos_vendidos >= all(select produtos_vendidos from (select  nome, sum(quantidade) as "produtos_vendidos" from venda join vendedor 
on venda.id_vendedor = vendedor.id_vendedor group by venda.id_vendedor) as t2);
-- Buscar nome, cpf e cep de cada funcionário
select nome, cpf, cep from funcionario f join endereco_funcionario e on f.id_funcionario = e.id_funcionario; 
-- Buscar nome de cada notebook e de seu respectivo fornecedor
select n.nome "notebook", f.nome as "fornecedor" from notebook n join fornecedor f on f.id_fornecedor = n.id_fornecedor;
-- Buscar data da venda que teve maior quantidade de produtos vendidos, nome do vendedor e nome do cliente.
select data_venda, vendedor.nome as "Vendedor", cliente.nome as "Cliente" from venda 
join vendedor on vendedor.id_vendedor = venda.id_vendedor
join cliente on cliente.id_cliente = venda.id_cliente
where quantidade >= all (select quantidade from venda);
-- Buscar endereço do cliente que comprou mais produtos
select cep as "Cep do cliente que mais comprou", numero "Nº da residência do cliente que mais comprou"from endereco_cliente join
(select id_cliente, max(total_comprado) from 
(select c.id_cliente, sum(quantidade) as "total_comprado" from cliente c 
join venda v on c.id_cliente = v.id_cliente group by nome) as compras_por_cliente) as cliente_maior_compra
on endereco_cliente.id_cliente = cliente_maior_compra.id_cliente;
-- Buscar nome do fornecedor que tem o notebook em menor quantidade no estoque.
select nome as "Fornecedor com menor estoque" from fornecedor join 
(select id_fornecedor, min(quantidade) as "menor estoque" from notebook) as menor_estoque
on fornecedor.id_fornecedor = menor_estoque.id_fornecedor;
-- Qual é a média de notebooks vendidos?
select round(avg(quantidade)) as "média de vendas" from venda;
-- Qual é a distância da sede do notebook Nitro 5?
select fn_calc_distancia(localizacao) as "Distância do fornecedor do Nitro 5" from fornecedor where localizacao = (select localizacao from fornecedor f join notebook n on f.id_fornecedor = n.id_fornecedor where n.nome = "Nitro 5");
-- Mostrar nome dos clientes que moram em uma residência com número menor que 500
select nome as "cliente que moram em uma residência com número menor que 500" from cliente c join endereco_cliente e on c.id_cliente = e.id_cliente where numero < 500;
-- Quais dias o cliente Gilvan realizou compra?
select data_venda as "Dias que Gilvan comprou" from venda where id_cliente in (select id_cliente from cliente where nome = "Gilvan");
-- Qual é o imposto aplicado para o funcionário com menor salário?
select calc_imposto(min(salario)) as "Imposto para o menor salário" from funcionario;
-- Qual é a quantidade de vendas realizadas para cada modelo de notebook?
select modelo, v.quantidade as "total de vendas" from venda v 
join notebook n on v.id_notebook = n.id_notebook
group by modelo;
-- Qual fornecedor possui a maior quantidade de produtos em estoque?
select f.nome as "Fornecedor com mais produtos em estoque" from fornecedor f 
join notebook n on n.id_fornecedor = f.id_fornecedor 
where n.quantidade =(select max(quantidade) from fornecedor f 
					join notebook n on f.id_fornecedor = n.id_fornecedor);
-- Qual é o nome e preço do notebook que está acima da média de preços?
select nome as "Notebook com preço acima da média", preco from notebook where preco > (select round(avg(preco)) from notebook);
-- Quais funcionários têm o nome começado com a letra L ?
select nome as "Funcionários com nome começados pela letra L" from funcionario where nome like "L%";

-- Views
select * from cliente_endereco;
select * from funcionario_endereco;
select * from resumo_vendas;