DROP TRIGGER antes_inserir_evento;

DELIMITER $$

CREATE TRIGGER antes_inserir_evento
BEFORE INSERT ON evento
FOR EACH ROW
BEGIN
DECLARE st_jogador_partida BOOLEAN DEFAULT FALSE;
    select true into st_jogador_partida from jogador as j
	inner join partida as p on j.id_time = p.id_mandante or j.id_time = p.id_visitante
	where id_partida = NEW.id_partida and id_jogador = NEW.id_jogador;
   
    IF NOT st_jogador_partida THEN
		SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Não é permitido inserir um jogador que não pertence aos times dessa partida';
    END IF;
   
END$$

DELIMITER ;

-- DROP TRIGGER depois_inserir_evento;

DELIMITER $$

CREATE TRIGGER depois_inserir_evento
AFTER INSERT ON evento
FOR EACH ROW
BEGIN
	DECLARE idTime INT;
    
    IF (select gol_mandante from partida where id_patida = NEW.id_partida) IS NULL THEN 
		UPDATE partida SET gol_mandante = 0, gol_visitante = 0  where id_partida = NEW.id_partida;
    END IF;
	
    IF NEW.descricao IN ('Gol (Gol de campo)','Gol (Pênalti)') THEN
		SELECT id_time into idTime FROM jogador where id_jogador = NEW.id_jogador;
    END IF;
    
    IF NEW.descricao IN ('Gol (Gol Contra)') THEN
		select if(id_time = id_mandante, id_visitante, id_mandante) into idTime from jogador as j
		inner join partida as p on j.id_time = p.id_mandante or j.id_time = p.id_visitante
		where id_partida = NEW.id_partida and id_jogador = NEW.id_jogador;
    END IF;
	
    IF idTime IS NOT NULL THEN
		UPDATE partida SET gol_mandante = gol_mandante + 1  where id_partida = NEW.id_partida and id_mandante = idTime;
		UPDATE partida SET gol_visitante = gol_visitante + 1  where id_partida = NEW.id_partida and id_visitante = idTime;
    END IF;
END$$

DELIMITER ;

INSERT INTO `evento`(`minuto`,`descricao`,`id_partida`,`id_jogador`)VALUES(0,'Gol (Gol de campo)',1,261);
INSERT INTO `evento`(`minuto`,`descricao`,`id_partida`,`id_jogador`)VALUES(0,'Gol (Gol Contra)',1,261);

select *  from evento where id_partida = 1;
SELECT * FROM partida WHERE id_partida = 1;
UPDATE partida SET gol_mandante = 0, gol_visitante = 0 where id_partida = 1;

select * from jogador;
select * from partida;
select * from evento;
select DISTINCT descricao from evento;
select *  from evento where id_partida = 1 order by minuto;
delete from evento where id_partida = 1 and minuto = 0;
