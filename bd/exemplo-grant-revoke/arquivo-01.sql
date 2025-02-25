SELECT User, Host FROM mysql.user;

CREATE USER 'novo-usuario'@'localhost' IDENTIFIED BY 'senai@123';

CREATE DATABASE pizzaria;

GRANT ALL PRIVILEGES ON pizzaria.* TO 'novo-usuario'@'localhost';

REVOKE CREATE ON pizzaria.* FROM 'novo-usuario'@'localhost';

USE pizzaria;
CREATE TABLE pizza(
id_pizza int auto_increment primary key,
sabor varchar(250),
ingredientes varchar(250));

SHOW GRANTS FOR 'novo-usuario'@'localhost';

-- GRANT USAGE ON *.* TO `novo-usuario`@`localhost`;
-- GRANT SELECT, INSERT, UPDATE, DELETE, DROP, REFERENCES, INDEX, ALTER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, EVENT, TRIGGER ON `pizzaria`.* TO `novo-usuario`@`localhost`;

CREATE TABLE au_pizza(
id_aupizza int auto_increment primary key,
id_pizza int,
sabor varchar(250),
ingredientes varchar(250),
usuario varchar(100),
data_hora datetime,
operacao varchar(10));

DELIMITER $$
CREATE TRIGGER depois_insert_pizza
AFTER INSERT ON pizza
FOR EACH ROW
BEGIN
	INSERT INTO au_pizza(id_pizza, sabor, ingredientes, usuario, data_hora, operacao)
    VALUES (NEW.id_pizza, NEW.sabor, NEW.ingredientes, user(), now(), 'insert');
END$$

DELIMITER ;

DELIMITER $$
CREATE TRIGGER depois_update_pizza
AFTER UPDATE ON pizza
FOR EACH ROW
BEGIN
	INSERT INTO au_pizza(id_pizza, sabor, ingredientes, usuario, data_hora, operacao)
    VALUES (OLD.id_pizza, OLD.sabor, OLD.ingredientes, user(), now(), 'update');
END$$

DELIMITER ;

DELIMITER $$
CREATE TRIGGER depois_delete_pizza
AFTER DELETE ON pizza
FOR EACH ROW
BEGIN
	INSERT INTO au_pizza(id_pizza, sabor, ingredientes, usuario, data_hora, operacao)
    VALUES (OLD.id_pizza, OLD.sabor, OLD.ingredientes, user(), now(), 'delete');
END$$

DELIMITER ;

GRANT select ON pizzaria.au_pizza TO 'luiz-maia'@'%';