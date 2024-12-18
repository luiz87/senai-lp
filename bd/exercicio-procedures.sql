use campeonatobrasileiro;
DELIMITER $$
CREATE PROCEDURE exemplo_while()
BEGIN
    DECLARE contador INT DEFAULT 1;  
    WHILE contador <= 5 DO
        SELECT CONCAT('Contador: ', contador);
        SET contador = contador + 1;
    END WHILE;
END$$
DELIMITER ;
call exemplo_while();

-- 01.
DELIMITER $$
CREATE PROCEDURE gerar_resultado_aleatorio()
BEGIN
    DECLARE contador INT DEFAULT 1;  
    WHILE contador <= 380 DO
        UPDATE partida SET gol_mandante = valor_aleatorio(0,6) , gol_visitante = valor_aleatorio(0,6) WHERE id_partida = contador;
        SET contador = contador + 1;
    END WHILE;
END$$
DELIMITER ;
-- drop procedure gerar_resultado_aleatorio;
call gerar_resultado_aleatorio();
select * from classificacao;

-- 02.
DELIMITER $$
CREATE PROCEDURE classificacao_rodada(num_rodada INT)
BEGIN
    select row_number() over() C, tb.* from (
    select 		
        sigla, 
		nome, 
		sum(pontos) pontos,
		count(*) J,
		sum(if(pontos = 3 , 1, 0)) V,    
		sum(gols) - sum(gols_sofridos) SG,
		concat(sum(gols),':',sum(gols_sofridos)) Gol,
		sum(if(pontos = 1 , 1, 0)) E,
		sum(if(pontos = 0 , 1, 0)) D
	from (
		select 
			rodada, 
			sigla, 
			nome, 
			gols, 
			gols_sofridos,
			if(gols > gols_sofridos , 3 , if(gols = gols_sofridos, 1, 0)) pontos
		from (
			select 
				rodada,
				id_mandante id_time, 
				gol_mandante gols, 
				gol_visitante  gols_sofridos
			from partida
			union all
			select 
				rodada,
				id_visitante,     
				gol_visitante,
				gol_mandante
			from partida) as tb
		inner join time as t on t.id_time = tb.id_time) tb
	where rodada <= num_rodada
	group by 
		sigla,
		nome
	order by pontos desc, V desc, SG desc) tb;
END$$
DELIMITER ;

call classificacao_rodada(19);
