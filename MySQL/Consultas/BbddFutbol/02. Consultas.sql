select *
from goalscorers g 
inner join results r on r.date = g.date and g.home_team = g.home_team 
where g.date = '1916-07-02';

select scorer, count(*) as numeroGoles from goalscorers g 
where team = 'Spain'
group by scorer 
order by count(*) desc limit 3 ;

-- crear nueva tabla country con una columna para el nombre del pais y otra columna para el numero de goles

create table Futbol (
	nombre varchar (255) primary key,
	numeroGoles int
	);


select DISTINCT (g.team ) from goalscorers g 

select count(g.scorer) as NumeroGoles from goalscorers g 
group by g.team;

update Futbol f 
inner join (select team, count(g.scorer) as NumeroGoles from goalscorers g group by g.team) sub on f.nombre = sub.team 
set f.numeroGoles = sub.NumeroGoles;

select date, count(*)  from goalscorers g 
where g.scorer = 'David Villa'
group by g.`date` 
order by count(*) desc limit 1;

-- equipo con más victorias
select  r.home_team ,count(*) from results r 
where r.home_score > r.away_score 
GROUP by r.home_team 

select r.away_team, count(*)  from results r 
where r.home_score < r.away_score 
group by r.away_team 

select tabloc.home_team, (tabloc + tabvis) as TotalGoles from (select  r.home_team ,count(*) as tabloc from results r where r.home_score > r.away_score GROUP by r.home_team ) as tabloc
inner join (select r.away_team, count(*) as tabvis from results r where r.home_score < r.away_score group by r.away_team) as tabvis on tabloc.home_team = tabvis.away_team 
order by TotalGoles  desc limit 5

-- Crear una columna que refleje el equipo ganador o empate
alter table results add Ganador varchar(255);

update results r set Ganador = r.home_team 
where r.home_score > r.away_score 

update results r set Ganador = r.away_team 
where r.home_score < r.away_score 

update results r set Ganador = 'Empate'
where r.home_score = r.away_score 

select Ganador, count(*) from results r 
where Ganador != 'Empate'
group by Ganador
order by count(*) desc limit 5

-- Realizar una consulta que devuelva el enfrentamiento más reñido (menos diferencias)

select r.home_team, r.away_team, count(*) as GanadosLocal from results r 
where Ganador = r.home_team 
GROUP by home_team, away_team 

select r.home_team, r.away_team, count(*) as Empate from results r 
where Ganador = 'Empate'
GROUP by home_team, away_team 

select r.home_team, r.away_team, count(*) as GanadosVisitante from results r 
where Ganador = r.away_team 
GROUP by home_team, away_team ;


select t1.home_team, t1.away_team, abs(t1.GanadosLocal - t2.GanadosVisitante ) as Diferencia, t1.GanadosLocal , t2.GanadosVisitante  from (select r.home_team, r.away_team, count(*) as GanadosLocal from results r where Ganador = r.home_team GROUP by home_team, away_team ) as t1
inner join (select r.home_team, r.away_team, count(*) as GanadosVisitante from results r where Ganador = r.away_team GROUP by home_team, away_team) as t2 on
t1.home_team = t2.home_team and t1.away_team = t2.away_team
where (t1.GanadosLocal + t2.GanadosVisitante) >= 50
order by Diferencia, (t1.GanadosLocal + t2.GanadosVisitante) desc


select t1.home_team, t1.away_team, abs(t1.GanadosLocal - t2.GanadosVisitante ) as Diferencia, t1.GanadosLocal , t2.GanadosVisitante, t3.Empate from (select r.home_team, r.away_team, count(*) as GanadosLocal from results r where Ganador = r.home_team GROUP by home_team, away_team ) as t1
inner join (select r.home_team, r.away_team, count(*) as GanadosVisitante from results r where Ganador = r.away_team GROUP by home_team, away_team) as t2 on
t1.home_team = t2.home_team and t1.away_team = t2.away_team
inner join (select r.home_team, r.away_team, count(*) as Empate from results r where Ganador = 'Empate'GROUP by home_team, away_team ) as t3 ON
t1.home_team = t3.home_team  and t2.away_team = t3.away_team 
where (t1.GanadosLocal + t2.GanadosVisitante + t3.Empate) >= 50
order by Diferencia, (t1.GanadosLocal + t2.GanadosVisitante) desc




