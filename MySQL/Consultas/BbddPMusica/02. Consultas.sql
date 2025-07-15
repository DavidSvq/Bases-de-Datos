-- EJERCICIO 1: Muestra los nombres y correos electrónicos de los usuarios que se 
-- registraron después del 1 de enero de 2023.

select nombre, email, fecha_registro 
from Usuarios u 
where fecha_registro > '2023-01-01';

-- EJERCICIO 2: Muestra el número de canciones que pertenecen a géneros que incluyen
-- la palabra Pop

select count(cancion_id)
from Canciones c 
where genero like '%Pop%';


-- EJERCICIO 3: Muestra el número de canciones por país

select pais , count(cancion_id)  as numeroDeCanciones
from Canciones c 
inner join Artistas A on A.artista_id = c.artista_id 
group by A.pais


-- EJERCICIO 4: Muestra las canciones que aparezcan en todas las listas de reproducción de Melissa Michael

select count(*) from Usuarios u 
inner join Listas_Reproduccion lr on lr.usuario_id = u.usuario_id
where u.nombre = 'Melissa Michael';


select c.titulo, u.nombre, count(*)
from Usuarios u 
inner join Listas_Reproduccion lr on lr.usuario_id = u.usuario_id 
inner join Canciones_Listas cl on cl.lista_id = lr.lista_id 
inner join Canciones c on c.cancion_id = cl.cancion_id
where u.nombre = 'Melissa Michael'
group by c.titulo
having count(*) = (select count(*) from Usuarios u 
inner join Listas_Reproduccion lr on lr.usuario_id = u.usuario_id
where u.nombre = 'Melissa Michael');


-- EJERCICIO 6: Calcula la duración total de todas las canciones incluidas en la
--  lista de reproducción llamada 'Most.'.

select sum(c.duracion)
from Canciones c 
inner join Canciones_Listas cl on cl.cancion_id = c.cancion_id 
inner join Listas_Reproduccion lr on lr.lista_id = cl.lista_id
where lr.nombre_lista = 'Most.';


-- EJERCICIO 7: Muestra los títulos de las canciones que aparecen en más de 4 listas de reproducción diferentes.

-- Prueba. Recuento de todas las canciones en las listas
select count(*) from Canciones c 
inner join Canciones_Listas cl on cl.cancion_id = c.cancion_id 
group by cl.cancion_id


select titulo, count(*) as aparicionesEnLasListas from Canciones c 
inner join Canciones_Listas cl on cl.cancion_id = c.cancion_id 
group by cl.cancion_id 
having count(*) > 4




-- EJERCICIO 8: Muestra al mayor fan de canciones de Puerto Rico (Tiene más canciones en sus listas)

select artista_id from Artistas a where pais = 'Puerto Rico'

select cancion_id from Canciones c where artista_id = 10

select * from Canciones_Listas cl where cancion_id in(48, 55, 81, 100)

select u.nombre 
from Usuarios u 
inner join Listas_Reproduccion lr on lr.usuario_id = u.usuario_id 
inner join Canciones_Listas cl on cl.lista_id = lr.lista_id 
inner join Canciones c on c.cancion_id = cl.cancion_id 
inner join Artistas a on a.artista_id = c.artista_id 
where pais = 'Puerto Rico'
group by u.nombre 
order by count(u.nombre) limit 1






-- EJERCICIO 9: Muestra la canciones de Bolivia que tienen una duración por encima de su media

-- subconsulta para calcular la media de duración de las canciones de bolivia
select avg(c.duracion) from Artistas a 
inner join Canciones c on c.artista_id = a.artista_id 
where a.pais = 'Bolivia'

select c.titulo, c.duracion from Artistas a 
inner join Canciones c on c.artista_id = a.artista_id 
where a.pais = 'Bolivia' and c.duracion > (select avg(c.duracion) from Artistas a 
inner join Canciones c on c.artista_id = a.artista_id 
where a.pais = 'Bolivia');


select u.nombre 
from Usuarios u 
inner join Listas_Reproduccion lr on lr.usuario_id = u.usuario_id 
inner join Canciones_Listas cl on cl.lista_id = lr.lista_id 
inner join Canciones c on c.cancion_id = cl.cancion_id 
inner join Artistas a on a.artista_id = c.artista_id
where c.duracion > (select avg(c.duracion) from Artistas a inner join Canciones c on c.artista_id = a.artista_id where a.pais = 'Bolivia')

/*EJERCICIO 10: Crear una Tabla e Insertar Datos
Crea una tabla llamada Seguidores_Artistas para almacenar los artistas seguidos por los usuarios.
   La tabla debe tener las columnas: seguimiento_id, usuario_id, artista_id, fecha_seguimiento.
   Inserta los siguientes datos en la tabla:
   1. Usuario 1 sigue al Artista 3 desde el 1 de marzo de 2023.
   2. Usuario 2 sigue al Artista 1 desde el 15 de febrero de 2023.
   3. Usuario 3 sigue al Artista 2 desde el 10 de enero de 2023.*/

create table Seguidores_Artistas( 
	seguimiento_id int primary key auto_increment,
	usuario_id int,
	foreign key (usuario_id) references Usuarios(usuario_id),
	artista_id int,
	foreign key (artista_id) references Artistas(artista_id),
	fecha_seguimiento date

);

insert into Seguidores_Artistas(usuario_id, artista_id, fecha_seguimiento) values (1, 3, '2023-03-01');
insert into Seguidores_Artistas(usuario_id, artista_id, fecha_seguimiento) values (2, 1, '2023-02-15');
insert into Seguidores_Artistas(usuario_id, artista_id, fecha_seguimiento) values (3, 2, '2023-01-10');

