create database dbibge;
use dbibge;
create table regiao(
    id int primary key,
    sigla varchar(2),
    nome varchar(200)
);

create table estado(
    id int primary key,
    sigla varchar(2),
    nome varchar(200),
    id_regiao int,
    foreign key (id_regiao) references regiao(id)
);

create table municipio(
    id int primary key,
    nome varchar(200),
    id_estado int,
    foreign key (id_estado) references estado(id)
);


