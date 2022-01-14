use clinica;

select nome, cpf from medicos where (idade < 40  or especialidade != "traumatologia");

select * from consultas where (hora between "12:00" and "18:00") and data_consulta > "2006-06-13";

select nome, idade from pacientes where (cidade != "florianópolis");

select hora from consultas where (data_consulta not between "2006-06-14" and "2006-06-20");

select nome, idade*12 as "idade em meses" from pacientes;

select distinct cidade as "Cidades resididas" from funcionarios;

select max(salario) as "Maior salário", min(salario) as "Menor salário" from funcionarios;

select max(hora) as "último horário marcado" from consultas where (data_consulta = "2006-06-13");

select avg(idade) as "média de idade dos médicos", count(numero_ambulatorio) as "Total de ambulatórios" from medicos;

select codigo_funcionario, nome, (salario - salario*0.2) as "Salário Líquido" from funcionarios;

select nome from funcionarios where (nome like "%a");

select nome, cpf from funcionarios where (cpf like "%0000%");

select nome, especialidade from medicos where (nome like "_o%" and nome like "%o");

select codigo_paciente, nome from pacientes where ( idade > 25 and doenca in("tendinite","fratura","gripe","sarampo"));

select m.nome, m.cpf from medicos m join pacientes p on m.cpf = p.cpf;

select f.codigo_funcionario, m.codigo_medico from funcionarios f join medicos m on f.cidade=m.cidade;

select p.codigo_paciente, p.nome as "paciente" from pacientes p join consultas c on c.codigo_paciente = p.codigo_paciente where (hora>"14:00");

select a.numero_ambulatorio as "ambulatório" , andar from ambulatorios a join medicos m on a.numero_ambulatorio = m.numero_ambulatorio where (m.especialidade = "ortopedia");

select nome, cpf from pacientes p join consultas c on c.codigo_paciente = p.codigo_paciente where (data_consulta between "2006-06-14" and "2006-06-16");

select m.nome as "Médico", m.idade from medicos m 
join consultas c on c.codigo_medico = m.codigo_medico
join pacientes p on p.codigo_paciente = c.codigo_paciente
where p.nome = "Ana";

select m.codigo_medico, m.nome as "Médico" from medicos m
join ambulatorios a on a.numero_ambulatorio = m.numero_ambulatorio 
join consultas c on c.codigo_medico = m.codigo_medico
where (a.numero_ambulatorio in (select a.numero_ambulatorio from ambulatorios a join medicos m on a.numero_ambulatorio = m.numero_ambulatorio where m.nome = "Pedro") and data_consulta = "2006-06-14");

select p.nome, p.cpf, p.idade from pacientes p 
join consultas c on p.codigo_paciente = c.codigo_paciente
join medicos m on c.codigo_medico = m.codigo_medico
where (m.especialidade = "ortopedia" and Day(c.data_consulta) < 16);

select f.nome, f.salario from funcionarios f where (f.cidade = (select cidade from funcionarios where( nome = "Carlos")) and f.salario > (select salario from funcionarios where(nome = "Carlos")));

select a.numero_ambulatorio, a.andar, a.capacidade, m.codigo_medico, m.nome as "médico" from ambulatorios a 
left join medicos m on m.numero_ambulatorio = a.numero_ambulatorio; 

select m.cpf as "cpf do médico", m.nome as "médico", p.cpf as "cpf do paciente", p.nome as "paciente", c.data_consulta from medicos m
left join consultas c on m.codigo_medico = c.codigo_medico
join pacientes p on c.codigo_paciente = p.codigo_paciente;