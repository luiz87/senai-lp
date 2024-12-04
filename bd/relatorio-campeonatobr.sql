use campeonatobrasileiro;

select * from estadio;
select * from time;
select * from partida;
select * from jogador;
select * from evento;

select
* 
from (
	select 
		sigla, 
		gol_mandante, 
		gol_visitante,
		if (gol_mandante > gol_visitante, 3 , 
		if (gol_mandante = gol_visitante, 1 , 0)) as pontos
	from partida as p 
	inner join time as t on p.id_mandante = t.id_time
	where gol_mandante is not null and gol_visitante is not null
) as tb;



