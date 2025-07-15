/*BASE DATOS FUTBOL*/

Delimiter €€
create function sumar(num int, num2 int)
returns int 
begin 
	return (num+num2);
end;
€€
delimiter ;

select sumar(1,2);


set global log_bin_trust_function_creators = 1;

Delimiter €€
create function sumaConVariable(num int, num2 int)
returns int 
begin 
	declare resultado int;
	set resultado = num + num2;
	return resultado;
end;
€€
delimiter ;

select sumaConVariable(3,7);


-- Crear una función que dado un país devuelva su número de partidos ganados

select count(*) from results r
where r.Ganador = 'Spain';

Delimiter €€
create function numeroPartidosGanados(equipo varchar(255))
returns int 
begin 
	declare resultado int;
	set resultado = (select count(*) from results r where r.Ganador = equipo);
	return resultado;
end;
€€
delimiter ;

select numeroPartidosGanados('Spain')

select f.nombre , numeroPartidosGanados(f.nombre) from Futbol f ;

Delimiter €€
create function numeroPGanados(equipo varchar(255))
returns int 
begin 
	declare resultado int;
	select count(*) into resultado from results r where r.Ganador = equipo;
	return resultado;
end;
€€
delimiter ;

select numeroPartidosGanados('Spain');

-- Realizar una función que dado 2 goleadores, devuelva el que haya metido más

select count(*) from goalscorers g where g.scorer = 'David Villa';

Delimiter €€ 
create function mayorGoleador(jugador1 varchar(255), jugador2 varchar(255))
	returns varchar(255)
	begin
		declare nGolesJug1 int;
		declare nGolesJug2 int;
		declare resultado varchar(255);
		set nGolesJug1 = (select count(*) from goalscorers g where g.scorer = jugador1);
		set nGolesJug2 = (select count(*) from goalscorers g where g.scorer = jugador2);
		if(nGolesJug1 > nGolesJug2) then 
			set resultado = jugador1;
		else 
			if (nGolesJug1 < nGolesJug2) then 
				set resultado = jugador2;
			else 
				set resultado = 'Empate';
			end if;
		end if;
		return resultado;
	end;	
€€
delimiter ;

select mayorGoleador('David Villa', 'Cristiano Ronaldo');

/*Desarrollar una función que dado un equipo devuelva 'Ganado' o 'Perdido' o 'Empate' dependiendo del resultado que su último partido como local*/

select r.Ganador   from results r 
where r.home_team = 'Spain'
order by `date` desc
limit 1;

delimiter €€
create function ultimoResultado(equipo varchar(255))
	returns varchar(255)
	begin
		declare resultado varchar(255);
		declare ganador varchar(255);
		set ganador = (select r.Ganador  from results r where r.home_team = equipo order by `date` desc limit 1);
		if(ganador = equipo) then 
			set resultado = 'Ganador';
		elseif (ganador = 'Empate') then 
			set resultado = 'Empatado';
		else 
			set resultado = 'Perdido';
		end if;
		return resultado;
	end;
€€
delimiter ;

select ultimoResultado('Spain');


/*BASE DATOS HOTEL LUJO*/

set global log_bin_trust_function_creators = 1;

/* Desarrollar una función que recibiendo una habitación, una fecha de entrada y una de salida, devuelva disponible u ocupada*/

select count(*) from Reservas r where r.habitacion_id = 26 and ((r.fecha_inicio >= '20240102' and r.fecha_inicio <= '20240106') or (r.fecha_fin  >= '20240102' and r.fecha_fin <= '20240106')
or (r.fecha_inicio < '20240102' and r.fecha_fin > '20240106'));

delimiter €€
	create function disponibilidad (id_hab int, fechaEnt date, fechaSal date)
	returns varchar(255)
	begin
		declare resultado varchar(255);
		declare disponible int;
		set disponible = (select count(*) from Reservas r where r.habitacion_id = id_hab and ((r.fecha_inicio >= fechaEnt and r.fecha_inicio <= fechaSal) or (r.fecha_fin  >= fechaEnt and r.fecha_fin <= fechaSal)
		or (r.fecha_inicio < fechaEnt and r.fecha_fin > fechaSal)));
		if(disponible >= 1) then 
			set resultado = 'No disponible';
		else
			set resultado = 'Disponible';
		end if;
		return resultado;
	end;
€€
delimiter ;

drop function disponibilidad; /*Borrar función*/

select disponibilidad(3,'20251205', '20260102') as Disponibilidad;

-- Desarrollar una función qué recibiendo lo mismo que el anterior ejercicio, en caso de disponibilidad reserve la habitación y devuelva reservado, y "no estaba
-- disponinble en caso contrario. PD: Una función puede ser utilizada dentro de otra.


delimiter €€
	create function hacerReserva (id_hab int, fechaEnt date, fechaSal date, idUsario int ) //Necesita al menos la foreingkey para poder crear la reserva
	returns varchar(255)
	begin
		declare resultado varchar(255);
		declare resultadoAuxiliar varchar(255);
		set resultadoAuxiliar = select disponibilidad(id_hab int, fechaEnt date, fechaSal date)
		if(resultadoAuxiliar = 'Disponible') then
		INSERT INTO Reservas
		(reserva_id, cliente_id, habitacion_id, fecha_inicio, fecha_fin, total)
		VALUES(idUsario, id_hab, 0, '', '', 0);	
	end
€€
delimiter ;


-- BASE DE DATOS GIMNASIO --

/* Desarrollar una función que dado el nombre de un entrenador devuelva el numero de clases que ha impartido*/

select r.ClaseID  from Reservas r GROUP by r.ClaseID, r.Fecha 

select * from Entrenadores e 
inner join Clases c on c.EntrenadorID = e.EntrenadorID
inner join (select r.ClaseID  from Reservas r GROUP by r.ClaseID, r.Fecha ) r on r.ClaseID = c.ClaseID
where e.Nombre = 'Carlos' and e.Apellido = 'Pérez';

delimiter €€
	create function clasesEntrenador (nombreE varchar(50), apellidoE varchar(50))
	returns int
	begin
		declare resultado int;
		set resultado (select count(*) from Entrenadores e inner join Clases c on c.EntrenadorID = e.EntrenadorID inner join (select count(*) from Reservas r GROUP by r.ClaseID, r.Fecha ) r on r.ClaseID = c.ClaseID
		where e.Nombre = nombreE and e.Apellido = apellidoE));
		return resultado;
	end
	
€€
delimiter ;
	
set global log_bin_trust_function_creators = 1;

select clasesEntrenador('Carlos', 'Pérez');

alter table Clases add maximoAsistentes int;

update Clases
set maximoAsistentes=RAND()*10 + 5;

/*Desarrollar una función que devuelva "RESERVADO" o "NO SE PUEDE REALIZAR LA RESERVA". Que dado un socio, una clase y una fecha, intente realizar una reserva para la misma.*/

select * from Reservas r 

select r.ClaseID , r.Fecha, count(*) from Reservas r 
where r.ClaseID = 2 and r.Fecha = '2024-06-02'

select r.SocioID  from Reservas r where r.SocioID = 1 and r.Fecha = '2024-06-02'

select max(ReservaID) from Reservas r 

select c.maximoAsistentes from Clases c where c.ClaseID = 2;

DELIMITER €€
	CREATE FUNCTION nuevaReserva(socioP int, claseP int, fechaP  date)
	returns varchar(255)
	begin
		DECLARE resultado varchar(255);
		DECLARE socioRepe int;
		DECLARE nAsistentes int;
		DECLARE maxAsistentes int;
		set nAsistentes = (select count(*) from Reservas r where r.ClaseID = claseP and r.Fecha = fechaP);
		set maxAsistentes = (select c.maximoAsistentes from Clases c where c.ClaseID = claseP);
		set socioRepe = (select SocioID  from Reservas r where r.SocioID = socioP and r.Fecha = fechaP and ClaseID = claseP);
		if(socioRepe is not null) then
			set resultado = 'Ya esta reservado';
		elseif(nAsistentes >= maxAsistentes) then
			set resultado = 'No se puede reservar';
		else
			set resultado = 'Reservado';
			INSERT INTO gimnasio.Reservas (SocioID, ClaseID, Fecha) VALUES(socioP, ClaseP, FechaP);
		end if;
		return resultado;
	end
€€
Delimiter ;

DROP function nuevaReserva;

select nuevaReserva(1, 2, '2024-06-02') as Reserva

-- PROCEDIMIENTOS --
-- Son como las funciones pero sin devolver nada(Equivalente a void en programación) --

Delimiter €€
CREATE procedure cambiarAsistentes (in claseIDP int)
	begin
		update Clases
		set maximoAsistentes = rand() * 10 + 5
		where ClaseID = claseIDP;
	end
€€
Delimiter ;

drop procedure cambiarAsistentes;
	
call cambiarAsistentes(1);

/*
 * Desarrollar un procedimiento que no reciba params y recalcule el nº de asistentes de la clase que tiene menos.
 * No utilizar update*/
select ClaseID from Clases c 
order by c.maximoAsistentes 
limit 1;

delimiter €€
create procedure cambiarAsistente()
	begin
		declare idAuxiliar int; 	
		set idAuxiliar = (select ClaseID from Clases c order by c.maximoAsistentes limit 1);
		call cambiarAsistentes(idAuxiliar);
	end
€€
delimiter ;

call cambiarAsistente();

-- 

alter TABLE Entrenadores add salarioPorClase int;

update Entrenadores set salarioPorClase= rand()*20 +20;

/*
 * Desarrollar un procedimiento que aumente en un 5% el salario del entrenador que más clases haya impartido en el último mes
 * */

select r.ClaseID , r.Fecha from Reservas r 
group by r.ClaseID , r.Fecha ;

select e.EntrenadorID from Entrenadores e 
inner join Clases c on c.EntrenadorID  = e.EntrenadorID
inner join (select r.ClaseID , r.Fecha from Reservas r group by r.ClaseID , r.Fecha) r on r.ClaseID = c.ClaseID
where MONTH(r.Fecha) = (MONTH(NOW()) - 1) and year(r.Fecha) = YEAR(NOW())
group by e.EntrenadorID
order by count(*)  desc limit 1;

select nuevaReserva(1, 2, '2025-02-01') as Reserva;

delimiter €€
create procedure empleadoMes()
begin
	declare empleadoMes int;
	set empleadoMes = (select e.EntrenadorID from Entrenadores e 
	inner join Clases c on c.EntrenadorID  = e.EntrenadorID
	inner join (select r.ClaseID , r.Fecha from Reservas r group by r.ClaseID , r.Fecha) r on r.ClaseID = c.ClaseID
	where MONTH(r.Fecha) = (MONTH(NOW()) - 1) and year(r.Fecha) = YEAR(NOW())
	group by e.EntrenadorID order by count(*)  desc limit 1);
	update Entrenadores
	set salarioPorClase = salarioPorClase * 1.05
	where EntrenadorID = empleadoMes;
end
€€
delimiter ;

call empleadoMes();






set global log_bin_trust_function_creators = 0;

select count(*) from goalscorers
where team = 'Spain'
group by scorer
order by count(*) DESC 
limit 1
;

delimiter €€
CREATE function golesMaxJugador(equipo varchar(50))
returns int
begin
	declare nGoles int;
	set nGoles = (
		select count(*) from goalscorers
		where team = equipo
		group by scorer
		order by count(*) DESC 
		limit 1
	);
return nGoles;
end;
€€

delimiter ;

drop function golesMaxJugador;

select golesMaxJugador('Romania');


delimiter €€
CREATE function golesMaxGoleador(eq1 varchar(50), eq2 varchar(50))
returns varchar(50)
begin
	declare golesEq1 int;
	declare golesEq2 int;
	declare mejorEq varchar(50);
	set golesEq1 = golesMaxJugador(eq1);
	set golesEq2 = golesMaxJugador(eq2);
	if (golesEq1 > golesEq2)then
		set mejorEq = eq1;
	elseif (golesEq1 < golesEq2)then
		set mejorEq = eq2;
	else
		set mejorEq = 'Empate';
	end if;
return mejorEq;
end;
€€
delimiter ;

drop function golesMaxGoleador;

select golesMaxGoleador('Spain', 'Romania');









set global log_bin_trust_function_creators = 1;

select count(*) from goalscorers g 
where team = 'Spain'
group by g.scorer 
order by count(*) DESC 
limit 1
;

delimiter €€
create function maxGoleador (equipo varchar(50))
returns int
begin
	declare goles int;
	set goles = (
		select count(*) from goalscorers g 
		where team = equipo
		group by g.scorer 
		order by count(*) DESC 
		limit 1
	);
return goles;
end;
€€
delimiter ;

delimiter €€
create function mejorGoleador (eq1 varchar(50), eq2 varchar(50))
returns varchar(50)
begin
	declare golesE1 int;
	declare golesE2 int;
	declare mejorE varchar(50);
	set golesE1 = maxGoleador(eq1);
	set golesE2 = maxGoleador(eq2);
	if(golesE1 > golesE2)then
		set mejorE = eq1;
	elseif(golesE1 < golesE2)then
		set mejorE = eq2;
	else
		set mejorE = 'Empate';
	end if;
return mejorE;
end;
€€
delimiter ;

select mejorGoleador('Romania', 'France');

delimiter €€
create procedure insertarTandaPenaltis(
	in fPart date,
	in e_casa varchar(50),
	in e_visit varchar(50),
	in ganador varchar(50)
)
begin
	insert into shootouts (date, home_team, away_team, winner)
	values(fPart, e_casa, e_visit, ganador);
end
€€
delimiter ;

call insertarTandaPenaltis('2025-03-09', 'Spain', 'France', 'Spain');


-- Base de datos Gimnasio --

/* Funciones con fechas */

select year(NOW()); -- Nos devuelve el dia actual

select day(now()); -- Nos devuelve el dia actual
 
select MONTH(NOW()); -- Nos devuelve el mes actual

select HOUR(NOW()); -- Nos devuelve la hora actual

select DAYOFWEEK(NOW()), hour (now()); -- Devuelve el dia de la semana (1 Domingo, 6 Sabado) dada una fecha y la hora


/* Desarrollar una función, que devuelve el nombre de la siguiente clase que va a ser impartida */

select * from Clases c 
where c.DiaSemana = 'Martes' and c.hora > '12:00:00'
order by c.Hora
limit 1
;


select c.Nombre  from Clases c 
where c.DiaSemana = diaDeLaSemana() and c.hora > NOW() -- HOUR(c.Hora) > HOUR(NOW())
order by c.Hora
limit 1
;

set global log_bin_trust_function_creators = 1;

delimiter €€
create function diaDeLaSemana()
	returns varchar(50)
	begin
		declare diaHoy int;
		declare dia varchar(50);
		set diaHoy = dayofweek(now());
		if(diaHoy = 1) then
			set dia = 'Domingo';
		elseif(diaHoy = 2) then
			set dia = 'Lunes';
		elseif(diaHoy = 3) then
			set dia = 'Martes';
		elseif(diaHoy = 4) then
			set dia = 'Miercoles';
		elseif(diaHoy = 5) then
			set dia = 'Jueves';
		elseif(diaHoy = 6) then
			set dia = 'Viernes';
		elseif(diaHoy = 7) then
			set dia = 'Sabado';
		end if;
	return dia;
	end;
€€
delimiter ;

drop function diaDeLaSemana;

select diaDeLaSemana();


delimiter €€ 
create function siguienteClase()
returns varchar(50)
begin
	declare proximaClase varchar(50);
	set proximaClase = (select c.Nombre  from Clases c 
		where c.DiaSemana = diaDeLaSemana() and c.hora > NOW()
		order by c.Hora
		limit 1);
return proximaClase;
end;
€€ 
delimiter ;

select siguienteClase();

/**
 * Desarrollar una función que dado un entrenador y un intervalo de fechas, devolver la ganancia generada por el entrenedar
 */
select r.ClaseID, r.Fecha  from Reservas r 

select sum(e.salarioPorClase) from Entrenadores e 
inner join Clases c  on c.EntrenadorID = e.EntrenadorID
inner join (select r.ClaseID, r.Fecha  from Reservas r ) r1 on r1.ClaseID = c.ClaseID
where e.EntrenadorID = 6 and r1.Fecha between '20240601' and '20240630'
group by c.ClaseID , r1.Fecha
;

delimiter €€
create function gananciasEntrenador(idEntre int, fIni date, fFin date)
returns int
begin
	declare ganancia int;
	set ganancia = (select sum(e.salarioPorClase) from Entrenadores e 
		inner join Clases c  on c.EntrenadorID = e.EntrenadorID
		inner join Reservas r on r.ClaseID = c.ClaseID
		where e.EntrenadorID = idEntre and r.Fecha between fIni and fFin
		) group by c.ClaseID , r1.Fecha;
return ganancia;
end;
€€ 
delimiter ;

drop function gananciasEntrenador;

select nombre, gananciasEntrenador(e.EntrenadorID, '20240601', '20240630')
from Entrenadores e 
order by gananciasEntrenador(e.EntrenadorID, '20240201', '20240228')
;


















