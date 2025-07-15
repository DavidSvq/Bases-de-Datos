-- 1 Función: Edad de un paciente. Crea una función que reciba el id de un paciente
-- y devuelva su edad en años. La función debe calcular la diferencia entre la fecha
-- actual y la fecha de nacimiento del paciente.

select year(now()) - year(fecha_nacimiento)
from Paciente p 
where p.id = 1
;

delimiter €€ 
create function calcularEdad(idPacien int)
returns int
return (select year(now()) - year(fecha_nacimiento) from Paciente p where p.id = idPacien);
€€
delimiter ;

set global log_bin_trust_function_creators = 1;

select calcularEdad(1) as edadPaciente;

/*
 * 8 Función: Clasificación de pacientes por edad
 * Implementa una función que reciba el id de un paciente y devuelva una clasificación
 * basada en su edad: Niño (menores de 12). Adolescente (12-18 años), Adulto (19-64 años) y
 * Mayor (65 años o más)*/

delimiter €€ 
create function clasificarPorEdad(idPaci int)
returns varchar(50)
begin
	declare edad int;
	declare resultado varchar(50);
	set edad = calcularEdad(idPaci);
	if(edad < 12) then
		set resultado = 'Niño';
	elseif(edad <= 18) then
		set resultado = 'Adolescente';
	elseif(edad < 65)then
		set resultado = 'Adulto';
	elseif(edad >= 65) then
		set resultado = 'Anciano';
	end if;
return resultado;
end;
€€
delimiter ;

drop function clasificarPorEdad;

select clasificarPorEdad(3);

/**
 * 13. Procedimiento.Definir prioridad de atención de una cita
 * Diseña un procedimiento que reciba el id de una cita y determine la prioridad de atención
 * según la edad del paciente y el motivo de la cita. Si el paciente es mayor de 70 años y el 
 * motivo es "Emergencia", la cita tendrá prioridad "Alta". Si el motivo es "Dolor Fuerte" y el
 * paciente tiene entre 50 y 69 años, la prioridad será "Media". Para el resto de los casos, la 
 * prioridad será "Baja".
 */

alter table Cita  add Prioridad varchar(50);

update Cita c 
set Prioridad = 'Alta'
where calcularEdad(c.id_paciente) > 70 
or c.motivo like '%Emergencia%' and c.id = 1 ;

update Cita c 
set Prioridad = 'Media'
where calcularEdad(c.id_paciente) between 50 and 69
or c.motivo like '%dolor%fuerte%'
or c.motivo like '%fuerte%dolor%'
and c.id = 1 ;


delimiter €€
create procedure ingresarPrioridad(in edadPaci int, in moti varchar(50))
begin
	if(edadPaci > 70 and movi = 'Emergencia') then
		update Cita c set Prioridad = 'Alta';
	elseif((edadPaci between 50 and 69) and movi = 'Dolor Fuerte')then
		update Cita c set Prioridad = 'Media';
	else
		update Cita c set Prioridad = 'Baja';
end
€€
delimiter ;

/**
 * 3 Funcion: Coste total de citas de un paciente.
 * Crea una función que reciba el id de un paciente y devuelva el monto total que ha gastado en citas 
 * médicas. La función debe sumar el costo de todas las facturas asociadas a ese paciente. Si el paciente no tiene facturas, debe devolver 0. 
 */

 
set global log_bin_trust_function_creators = 1;

select sum(f.monto) from Factura f 
inner join Cita c on c.id = f.id_cita
where c.id_paciente = 9;

delimiter €€
create function gastoTotal (idPaciente int)
returns float
begin
	declare gastoAux float;
	set gastoAux = (select sum(f.monto) from Factura f 
		inner join Cita c on c.id = f.id_cita
		where c.id_paciente = idPaciente);
		if(gastoAux is null)then
			set gastoAux = 0;
		end if;
return gastoAux;
end;
€€
delimiter ;

select gastoTotal(9);

/**
 *Procedimiento: Generar una factura automaticamente
 *Crea un procedimiento almacenado que genere una factura para una cita médica. Este 
 *procedimiento debe recibir el id de la cita como parametro y generar una factura con 
 *un monto aleatorio entre 50 y 500 euros. Si la cta ya tiene una factura asociada, debe 
 *lanzar un error. 
 */
INSERT INTO  Cita c (id, id_paciente, id_medico, fecha, motivo, prioridad)
values (id_cita, 1, 4, 2025-03-18 16:00:00, 'Chequeo General', 'Alta');

delimiter €€ 
create procedure generarFactura(in idCita int, out errorFa varchar(50))
begin
	declare monto_aux float;
	set monto_aux = rand() * 450 + 50;
	if(id_cita is not null) then
		INSERT INTO  Cita c (id, id_paciente, id_medico, fecha, motivo, prioridad)
		values (idCita, 1, 4, 2025-03-18 16:00:00, 'Chequeo General', 'Alta');
		insert into Factura (id_Cita, monto, pagado) values (9, idCita, monto_aux, 1);
	else
		set errorFa = 'Error';
end
€€
delimiter ;


select * from Factura f 
where id_cita = 6;

set global log_bin_trust_function_creators = 1;

/**
 * Desarrollar una función que recibiendo una altura y un peso, devuelva su IMC. Peso / ALtura ^2
 */

delimiter €€
create function calcularIMC (altura int, peso float)
returns float
begin
	declare resultado float;
	set resultado = peso/(altura*altura);
return resultado;
end;
€€
delimiter ;

select calcularIMC(170, 70);

/**
 * Desarrolla una función dado un paciente devuelva el médico con el que más cita haya tenido
 * 
 */

select c.id_medico 
from Cita c 
where c.id_paciente = 1
GROUP BY c.id_medico 
order by COUNT(*) desc
limit 1 
;

delimiter €€
create function citasMasMedicos(idPancient int)
returns int
return (select c.id_medico 
	from Cita c 
	where c.id_paciente = idPancient
	GROUP BY c.id_medico 
	order by COUNT(*) desc
	limit 1 );
€€
delimiter ;

drop function citasMasMedicos;

select citasMasMedicos(3)
;

/*
* DESARROLLA UNA FUNCIÓN QUE DADO UN PACIENTE DEVUELVA 'HABITUAL' SI HA ACUDIDO
* A MÁS DE 5 CITAS. 'PUNTUAL' ENTRE 1 Y 5. 'NUEVO' SI NO HA TENIDO TODAVÍA NINGUNA CITA
*/

select count(c.id )
from Cita c 
where c.id_paciente = 1
;

delimiter €€
create function calificarPaciente(idPacient int)
returns varchar(255)
begin
	declare resultado varchar(255);
	declare nCitas int;
	set nCitas = (select count(c.id )
					from Cita c 
					where c.id_paciente = idPacient);
	if(nCitas > 5)then
		set resultado = 'Habitual';
	elseif(nCitas <= 5 and nCitas >=1)then
		set resultado = 'Puntual';
	elseif(nCitas = 0) then
		set resultado = 'Nuevo';
	end if;
return resultado;
end;
€€
delimiter ;

SELECT calificarPaciente(1);

/*AÑADIR UNA COLUMNA PORCENTAJE (CON VALORES ALEATORIOS HASTA 20), QUE SERÁ EL PORCENTAJE DE LO QUE RECIBE DE UNA FACTURA Y OTRA
 * RECIBIDO EN LA TABLA MÉDICO, QUE SERÁ EL TOTAL DE DINERO RECIBIDO POR EL MÉDICO. DESARROLLA UN 
 * PROCEDIMIENTO QUE CALCULE EL TOTAL GANADO POR UN MÉDICO CON LAS FACTURAS PAGADAS*/

alter table Medico add column Porcentaje int
;

alter table Medico add column Cobrado float
;

select *
from Factura f 
inner join Cita c ON c.id = f.id_cita
inner join Medico m ON m.id = c.id_medico
where c.id_medico = 5 and f.pagado = 1
;

delimiter €€
create procedure asignarPorcentaje()
begin
	update Medico 
	set Porcentaje = rand()*20;
end
€€
delimiter ;

call asignarPorcentaje();


select *
from Factura f 
inner join Cita c ON c.id = f.id_cita
inner join Medico m ON m.id = c.id_medico
where f.pagado = 1
;

select sum(f.monto * m.Porcentaje)/100 as cobrado
from Factura f 
inner join Cita c ON c.id = f.id_cita
inner join Medico m ON m.id = c.id_medico
where f.pagado = 1 and m.id = 5 
;

UPDATE Medico 
set Cobrado = (select sum(f.monto * m.Porcentaje)/100
				from Factura f 
				inner join Cita c ON c.id = f.id_cita
				inner join Medico m ON m.id = c.id_medico
				where f.pagado = 1 and m.id = 3)
;


delimiter €€
create procedure asignarCobro()
begin
	update Medico
	set Cobrado = (select sum(f.monto * m.Porcentaje)/100 as cobrado
					from Factura f 
					inner join Cita c ON c.id = f.id_cita
					inner join Medico m ON m.id = c.id_medico
					where f.pagado = 1 );
end
€€
delimiter ;

drop procedure asignarCobro;

call asignarCobro();

/*delimiter €€ 
create procedure (in idMedic int)
begin
	declare facturaPagada = (select *
							from Factura f 
							inner join Cita c ON c.id = f.id_cita
							inner join Medico m ON m.id = c.id_medico
							where c.id_medico = 5 and f.pagado = 1);

end*/

select * from Medico m 

alter table Medico add ultimaCita int;

alter table Medico add foreign key(ultimaCita)references Cita (id);

/***
 * Desarrollar un Trigger que tras una nueva cita automáticamente la asigne al médico correspondiente
 **/

delimiter €€
create trigger asignarUltimaCita
after insert on Cita
for each row
begin
	update Medico 
	set ultimaCita = new.id
	where id = new.id_medico;
end
€€
delimiter ;

drop trigger asignarUltimaCita;

insert into Cita (id_medico, id_paciente, fecha, motivo, Prioridad)
values(5,5,'2025-06-11', 'Revisión', 'Media');

/**
 * Desarrollar un trigger que permita eliminar una cita, sin tener fallos por la FK ultimaCita
 */

select id
from Cita c 
where id_medico = 2 and id != 5
order by fecha desc
limit 1;


delimiter €€
create trigger preBorrado
before delete on Cita 
for each row
begin
	declare ultima int;
	set ultima = (select id
				from Cita c 
				where id_medico = old.id_medico and id != old.id
				order by fecha desc
				limit 1);		
	update Medico
	set ultimaCita = null
	where ultimaCita = old.id;
	delete from Factura
	where id_cita = old.id;
end
€€
delimiter ;

drop trigger preBorrado;

delete from Cita 
where id = 19;
