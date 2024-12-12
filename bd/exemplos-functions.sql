use campeonatobrasileiro;

DELIMITER $$

CREATE FUNCTION quadrado(num INT)
RETURNS INT
DETERMINISTIC
BEGIN 
	RETURN num * num;
END$$

DELIMITER ;

select quadrado(4);


DELIMITER $$

CREATE FUNCTION eh_par(num INT)
RETURNS VARCHAR(10)
DETERMINISTIC 
BEGIN
	IF num % 2 = 0 THEN
		RETURN 'Par';
	ELSE
		RETURN 'Impar';
    END IF;
END$$

DELIMITER ;

select eh_par(5), eh_par(8);

DELIMITER $$

CREATE FUNCTION idade(dt DATE)
RETURNS INT
NOT DETERMINISTIC 
READS SQL DATA
BEGIN
	RETURN datediff(curdate(),dt) div 365.25;
END$$

DELIMITER ;
-- READS SQL DATA: Indicar que a função lê dados (mesmo que apenas CURDATE()), sem modificá-los. 
-- Isso ajuda a cumprir os requisitos do MySQL para replicação.
SELECT idade(dt_nascimento) from jogador;


DELIMITER $$

CREATE FUNCTION faixa_etaria(dt date)
RETURNS VARCHAR(20)
NOT DETERMINISTIC
READS SQL DATA
BEGIN
	DECLARE fx_etaria INT;
    SET fx_etaria = (SELECT idade(dt) div 10);
    RETURN concat('Entre ',fx_etaria,'0 e ',fx_etaria,'9');
END$$

DELIMITER ;

select faixa_etaria(dt_nascimento) from jogador;