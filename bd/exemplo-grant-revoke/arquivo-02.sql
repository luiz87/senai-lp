GRANT INSERT, SELECT, UPDATE ON pizzaria.pizza TO 'anderson'@'%';
GRANT INSERT, SELECT, UPDATE ON pizzaria.pizza TO 'fabricio'@'%';
GRANT INSERT, SELECT, UPDATE ON pizzaria.pizza TO 'felipe'@'%';
GRANT INSERT, SELECT, UPDATE ON pizzaria.pizza TO 'gabriel'@'%';
GRANT INSERT, SELECT, UPDATE ON pizzaria.pizza TO 'iara'@'%';
GRANT INSERT, SELECT, UPDATE ON pizzaria.pizza TO 'italo'@'%';
GRANT INSERT, SELECT, UPDATE ON pizzaria.pizza TO 'lucas'@'%';
GRANT INSERT, SELECT, UPDATE ON pizzaria.pizza TO 'luiz'@'%';
GRANT INSERT, SELECT, UPDATE ON pizzaria.pizza TO 'marcos'@'%';
GRANT INSERT, SELECT, UPDATE ON pizzaria.pizza TO 'thiago'@'%';

SELECT * FROM au_pizza;

GRANT SELECT ON pizzaria.au_pizza TO 'anderson'@'%';
GRANT SELECT ON pizzaria.au_pizza TO 'fabricio'@'%';
GRANT SELECT ON pizzaria.au_pizza TO 'felipe'@'%';
GRANT SELECT ON pizzaria.au_pizza TO 'gabriel'@'%';
GRANT SELECT ON pizzaria.au_pizza TO 'iara'@'%';
GRANT SELECT ON pizzaria.au_pizza TO 'italo'@'%';
GRANT SELECT ON pizzaria.au_pizza TO 'lucas'@'%';
GRANT SELECT ON pizzaria.au_pizza TO 'luiz'@'%';
GRANT SELECT ON pizzaria.au_pizza TO 'marcos'@'%';
GRANT SELECT ON pizzaria.au_pizza TO 'thiago'@'%';

mysql -h 172.16.3.212 -u luiz-maia -p pizzaria
senai@123
insert into pizza(sabor,ingredientes) values ('Pizza 01','Teste'), ('Pizza 02','Teste'), ('Pizza 03','Teste'), ('Pizza 04','Teste'), ('Pizza 05','Teste');
update pizza set ingredientes = concat(ingredientes,' ',', Novo Ingrediente Secreto') where id_pizza = (select max(id_pizza) from pizza);
delete from pizza where id_pizza = (select max(id_pizza) from pizza);
select * from pizza;
select * from au_pizza;
quit
