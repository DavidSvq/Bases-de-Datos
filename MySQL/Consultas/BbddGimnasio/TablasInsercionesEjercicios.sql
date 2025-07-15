CREATE TABLE Socios (
    SocioID INT PRIMARY KEY,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    Email VARCHAR(100),
    Telefono VARCHAR(15),
    FechaNacimiento DATE
);

INSERT INTO Socios (SocioID, Nombre, Apellido, Email, Telefono, FechaNacimiento) VALUES
(1, 'Juan', 'Pérez', 'juan.perez@example.com', '123456789', '1985-01-15'),
(2, 'María', 'García', 'maria.garcia@example.com', '234567890', '1990-03-22'),
(3, 'Carlos', 'Sánchez', 'carlos.sanchez@example.com', '345678901', '1987-06-10'),
(4, 'Ana', 'Martínez', 'ana.martinez@example.com', '456789012', '1992-08-18'),
(5, 'Pedro', 'López', 'pedro.lopez@example.com', '567890123', '1983-11-29'),
(6, 'Lucía', 'Hernández', 'lucia.hernandez@example.com', '678901234', '1995-04-14'),
(7, 'Jorge', 'Díaz', 'jorge.diaz@example.com', '789012345', '1989-12-02'),
(8, 'Laura', 'Rodríguez', 'laura.rodriguez@example.com', '890123456', '1991-07-25'),
(9, 'Sergio', 'Fernández', 'sergio.fernandez@example.com', '901234567', '1986-09-17'),
(10, 'Elena', 'Gómez', 'elena.gomez@example.com', '123123123', '1988-05-03');
CREATE TABLE Entrenadores (
    EntrenadorID INT PRIMARY KEY,
    Nombre VARCHAR(50),
    Apellido VARCHAR(50),
    Especialidad VARCHAR(100)
);
INSERT INTO Entrenadores (EntrenadorID, Nombre, Apellido, Especialidad) VALUES
(1, 'Carlos', 'Pérez', 'Yoga'),
(2, 'María', 'López', 'Pilates'),
(3, 'José', 'Martínez', 'CrossFit'),
(4, 'Ana', 'García', 'Zumba'),
(5, 'Luis', 'Hernández', 'HIIT'),
(6, 'Laura', 'Díaz', 'Spinning'),
(7, 'Javier', 'González', 'Natación'),
(8, 'Elena', 'Fernández', 'Boxeo'),
(9, 'Fernando', 'Gómez', 'Entrenamiento Funcional'),
(10, 'Marta', 'Ruiz', 'Body Pump');

CREATE TABLE Clases (
    ClaseID INT PRIMARY KEY,
    Nombre VARCHAR(100),
    DiaSemana VARCHAR(10),
    Hora TIME,
    EntrenadorID INT,
    FOREIGN KEY (EntrenadorID) REFERENCES Entrenadores(EntrenadorID)
);
INSERT INTO Clases (ClaseID, Nombre, DiaSemana, Hora, EntrenadorID) VALUES
(1, 'Yoga Matutino', 'Lunes', '08:00:00', 1),
(2, 'Pilates Avanzado', 'Martes', '09:00:00', 2),
(3, 'CrossFit Intenso', 'Miercoles', '10:00:00', 3),
(4, 'Zumba Fitness', 'Jueves', '11:00:00', 4),
(5, 'HIIT Express', 'Viernes', '12:00:00', 5),
(6, 'Spinning Power', 'Sabado', '13:00:00', 6),
(7, 'Natación Libre', 'Domingo', '14:00:00', 7),
(8, 'Boxeo Training', 'Lunes', '15:00:00', 8),
(9, 'Entrenamiento Funcional', 'Martes', '16:00:00', 9),
(10, 'Body Pump', 'Miercoles', '17:00:00', 10),
(11, 'Body Combat', 'Jueves', '18:00:00', 1),
(12, 'Step Aeróbico', 'Viernes', '19:00:00', 1),
(13, 'AquaGym', 'Sabado', '20:00:00', 3),
(14, 'Aeróbic Clásico', 'Domingo', '21:00:00', 3),
(15, 'TRX Power', 'Lunes', '22:00:00', 5),
(16, 'Stretching Relajante', 'Martes', '23:00:00', 5),
(17, 'Fitness General', 'Miercoles', '07:00:00', 7),
(18, 'Tai Chi Avanzado', 'Jueves', '06:00:00', 3),
(19, 'Ciclismo Indoor', 'Viernes', '05:00:00', 5),
(20, 'Kettlebell Training', 'Sabado', '04:00:00', 6);

CREATE TABLE Reservas (
    ReservaID INT PRIMARY KEY,
    SocioID INT,
    ClaseID INT,
    Fecha DATE,
    FOREIGN KEY (SocioID) REFERENCES Socios(SocioID),
    FOREIGN KEY (ClaseID) REFERENCES Clases(ClaseID)
);

INSERT INTO Reservas (ReservaID, SocioID, ClaseID, Fecha) VALUES
(1, 1, 1, '2024-06-01'),
(2, 1, 2, '2024-06-02'),
(3, 3, 3, '2024-06-03'),
(4, 4, 4, '2024-06-04'),
(5, 4, 5, '2024-06-05'),
(6, 6, 6, '2024-06-06'),
(7, 7, 7, '2024-06-07'),
(8, 8, 8, '2024-06-08'),
(9, 9, 9, '2024-06-09'),
(10, 5, 10, '2024-06-10'),
(11, 5, 11, '2024-06-11'),
(12, 2, 12, '2024-06-12'),
(13, 5, 13, '2024-06-13'),
(14, 4, 14, '2024-06-14'),
(15, 5, 15, '2024-06-15'),
(16, 6, 16, '2024-06-16'),
(17, 2, 17, '2024-06-17'),
(18, 7, 18, '2024-06-18'),
(19, 8, 19, '2024-06-19'),
(20, 2, 20, '2024-06-20');



/**
 * 1. Consultas SQL

- Escriba una consulta para obtener las clases impartidas por un entrenador específico.
- Diseñe una consulta que muestre el nombre y apellido de los socios que han reservado la clase
de &quot;Yoga Matutino&quot;
- Desarrolle una consulta que devuelva la dupla entrenador-socio que más haya coincidido.
*/

select * from Clases c 
where c.EntrenadorID = 3
;

select s.Nombre, s.Apellido from Socios s 
inner join Reservas r on r.SocioID = s.SocioID
inner join Clases c on c.ClaseID = r.ClaseID
where c.Nombre like 'Yoga Matutino'
;

select c.EntrenadorID, r.SocioID, count(*) as MayorCoincidencia
from Reservas r 
inner join Clases c on c.ClaseID = r.ClaseID
GROUP by c.EntrenadorID, r.SocioID 
order by count(*) desc
limit 1
;

/**
 * 2. Inserciones SQL
 * - Inserte un nuevo socio en la tabla `Socios`.
 */

insert into Socios (SocioID, Nombre, Apellido, Email, Telefono, FechaNacimiento)
values (11, 'David', 'Yo', 'arroba@punto.com', 23462957, '2000-03-20')
;


/**
 * 3. Modificaciones y Borrados
 * - Escriba una instrucción SQL para actualizar la cantidad de un equipo específico.
 * - Añade una columna en la tabla Entrenadores llamada nClases (int).
 */

UPDATE Clases c 
set c.Hora = '13:30:00'
where c.ClaseID = 6
;

alter table Entrenadores add column NumeroDeClases int;


/**
 * 4. Funciones y procedimientos.

- Utilizando un procedimiento que reciba como parámetro un entrenador, añade el valor del
número de clases que imparte ese entrenador.
- Desarrolla una función que dado un socio te devuelva el nombre del entrenador con el que
más ha coincidido.
 */

delimiter €€
create procedure insertarNumeroClasesEntrendado(in idEntrenad int)
begin
	declare nClases int;
	set nClases = (select count(*) from Clases c 
					where c.EntrenadorID = idEntrenad);
	update Entrenadores e
	set NumeroDeClases = nClases
	where e.EntrenadorID = idEntrenad;
end
€€
delimiter ;

drop procedure insertarNumeroClasesEntrendado;


call insertarNumeroClasesEntrendado(10);


set global log_bin_trust_function_creators = 1;

select e.Nombre
from Clases c 
inner join Reservas r on r.ClaseID = c.ClaseID
inner join Entrenadores e on e.EntrenadorID = c.EntrenadorID
where r.SocioID = 1
group by e.Nombre, c.EntrenadorID 
order by count(*) desc
limit 1
;

delimiter €€
create function nombreEntrenador(idSoci int)
returns varchar(150)
begin
	declare nombre_E varchar(150);
	set nombre_E = (select e.Nombre
					from Clases c 
					inner join Reservas r on r.ClaseID = c.ClaseID
					inner join Entrenadores e on e.EntrenadorID = c.EntrenadorID
					where r.SocioID = idSoci
					group by e.Nombre, c.EntrenadorID 
					order by count(*) desc
					limit 1);
	if(nombre_E is null)then
		set nombre_E = 'Error al introducir el socio. No tiene clases asociadas';
	end if;
return nombre_E;
end;
€€
delimiter ;

drop function nombreEntrenador;

select nombreEntrenador(1) as MayorCoincidenciaCon;



