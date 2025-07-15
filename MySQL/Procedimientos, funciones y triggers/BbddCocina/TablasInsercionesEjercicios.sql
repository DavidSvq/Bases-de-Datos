-- Bucles y Disparadores


-- Tabla de Aspirantes
CREATE TABLE Aspirantes (
id_aspirante INT AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
apellido VARCHAR(50) NOT NULL,
fecha_nacimiento DATE NOT NULL,
especialidad_preferida VARCHAR(50),
nivel_culinario INT
);

-- Tabla de Recetas
CREATE TABLE Recetas (
id_receta INT AUTO_INCREMENT PRIMARY KEY,
nombre_receta VARCHAR(100) NOT NULL,
tipo_cocina VARCHAR(50),
dificultad VARCHAR(50),
tiempo_preparacion INT,
descripcion TEXT
);

-- Tabla de MaestrosChefs
CREATE TABLE MaestrosChefs (
id_chef INT AUTO_INCREMENT PRIMARY KEY,
nombre_chef VARCHAR(50) NOT NULL,
apellido_chef VARCHAR(50) NOT NULL,
especialidad VARCHAR(50),
experiencia_anios INT
);


INSERT INTO Aspirantes (nombre, apellido, fecha_nacimiento, especialidad_preferida, nivel_culinario) VALUES
('Ana', 'González', '1995-03-12', 'Pastelería', 3),
('Carlos', 'López', '1990-07-25', 'Cocina Mediterránea', 2),
('Elena', 'Martínez', '1998-01-05', 'Cocina Asiática', 1),
('David', 'Ramírez', '1993-09-18', 'Cocina Mexicana', 4),
('Laura', 'Pérez', '1997-04-23', 'Cocina Italiana', 2),
('Javier', 'Gómez', '1994-11-30', 'Cocina Vegetariana', 3),
('María', 'Sánchez', '1999-06-15', 'Cocina Española', 1),
('Sofía', 'Díaz', '1996-08-20', 'Cocina Francesa', 4),
('Diego', 'Hernández', '1992-02-10', 'Cocina Fusión', 3),
('Patricia', 'Torres', '1991-10-07', 'Repostería', 2);

-- Inserciones para la tabla de Recetas
INSERT INTO Recetas (nombre_receta, tipo_cocina, dificultad, tiempo_preparacion, descripcion) VALUES
('Tiramisú', 'Italiana', 'Media', 60, 'Postre italiano a base de café y mascarpone'),
('Sushi', 'Asiática', 'Alta', 45, 'Rollitos de arroz y pescado crudo'),
('Paella', 'Española', 'Media', 50, 'Arroz con mariscos y pollo'),
('Tacos al Pastor', 'Mexicana', 'Baja', 30, 'Tortillas de maíz con carne adobada'),
('Ratatouille', 'Francesa', 'Media', 40, 'Guiso de verduras al horno'),
('Pasta Carbonara', 'Italiana', 'Media', 35, 'Pasta con salsa a base de huevo, queso, panceta y pimienta'),
('Curry de Verduras', 'Asiática', 'Media', 40, 'Guiso de verduras con salsa de curry'),
('Croissants', 'Francesa', 'Alta', 90, 'Panecillos hojaldrados tradicionales franceses'),
('Gazpacho', 'Española', 'Baja', 20, 'Sopa fría de tomate y hortalizas'),
('Risotto de Champiñones', 'Italiana', 'Media', 45, 'Arroz cremoso con champiñones y queso Parmesano');

-- Inserciones para la tabla de MaestrosChefs
INSERT INTO MaestrosChefs (nombre_chef, apellido_chef, especialidad, experiencia_anios) VALUES
('Alejandro', 'Ruiz', 'Cocina Mexicana', 15),
('Isabel', 'Gómez', 'Cocina Italiana', 12),
('Carlos', 'Fernández', 'Cocina Española', 20),
('Lucía', 'Morales', 'Cocina Asiática', 10),
('Roberto', 'López', 'Cocina Francesa', 18),
('María', 'Ortega', 'Cocina Vegetariana', 8),
('Javier', 'Navarro', 'Cocina Mediterránea', 16),
('Elena', 'García', 'Repostería', 22),
('Daniel', 'Sanchez', 'Cocina Fusión', 14),
('Laura', 'Jiménez', 'Pastelería', 9);

-- Tabla de Chef_receta
CREATE TABLE CHEF_RECETA(
id_receta_chef int primary key auto_increment,
nombre_chef varchar(255),
apellido_chef varchar(255),
receta int,
nota float,
foreign key (receta) references Recetas(id_receta)
);

-- Alejandro Ruiz: Cocina Mexicana
INSERT INTO CHEF_RECETA (nombre_chef, apellido_chef, receta, nota) VALUES
('Alejandro', 'Ruiz', 4, 9.2),
('Alejandro', 'Ruiz', 3, 8.7),
('Alejandro', 'Ruiz', 9, 9.1);

-- Isabel Gómez: Cocina Italiana
INSERT INTO CHEF_RECETA (nombre_chef, apellido_chef, receta, nota) VALUES
('Isabel', 'Gómez', 6, 8.5),
('Isabel', 'Gómez', 1, 9.0),
('Isabel', 'Gómez', 10, 8.6);

-- Carlos Fernández: Cocina Española
INSERT INTO CHEF_RECETA (nombre_chef, apellido_chef, receta, nota) VALUES
('Carlos', 'Fernández', 3, 9.4),
('Carlos', 'Fernández', 9, 9.0);

-- Elena García: Repostería
INSERT INTO CHEF_RECETA (nombre_chef, apellido_chef, receta, nota) VALUES
('Elena', 'García', 1, 9.6),
('Elena', 'García', 8, 9.8);

-- Laura Jiménez: Pastelería
INSERT INTO CHEF_RECETA (nombre_chef, apellido_chef, receta, nota) VALUES
('Laura', 'Jiménez', 1, 9.3),
('Laura', 'Jiménez', 8, 9.1);


-- Ana González: Pastelería
INSERT INTO CHEF_RECETA (nombre_chef, apellido_chef, receta, nota) VALUES
('Ana', 'González', 1, 8.5),
('Ana', 'González', 8, 8.2);

-- Carlos López: Mediterránea
INSERT INTO CHEF_RECETA (nombre_chef, apellido_chef, receta, nota) VALUES
('Carlos', 'López', 6, 7.8);

-- Elena Martínez: Asiática
INSERT INTO CHEF_RECETA (nombre_chef, apellido_chef, receta, nota) VALUES
('Elena', 'Martínez', 2, 7.2);

-- David Ramírez: Mexicana
INSERT INTO CHEF_RECETA (nombre_chef, apellido_chef, receta, nota) VALUES
('David', 'Ramírez', 4, 8.0);

-- Sofía Díaz: Francesa
INSERT INTO CHEF_RECETA (nombre_chef, apellido_chef, receta, nota) VALUES
('Sofía', 'Díaz', 5, 8.8);


-- 1. Realiza una función que dado un chef devuelva su mejor plato. (1p)

select r.nombre_receta
from CHEF_RECETA cr 
inner join Recetas r on r.id_receta = cr.receta
where nombre_chef  = 'Elena'
order by  cr.nota desc
limit 1;

set global log_bin_trust_function_creators = 1;

delimiter €€
create function mejorPlato(nombreChe varchar(255))
returns varchar(255)
return (select r.nombre_receta
		from CHEF_RECETA cr 
		inner join Recetas r on r.id_receta = cr.receta
		where nombre_chef  = nombreChe
		order by  cr.nota desc
		limit 1);
€€
delimiter ;

select mejorPlato('Elena');

-- 2. Desarrolla un disparador que no permita insertar notas mayores a 10. (1.5p)

delimiter €€
create trigger notaLimite
before insert on CHEF_RECETA
for each row
begin
	if(new.nota > 10)then
		/*insert into CHEF_RECETA (nombre_chef, apellido_chef, receta, nota)
		values(new.nombre_chef, new.apellido_chef, new.receta, 10);*/
		/*update CHEF_RECETA 
		set nota = 10
		where nombre_chef = new.nombre_chef;*/
		set new.nota = 10;
	end if;
end;
€€
delimiter ;

drop trigger notaLimite;

insert into CHEF_RECETA (nombre_chef, apellido_chef, receta, nota)
values('Elena', 'Martinez', 3, 12);



-- 3. Añade una columna notaMediaChef tanto para los maestros como los aspirantes.
-- Desarrolla dos procedimientos que utilizando bucles rellene a cada uno de los chef su nota media. 
-- (2.5 p)

alter table Aspirantes add notaMediaChef float;

alter table MaestrosChefs  add notaMediaChef float;

select nombre_chef, apellido_chef, avg(nota)
from CHEF_RECETA cr 
group by cr.nombre_chef, cr.apellido_chef 
;

delimiter €€
create procedure asignarNotaMedia()
begin
	declare nombreA varchar(255);
	declare apellidoA varchar(255);
	declare mediaA float;
	declare cursorG cursor for select nombre_chef, apellido_chef, avg(nota)
								from CHEF_RECETA cr 
								group by cr.nombre_chef, cr.apellido_chef;
	declare continue handler for not found set @done=true;
	set @done=false;
	open cursorG;
	bucle:loop
		fetch cursorG into nombreA, apellidoA, mediaA;
		if @done then
			leave bucle;
		end if;
		update Aspirantes a 
		set a.notaMediaChef = mediaA
		where a.nombre = nombreA and a.apellido = apellidoA;
		update MaestrosChefs mc  
		set mc.notaMediaChef = mediaA
		where mc.nombre_chef = nombreA and mc.apellido_chef = apellidoA;
	end loop;
	close cursorG;
end
€€ 
delimiter ;

call asignarNotaMedia();

-- 4. Desarrolla disparadores que ante una nueva nota o la modificación de una, actualice la nota
-- media del chef que corresponda (3p)

select avg(nota)
from CHEF_RECETA cr 
where cr.nombre_chef = 'Elena' and cr.apellido_chef = 'Martínez';



delimiter €€
create trigger actualizarNota
after insert on CHEF_RECETA
for each row
begin
	declare mediaA float;
	set mediaA = (select avg(nota)
				from CHEF_RECETA cr 
				where cr.nombre = new.nombre and cr.apellido = new.apellido);
	update Aspirantes a 
	set a.notaMediaChef = mediaA
	where a.nombre = new.nombre_chef and a.apellido = new.apellido_chef;
end









-- 5. Desarrolla una función que, dado un chef, con un bucle te devuelva el 
-- ranking de los tres mejores platos de un chef, en un único registro. (2p)