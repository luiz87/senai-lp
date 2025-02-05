create database lojinha;

use lojinha;

create table cliente(
id int,
nome varchar(100) not null,
constraint PK_cliente primary key (id));

create table email_cliente(
id int,
email varchar(100),
id_cliente int,
constraint PK_email_cliente primary key (id),
constraint FK_id_cliente foreign key (id_cliente) references cliente(id));

create table pedido(
id int,
data date,
id_cliente int,
constraint PK_pedido primary key(id),
constraint FK_pedido_cliente foreign key (id_cliente) references cliente(id));

create table produto(
id int,
descricao varchar(200),
id_categoria int,
id_fornecedor int,
estoque int,
constraint PK_produto primary key(id));

create table categoria(
id int,
nome varchar(100),
constraint PK_categoria primary key(id));

alter table produto
add constraint FK_produto_categoria foreign key (id_categoria) references categoria(id);

create table fornecedor(
id int,
nome varchar(100),
constraint PK_fornecedor primary key(id));

alter table produto
add constraint FK_produto_fornecedor foreign key (id_fornecedor) references fornecedor(id);

create table pedido_produto(
id int,
id_pedido int,
id_produto int,
quantidade int,
constraint PK_pedido_produto primary key(id),
constraint FK_pedidoproduto_pedido foreign key (id_pedido) references pedido(id),
constraint FK_pedidoproduto_produto foreign key (id_produto) references produto(id));

-- monte os inserts para 

insert into cliente values
(1,'Ana'),
(2,'José'),
(3,'João');
select * from cliente;

insert into email_cliente values
(1,'e1',1),
(2,'e2',1),
(3,'e3',2),
(4,'e4',2),
(5,'e5',3);
select * from email_cliente;

insert into pedido values
(1,'2015-10-05',1),
(2,'2014-12-31',1),
(3,'2010-09-10',2),
(4,'2015-03-14',2),
(5,'2014-07-21',2);
select * from pedido;

insert into categoria values
(1,'Ferramenta'),
(2,'Vestuário'),
(3,'Alimento');
select * from categoria;

insert into fornecedor values
(1,'F1'),
(2,'F2'),
(3,'F3');
select * from fornecedor;

insert into produto values
(1,'Alicate',1,1,10),
(2,'Leite',2,1,100),
(3,'Suco',2,1,50),
(4,'Camisa',3,2,40),
(5,'Calça',3,2,20);
select * from produto;

insert into pedido_produto values
(1,1,1,10),
(2,1,2,20),
(3,2,3,5),
(4,3,4,10),
(5,4,5,5);
select * from pedido_produto;

-- a) Mostre todos os clientes com seus e-mails organizados pelo nome do cliente 
select 
	c.id,
	nome,
	email
from cliente as c
inner join email_cliente as ec on c.id = id_cliente;

-- b) Mostre todos os pedidos realizados entre 2010 e 2014 

select * from pedido
where year(data) between 2010 and 2014
order by data asc;

-- c) Mostre todos os clientes que possuem pedidos entre 2015 e 2016 

select * from pedido as p
inner join cliente as c on p.id_cliente = c.id
where year(data) between 2015 and 2016;

-- d) Mostre o nome das categorias que iniciam pela letra f, 
-- organizadas pelo nome da categoria de forma descendente, sem valores repetidos 

select distinct nome from categoria
where nome like 'f%'
order by nome desc;

-- e) Apresente o total de produtos que são da categoria Vestuário

select count(*) qt from produto as p 
inner join categoria as c on p.id_categoria = c.id
where c.nome = 'Vestuário';

-- f) Mostre o nome da categoria e o total em estoque de cada produto agrupado por categoria 

select nome, sum(estoque) total
from categoria as c 
inner join produto as p on c.id = p.id_categoria
group by nome;

-- g) Mostre o nome do produto com o nome do respectivo fornecedor 

select nome, descricao from produto as p 
inner join fornecedor as f on p.id_fornecedor = f.id;

-- h) Para o cliente com id=01, mostre a data de todos os pedidos efetuados classificados pela data do pedido 

select data from cliente as c 
inner join pedido as p on c.id = p.id_cliente
where c.id = 1
order by data asc;

-- i) Liste a descrição e a quantidade pedida de cada produto 

select descricao, sum(quantidade) total from produto as p
inner join pedido_produto as pp on p.id = pp.id_produto
group by 
descricao;

-- j) Na tabela produto, insira um novo campo chamado preco do tipo decimal(5,2). 
-- Utilize o comando update e atribua 10% do valor do estoque do produto para este novo campo (preco), 
-- ou seja, para estoque igual a 100, o preco deverá ser de 10.  

alter table produto add preco decimal(5,2);
update produto set preco = estoque * 0.1 where id > 0;
select * from produto;

-- k) Na tabela produto, informe o maior valor de estoque 

select max(estoque) from produto;