show databases; -- visualizar as databases

create database campeonatobrasileiro; -- criar base de dados

status; -- visualiza principais configurações

use campeonatobrasileiro; -- entra em uma base de dados 

-- cria uma nova tabela
create table estadio(
id_estadio int primary key auto_increment,
nome varchar(150) not null,
endereco varchar(150),
capacidade int);

show tables; -- mostra as tabelas de uma base de dados

desc estadio; -- descreve a estrutura de uma tabela

create table time(
id_time int,
nome_completo varchar(150),
nome varchar(150),
sigla varchar(3),
cidade varchar(150),
estado varchar(150),
id_estadio int not null,
constraint PK_Time primary key(id_time),
constraint FK_EstadioTime foreign key(id_estadio) references estadio(id_estadio));