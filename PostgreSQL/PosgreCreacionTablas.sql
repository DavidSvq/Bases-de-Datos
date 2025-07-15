create table empleado(
	id_empleado serial primary key,
	nombre text,
	apellidos text,
	dni text,
	fecha_alta date,
	salario real
);

create table profesor(
	departamento text,
	tutor_grupo bool
) inherits(empleado);

create table administracion (
	area text,
	extension_telefono int
)inherits(empleado);

create table mantenimiento (
	nHoras int check (nHoras > 3 and nHoras < 9)
)inherits(empleado);

create table directores(
	correo text check( correo ~ '.*@.*\..*')
)inherits(empleado);

INSERT INTO public.profesor
(id_empleado, nombre, apellidos, dni, fecha_alta, salario, departamento, tutor_grupo)
VALUES(nextval('empleado_id_empleado_seq'::regclass), 'David', 'Ro te', '5235854-R', '20250515', 1600, 'Informatica', true);

INSERT INTO public.profesor
(id_empleado, nombre, apellidos, dni, fecha_alta, salario, departamento, tutor_grupo)
VALUES(nextval('empleado_id_empleado_seq'::regclass), 'Laura', 'Gar Te', '5897547-T', '20250410', 1500.5, 'Matematicas', false);

INSERT INTO public.administracion
(id_empleado, nombre, apellidos, dni, fecha_alta, salario, area, extension_telefono)
VALUES(nextval('empleado_id_empleado_seq'::regclass), 'Javier', 'Jas Far', '256985-Q', '20201130', 1400.9, 'Secretaria', 965);

INSERT INTO public.administracion
(id_empleado, nombre, apellidos, dni, fecha_alta, salario, area, extension_telefono)
VALUES(nextval('empleado_id_empleado_seq'::regclass), 'Mari Carmen', 'Res Cap', '659852-H', '20190920', 1555.5, 'Administracion', 800);


select nombre, salario 
from empleado;

select * from profesor
where tutor_grupo = true;

select nombre, area 
from administracion a 
where a.area like 'Secretaria';

INSERT INTO public.mantenimiento
(id_empleado, nombre, apellidos, dni, fecha_alta, salario, nhoras)
VALUES(nextval('empleado_id_empleado_seq'::regclass), 'Lucia', 'Ma Ta', '45896-T', '20191212',1300, 7);

/*
 * BBDD Comunidad Creativa*/

-- Crear un tipo ENUM llamado genero_artistico con los valores: 'pintura', 'música', 'escultura', 'danza', 'literatura'.
create type genero_artistico as enum(
'pintura', 'música', 'escultura', 'danza', 'literarura');

--Crear un tipo compuesto llamado nombre_completo con dos campos: nombre (texto) apellidos (texto)
create type nombre_completo as (nombre text, apellidos text);

/***
 * Crear una tabla base llamada miembro con los siguientes campos:
id SERIAL PRIMARY KEY
nombre del tipo nombre_completo
email (texto) con una restricción regex que valide el formato básico de email
edad (entero) con una restricción numérica para que sea ≥ 18 y ≤ 99
tipo (TEXT) → debe ser 'artista' o 'organizador'
 */

create table miembro(
	id serial primary key,
	nombre nombre_completo,
	email text check(email ~ '[a-zA-Z0-9_\.-]+@[a-zA-Z0-9\.]+\.[a-zA-Z]+'),
	edad int check (edad >= 18 and edad < 100),
	tipo text check (tipo = 'artista' or tipo = 'organizador')
);

INSERT INTO public.miembro
(id, nombre, email, edad, tipo)
VALUES(nextval('miembro_id_seq'::regclass), ('pepe','luis'), 'pepe@de.es', 18, 'artista');

/***
 * Crear una tabla artista que herede de miembro, y añada:
genero del tipo genero_artistico
años_experiencia entero (≥ 0)
 */

create table artista(
	genero genero_artistico,
	anios_experiencia int check (anios_experiencia >= 0)
) inherits(miembro);

INSERT INTO public.artista
(id, nombre, email, edad, tipo, genero, anios_experiencia)
VALUES(nextval('miembro_id_seq'::regclass), ('david', ' rome'), 'dav@hot.es', 19, 'artista', 'escultura', 13);

-- crear con array

create table organizado(
	area text,
	activo boolean,
	n_telefono int[]
)inherits(miembro);

INSERT INTO public.organizado
(id, nombre, email, edad, tipo, area, activo, n_telefono)
VALUES(nextval('miembro_id_seq'::regclass), ('mar', 'ro'), 'mar@hto.es', 40, 'artista', 'danza', false, array[6895,9854]);


select nombre , n_telefono[2] from organizado

-- Ejercicio de repaso..

create type nombre_completo1 as (
	nombre text,
	apellido text
);

create type direccion_completa as (
	direccion text,
	provincia text,
	codigo_postal int
);

create table usuarios(
	id serial primary key,
	nombre nombre_completo1,
	direccion direccion_completa,
	username text check(username ~'([A-Za-z[\w\-\.]*[A-Za-z]){4,16}') unique,
	biografia text,
	fecha_nacimiento date,
	lista_intereses text[],
	fecha_creacion timestamptz default Now()

);

INSERT INTO public.usuarios
(nombre, direccion, username, biografia, fecha_nacimiento, lista_intereses, fecha_creacion)
VALUES(row('da', 'ro te'), row('Calle En Obras s/n', 'Sevilla', 41001), 'dav_67895_yy' , 'aaa', '20001212', array['aa', 'bbb', 'cccc'], now());

-- ^[A-Za-z]([\w\-\.]*){2,14}[A-Za-z]$

create table prueba(
	id_prueba int references usuarios(id),
	nombreAux text check(char_length(nombreAux) > 4),
	edad int check(edad >= 18 and edad <=100)
)inherits (usuarios);


INSERT INTO public.prueba
(nombre, direccion, username, biografia, fecha_nacimiento, lista_intereses, fecha_creacion, id_prueba, nombreaux, edad)
VALUES(row('da', 'ro te'), row('Calle En Obras s/n', 'Sevilla', 41001), 'dav_79ioi', 'Ext', '19801109', array['a', 'b', 'c', 'd'], now(), 5, 'partyss', 21);

select nombre from prueba

select (nombre).apellido from prueba




















