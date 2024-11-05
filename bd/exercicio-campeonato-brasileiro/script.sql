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

create table jogador(
id_jogador int,
nome varchar(150),
numero int,
dt_nascimento date,
posicao varchar(150),
id_time int,
constraint PK_Jogador primary key(id_jogador),
constraint FK_JogadorTime foreign key(id_time) references time(id_time));

create table partida(
id_partida int,
rodada int,
horario datetime,
gol_mandante int,
gol_visitante int,
id_mandante int,
id_visitante int,
id_estadio int,
constraint PK_Partida primary key(id_partida),
constraint FK_TimeMandante foreign key(id_mandante) references time(id_time),
constraint FK_TimeVisitante foreign key(id_visitante) references time(id_time),
constraint FK_PartidaEstadio foreign key(id_estadio) references estadio(id_estadio));

create table evento(
id_evento int,
minuto int,
descricao varchar(150),
id_partida int,
id_jogador int,
constraint PK_Evento primary key(id_evento),
constraint FK_EventoPartida foreign key(id_partida) references partida(id_partida),
constraint FK_EventoJogador foreign key(id_jogador) references jogador(id_jogador));

desc estadio;
desc time   ;
desc jogador;
desc partida;
desc evento ;

alter table evento modify id_evento int auto_increment;