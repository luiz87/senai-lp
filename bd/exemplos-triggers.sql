use campeonatobrasileiro;
DELIMITER $$

CREATE TRIGGER antes_de_inserir_usuario
BEFORE INSERT ON usuarios
FOR EACH ROW
BEGIN
    IF NEW.nome IS NULL OR NEW.nome = '' THEN
        SET NEW.nome = 'Nome Padrão';
    END IF;
END$$

DELIMITER ;

select * from usuarios;
CALL adicionar_usuario('','teste@trigger.com');
select * from usuarios;

-- drop table auditoria_usuarios;
CREATE TABLE auditoria_usuarios  (
   id int NOT NULL AUTO_INCREMENT,
   id_usuario int NOT NULL,   
   nome varchar(100) ,
   email varchar(100) ,
   operacao varchar(100) ,
   data_evento timestamp NOT NULL,
   PRIMARY KEY (id)
 );
 
 DELIMITER $$
 
 CREATE TRIGGER apos_atualizar_usuario
 AFTER UPDATE ON usuarios
 FOR EACH ROW
 BEGIN
	INSERT INTO auditoria_usuarios VALUES (null, OLD.id, OLD.nome, OLD.email, 'update', NOW());
 END$$
 
 DELIMITER ;
 
 select * from usuarios;
 UPDATE usuarios SET nome = 'Bill Gates' , email = 'bill@microsoft.com' WHERE id = 4;
 UPDATE usuarios SET nome = 'Chapollin Colorado' , email = 'chapollin@microsoft.com' WHERE id = 5;
 select * from usuarios;
 select * from auditoria_usuarios;
 
 
DELIMITER $$

CREATE TRIGGER antes_de_excluir_usuario
BEFORE DELETE ON usuarios
FOR EACH ROW
BEGIN
    IF OLD.id = 1 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Não é permitido excluir o usuário administrador';
    END IF;
END$$

DELIMITER ;
 
DELETE FROM usuarios WHERE id = 1;