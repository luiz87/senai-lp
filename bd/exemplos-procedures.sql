use campeonatobrasileiro;

CREATE TABLE usuarios (
   id int NOT NULL AUTO_INCREMENT,
   nome varchar(100) DEFAULT NULL,
   email varchar(100) DEFAULT NULL,
   PRIMARY KEY (id)
 );
 
DELIMITER $$

CREATE PROCEDURE adicionar_usuario(nome VARCHAR(100), email VARCHAR(100))
BEGIN
    INSERT INTO usuarios (nome, email) VALUES (nome, email);
END$$

DELIMITER ;

CALL adicionar_usuario('João Silva', 'joao@gmail.com');
CALL adicionar_usuario('Luiz Felipe', 'luiz@gmail.com');
CALL adicionar_usuario('Elon Musk', 'elon@gmail.com');

SELECT * FROM usuarios;

-- Exemplo com Parâmetro de Saída: Uma procedure que retorna a quantidade de usuários em uma tabela:

DELIMITER $$

CREATE PROCEDURE contar_usuarios(OUT quantidade INT)
BEGIN
    SELECT COUNT(*) INTO quantidade FROM usuarios;
END$$

DELIMITER ;

CALL contar_usuarios(@total);
select @total;
