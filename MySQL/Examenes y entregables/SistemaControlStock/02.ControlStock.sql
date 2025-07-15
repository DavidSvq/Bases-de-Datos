/***
 * Creación de tablas, primero creo las tablas que no involucran claves foráneas: Cliente y Producto. Despues las tablas
 * que alojan las claves primarias de las tablas anteriores, como claves foráneas: Pedido y DetallesPedido, además en ese
 * orden, ya que DetallesPedido recibe como la clave primaria compuesta, la de Pedido y Producto. Por último, creo las 
 * tablas de control para alertas y errores.
 */
create table Cliente(
	IdCliente int primary key auto_increment,
	Nombre varchar(255),
	Apellidos varchar(255),
	Contacto varchar(255)
);

create table Producto(
	IdProducto int primary key auto_increment,
	Nombre varchar(255),
	PrecioUnidad float,
	Stock int,
	StockMaximo int
);

create table Pedido(
	IdPedido int primary key auto_increment,
	IdCliente int,
	foreign key (IdCliente) references Cliente(IdCliente),
	FechaPedido datetime,
	Estado varchar(255)
);

-- Esta tabla nace de la relación N:M entre productos y pedidos, por lo que pasan a ser
-- una PK compuesta, evitando así que se duplique un producto para en un mismo pedido y
-- a su vez permite que pueda haber un IdPedido repetido con otro producto.
-- Otra opción, sería añadir un PK autoincremental para cada detalle, pudiendo repetirse
-- un mismo podructo en el mismo pedido. Daría opciones de modifcar los detalles por línea,
-- producto, de cada IdPedido.

create table DetallesPedido(
	IdPedido int,
	IdProducto int,
	primary key(IdPedido, IdProducto),
	foreign key (IdPedido) references Pedido (IdPedido),
	foreign key (IdProducto) references Producto(IdProducto),
	Cantidad int,
	precioUnidad float,
	total float
);

create table Alertas(
	IdAlerta int primary key auto_increment,
	IdProducto int,
	foreign key (IdProducto) references Producto(IdProducto),
	Causa varchar(255),
	Fecha datetime,
	Destinada varchar(255)
);


create table Errores(
	IdError int primary key auto_increment,
	IdProducto int,
	foreign key (IdProducto) references Producto(IdProducto),
	Fecha datetime,
	Motivo varchar(255)
);

/***
 * Procedimiento para insertar un nuevo Cliente.
 * Aunque el ejercicio no lo pide explicitamente, creo que lo faclita al iniciar una
 * BBDD desde cero(Y así practico).
 */

delimiter €€
create procedure insertarCliente(in nomb varchar(255),in apelli varchar(255), in contac varchar(255))
begin
	insert into Cliente(Nombre, Apellidos, Contacto)
	values(nomb, apelli, contac);
end
€€
delimiter ;

-- Insersión de 5 nuevos clientes

call insertarCliente('David', 'R T', 'd@d.com');

call insertarCliente('Maria', 'Jota Ka', '235678456');

call insertarCliente('Jose', 'H D', 'j@hd.com');

call insertarCliente('Laura', 'Sa La', 'la@d.com 45829545');

call insertarCliente('Pablo', 'Z K', 'p@zk.com');

/**
 * Aplico lo mismo para la tabla Producto, creación del procedimiento y 
 * posterior inserción.
 */

delimiter €€
create procedure insertarProducto(in nomb varchar(255),in precUni float, in stock int, in stockMaX int)
begin
	insert into Producto(Nombre, PrecioUnidad, Stock, StockMaximo)
	values(nomb, precUni, stock, stockMaX);
end
€€
delimiter ;

call insertarProducto('TV 65 Pulgadas', 799.99, 10, 25);

call insertarProducto('TV 50 Pulgadas', 599.99, 10, 25);

call insertarProducto('TV 40 Pulgadas', 399.99, 10, 25);

call insertarProducto('Portatil Dell', 699.99, 8, 15);

call insertarProducto('Teclado Luces', 55.50, 30, 75);

-- Inserción manual de varios productos en un mismo IdPedido y fechas antiguas. Es importante
-- mantener el orden de inserción ya que detallesPedido depende de la id de pedido.
insert into Pedido(IdCliente, FechaPedido, Estado)
values(1, '2025-04-13 11:42:56', 'Pendiente');

insert into DetallesPedido(IdPedido, IdProducto, Cantidad, precioUnidad, total)
values(1, 4, 1, 699.99, 699.99),
	(1, 5, 2, 55.5, 111),
	(1, 1, 1, 799.99, 799.99)
;

insert into Pedido(IdCliente, FechaPedido, Estado)
values(4, '2025-04-13 13:42:56', 'Pendiente')
;

insert into DetallesPedido(IdPedido, IdProducto, Cantidad, precioUnidad, total)
values(2, 2, 1, 599.99, 599.99)
;

insert into Pedido(IdCliente, FechaPedido, Estado)
values(4, '2025-04-13 17:42:56', 'Pendiente')
;

insert into DetallesPedido(IdPedido, IdProducto, Cantidad, precioUnidad, total)
values(3, 3, 1, 399.99, 399.99)
;


/***
 * Controlar el error si se intenta borrar un producto que aun esta pendiente en una factura de forma 
 * automática mediante un trigger, generando un control de error personalizado con el comando signal.
 * Esta opción evita que se borre, pero no permite generar una fila en la tabla errores ya que corta el
 * flujo de ejecución(ni aun poniendolo delante, de hecho creo que se intentó insertar sin exito ya que el
 * siguiente id de los errores salta del 1 al 8 con el siguiente registro y es autoincremental.
 * Como segunda opción, crear un procedimiento el cúal se use para borrar productos y ahí si se puede 
 * gestionar que no se borre y se genere la respectiva fila en la tabla errores.
 */

-- Consulta para la función exists que devuelve true si existe algún dato y false si esta vacia sobre una
-- consulta realizada. Da igual que muestre el select, solo importa si la busqueda contiene o no datos, por 
-- convención se pone 1, pero se podria poner cualquier cosa: *, IdProducto.....da igual el contenido del 
-- select.
select *
from Producto p 
inner join DetallesPedido dp on dp.IdProducto = p.IdProducto
inner join Pedido p2 on p2.IdPedido = dp.IdPedido
where p.IdProducto = 3 and p2.Estado like 'Pendiente'
;

-- Trigger 
delimiter €€
create trigger noBorrarSi
before delete on Producto
for each row
begin
	if exists(select 1
			from Producto p 
			inner join DetallesPedido dp on dp.IdProducto = p.IdProducto
			inner join Pedido p2 on p2.IdPedido = dp.IdPedido
			where p.IdProducto = old.IdProducto and p2.Estado like 'Pendiente')then
	signal sqlstate '45000'	
	set message_text = 'No se puede eliminar un Producto que aún esta pendiente en un Pedido';
	end if;
end
€€
delimiter ;

delete from Producto 
where IdProducto = 1
;

-- Creación del procedimiento para eliminar un producto y registrar el error si se produce
delimiter €€
create procedure eliminarProducto(in idProduc int)
begin
	if exists(select 1
			from Producto p 
			inner join DetallesPedido dp on dp.IdProducto = p.IdProducto
			inner join Pedido p2 on p2.IdPedido = dp.IdPedido
			where p.IdProducto = idProduc and p2.Estado like 'Pendiente')then
		insert into Errores(IdProducto, Fecha, Motivo)
		values(idProduc, now(), 'No se puede borrar producto pendiente en Pedido');
	else
		delete from Producto 
		where IdProducto = IdProduc;
	end if;
end
€€
delimiter ;

call eliminarProducto(1);

/***
 * Procedimiento para registrar un pedido, lo que a su vez conlleva la realización
 * de un trigger para actualizar el Stock en caso que el pedido se genere correctamente,
 * usando un after ya que solo se realiza si no se produjo ningún error controlado.  
 * Tambíen se podría ejecutar otro trigger en caso de que las existencias alcancen el 
 * mínimo establecido para generar una alerta al responsable de compras.
 * (En este caso, como la acción se ejecuta igualmente, se realiza after, después de 
 * que se realiza la acción que genera el aviso(la actualización del Stock tras la 
 * compra.))
 * En este caso para generar un pedido hay que insertar datos en dos tablas, primero en 
 * la tabla Pedidos, que genera un Id del pedido. Y después, con ese Id generado, en la
 * tabla detalles del pedido. 
 * Para controlar los errores por stock insuficiente, se registran en su correspondiente 
 * tabla, he usado un condicional if que verifique antes de insertar datos si el stock 
 * actual es mayor que la cantidad solicitada y sino hacer la inserción correspondiente 
 * en la tabla errores.
 */

-- Consulta para saber el stock actual de un producto concreto
select Stock 
from Producto
where IdProducto = 1;

-- Consulta para saber el id de un pedido más reciente
select idPedido
from Pedido
where IdCliente = 1
order by FechaPedido desc
limit 1;

-- Consulta para saber el precio por unidad
select PrecioUnidad 
from Producto 
where IdProducto = 1;

-- Procedimiento para insertar un pedido y sus detalles, o en su defecto registar el 
-- error(Un pedido un sólo producto). Entiendo, al menos no hayé forma de lo contrario, 
-- que si se quiere manejar que haya más de un producto en el mismo pedido de forma 
-- dinámica(sin saber de antemano cuántos serán y sus datos) habría que desarrollarlo  
-- más en el código de programación que se usa para conectarse a la BBDD.
-- O como alternativa realizar el procedimiento sólo del pedido, y ya después ejecutar
-- otro para generar los datos de detallesPedido tantas como sea necesario(como quedó
-- el ejercicio se pueden insertar más productos a un idpedido manualmente). Pero de 
-- cualquier modo necesitas saber cuantos datos para parámetros te hacen falta ya que 
-- no se puede interactuar con la BBDD en la ejecución del procedimiento como en 
-- lenguajes de programación.
delimiter €€
create procedure insertarPedido(in idProd int, in idClien int, in cantida int)
begin
	declare stockA int;
	declare precioU float;
	declare precioT float;
	declare idPedidoA int;
	set stockA = (select Stock from Producto where IdProducto = idProd);
	set precioU = (select PrecioUnidad from Producto where IdProducto = idProd);
	set precioT = cantida * precioU;
	if(stockA > cantida)then
		insert into Pedido(IdCliente, FechaPedido, Estado)
		values(idClien, now(), 'Pendiente');
		set idPedidoA = (select idPedido
						from Pedido
						where IdCliente = idClien
						order by FechaPedido desc
						limit 1);
		insert into DetallesPedido(IdPedido, IdProducto, Cantidad, precioUnidad, total)
		values(idPedidoA,idProd, cantida, precioU, precioT);
	else
		insert into Errores(IdProducto, Fecha, Motivo)
		values(idProd, now(), 'Stock insuficiente');
	end if;
end;
€€
delimiter ;


-- Inserción correcta en ambas tablas, Pedido y DetallesPedido
call insertarPedido(1, 1, 1);

-- Intento de solicitar una cantidad superior al Stock, registro en la tabla Errores
call insertarPedido(1, 1, 100);

-- Trigger para actualizar el stock. Se realiza un update en la tabla producto cuando
-- se detecta una insersión en la tabla detalles del pedido, utilizando la nueva cantidad
-- para descontar al stock existente.

delimiter €€
create trigger actualizarStock
after insert on DetallesPedido
for each row
begin
	update Producto
	set Stock = Stock - new.Cantidad
	where IdProducto = new.IdProducto;
end
€€
delimiter ;


-- Comprobación del trigger
call insertarPedido(5, 2, 2);

-- Trigger para generar la alerta si el stock baja del 10% del stock total. Utilizo una variable para
-- calcular el porcentaje del stock mínimo, multiplicando el stockMaximo anterior(para este caso hubiera
-- valido el nuevo, ya que ese valor se mantiene constante). Después uso un condicional if para que solo
-- se realice la acción deseada en caso que se modifique la columna en cuestión y no cualquiera de las otras
-- de la tabla. Y por último añado la condición que genera la alerta y si se cumple se procede a su registro 
-- en la tabla.

delimiter €€
create trigger generarAlerta
after update on Producto
for each row
begin
	declare stockM int;
	set stockM = old.StockMaximo * 0.1;
	if(old.Stock != new.Stock)then
		if(new.Stock <= stockM)then
			insert into Alertas(IdProducto, Causa, Fecha, Destinada)
			values(new.IdProducto,'Stock Mínimo Alcanzado', now(), 'Responsable Compras');
		end if;
	end if;
end
€€
delimiter ;


-- Inserción nuevo producto con el límete del 10% para ser alcanzado en su próximo pedido y registrar la alerta
call insertarProducto('Raton Inalámbrico', 9.50, 6, 60);

-- Realizar nuevo pédido donde se debe ejecutar el trigger generarAlerta
call insertarPedido(6, 5, 1);

/***
 * Función para obtener el total gastado por un cliente.
 * Y procedimientos para mostar el total de todos los cliente: uno que utiliza un bucle que llama a la función
 * anterior para cada cliente y otro que usa una simple consulta.
 * Añadido una función que devuelve el total "factuado" en un dia.
*/

-- Consulta para saber lo gastado por un cliente
select sum(total)
from Cliente c 
inner join Pedido p on p.IdCliente = c.IdCliente
inner join DetallesPedido dp on dp.IdPedido = p.IdPedido
where c.IdCliente = 1;

set global log_bin_trust_function_creators = 1;

-- Función que recibe por parámetros el id del cliente y devuelve el total gastado por dicho cliente.
delimiter €€
create function totalGastado(idClient int)
returns float
begin
	declare tGastado float;
	set tGastado = (select sum(total)
					from Cliente c 
					inner join Pedido p on p.IdCliente = c.IdCliente
					inner join DetallesPedido dp on dp.IdPedido = p.IdPedido
					where c.IdCliente = idClient);
	return tGastado;
end;
€€ 
delimiter ;

select totalGastado(1) as TotalGastado;


select IdCliente, Nombre 
from Cliente c 


-- Procedimiento para ver el total gastado por cada cliente usando un bucle, muestra cada
-- resultado en una ventana separada.
delimiter €€
create procedure mostrarTotales()
begin
	declare idClien int;
	declare nombreCli varchar(255);
	declare total float;
	declare cursorG cursor for select IdCliente, Nombre from Cliente;
	declare continue handler for not found set @done=true;
	set @done=false;
	open cursorG;
	bucle:loop
		fetch cursorG into idClien, nombreCli;
		if @done then
			leave bucle;
		end if;
		set total = totalGastado(idClien);
		select idClien as Id, nombreCli as Nombre ,total as TotalGastado;
	end loop;
	close cursorG;
end
€€
delimiter ;

call mostrarTotales();

-- Procedimiento que devuelve una consulta con los clientes y sus totales

-- Consulta que devuelve el total
select c.IdCliente, Nombre , sum(total)
from Cliente c 
inner join Pedido p on p.IdCliente = c.IdCliente
inner join DetallesPedido dp on dp.IdPedido = p.IdPedido
group by c.IdCliente, c.Nombre 
;

delimiter €€
create procedure listarTotales()
begin
	select c.IdCliente, Nombre , sum(total) as TotalGastado
	from Cliente c 
	inner join Pedido p on p.IdCliente = c.IdCliente
	inner join DetallesPedido dp on dp.IdPedido = p.IdPedido
	group by c.IdCliente, c.Nombre 
;
end
€€
delimiter ;

call listarTotales();

-- Función que pasada una fecha por parámetros devuelve el total generado por los pedidos en esa fecha

-- Consulta para una fecha concreta
select sum(total)
from DetallesPedido dp
inner join Pedido p on dp.IdPedido = p.IdPedido
where date(FechaPedido) = date(now())
;

-- Función
delimiter €€
create function totalRecaudado(fecha date)
returns float
begin
	declare totalA float;
	set totalA = (select sum(total)
				from DetallesPedido dp
				inner join Pedido p on dp.IdPedido = p.IdPedido
				where date(FechaPedido) = fecha);
return totalA;
end;
€€
delimiter ;

select totalRecaudado('2025-04-13') as TotalGenerado, '2025-04-13' as DiaConsultado
;

/**
 * Procedimiento para listar las ventas realizadas en un dia dado
 * 
 */
-- Consulta para ver las ventas(pedidos) de un dia concreto
select *
from Pedido p 
inner join DetallesPedido dp on dp.IdPedido = p.IdPedido
where date(FechaPedido) = '2025-04-14';


delimiter €€
create procedure PedidosDia(in fecha date)
begin
	select *
	from Pedido p 
	inner join DetallesPedido dp on dp.IdPedido = p.IdPedido
	where date(FechaPedido) = fecha;
end
€€
delimiter ;

call PedidosDia('2025-04-13');





