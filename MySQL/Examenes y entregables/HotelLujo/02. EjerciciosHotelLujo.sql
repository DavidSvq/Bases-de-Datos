-- EJERCICIO 1: Clientes Nuevos
-- Muestra los nombres y correos electrónicos de los clientes 
-- que se registraron en el último mes.

select nombre, email
from Clientes c 
where fecha_registro >'2024-12-24';


-- EJERCICIO 2: Habitaciones Disponibles
-- Muestra todas las habitaciones de la familia Taylor.
select h.habitacion_id 
from Clientes c 
inner join Reservas r on r.cliente_id = c.cliente_id
inner join Habitaciones h on h.habitacion_id = r.habitacion_id
where c.nombre like '%Taylor%' ;


-- EJERCICIO 3: Reservas en Proceso
-- Lista los nombres de los clientes que tienen una reserva activa en el hotel el
-- día de hoy.

select c.nombre
from Clientes c 
inner join Reservas r on r.cliente_id = c.cliente_id 
where r.fecha_fin > '2025-01-24' and r.fecha_inicio < '2025-01-23';

-- EJERCICIO 4: Ganancias Máxima por Tipo de Habitación
-- Calcula la ganancia máxima generada por cada tipo de habitación en una reserva.

select max(precio_por_noche) as gananciaMaxSegunTipoReserva 
from Habitaciones h 
group by tipo ;

-- EJERCICIO 5: Muestra el servicio menos solicitado en 2023. 

select (select count(servicio_id) from Servicios_Reservas sr group by servicio_id order by count(servicio_id) limit 1) as servicioMenosSolicitado2023
from Reservas r 
where fecha_inicio >= '2023-01-01' and fecha_fin <= '2023-12-31'
limit 1;


-- EJERCICIO 6: 
-- Encuentra los 3 clientes que más han gastado en el hotel
-- (Ten en cuenta sus reservas y servicios).

select *
from Reservas r 
inner join Clientes c on c.cliente_id = r.cliente_id 
order by r.total desc
limit 3;



-- EJERCICIO 7: 
-- Muestra el tipo de habitación más reservado, junto con la cantidad de reservas.

select tipo, count(*) as numeroReservas
from Habitaciones h 
group by tipo
order by count(*) desc limit 1;



-- EJERCICIO 8: Cliente VIP:  Muestra el cliente que ha reservado más habitaciones
-- Suite con un precio por noche por encima de la media (de las habitaciones Suite)

-- subconsulta
select avg(h.precio_por_noche) from Habitaciones h where h.tipo = 'Suite';

select c.cliente_id, nombre, count(c.cliente_id) as numeroReservas
from Clientes c 
inner join Reservas r on r.cliente_id = c.cliente_id 
inner join Habitaciones h on h.habitacion_id = r.habitacion_id 
where h.precio_por_noche > (select avg(h.precio_por_noche) from Habitaciones h where h.tipo = 'Suite')
group by c.cliente_id
order by count(c.cliente_id) desc limit 1;



-- EJERCICIO 9: Servicios Más Populares
-- Encuentra los servicios que Nathan White ha repetido.

select s.servicio_id
from Clientes c 
inner join Reservas r on r.cliente_id = c.cliente_id 
inner join Servicios_Reservas sr on sr.reserva_id = r.reserva_id
inner join Servicios s on s.servicio_id = sr.servicio_id
where c.nombre = 'Nathan White'
group by s.servicio_id
having count(*) > 1 ;


-- EJERCICIO 10: Crear Tabla e Insertar Datos
-- Crea una tabla llamada Opiniones_Clientes para almacenar comentarios de los clientes sobre su estadía.
-- La tabla debe incluir los campos: opinion_id, cliente_id, comentario, fecha_opinion.
-- Inserta las siguientes opiniones:
-- 1. Cliente 1: "Excelente servicio y muy cómodo" (fecha: 2023-03-01)
-- 2. Cliente 2: "El desayuno podría mejorar" (fecha: 2023-03-02)
-- 3. Cliente 3: "La limpieza fue impecable" (fecha: 2023-03-03)

create table opiniones_clientes(
	opinion_id int primary key auto_increment,
	cliente_id int,
	FOREIGN KEY (cliente_id) REFERENCES Clientes(cliente_id),
	comentario varchar(255),
	fecha_opinion date
)

insert into opiniones_clientes(cliente_id, comentario, fecha_opinion) values (1,'Excelente servicio y muy cómodo', '2023-03-01');
insert into opiniones_clientes(cliente_id , comentario, fecha_opinion) values (2, 'El desayuno podría mejorar', '2023-03-01');
insert into opiniones_clientes(cliente_id , comentario, fecha_opinion) values (3, 'El desayuno podría mejorar', '2023-03-03');


