use campeonatobrasileiro;

select * from time;

select  nome, sigla, estado from time;

select * from time where estado = 'SP';

select * from time where estado = 'SP' or estado = 'RJ';

select * from time where estado = 'RJ' and sigla like 'F%';

select * from time where estado = 'RJ' and sigla not like 'F%';

select * from time where sigla <> 'COR';

select * from estadio;

select * from estadio where capacidade < 60000;

select * from estadio where capacidade > 50000 and capacidade < 60000;

select * from estadio where not(capacidade > 50000 and capacidade < 60000);

select * from estadio where nome like '%Arena%';

select * from estadio where nome like 'Arena%';
select * from estadio where nome like '%o' or nome like '%a';

select * from estadio where nome like 'Arena%' and (nome like '%o' or nome like '%a');

