CREATE DATABASE tarefa4;
use tarefa4;

CREATE TABLE if not exists paciente(
	codp int unsigned not null auto_increment,
    nome varchar(70),
    idade tinyint not null,
    cidade varchar(80),
    cpf varchar(11) not null,
    doenca varchar(120),
    primary key (codp),
    UNIQUE INDEX cpf_uk (cpf)
)engine=InnoDB;

CREATE TABLE if not exists ambulatorio (
	nroa int unsigned not null auto_increment,
    andar int not null,
    capacidade int not null,
    primary key (nroa)
)engine=InnoDB;

CREATE TABLE if not exists medico (
	codm int unsigned not null auto_increment,
	nome varchar(70),
    idade tinyint unsigned not null,
    especialidade varchar(100),
    cpf varchar(11) not null,
    cidade varchar(100),
    nroa int unsigned not null,
    primary key (codm),
    UNIQUE INDEX cpf_uk (cpf),
    INDEX fk_nroa (nroa),
    CONSTRAINT fk_medico_ambulatorio
		FOREIGN KEY (nroa)
		REFERENCES ambulatorio (nroa)
)engine=innoDb;

CREATE TABLE funcionario (
	codf int unsigned not null auto_increment,
    nome varchar(70),
    idade varchar(3),
    cidade varchar(80),
    salario double,
    cpf varchar(11),
    primary key (codf),
    UNIQUE INDEX cpf_uk (cpf)
)engine=InnoDB;

CREATE TABLE consulta (
	codm int unsigned not null,
    codp int unsigned not null,
    data date,   
    hora time,
    INDEX codm_fk (codm),
    foreign key (codm)
    references medico (codm)
)engine=innoDB;
-- Fiz um teste de criar a tabela sem a CONSTRAINT para a FOREIGN KEY para ver o que acontecia. Então tive que alterar a tabela depois --
ALTER TABLE consulta DROP FOREIGN KEY consulta_ibfk_1; -- Apaguei a FK gerada automaticamente --
ALTER TABLE consulta ADD CONSTRAINT consulta_medico_fk foreign key(codm) references medico (codm); -- Adicionei a fk com o nome que eu escolhi --
-- Agora vou adicionar um index para a outra fk--
ALTER TABLE consulta ADD INDEX codp_fk (codp);
-- Por fim, vou criar a fk --
ALTER TABLE consulta ADD CONSTRAINT consulta_paciente_fk FOREIGN KEY (codp) references paciente (codp);
-- Definindo a pk -- 
ALTER TABLE consulta ADD primary key (codm,codp);

-- Preenchendo aa tabela de paciente -- 
insert into paciente values (1,'Ana',20,'Florianópolis','20000200000','gripe');
insert into paciente values (2,'Paulo',24,'Palhoca ','20000220000','fratura');
insert into paciente values (3,'Lucia',30,'Biguacu','22000200000','tendinite');
insert into paciente values (4,'Carlos',28,'Joinville','11000110000','sarampo');

-- Preenchendo tabela de ambulatorio --
insert into ambulatorio values (1,1,30);
insert into ambulatorio values (2,1,50);
insert into ambulatorio values (3,2,40);
insert into ambulatorio values (4,2,25);
insert into ambulatorio values (5,2,55);

-- Preenchendo funcionario --
insert into funcionario values (1,'Rita',32,'Sao Jose', 1200, '20000100000');
insert into funcionario values (2 ,'Maria',55,'Palhoca',1220,'30000110000');
insert into funcionario values (3,'Caio',45,'Florianopolis',1100,'41000100000');
insert into funcionario values (4,'Carlos',44,'Florianopolis',1200,'51000110000');
insert into funcionario values (5,'Paula',33,'Florianopolis',2500,'61000111000');

-- Preenchendo medico --
insert into medico values (1,'Joao',40,'ortopedia','10000100000','Florianopolis',1);
insert into medico values (2,'Maria',42,'traumatologia','10000110000','Blumenau',2);
insert into medico values (3,'Pedro',51,'pediatria','11000100000','São José',2);
alter table medico modify column nroa int unsigned comment 'Alterando para aceitar null';
insert into medico (codm,nome,idade,especialidade,cpf,cidade)values (4,'Carlos',28,'ortopedia','11000110000','Joinville');
insert into medico values (5,'Marcia',33,'neurologia','11000111000','Biguacu',3);

-- Preenchendo consulta -- 
insert into consulta  values (1,1,'2006/06/12','14:00');
insert into consulta values (1,4,'2006/06/13','10:00');
insert into consulta values (2,1,'2006/06/13','9:00');
insert into consulta values (2,2,'2006/06/13','11:00');
insert into consulta values (2,3,'2006/06/14','14:00');
insert into consulta values (2,4,'2006/06/14','17:00');
insert into consulta values (3,1,'2006/06/19','18:00');
insert into consulta values (3,3,'2006/06/12','10:00');
insert into consulta values (3,4,'2006/06/19','13:00');
insert into consulta values (4,4,'2006/06/20','13:00');
-- Tirando PK --
alter table consulta modify column codm int unsigned not null;
alter table consulta modify column codp int unsigned not null;
alter table consulta drop primary key;
insert into consulta values (4,4,'2006/06/22','19:30');

-- Exercícios --
update paciente set cidade = 'Ilhota' 
where codp = 2;

select * from consulta;

update consulta set data = '2006/07/04', hora = '12:00' 
where codm = 1 and codp = 4;

select * from paciente;

update paciente set idade = 21, doenca ='Cancer'
where codp = 1;

update consulta set hora = '14:30'
where codm = 3 and codp = 4;

select * from funcionario;

delete from funcionario where codf = 4;

SET SQL_SAFE_UPDATES = 0;

delete from consulta where hora > '19:00';

delete from paciente where idade < 10 or doenca = 'Cancer';

delete from medico where cidade = 'Biguacu' and cidade = 'Palhoca';