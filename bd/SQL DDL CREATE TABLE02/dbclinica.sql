create database dbclinica;
use dbclinica;

create table sala(
numero_sala int check(numero_sala > 1 and numero_sala < 50),
andar int not null,
constraint PK_Sala primary key(numero_sala)
);

create table medico(
crm int,
nome varchar(40) not null,
idade int check(idade > 23),
especialidade varchar(20) not null default('Ortopedia'),
cpf varchar(15) unique not null,
dt_admissao date,
constraint PK_Medico primary key(crm)
);

create table paciente(
cpf varchar(11),
nome varchar(40) not null,
dt_nascimento date,
cidade varchar(30) default('Taguatinga'),
doenca varchar(40) not null,
plano_saude varchar(40) not null default('SUS'),
constraint PK_Paciente primary key(cpf)
);

create table funcionario(
matricula int auto_increment,
nome varchar(40) not null,
dt_nascimento date not null,
dt_admissao date not null,
cargo varchar(40) not null default('Assitente Médico'),
salario decimal(8,2) not null default(1510.00),
constraint PK_Funcionario primary key(matricula)
);

create table consulta(
codigo_consulta int auto_increment,
dt_horario datetime,
constraint PK_consulta primary key(codigo_consulta)
);

alter table sala add(
crm int,
constraint FK_SalaMedico foreign key(crm) references medico(crm)
);

alter table consulta add(
crm int not null,
cpf varchar(11) not null,
constraint FK_ConsultaMedico foreign key(crm) references medico(crm),
constraint FK_ConsultaPaciente foreign key(cpf) references paciente(cpf)
);