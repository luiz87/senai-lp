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

-- Exemplo com lógica condicional, uma procedure que atualiza um registro somente se ele existir:

DELIMITER $$

CREATE PROCEDURE atualizar_email(id_usuario INT, novo_email VARCHAR(100))
BEGIN
	IF EXISTS (SELECT 1 FROM usuarios WHERE id = id_usuario) THEN
		UPDATE usuarios SET email = novo_email WHERE id = id_usuario;
    ELSE
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Usuário não encontrado';
    END IF;
END$$

DELIMITER ;

CALL atualizar_email(5,'novo_email@gmail.com');
CALL atualizar_email(1,'novo_email@gmail.com');
SELECT * FROM usuarios;

-- Atualizar gols da partida

DELIMITER $$

CREATE PROCEDURE atualizar_gol_partida(m_sigla VARCHAR(3), m_gol INT, v_gol INT, v_sigla VARCHAR(3))
BEGIN
	
    DECLARE idpartida INT;
    
    SET idpartida = (SELECT id_partida FROM partida 
						WHERE id_mandante = (SELECT id_time FROM time WHERE sigla = m_sigla) AND
							  id_visitante = (SELECT id_time FROM time WHERE sigla = v_sigla));
	
    UPDATE partida SET gol_mandante = m_gol , gol_visitante = v_gol WHERE id_partida = idpartida;
END$$

DELIMITER ;

-- RODADA 37
CALL atualizar_gol_partida('FLU',0,0,'CUI');
CALL atualizar_gol_partida('CAP',1,2,'RBB');

-- RODADA 38
CALL atualizar_gol_partida('GRE',0,3,'COR');
CALL atualizar_gol_partida('CAM',1,0,'CAP');
CALL atualizar_gol_partida('BAH',2,0,'ACG');
CALL atualizar_gol_partida('FLA',2,2,'VIT');
CALL atualizar_gol_partida('BOT',2,1,'SAO');
CALL atualizar_gol_partida('PAL',0,1,'FLU');
CALL atualizar_gol_partida('RBB',5,1,'CRI');
CALL atualizar_gol_partida('FOR',3,0,'INT');
CALL atualizar_gol_partida('CUI',1,2,'VAS');
CALL atualizar_gol_partida('JUV',0,1,'CRU');


SELECT * FROM partida where gol_mandante is null;
SELECT * FROM time;