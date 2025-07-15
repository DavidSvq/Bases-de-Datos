
-- Tipo compuesto nombre

create type nombre_completo as(
	nombre text,
	apellidos text
);

-- tabla usuarios
-- Se añade para que por defecto se añada la fecha del momento de la insersión en la tabla

create table usuarios(
	id_usuario serial primary key,
	nombre nombre_completo,
	email text check(email ~'^[A-Za-z][A-Za-z0-9\.\-_]+@[A-Za-z0-9\.\-_]+\.[A-Za-z]{2,6}$'),
	username text check(username ~'^[A-Za-z][A-Za-z0-9_]{3,18}[A-Za-z0-9]$') unique,
	fecha_nacimiento date,
	intereses_deportivos text[],
	fecha_registro date default current_date
);

-- tabla deportista, hereda de usuarios
-- enumerado usado en la tabla 
create type condicion_fisica as enum(
	'bajo', 'medio', 'alto'
);

create table deportista (
	condicion_fisica condicion_fisica,
	habitos_saludabes text[],
	primary key (id_usuario)
) inherits (usuarios);

create table entrenador (
	area_especialidad text,
	certificado_valido boolean,
	primary key (id_usuario)
) inherits (usuarios);

-- tabla actividades
--enumerado usado en la tabla
create type tipo_deporte as enum(
	'cardio', 'fuerza', 'flexibilidad', 'mixto'
);

create table actividades(
	id_actividad serial primary key,
	nombre text,
	tipo_deporte tipo_deporte,
	entrenador_id int references entrenador(id_usuario),
	duracion_minutos int check(duracion_minutos >= 15 and duracion_minutos <=180),
	fecha date
);


-- tabla inscripciones

create table inscripciones (
	id_inscripcion serial primary key,
	id_usuario int references usuarios(id_usuario),
	id_actividad int references actividades(id_actividad),
	fecha_inscripcion date,
	confirmada boolean
);

-- tabla valoraciones

create table valoraciones (
	id_valoracion serial primary key,
	id_usuario int references usuarios(id_usuario),
	id_actividad int references actividades(id_actividad),
	puntuacion int check(puntuacion >=1 and puntuacion <= 5),
	comentario text,
	fecha date
);


-- inserciones tabla usuarios

INSERT INTO public.usuarios
(nombre, email, username, fecha_nacimiento, intereses_deportivos, fecha_registro)
VALUES(row('David', 'Rome Tern'), 'dav@hotmail.com', 'dav_79_id', '19890527', array['futbol', 'atletismo', 'rugby'], CURRENT_DATE);

INSERT INTO public.usuarios
(nombre, email, username, fecha_nacimiento, intereses_deportivos, fecha_registro)
VALUES(row('Maria', 'Rome Tern'), 'mari@gmail.es', 'mari_a45_s', '19951129', array['baloncesto', 'remo'], CURRENT_DATE);

INSERT INTO public.usuarios
(nombre, email, username, fecha_nacimiento, intereses_deportivos, fecha_registro)
VALUES(row('Juan', 'Mero Ser'), 'juan.mer@hotmail.com', 'juan_Guan', '20030102', array['tenis', 'padel'], CURRENT_DATE);

-- inserciones tabla deportista

INSERT INTO public.deportista
(nombre, email, username, fecha_nacimiento, intereses_deportivos, fecha_registro, condicion_fisica, habitos_saludabes)
VALUES(row('Juana', 'Paz Rode'), 'juana_@gmel.es', 'guanita_76', '19950608', array['natacion', 'salto trampolin'], CURRENT_DATE, 'medio', array['descanso 8 horas', '3 horas diarias de ejercio']);

INSERT INTO public.deportista
(nombre, email, username, fecha_nacimiento, intereses_deportivos, fecha_registro, condicion_fisica, habitos_saludabes)
VALUES(row('Ricardo', 'Luz Fuerte'), 'ricard@hotmail.es', 'ricard_corasoa_leao', '19871015', array['futbol sala', 'futbol 7'], CURRENT_DATE, 'alto', array['descanso 8 horas', 'alimentacion saludable']);

INSERT INTO public.deportista
(nombre, email, username, fecha_nacimiento, intereses_deportivos, fecha_registro, condicion_fisica, habitos_saludabes)
VALUES(row('Lorena', 'Tuz Fort'), 'lor_3n4A@hot.cam.es', 'lor_3n4A', '20070707', array['Natacion', 'gimnasia artistica'], CURRENT_DATE, 'bajo', array['8 horas de descanso']);


-- inserciones tabla entrenador

INSERT INTO public.entrenador
(nombre, email, username, fecha_nacimiento, intereses_deportivos, fecha_registro, area_especialidad, certificado_valido)
VALUES(row('Agustin', 'Mucho Tay'), 'agus1234@hotmail.com', 'agustirrin_01', '20000228', array['futbol', 'rugby'], CURRENT_DATE, 'Alterofilia', true);

INSERT INTO public.entrenador
(nombre, email, username, fecha_nacimiento, intereses_deportivos, fecha_registro, area_especialidad, certificado_valido)
VALUES(row('Agata', 'Ruiz Perez'), 'a4gatas@gmail.com', 'aGa_Ta00', '19991212', array['Natacion', 'gimnasia artistica'], CURRENT_DATE, 'Natacion', true);

INSERT INTO public.entrenador
(nombre, email, username, fecha_nacimiento, intereses_deportivos, fecha_registro, area_especialidad, certificado_valido)
VALUES(row('Manuel', 'Luiz Lerez'), 'manu.el@hotmail.com', 'manu_el_manu', '20010315', array['futbol sala', 'futbol 7'], CURRENT_DATE, 'Fulbol 7', false);

-- inserciones tabla actividades

INSERT INTO public.actividades
(nombre, tipo_deporte, entrenador_id, duracion_minutos, fecha)
VALUES('Futbito', 'mixto', 7, 55, '20250528');

INSERT INTO public.actividades
(nombre, tipo_deporte, entrenador_id, duracion_minutos, fecha)
VALUES('Alterofilia', 'fuerza', 8, 60, '20250529');

INSERT INTO public.actividades
(nombre, tipo_deporte, entrenador_id, duracion_minutos, fecha)
VALUES('Zumba', 'cardio', 9, 60, '20250530');

-- inserciones tabla inscripciones

INSERT INTO public.inscripciones
(id_usuario, id_actividad, fecha_inscripcion, confirmada)
VALUES(1, 1, '20250527', true);

INSERT INTO public.inscripciones
(id_usuario, id_actividad, fecha_inscripcion, confirmada)
VALUES(2, 2, '20250526', false);

INSERT INTO public.inscripciones
(id_usuario, id_actividad, fecha_inscripcion, confirmada)
VALUES(3, 3, '20250524', true);

-- inserciones tabla valoraciones

INSERT INTO public.valoraciones
(id_usuario, id_actividad, puntuacion, comentario, fecha)
VALUES(1, 1, 4, 'Buen partido de entrenamiento', '20250530');

INSERT INTO public.valoraciones
(id_usuario, id_actividad, puntuacion, comentario, fecha)
VALUES(2, 2, 3, 'Bastante exigida la clase', '20250529');

INSERT INTO public.valoraciones
(id_usuario, id_actividad, puntuacion, comentario, fecha)
VALUES(3, 3, 3, 'Mucho ritmo', '20250531');


-- consultas

-- Realizar una consulta filtrando usuarios únicamente por el nombre (sin apellidos).
select (nombre).nombre from usuarios

-- Realizar una consulta que muestre el nombre de los usuarios inscritos en una actividad en concreto.
select u.nombre  from usuarios u  
inner join inscripciones i on i.id_usuario  = u.id_usuario
inner join actividades a on a.id_actividad = i.id_actividad
where a.nombre = 'Futbito'
