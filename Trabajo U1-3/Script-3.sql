create table estudiantes(
	estudiante_id int primary key auto_increment,
	nombre varchar(255),
	apellidos varchar(255),
	fecha_nacimiento date,
	direccion varchar(255),
	email varchar(255),
	telefono int
);
create table examenes(
	examen_id int primary key auto_increment,
	asignatura_id int,
	foreign key (asignatura_id) references asignaturas (asignatura_id),
	profesor_id int,
	foreign key (profesor_id) references profesores (profesor_id),
	fecha_examen date,
	duracion_minutos int
);
create table calificaciones(
	clasificacion_id int primary key auto_increment,
	estudiante_id int,
	foreign key (estudiante_id) references estudiantes (estudiante_id),
	nota int,
	examen_id int,
	foreign key (examen_id) references examenes (examen_id)
);
create table cursos(
	curso_id int primary key auto_increment,
	nombre varchar(255),
	descripcion varchar(255),
	nivel_academico varchar (255)
);
create table asignaturas(
	asignatura_id int primary key auto_increment,
	nombre varchar(255),
	descripcion text,
	creditos int
);
create table cursos_tiene_asignaturas(
	curso_id int,
	asignatura_id int,
	primary key(curso_id, asignatura_id),
	foreign key (curso_id) references cursos (curso_id),
	foreign key (asignatura_id) references asignaturas (asignatura_id)
);
create table horario(
	horario_id int primary key auto_increment,
	dia_semana varchar(255),
	aula varchar(255),
	hora_inicio time,
	hora_fin time	
);
create table asignatura_define_horario(
	asignatura_id int,
	horario_id int,
	primary key (asignatura_id, horario_id),
	foreign key (asignatura_id) references asignaturas (asignatura_id),
	foreign key (horario_id) references horario (horario_id)
);
create table profesores(++
	profesor_id int primary key auto_increment,
	nombre varchar(255),
	apellidos varchar(255),
	especialidad varchar(255),
	email varchar(255),
	telefono int
);
create table profesores_imparten_asignaturas(
	asignatura_id int,
	profesor_id int,
	primary key (asignatura_id, profesor_id),
	foreign key (asignatura_id) references asignaturas (asignatura_id),
	foreign key (profesor_id) references profesores (profesor_id)
);
create table departamentos(
	departamento_id int primary key auto_increment,
	nombre varchar(255),
	jefe_departamento varchar(255),
	profesor_id int,
	foreign key (profesor_id) references profesores (profesor_id)
);
insert into estudiantes (nombre, apellidos, fecha_nacimiento, direccion, telefono, email) values ('david', 'romero',19791104,'C/En obras', 56566565, 'edad@hrjkjsf.es');
insert into estudiantes (nombre, apellidos, fecha_nacimiento, direccion, telefono, email) values ('maria', 'una', 19901213,'C/Larga',5858585, 'kdfjlkds@hfj.com');
insert into estudiantes (nombre, apellidos, fecha_nacimiento, direccion, telefono, email) values ('tobias', 'temprano',19990104,'C/Corta', 56766565, 'ead@hrjk.es');
insert into examenes (fecha_examen, duracion_minutos) values (20241217,120);
insert into asignaturas (nombre, descripcion, creditos) values ('matematicas', 'matematicas aplicadas', 1);
insert into examenes (asignatura_id) values (1);
insert into asignaturas (nombre, descripcion, creditos) values ('informatica', 'sistemas informaticos', 1);
insert into asignaturas (nombre, descripcion, creditos) values ('diseño', 'diseño web', 1);
insert into profesores (nombre, apellidos, especialidad, email, telefono) values ('Olga','sana', 'microinformatica', 'ekdl@jkkjf.es', 98850986);
insert into profesores (nombre, apellidos, especialidad, email, telefono) values ('esteban','corroba', 'ciberseguridad', 'ekdl@jhhjf.es', 88850986);
insert into profesores (nombre, apellidos, especialidad, email, telefono) values ('Aitor','Menta', 'fisica', 'uudl@jkkjf.es', 323850986);
insert into cursos (nombre,descripcion, nivel_academico) values ('DAM','Desarrollo Aplicaciones Multiplataforma', 'Master');
insert into cursos (nombre,descripcion, nivel_academico) values ('DAW','Desarrollo Aplicaciones Web', 'Master');
insert into cursos (nombre,descripcion, nivel_academico) values ('CBI','CiberSeguridad Industrial', 'Master');
insert into departamentos (nombre, jefe_departamento, profesor_id ) values ('Informatica','lolo', 1);
insert into departamentos (nombre, jefe_departamento, profesor_id ) values ('Matematicas','lolo', 2);
insert into departamentos (nombre, jefe_departamento, profesor_id ) values ('ingles','lucia', 3 );
insert into profesores_imparten_asignaturas (asignatura_id, profesor_id) values (1, 1);
insert into profesores_imparten_asignaturas (asignatura_id, profesor_id) values (2, 2);
insert into profesores_imparten_asignaturas (asignatura_id, profesor_id) values (3, 3);
insert into horario (dia_semana, aula, hora_inicio, hora_fin) values ('lunes', 'd.1', '14:30', '15:30');
insert into horario (dia_semana, aula, hora_inicio, hora_fin) values ('martes', 'd.4', '17:30', '18:30');
insert into horario (dia_semana, aula, hora_inicio, hora_fin) values ('viernes', 'e.1', '14:30', '15:30');
insert into asignatura_define_horario (asignatura_id, horario_id) values (1,2);
insert into asignatura_define_horario (asignatura_id, horario_id) values (2,1);
insert into asignatura_define_horario (asignatura_id, horario_id) values (3,3);
insert into examenes (asignatura_id, profesor_id, fecha_examen, duracion_minutos) values (1,2, 20241221, 120);
insert into examenes (asignatura_id, profesor_id, fecha_examen, duracion_minutos) values (2,2, 20241222, 180);
insert into examenes (asignatura_id, profesor_id, fecha_examen, duracion_minutos) values (3,3, 20241220, 60);
insert into calificaciones (estudiante_id, examen_id, nota) values (1,3,9);
insert into calificaciones (estudiante_id, examen_id, nota) values (3,1,7);
insert into calificaciones (estudiante_id, examen_id, nota) values (2,2,9);
insert into cursos_tiene_asignaturas (curso_id, asignatura_id) values(1,2);
insert into cursos_tiene_asignaturas (curso_id, asignatura_id) values(2,1);
insert into cursos_tiene_asignaturas (curso_id, asignatura_id) values(3,3);

