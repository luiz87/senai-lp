create database dbloja;
use dbloja;

create table categoria(
id_categoria int auto_increment,
nome varchar(100),
constraint PK_Categoria primary key(id_categoria)
);

create table produto(
id_produto int auto_increment,
nome varchar(100),
preco float(5,2),
id_categoria int,
constraint PK_Produto primary key(id_produto),
constraint FK_ProdutoCategoria foreign key(id_categoria) references categoria(id_categoria)
);

create table cliente(
id_cliente int auto_increment,
nome varchar(100),
limite_credito float(5,2),
status varchar(10),
cep varchar(10),
logradouro varchar(200),
numero int,
constraint PK_Cliente primary key(id_cliente)
);

create table pedido(
id_pedido int auto_increment,
data date,
total_pedido float(5,2),
id_cliente int not null,
constraint PK_Pedido primary key(id_pedido),
constraint FK_PedidoCliente foreign key(id_cliente) references cliente(id_cliente)
);

create table rl_pedido_produto(
id_pedido int,
id_produto int,
quantidade int not null,
constraint PK_RLPeditoProduto primary key(id_pedido,id_produto),
constraint FK_RLPedito foreign key(id_pedido) references pedido(id_pedido),
constraint FK_RLProduto foreign key(id_produto) references produto(id_produto)
);