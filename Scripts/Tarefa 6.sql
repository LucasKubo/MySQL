use clinica;
select * from ambulatorios;

-- Inserindo tuplas em consultas
select * from consultas order by hora asc;
insert into consultas values ("2006-06-22","19:30",4,4);
insert into consultas values ("2006-06-19","13:00",3,4);

-- Inserindo tupla em pacientes
select * from pacientes;
insert into pacientes values (1,"Ana",20,"Florianópolis","20000200000","gripe");

-- Inserindo novas tuplas
insert into consultas values ("2006-06-19","18:00",3,1);
insert into consultas values ("2006-06-13","9:00",2,1);
insert into consultas values ("2006-06-13","10:00",1,4);
insert into consultas values ("2006-06-12","14:00",1,1);

-- Excluindo tuplas não presentes na tabela
SET SQL_SAFE_UPDATES=0;
delete from consultas where (hora = "12:00");
delete from consultas where (hora = "14:30");
select count(*) from consultas;

-- Inserindo tuplas em funcionarios
select * from funcionarios;
insert into funcionarios values (4,"Carlos",44,"51000110000","Florianopolis",1200);

-- Inserindo tuplas em médicos
select * from medicos;
insert into medicos values(5,"Marcia",33,"neurologia","11000111000","Biguacu",3);

-- Começando exercícios
-- 1
select nome, cpf from medicos where cpf in (select cpf from pacientes);
-- 2 
select p.codigo_paciente, nome from pacientes p where codigo_paciente in (select codigo_paciente from consultas where hora > "14:00");
-- 3
select nome, idade from medicos where codigo_medico in (select codigo_medico from consultas where codigo_paciente in 
(select codigo_paciente from pacientes where nome = "Ana"));
-- 4 
select a.numero_ambulatorio, andar from ambulatorios a where a.numero_ambulatorio not in 
(select distinct medicos.numero_ambulatorio from medicos where medicos.numero_ambulatorio is not null);
-- 5 
select nome, idade from pacientes where codigo_paciente in
(select codigo_paciente from consultas where Day(data_consulta) < 16);
-- 6 
select numero_ambulatorio, andar, capacidade from ambulatorios where capacidade > any(select capacidade from ambulatorios );
-- 7 
select nome, idade from medicos where codigo_medico = any
(select codigo_medico from consultas where codigo_paciente = any (
select codigo_paciente from pacientes where nome="Ana"));
-- 8 
select nome, idade from medicos where idade <= all (select idade from medicos);
-- 9 
select nome, cpf from pacientes where codigo_paciente = any
(select codigo_paciente from consultas where hora <= all (
select hora from consultas where data_consulta = "2006-11-12"));
-- 10 
select nome, cpf from medicos where numero_ambulatorio = any
(select numero_ambulatorio from ambulatorios where capacidade <= all(
select capacidade from ambulatorios where andar = "2"));
-- 11 
select nome, cpf from medicos m where exists (select * from pacientes where cpf = m.cpf);
-- 12 
select nome,idade from medicos m where exists
(select * from consultas c where exists
(select * from pacientes p where nome = "Ana" and p.codigo_paciente = c.codigo_paciente and m.codigo_medico = c.codigo_medico));
-- 13
select numero_ambulatorio from ambulatorios a1 where exists
(select * from ambulatorios a2 where a2.capacidade >= all (select capacidade a3 from ambulatorios)
and a1.numero_ambulatorio = a2.numero_ambulatorio);
-- 14
select nome, cpf, codigo_medico from medicos m where exists
(select codigo_paciente from pacientes p where exists
(select * from consultas c where c.codigo_medico = m.codigo_medico and c.codigo_paciente = p.codigo_paciente));
-- 15

-- 16
select c.* from (select * from consultas) as c join medicos m on m.codigo_medico = c.codigo_medico
where nome = "Maria";
-- 17
select p.* from (select codigo_paciente, nome from pacientes) as p join consultas c on p.codigo_paciente = c.codigo_paciente where hora > "14:00";
-- 18
select p.nome, p.cidade from (select codigo_paciente, nome, cidade from pacientes) as p join 
consultas c on p.codigo_paciente = c.codigo_paciente join 
(select codigo_medico from medicos where especialidade = "ortopedia") as m on m.codigo_medico = c.codigo_medico;
-- 19 
select p.nome, p.cpf from (select codigo_paciente, nome, cpf from pacientes where cidade = "Florianopolis") as p join consultas c on p.codigo_paciente = c.codigo_paciente where codigo_medico != (select codigo_medico from medicos where nome = "João");
-- 20
select * from funcionarios order by salario desc, idade asc limit 3;
-- 21
select nome, a.numero_ambulatorio, a.andar from medicos m join ambulatorios a on clinica.m.numero_ambulatorio = clinica.a.numero_ambulatorio order by clinica.a.numero_ambulatorio;
-- 22
select m.nome as "médico" , p.nome as "paciente" from medicos m join consultas c on m.codigo_medico = c.codigo_medico 
join pacientes p on p.codigo_paciente = c.codigo_paciente order by c.hora, c.data_consulta;
-- 23
select idade,count(*) as "quantidade" from medicos group by idade;
-- 24
select data_consulta, count(*) from consultas group by data_consulta having data_consulta in (select data_consulta from consultas where hora > "12:00");
-- 25
select andar, round(avg(capacidade)) as "média de capacidade" from ambulatorios group by andar;
-- 26
select andar, avg(capacidade) from ambulatorios group by andar having avg(capacidade) >= 40;
-- 27
select m.nome from consultas c 
join medicos m on m.codigo_medico = c.codigo_medico 
group by c.codigo_medico having count(c.codigo_medico) > 1;
-- 28
update consultas set hora = "19:00" where codigo_paciente in (select codigo_paciente from pacientes where nome="Ana");
insert into pacientes (nome,idade,cidade,cpf,doenca) values ("Lucas",19,"São Paulo", "11111111010","Nenhuma");
-- 29
delete from pacientes p where not exists (select * from consultas where codigo_paciente = p.codigo_paciente);
-- 30
delete from consultas where codigo_medico in (select codigo_medico from medicos where nome="Pedro") and hora < "12:00";
-- 31
update ambulatorios set andar= (select andar from ambulatorios where numero_ambulatorio = 1), capacidade = (select max(capacidade)*2 from ambulatorios) where numero_ambulatorio = 4;
-- 32
insert into medicos (nome, idade, cpf, cidade, especialidade, numero_ambulatorio) 
values ((select nome from funcionarios where codigo_funcionario = 3),(select idade from funcionarios where codigo_funcionario = 3),(select cpf from funcionarios where codigo_funcionario = 3),(select cidade from funcionarios where codigo_funcionario = 3),"traumatologia",2);