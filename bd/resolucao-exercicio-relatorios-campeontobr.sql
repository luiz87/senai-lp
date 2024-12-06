SET SQL_SAFE_UPDATES=0;
update evento set descricao = 'Substituição' where descricao = 'Substitution';
update evento set descricao = 'Bola na Trave' where descricao = 'Woodwork';
update evento set descricao = 'Cartão Vermelho (Segundo Cartão Amarelo)' 
where descricao = 'Cartão Vermelho (Second Yellow Card)';

UPDATE partida SET gol_mandante = 1, gol_visitante = 1 WHERE id_partida = 341;
UPDATE partida SET gol_mandante = 0, gol_visitante = 1 WHERE id_partida = 342;
UPDATE partida SET gol_mandante = 1, gol_visitante = 1 WHERE id_partida = 343;
UPDATE partida SET gol_mandante = 2, gol_visitante = 2 WHERE id_partida = 344;
UPDATE partida SET gol_mandante = 4, gol_visitante = 1 WHERE id_partida = 345;
UPDATE partida SET gol_mandante = 1, gol_visitante = 1 WHERE id_partida = 346;
UPDATE partida SET gol_mandante = 3, gol_visitante = 1 WHERE id_partida = 347;
UPDATE partida SET gol_mandante = 0, gol_visitante = 0 WHERE id_partida = 348;
UPDATE partida SET gol_mandante = 0, gol_visitante = 0 WHERE id_partida = 349;
UPDATE partida SET gol_mandante = 1, gol_visitante = 1 WHERE id_partida = 350;
UPDATE partida SET gol_mandante = 2, gol_visitante = 3 WHERE id_partida = 351;
UPDATE partida SET gol_mandante = 1, gol_visitante = 3 WHERE id_partida = 352;
UPDATE partida SET gol_mandante = 1, gol_visitante = 2 WHERE id_partida = 353;
UPDATE partida SET gol_mandante = 2, gol_visitante = 4 WHERE id_partida = 354;
UPDATE partida SET gol_mandante = 2, gol_visitante = 2 WHERE id_partida = 355;
UPDATE partida SET gol_mandante = 2, gol_visitante = 1 WHERE id_partida = 356;
UPDATE partida SET gol_mandante = 3, gol_visitante = 2 WHERE id_partida = 357;
UPDATE partida SET gol_mandante = 2, gol_visitante = 0 WHERE id_partida = 358;
UPDATE partida SET gol_mandante = 1, gol_visitante = 1 WHERE id_partida = 359;
UPDATE partida SET gol_mandante = 1, gol_visitante = 1 WHERE id_partida = 360;
UPDATE partida SET gol_mandante = 3, gol_visitante = 0 WHERE id_partida = 366;
UPDATE partida SET gol_mandante = 2, gol_visitante = 0 WHERE id_partida = 365;
UPDATE partida SET gol_mandante = 1, gol_visitante = 1 WHERE id_partida = 363;
UPDATE partida SET gol_mandante = 1, gol_visitante = 2 WHERE id_partida = 367;
UPDATE partida SET gol_mandante = 0, gol_visitante = 3 WHERE id_partida = 370;
UPDATE partida SET gol_mandante = 0, gol_visitante = 1 WHERE id_partida = 361;
UPDATE partida SET gol_mandante = 1, gol_visitante = 2 WHERE id_partida = 362;
UPDATE partida SET gol_mandante = 3, gol_visitante = 1 WHERE id_partida = 369;

select 
	minuto , 
    count(*) qt_gols 
from evento
where descricao like 'Gol%' and descricao not like '%VAR%' 
group by minuto 
order by qt_gols desc;

select 
	2024 - year(dt_nascimento) idade, 
    count(*) quantidade
from jogador
where dt_nascimento is not null and posicao not in ('Auxiliar técnico','Técnico')
group by idade
order by idade desc;

select 
	numero,
    nome ,
    -- count(*) qt_cartoes,
    sum(if(descricao like '%Amarelo%' , 1 , 0)) qt_amarelo,
    sum(if(descricao like '%Vermelho%' , 1 , 0)) qt_vermelho,
    sum(if(descricao like '%Amarelo%' and descricao like '%Vermelho%', 2 , 1)) qt_total
from jogador as j
inner join evento as e on j.id_jogador = e.id_jogador
where descricao like 'Cartão%' -- and id_partida like '338'
group by numero, nome
order by qt_total desc;
