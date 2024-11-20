use dbmaternidade;

select * from mae;
select * from bebe;
select * from medico;

select * from mae , bebe , medico
where mae.id_mae = bebe.id_mae and bebe.crm = medico.crm;

select 
	mae.nome AS "Mãe", 
    bebe.nome AS "Bebê", 
    medico.nome AS "Médico" 
from mae 
inner join bebe on mae.id_mae = bebe.id_mae
inner join medico on bebe.crm = medico.crm;

