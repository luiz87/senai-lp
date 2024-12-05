use campeonatobrasileiro;

select * from estadio;
select * from time;
select * from partida;
select * from jogador;
select * from evento;
select * from vw_mandante;
create view vw_mandante as (
select	
    sigla,
    sum(pontos) as pontos,
    count(*) qt_partidas,
    sum(if(pontos = 3, 1 , 0)) vitoria,
    sum(if(pontos = 1, 1 , 0)) empate,
    sum(if(pontos = 0, 1 , 0)) derrota,
    sum(gol_mandante) as gols,
    sum(gol_visitante) as gols_sofridos, 
    sum(gol_mandante - gol_visitante) as saldo_gols
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
) as tb
group by sigla);

select * from vw_visitante;
create view vw_visitante as (
select	
    sigla,
    sum(pontos) as pontos,
    count(*) qt_partidas,
    sum(if(pontos = 3, 1 , 0)) vitoria,
    sum(if(pontos = 1, 1 , 0)) empate,
    sum(if(pontos = 0, 1 , 0)) derrota,
    sum(gol_visitante) as gols,
    sum(gol_mandante) as gols_sofridos, 
    sum(gol_visitante - gol_mandante) as saldo_gols
from (
	select 
		sigla, 
		gol_mandante, 
		gol_visitante,
		if (gol_visitante > gol_mandante, 3 , 
		if (gol_visitante = gol_mandante, 1 , 0)) as pontos
	from partida as p 
	inner join time as t on p.id_visitante = t.id_time
	where gol_mandante is not null and gol_visitante is not null
) as tb
group by sigla);

-- montar a view da classificação

create view classificacao as (
select 	
    sigla ,
    sum(pontos) pontos,
    sum(qt_partidas) J, 
    sum(vitoria) V, 
    sum(saldo_gols) SG,
    concat(sum(gols),':',sum(gols_sofridos)) Gol,
    sum(empate) E, 
    sum(derrota) D
from (select * from vw_mandante
		union all
	  select * from vw_visitante) as tb
group by sigla);
select row_number() over() N, c.* from classificacao as c order by pontos desc, V desc, SG desc;









