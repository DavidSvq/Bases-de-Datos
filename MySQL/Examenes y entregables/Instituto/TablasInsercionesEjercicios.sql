
-- Tabla de profesores
CREATE TABLE Profesores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    especialidad VARCHAR(100)
);

-- Tabla de cursos
CREATE TABLE Cursos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    horas INT,
    profesor_id INT,
    FOREIGN KEY (profesor_id) REFERENCES Profesores(id)
);

-- Tabla de alumnos
CREATE TABLE Alumnos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    email VARCHAR(100),
    fecha_registro DATE
);

-- Tabla de matrículas
CREATE TABLE Matriculas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    alumno_id INT,
    curso_id INT,
    fecha_matricula DATE,
    nota_final float,
    FOREIGN KEY (alumno_id) REFERENCES Alumnos(id),
    FOREIGN KEY (curso_id) REFERENCES Cursos(id)
);

-- Tabla de clases
CREATE TABLE Clases (
    id INT AUTO_INCREMENT PRIMARY KEY,
    curso_id INT,
    fecha DATE,
    tema VARCHAR(255),
    FOREIGN KEY (curso_id) REFERENCES Cursos(id)
);

-- Tabla de asistencia
CREATE TABLE Asistencias (
    id INT AUTO_INCREMENT PRIMARY KEY,
    clase_id INT,
    alumno_id INT,
    asistio BOOLEAN,
    FOREIGN KEY (clase_id) REFERENCES Clases(id),
    FOREIGN KEY (alumno_id) REFERENCES Alumnos(id)
);
-- Profesores
INSERT INTO Profesores (nombre, especialidad) VALUES
('Ana Torres', 'Programación'),
('Luis García', 'Bases de Datos'),
('Marta Ruiz', 'Diseño Web');

-- Cursos
INSERT INTO Cursos (nombre, horas, profesor_id) VALUES
('Java desde cero', 60, 1),
('MySQL avanzado', 50, 2),
('HTML y CSS', 40, 3);

-- Alumnos
INSERT INTO Alumnos (nombre, email, fecha_registro) VALUES
('Carlos Pérez', 'carlos@mail.com', '2023-09-01'),
('Lucía López', 'lucia@mail.com', '2023-09-02'),
('David Sánchez', 'david@mail.com', '2023-09-03'),
('María Torres', 'maria@mail.com', '2023-09-04'),
('Elena Gómez', 'elena@mail.com', '2023-09-05');

-- Matriculas
INSERT INTO Matriculas (alumno_id, curso_id, fecha_matricula, nota_final) VALUES
(1, 1, '2023-09-10', NULL),
(2, 1, '2023-09-11', NULL),
(3, 2, '2023-09-10', NULL),
(4, 2, '2023-09-12', NULL),
(5, 3, '2023-09-12', NULL);

-- Clases
INSERT INTO Clases (curso_id, fecha, tema) VALUES
(1, '2023-09-15', 'Introducción a Java'),
(1, '2023-09-17', 'Estructuras de control'),
(2, '2023-09-16', 'Subconsultas y Joins'),
(3, '2023-09-18', 'Selectores CSS'),
(3, '2023-09-20', 'Flexbox y Grid');

-- Asistencias
INSERT INTO Asistencias (clase_id, alumno_id, asistio) VALUES
(1, 1, TRUE),
(1, 2, FALSE),
(2, 1, TRUE),
(2, 2, TRUE),
(3, 3, TRUE),
(3, 4, TRUE),
(4, 5, TRUE),
(5, 5, FALSE);


--------------------------------------------------------------------------------
-- EXAMEN: PROCEDIMIENTOS Y FUNCIONES CON BUCLES Y TRIGGERS EN MYSQL
-- --------------------------------------------------------------------------------

-- 1. TRIGGER:
-- Realizar un disparador que no permita insertar ni modificar una nota con un valor
-- negativo ni mayor de 10. En caso de insertar un valor negativo se guardará como 0 y
-- en caso mayor de 10, como 1.

delimiter €€
create trigger controlNotasLimite
before insert on Matriculas
for each row
begin
	if new.nota_final < 0 then
		set new.nota_final = 0;
	elseif new.nota_final > 10 then
		set new.nota_final = 10;
	end if;
end
€€
delimiter ;

insert into Matriculas (alumno_id, curso_id, fecha_matricula,nota_final)
values(1,1, date(now()),12);

delimiter €€
create trigger controlNotasLimiteModifcación
before update on Matriculas
for each row
begin
	if old.nota_final != new.nota_final then
		if new.nota_final < 0 then
			set new.nota_final = 0;
		elseif new.nota_final > 10 then
			set new.nota_final = 10;
		end if;
	end if;
end
€€
delimiter ;

update Matriculas 
set nota_final = -3
where id = 6;

-- 2. FUNCIÓN: PorcentajeAsistencia
-- Crea una función llamada `PorcentajeAsistencia` que reciba el ID de un alumno
-- y el ID de un curso, y devuelva el porcentaje de clases a las que asistió ese
-- alumno en ese curso (número de asistencias positivas dividido entre total de clases).

-- Clases asistidas
select sum(asistio)
from Asistencias a 
inner join Clases c on a.clase_id = c.id
where a.alumno_id = 1 and curso_id = 1

-- Numero de clases
select count(clase_id)
from Asistencias a 
inner join Clases c on a.clase_id = c.id
where a.alumno_id = 1 and curso_id = 1
;

set global log_bin_trust_function_creators=1;

delimiter €€ 
create function porcentajeAsistencia(idALum int, idCur int)
returns float
begin
	declare nClases int;
	declare nAsistencias int;
	declare porcentaje float;
	set nClases = (select count(clase_id)
					from Asistencias a 
					inner join Clases c on a.clase_id = c.id
					where a.alumno_id = idALum and curso_id = idCur);
	set nAsistencias = (select sum(asistio)
						from Asistencias a 
						inner join Clases c on a.clase_id = c.id
						where a.alumno_id = 1 and curso_id = 1);
	set porcentaje = (nAsistencias/nClases) * 100;
return porcentaje;
end;
€€
delimiter ;

select porcentajeAsistencia(1, 1) as PorcentajeAsistencia

-- 3. PROCEDIMIENTO: SIMULAR CLASE
-- CREA UN PROCEDIMIENTO SIMULAR CLASE, QUE DADA UNA CLASE SIMULE
-- LA ASISTENCIA DE LOS ALUMNOS MATRICULADOS ALEATORIAMENTE 
-- (50% DE PROBABILIDAD DE ASISTENCIA)

-- Consulta asistencia alumnos para clase_id
select asistio
from Asistencias a 
inner join Clases c on a.clase_id = c.id
where c.id = 1
  ;

delimiter €€
create procedure simularClase(in idClas int)
begin
	declare aleatorio int;
	declare asistioA int;
	declare cursorG cursor for select asistio
								from Asistencias a 
								inner join Clases c on a.clase_id = c.id
								where c.id = idClas;
	declare continue handler for not found set @done=true;
	set @done=false;
	open cursorG;
	bucle:loop
		fetch cursorG into asistioA;
		if @done then
			leave bucle;
		end if;
		set aleatorio = round(rand() * 1 );
		update Asistencias a 
		set asistio = aleatorio
		where clase_id = idClas;
	end loop;
	close cursorG;	
end
€€
delimiter ;

call simularClase(1);

-- 4. TRIGGER: FechaMatriculaPorDefecto
-- Crea un trigger  en la tabla `Matriculas` que establezca
-- automáticamente la fecha actual en el campo `fecha_matricula`
-- si se intenta insertar un valor NULL en ese campo.

delimiter €€
create trigger FechaMatriculaPorDefecto
before insert on Matriculas
for each row
begin
	if new.fecha_matricula is null then
		set new.fecha_matricula = date(now());
	end if;
end;
€€ 
delimiter ;

insert into Matriculas (alumno_id, curso_id, fecha_matricula, nota_final)
values(1, 2, null, 8);


-- 5. PROCEDIMIENTO: EliminarAlumnosInactivos
-- Crea un procedimiento que utilice bucles llamado `EliminarAlumnosInactivos`
-- que elimine de la tabla `Alumnos` a todos aquellos que no estén matriculados en ningún curso.

-- insertar alumnos sin registrar en ningun curso
insert into Alumnos (nombre, email, fecha_registro)
values('David','d@d.com', date(now()));

insert into Alumnos (nombre, email, fecha_registro)
values('Maria','d@d.com', date(now()));

select m.alumno_id
from Alumnos a 
left join Matriculas m on m.alumno_id = a.id;

select m.id 
from Alumnos a 
left join Matriculas m on m.alumno_id = a.id
where m.alumno_id is null;

delimiter €€
create procedure EliminarAlumnosInactivos()
begin
	declare cursoA int;
	declare cursorG cursor for select m.id 
								from Alumnos a 
								left join Matriculas m on m.alumno_id = a.id;
	declare continue handler for not found set @done=true;
	set @done=false;
	open cursorG;
	bucle:loop
		fetch cursorG into cursoA;
		if @done then
			leave bucle;
		end if;
		if cursoA=null then
			delete from Alumnos;
		end if;
	end loop;
	close cursorG;
end
€€ 
delimiter ;

drop procedure EliminarAlumnosInactivos;

call EliminarAlumnosInactivos();


