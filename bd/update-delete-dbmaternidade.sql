update bebe set crm = 1010;

select * from mae where nome = 'Eliana';

select * from bebe where id_mae = 2;

select * from bebe where id_mae = (select id_mae from mae where nome = 'Claudia Leitte');

select * from medico where nome = 'Dr. Carlos Santos';
select * from mae where nome = 'Ivete Sangalo';
update bebe set crm = '1030' where id_mae = 2;
update bebe set crm = (select crm from medico where nome = 'Dr. Carlos Santos') 
where id_mae = (select id_mae from mae where nome = 'Ivete Sangalo');

delete from bebe where id_mae = (select id_mae from mae where nome = 'Simone Mendes');

