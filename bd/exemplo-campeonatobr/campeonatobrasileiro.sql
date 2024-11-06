show databases; -- visualizar as databases
drop database if exists campeonatobrasileiro;
create database campeonatobrasileiro; -- criar base de dados
use campeonatobrasileiro; -- entra em uma base de dados 
-- status; -- visualiza principais configurações

show tables; -- mostra as tabelas de uma base de dados

-- cria uma nova tabela
create table estadio(
id_estadio int primary key auto_increment,
nome varchar(150) not null,
endereco varchar(150),
capacidade int);
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
desc time;

create table jogador(
id_jogador int,
nome varchar(150),
numero int,
dt_nascimento date,
posicao varchar(150),
id_time int,
constraint PK_Jogador primary key(id_jogador),
constraint FK_JogadorTime foreign key(id_time) references time(id_time));
desc jogador;

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
desc partida;

create table evento(
id_evento int,
minuto int,
descricao varchar(150),
id_partida int,
id_jogador int,
constraint PK_Evento primary key(id_evento),
constraint FK_EventoPartida foreign key(id_partida) references partida(id_partida),
constraint FK_EventoJogador foreign key(id_jogador) references jogador(id_jogador));
desc evento;

alter table evento modify id_evento int auto_increment;

 -- apagando a regra de chave estrangeira 
 alter table jogador drop constraint FK_JogadorTime;
 alter table partida drop constraint FK_TimeMandante;
 alter table partida drop constraint FK_TimeVisitante;
 -- incluindo o auto_increment
 alter table time modify id_time int auto_increment;
 -- incluir novamente a regra da chave estrangeira
 alter table jogador add constraint FK_JogadorTime foreign key(id_time) references time(id_time);
 alter table partida add constraint FK_TimeMandante foreign key(id_mandante) references time(id_time);
 alter table partida add constraint FK_TimeVisitante foreign key(id_visitante) references time(id_time);

 alter table evento drop constraint FK_EventoPartida;
 alter table partida modify id_partida int auto_increment;
 alter table evento add constraint FK_EventoPartida 
 foreign key(id_partida) references partida(id_partida);
 
 alter table evento drop constraint FK_EventoJogador;
 alter table jogador modify id_jogador int auto_increment;
 alter table evento add constraint FK_EventoJogador 
 foreign key(id_jogador) references jogador(id_jogador);

 -- insert para unica linha
insert into estadio(nome, endereco, capacidade)
value('Maracanã','Av. Pres. Castelo Branco, Portão 3 - Maracanã, Rio de Janeiro - RJ',78838);

-- insert para multiplas linhas
insert into estadio(nome, endereco, capacidade) values
('Morumbi (Estádio Cícero Pompeu de Toledo)','Praça Roberto Gomes Pedrosa, 1 - Morumbi, São Paulo - SP','66795'),
('Mineirão (Estádio Governador Magalhães Pinto)','Av. Antônio Abrahão Caram, 1001 - Pampulha, Belo Horizonte - MG','61846'),
('Arena do Grêmio','Av. Padre Leopoldo Brentano, 110 - Humaitá, Porto Alegre - RS','55662'),
('Allianz Parque','Av. Francisco Matarazzo, 1705 - Água Branca, São Paulo - SP','43713'),
('Beira-Rio (Estádio José Pinheiro Borda)','Av. Padre Cacique, 891 - Praia de Belas, Porto Alegre - RS','50128'),
('Arena Fonte Nova','Ladeira da Fonte das Pedras - Nazaré, Salvador - BA','47907'),
('Arena Castelão (Estádio Governador Plácido Castelo)','Av. Alberto Craveiro, 2901 - Castelão, Fortaleza - CE','63903'),
('Neo Química Arena','Av. Miguel Ignácio Curi, 111 - Artur Alvim, São Paulo - SP','49205'),
('Estádio Nilton Santos (Engenhão)','R. José dos Reis, 425 - Engenho de Dentro, Rio de Janeiro - RJ','46831'),
('Arena da Baixada (Estádio Joaquim Américo)','R. Buenos Aires, 1260 - Água Verde, Curitiba - PR','42372'),
('Arena Pantanal','Av. Agrícola Paes de Barros - Verdão, Cuiabá - MT','44000'),
('Estádio Serra Dourada','Av. Fued José Sebba - Jardim Goiás, Goiânia - GO','50049'),
('Arena Pernambuco','Av. Deus é Fiel, 1 - São Lourenço da Mata, Recife - PE','44300'),
('Estádio Couto Pereira','R. Ubaldino do Amaral, 37 - Alto da Glória, Curitiba - PR','40502'),
('Vila Belmiro (Estádio Urbano Caldeira)','R. Princesa Isabel, 77 - Vila Belmiro, Santos - SP','16068'),
('Estádio São Januário','R. Gen. Almério de Moura, 131 - Vasco da Gama, Rio de Janeiro - RJ','21880'),
('Estádio Independência (Arena Independência)','R. Pitangui, 3230 - Horto, Belo Horizonte - MG','23018'),
('Arena da Amazônia','Av. Constantino Nery, 5001 - Flores, Manaus - AM','44310'),
('Estádio Mané Garrincha','SRPN - Asa Norte, Brasília - DF','72788');

select * from estadio;

insert into time(nome_completo,nome,sigla,cidade,estado,id_estadio) values
('América Futebol Clube','América-MG','AME','Belo Horizonte','MG',1);

insert into time(nome_completo,nome,sigla,cidade,estado,id_estadio) values
('Club Athletico Paranaense','Athletico-PR','CAP','Curitiba','PR',1),
('Clube Atlético Mineiro','Atlético-MG','CAM','Belo Horizonte','MG',1),
('Esporte Clube Bahia','Bahia','BAH','Salvador','BA',1),
('Botafogo de Futebol e Regatas','Botafogo','BOT','Rio de Janeiro','RJ',1),
('Sport Club Corinthians Paulista','Corinthians','COR','São Paulo','SP',1),
('Coritiba Foot Ball Club','Coritiba','CFC','Curitiba','PR',1),
('Cruzeiro Esporte Clube','Cruzeiro','CRU','Belo Horizonte','MG',1),
('Cuiabá Esporte Clube','Cuiabá','CUI','Cuiabá','MT',1),
('Clube de Regatas do Flamengo','Flamengo','FLA','Rio de Janeiro','RJ',1),
('Fluminense Football Club','Fluminense','FLU','Rio de Janeiro','RJ',1),
('Fortaleza Esporte Clube','Fortaleza','FOR','Fortaleza','CE',1),
('Goiás Esporte Clube','Goiás','GOI','Goiânia','GO',1),
('Grêmio Foot-Ball Porto Alegrense','Grêmio','GRE','Porto Alegre','RS',1),
('Sport Club Internacional','Internacional','INT','Porto Alegre','RS',1),
('Sociedade Esportiva Palmeiras','Palmeiras','PAL','São Paulo','SP',1),
('Red Bull Bragantino','Bragantino','RBB','Bragança Paulista','SP',1),
('Santos Futebol Clube','Santos','SAN','Santos','SP',1),
('São Paulo Futebol Clube','São Paulo','SAO','São Paulo','SP',1),
('Club de Regatas Vasco da Gama','Vasco','VAS','Rio de Janeiro','RJ',1);

select * from time;

update time set id_estadio = 18 where id_time = 1;
update time set id_estadio = 11 where id_time = 2;
update time set id_estadio = 3  where id_time = 3;
update time set id_estadio = 13 where id_time = 4;
update time set id_estadio = 7  where id_time = 5;
update time set id_estadio = 10 where id_time = 6;
update time set id_estadio = 9  where id_time = 7;
update time set id_estadio = 3  where id_time = 8;
update time set id_estadio = 12 where id_time = 9;
update time set id_estadio = 1  where id_time = 10;
update time set id_estadio = 1  where id_time = 11;
update time set id_estadio = 8  where id_time = 12;
update time set id_estadio = 13 where id_time = 13;
update time set id_estadio = 4  where id_time = 14;
update time set id_estadio = 6  where id_time = 15;
update time set id_estadio = 5  where id_time = 16;
update time set id_estadio = 20 where id_time = 17;
update time set id_estadio = 16 where id_time = 18;
update time set id_estadio = 2  where id_time = 19;
update time set id_estadio = 17 where id_time = 20;
