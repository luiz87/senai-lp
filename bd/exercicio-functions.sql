use campeonatobrasileiro;
-- 01. function valor_aleatorio
DELIMITER $$
CREATE FUNCTION valor_aleatorio(min INT, max INT)
RETURNS INT
NOT DETERMINISTIC
READS SQL DATA
BEGIN
    RETURN ROUND(RAND()*(max-min))+min;
END$$
DELIMITER ;
-- DROP FUNCTION valor_aleatorio;
select valor_aleatorio(5,15);

-- 02. function data_br
DELIMITER $$
CREATE FUNCTION data_br(dt date)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    RETURN DATE_FORMAT(dt,'%d/%m/%Y');
END$$
DELIMITER ;
-- drop function data_br;
select data_br('1987-07-21'), data_br(curdate());

-- 03. function signo
DELIMITER $$
CREATE FUNCTION signo(dt date)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
	IF DATE_FORMAT(dt,'%m%d') BETWEEN '0321' AND '0419' THEN
		RETURN 'Áries';
    END IF;
	IF DATE_FORMAT(dt,'%m%d') BETWEEN '0420' AND '0520' THEN
		RETURN 'Touro';
    END IF;
    IF DATE_FORMAT(dt,'%m%d') BETWEEN '0521' AND '0620' THEN
		RETURN 'Gêmeos';
    END IF;
    IF DATE_FORMAT(dt,'%m%d') BETWEEN '0621' AND '0722' THEN
		RETURN 'Câncer';
    END IF;
    IF DATE_FORMAT(dt,'%m%d') BETWEEN '0723' AND '0822' THEN
		RETURN 'Leão';
    END IF;
    IF DATE_FORMAT(dt,'%m%d') BETWEEN '0823' AND '0922' THEN
		RETURN 'Virgem';
    END IF;
    IF DATE_FORMAT(dt,'%m%d') BETWEEN '0923' AND '1022' THEN
		RETURN 'Libra';
    END IF;
    IF DATE_FORMAT(dt,'%m%d') BETWEEN '1023' AND '1121' THEN
		RETURN 'Escorpião';
    END IF;
    IF DATE_FORMAT(dt,'%m%d') BETWEEN '1122' AND '1221' THEN
		RETURN 'Sagitário';
    END IF;
    IF DATE_FORMAT(dt,'%m%d') BETWEEN '1222' AND '1231' OR DATE_FORMAT(dt,'%m%d') BETWEEN '0101' AND '0119' THEN
		RETURN 'Capricórnio';
    END IF;
    IF DATE_FORMAT(dt,'%m%d') BETWEEN '0120' AND '0218' THEN
		RETURN 'Aquário';
    END IF;
    IF DATE_FORMAT(dt,'%m%d') BETWEEN '0219' AND '0320' THEN
		RETURN 'Peixes';
    END IF;
END$$
DELIMITER ;
-- drop function signo;
select signo('1987-04-01');
select signo('1987-05-01');
select signo('1987-06-01');
select signo('1987-07-01');
select signo('1987-08-01');
select signo('1987-09-01');
select signo('1987-10-01');
select signo('1987-11-01');
select signo('1987-12-01');
select signo('1987-01-01');
select signo('1987-02-01');
select signo('1987-03-01');
