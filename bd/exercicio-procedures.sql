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
CREATE PROCEDURE classificacao_rodada(nuRodada INT)
BEGIN
with partidas as (
select 
	rodada,
    id_mandante as id_time,
    gol_mandante as gol_feito,
    gol_visitante as gol_sofrido
from partida
union all 
select 
	rodada,
    id_visitante,
    gol_visitante,
    gol_mandante
from partida),
resultados as (
select 
	rodada,
    sigla,
    nome,
    gol_feito,
    gol_sofrido,
    gol_feito - gol_sofrido saldo_gols,
    if(gol_feito > gol_sofrido,3,if(gol_feito = gol_sofrido,1,0)) pontos,
    if(gol_feito > gol_sofrido,1,0) V,
    if(gol_feito = gol_sofrido,1,0) E,
    if(gol_feito < gol_sofrido,1,0) D
from partidas as p
inner join time as t on t.id_time = p.id_time)
select row_number() over() C, tb.* from (
select 	
    sigla, 
    nome, 
    sum(gol_feito) gol_feito, 
    sum(gol_sofrido) gol_sofrido, 
    sum(saldo_gols) saldo_gols,
    sum(pontos) pontos,
    sum(V) V, 
    sum(E) E, 
    sum(D) D,
    count(*) qt_rodadas
from resultados where rodada <= nuRodada and gol_feito is not null
group by 
	sigla,
    nome
order by pontos desc, V desc, saldo_gols desc, gol_feito desc) as tb;
END$$
DELIMITER ;
-- drop procedure classificacao_rodada;
call classificacao_rodada(1);
