-- Crear tabla destinos
CREATE TABLE destinos (
  id_destino INT AUTO_INCREMENT PRIMARY KEY,
  nombre_destino VARCHAR(255) NOT NULL,
  pais VARCHAR(255) NOT NULL,
  descripcion TEXT
);

-- Crear tabla hoteles
CREATE TABLE hoteles (
  id_hotel INT AUTO_INCREMENT PRIMARY KEY,
  id_destino INT,
  nombre_hotel VARCHAR(255) NOT NULL,
  direccion VARCHAR(255),
  calificacion FLOAT,
  FOREIGN KEY (id_destino) REFERENCES destinos(id_destino)
);

-- Crear tabla atracciones
CREATE TABLE atracciones (
  id_atraccion INT AUTO_INCREMENT PRIMARY KEY,
  id_destino INT,
  nombre_atraccion VARCHAR(255) NOT NULL,
  descripcion TEXT,
  FOREIGN KEY (id_destino) REFERENCES destinos(id_destino)
);

-- Crear tabla usuarios
CREATE TABLE usuarios (
  id_usuario INT AUTO_INCREMENT PRIMARY KEY,
  nombre_usuario VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL
);

-- Crear tabla opiniones
CREATE TABLE opiniones (
  id_opinion INT AUTO_INCREMENT PRIMARY KEY,
  id_hotel INT,
  id_usuario INT,
  texto TEXT,
  calificacion FLOAT,
  FOREIGN KEY (id_hotel) REFERENCES hoteles(id_hotel),
  FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

-- Inserciones de ejemplo
INSERT INTO destinos (nombre_destino, pais, descripcion) VALUES
  ('París', 'Francia', 'La ciudad del amor y la Torre Eiffel'),
  ('Roma', 'Italia', 'La ciudad eterna y el Coliseo'),
  ('Nueva York', 'Estados Unidos', 'La Gran Manzana y la Estatua de la Libertad');

INSERT INTO hoteles (id_destino, nombre_hotel, direccion, calificacion) VALUES
  (1, 'Le Ritz Paris', '15 Place Vendôme, 75001 París', 4.8),
  (1, 'Hotel Plaza Athénée', '25 Avenue Montaigne, 75008 París', 4.7),
  (2, 'Hotel Eden', 'Via Ludovisi 49, 00187 Roma', 4.6),
  (2, 'The St. Regis Rome', 'Via Vittorio Emanuele Orlando 3, 00185 Roma', 4.5),
  (3, 'The Plaza', '768 5th Ave, New York, NY 10019', 4.4),
  (3, 'The Ritz-Carlton New York', '50 Central Park S, New York, NY 10019', 4.3);

INSERT INTO atracciones (id_destino, nombre_atraccion, descripcion) VALUES
  (1, 'Torre Eiffel', 'Monumento icónico de París y Francia'),
  (1, 'Museo del Louvre', 'Museo de arte más famoso del mundo'),
  (2, 'Coliseo', 'Anfiteatro romano emblemático de la Antigua Roma'),
  (2, 'Fontana di Trevi', 'Famosa fuente barroca en Roma'),
  (3, 'Estatua de la Libertad', 'Monumento emblemático de Nueva York y símbolo de libertad'),
  (3, 'Times Square', 'Popular área comercial y centro de entretenimiento en el corazón de Manhattan');

INSERT INTO usuarios (nombre_usuario, email) VALUES
('Juan Pérez', 'juan.perez@email.com'),
('María Rodríguez', 'maria.rodriguez@email.com'),
('Pedro Gómez', 'pedro.gomez@email.com'),
('Ana Sánchez', 'ana.sanchez@email.com');

INSERT INTO opiniones (id_hotel, id_usuario, texto, calificacion) VALUES
(1, 1, 'Excelente servicio y ubicación perfecta', 5),
(1, 2, 'Un hotel de lujo con habitaciones espaciosas', 4.5),
(2, 1, 'Hermoso hotel en el corazón de Roma', 4.7),
(2, 3, 'Una estancia increíble, lo recomiendo', 4.8),
(3, 4, 'Un hotel clásico en Nueva York con vistas impresionantes', 4.4),
(4, 4, 'Elegante y cómodo, cerca de Central Park', 4.6);



/*
 *  1. Realiza un disparador que tras la inserción de una opinión sobre un hotel,
 *  actualice automaticamente su calificación.
 */

select avg(calificacion)
from hoteles h 
where id_hotel = 2;


delimiter €€
create trigger actualizarPuntuacion
after insert on opiniones
for each row
begin
	declare mediaP float;	
	set mediaP = (select avg(calificacion)
				from hoteles h 
				where id_hotel = new.id_hotel);
	update hoteles h
	set calificacion = mediaP
	where id_hotel = new.id_hotel;	
end
€€
delimiter ;


insert into opiniones(id_hotel, id_usuario, texto, calificacion)
values(2,3, 'Mala experiencia, habitación sucia', 3);


/*
 * 2. Cree una tabla opiniones_atraccion (con los mismos campos que la  tabla opinión sobre hoteles) ,
 *  añada a las atracciones una columna calificacion , cree un disparador que actualice esa columna
 * e inserte multiples opiniones.
 */

alter table atracciones add calificacion float;

create table opinionesAtracciones (
	id_opinionesAtrac int primary key auto_increment,
	id_atraccion int,
	foreign key (id_atraccion) references atracciones(id_atraccion),
	id_usuario int,
	foreign key (id_usuario) references usuarios(id_usuario),
	texto varchar(255),
	calificacion float
);

delete table opinionesAtracciones;

select avg(calificacion )
from opinionesAtracciones oa  
where id_atraccion = 1
;


delimiter €€
create trigger actualizarCalificacionAtracciones
after insert on opinionesAtracciones
for each row
begin
	declare mediaP float;	
	set mediaP = (select avg(calificacion)
				from opinionesAtracciones  
				where id_atraccion = new.id_atraccion);
	update atracciones
	set calificacion = mediaP
	where id_atraccion = new.id_atraccion;	
end
€€
delimiter ;

drop trigger actualizarCalificacionAtracciones;

insert into opinionesAtracciones (id_atraccion, id_usuario, texto, calificacion)
values(1,3, 'Buenas vistas de Paris ', 4);


/*
 * 3. Realiza una función que dada una atracción devuelva el 
 * mejor hotel en el que hospedarse, realiza la función de dos maneras, una sin bucles y cursores y
 * otra con. 
 */ 

select h.nombre_hotel 
from atracciones a 
inner join hoteles h on a.id_destino = h.id_destino
where id_atraccion = 1
order by a.calificacion desc
limit 1 ;

set global log_bin_trust_function_creators = 1;

delimiter €€
create function mejorAtraccion (id_atract int)
returns varchar(255)
begin
	return (select h.nombre_hotel 
			from atracciones a 
			inner join hoteles h on a.id_destino = h.id_destino
			where id_atraccion = id_atract
			order by a.calificacion desc
			limit 1);
end
€€
delimiter ;

select mejorAtraccion(3);


