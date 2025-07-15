-- Creación de la tabla de autores
CREATE TABLE Autores (
    id_autor INT PRIMARY KEY,
    nombre VARCHAR(100),
    nacionalidad VARCHAR(100)
);

-- Inserciones en la tabla de autores
INSERT INTO Autores (id_autor, nombre, nacionalidad) VALUES
(1, 'Gabriel García Márquez', 'Colombiano'),
(2, 'J.K. Rowling', 'Británica'),
(3, 'Haruki Murakami', 'Japonés'),
(4, 'Jane Austen', 'Británica'),
(5, 'George Orwell', 'Británica'),
(6, 'Gabriel García Lorca', 'Español'),
(7, 'Mario Vargas Llosa', 'Peruano'),
(8, 'Stephen King', 'Estadounidense'),
(9, 'Agatha Christie', 'Británica'),
(10, 'Isabel Allende', 'Chilena'),
(11, 'Ernest Hemingway', 'Estadounidense'),
(12, 'Fyodor Dostoevsky', 'Ruso'),
(13, 'Toni Morrison', 'Estadounidense'),
(14, 'Margaret Atwood', 'Canadiense'),
(15, 'Leo Tolstoy', 'Ruso'),
(16, 'Virginia Woolf', 'Británica'),
(17, 'Franz Kafka', 'Austríaco'),
(18, 'Charles Dickens', 'Británica'),
(19, 'Mark Twain', 'Estadounidense'),
(20, 'Paulo Coelho', 'Brasileño'),
(21, 'J.R.R. Tolkien', 'Británica'),
(22, 'Gustave Flaubert', 'Francés'),
(23, 'Albert Camus', 'Francés'),
(24, 'Jorge Luis Borges', 'Argentino'),
(25, 'Herman Melville', 'Estadounidense'),
(26, 'Emily Dickinson', 'Estadounidense'),
(27, 'Homer', 'Griega'),
(28, 'William Shakespeare', 'Británica'),
(29, 'Miguel de Cervantes', 'Español'),
(30, 'Hermann Hesse', 'Alemán'),
(31, 'John Steinbeck', 'Estadounidense'),
(32, 'Truman Capote', 'Estadounidense'),
(33, 'Jorge Amado', 'Brasileño'),
(34, 'Philip K. Dick', 'Estadounidense'),
(35, 'Agatha Christie', 'Británica'),
(36, 'Jane Austen', 'Británica'),
(37, 'Stephen King', 'Estadounidense'),
(38, 'Oscar Wilde', 'Irlandés'),
(39, 'Rudyard Kipling', 'Británica'),
(40, 'Anton Chekhov', 'Ruso'),
(41, 'Isabel Allende', 'Chilena'),
(42, 'Octavia E. Butler', 'Estadounidense'),
(43, 'Kazuo Ishiguro', 'Británica'),
(44, 'T.S. Eliot', 'Estadounidense'),
(45, 'George Orwell', 'Británica'),
(46, 'Ursula K. Le Guin', 'Estadounidense'),
(47, 'Neil Gaiman', 'Británica'),
(48, 'Jorge Luis Borges', 'Argentino'),
(49, 'Marianne Williamson', 'Estadounidense'),
(50, 'Gabriel García Márquez', 'Colombiano');

-- Creación de la tabla de libros
CREATE TABLE Libros (
    id_libro INT PRIMARY KEY,
    titulo VARCHAR(255),
    genero VARCHAR(100),
    id_autor INT,
    FOREIGN KEY (id_autor) REFERENCES Autores(id_autor)
);

-- Inserciones en la tabla de libros
INSERT INTO Libros (id_libro, titulo, genero, id_autor) VALUES
(1, 'Cien años de soledad', 'Realismo mágico', 1),
(2, 'Harry Potter y la piedra filosofal', 'Fantasía', 2),
(3, 'Norwegian Wood', 'Ficción', 3),
(4, 'Orgullo y prejuicio', 'Romance', 4),
(5, '1984', 'Ciencia ficción', 5),
(6, 'La casa de Bernarda Alba', 'Teatro', 6),
(7, 'La ciudad y los perros', 'Novela', 7),
(8, 'El resplandor', 'Terror', 8),
(9, 'Diez negritos', 'Misterio', 9),
(10, 'La casa de los espíritus', 'Realismo mágico', 10),
(11, 'El viejo y el mar', 'Novela', 11),
(12, 'Crónica de una muerte anunciada', 'Ficción', 12),
(13, 'Crimen y castigo', 'Novela', 13),
(14, 'Beloved', 'Ficción histórica', 14),
(15, 'El cuento de la criada', 'Ciencia ficción', 15),
(16, 'Guerra y paz', 'Novela histórica', 16),
(17, 'Mrs. Dalloway', 'Ficción', 17),
(18, 'La metamorfosis', 'Ficción', 18),
(19, 'Grandes esperanzas', 'Novela', 19),
(20, 'Las aventuras de Huckleberry Finn', 'Novela', 20),
(21, 'El alquimista', 'Ficción', 21),
(22, 'El hobbit', 'Fantasía', 22),
(23, 'Madame Bovary', 'Novela', 23),
(24, 'El extranjero', 'Ficción', 24),
(25, 'Ficciones', 'Ficción', 25),
(26, 'Moby Dick', 'Novela', 26),
(27, 'Poemas', 'Poesía', 27),
(28, 'La Odisea', 'Épica', 28),
(29, 'Romeo y Julieta', 'Tragedia', 29),
(30, 'Don Quijote de la Mancha', 'Novela', 30),
(31, 'Siddhartha', 'Ficción', 31),
(32, 'Las uvas de la ira', 'Novela', 32),
(33, 'A sangre fría', 'Novela', 33),
(34, 'Dona Flor y sus dos maridos', 'Novela', 34),
(35, '¿Sueñan los androides con ovejas eléctricas?', 'Ciencia ficción', 35),
(36, 'Asesinato en el Orient Express', 'Misterio', 36),
(37, 'Orgullo y prejuicio', 'Romance', 37),
(38, 'El resplandor', 'Terror', 38),
(39, 'El retrato de Dorian Gray', 'Ficción gótica', 39),
(40, 'El libro de la selva', 'Cuentos', 40),
(41, 'La gaviota', 'Drama', 41),
(42, 'La casa de los espíritus', 'Ficción mágica', 42),
(43, 'Parable of the Sower', 'Ciencia ficción', 43),
(44, 'Nunca me abandones', 'Ficción especulativa', 44),
(45, 'La tierra baldía', 'Poesía', 45),
(46, '1984', 'Ciencia ficción', 46),
(47, 'La mano izquierda de la oscuridad', 'Ciencia ficción', 47),
(48, 'American Gods', 'Fantasía', 48),
(49, 'Ficciones', 'Ficción', 49),
(50, 'Volver al amor', 'Espiritualidad', 50),
(51, 'El amor en los tiempos del cólera', 'Realismo mágico', 1),
(52, 'Cronica de una muerte anunciada', 'Ficción', 1),
(53, 'El coronel no tiene quien le escriba', 'Novela', 1),
(54, 'El general en su laberinto', 'Ficción histórica', 1),
(55, 'Relato de un náufrago', 'No ficción', 1),
(56, 'Harry Potter y la cámara secreta', 'Fantasía', 2),
(57, 'Harry Potter y el prisionero de Azkaban', 'Fantasía', 2),
(58, 'Harry Potter y el cáliz de fuego', 'Fantasía', 2),
(59, 'Harry Potter y la Orden del Fénix', 'Fantasía', 2),
(60, 'Harry Potter y el misterio del príncipe', 'Fantasía', 2),
(61, 'Tokio blues', 'Ficción', 3),
(62, 'Kafka en la orilla', 'Ficción', 3),
(63, '1Q84', 'Ficción', 3),
(64, 'Al sur de la frontera, al oeste del sol', 'Ficción', 3),
(65, 'Norwegian Wood', 'Ficción', 3),
(66, 'Sentido y sensibilidad', 'Romance', 4),
(67, 'Emma', 'Romance', 4),
(68, 'Persuasión', 'Romance', 4),
(69, 'Orgullo y prejuicio', 'Romance', 4),
(70, 'Mansfield Park', 'Romance', 4),
(71, 'Rebelión en la granja', 'Ficción', 5),
(72, 'Homenaje a Cataluña', 'No ficción', 5),
(73, '1984', 'Ciencia ficción', 5),
(74, 'La casa de Bernarda Alba', 'Teatro', 6),
(75, 'Yerma', 'Teatro', 6),
(76, 'Bodas de sangre', 'Teatro', 6),
(77, 'Poeta en Nueva York', 'Poesía', 6),
(78, 'La ciudad y los perros', 'Novela', 7),
(79, 'La tía Julia y el escribidor', 'Novela', 7),
(80, 'Pantaleón y las visitadoras', 'Novela', 7),
(81, 'Travesuras de la niña mala', 'Novela', 7),
(82, 'El resplandor', 'Terror', 8),
(83, 'It', 'Terror', 8),
(84, 'Cementerio de animales', 'Terror', 8),
(85, 'Carrie', 'Terror', 8),
(86, 'Asesinato en el Orient Express', 'Misterio', 9),
(87, 'Diez negritos', 'Misterio', 9),
(88, 'El misterio de Pale Horse', 'Misterio', 9),
(89, 'Asesinato en Mesopotamia', 'Misterio', 9),
(90, 'La casa de los espíritus', 'Realismo mágico', 10),
(91, 'De amor y de sombra', 'Ficción', 10),
(92, 'Eva Luna', 'Ficción', 10),
(93, 'La ciudad de las bestias', 'Ficción', 10),
(94, 'El bosque de los pigmeos', 'Ficción', 10),
(95, 'El amor en los tiempos del cólera', 'Realismo mágico', 1),
(96, 'Cronica de una muerte anunciada', 'Ficción', 1),
(97, 'El coronel no tiene quien le escriba', 'Novela', 1),
(98, 'El general en su laberinto', 'Ficción histórica', 1),
(99, 'Relato de un náufrago', 'No ficción', 1),
(100, 'Harry Potter y la cámara secreta', 'Fantasía', 2),
(101, 'Harry Potter y el prisionero de Azkaban', 'Fantasía', 2),
(102, 'Harry Potter y el cáliz de fuego', 'Fantasía', 2),
(103, 'Harry Potter y la Orden del Fénix', 'Fantasía', 2),
(104, 'Harry Potter y el misterio del príncipe', 'Fantasía', 2),
(105, 'Tokio blues', 'Ficción', 3),
(106, 'Kafka en la orilla', 'Ficción', 3),
(107, '1Q84', 'Ficción', 3),
(108, 'Al sur de la frontera, al oeste del sol', 'Ficción', 3),
(109, 'Norwegian Wood', 'Ficción', 3),
(110, 'Sentido y sensibilidad', 'Romance', 4),
(111, 'Emma', 'Romance', 4),
(112, 'Persuasión', 'Romance', 4),
(113, 'Orgullo y prejuicio', 'Romance', 4),
(114, 'Mansfield Park', 'Romance', 4),
(115, 'Rebelión en la granja', 'Ficción', 5),
(116, 'Homenaje a Cataluña', 'No ficción', 5),
(117, '1984', 'Ciencia ficción', 5),
(118, 'La casa de Bernarda Alba', 'Teatro', 6),
(119, 'Yerma', 'Teatro', 6),
(120, 'Bodas de sangre', 'Teatro', 6),
(121, 'Poeta en Nueva York', 'Poesía', 6),
(122, 'La ciudad y los perros', 'Novela', 7),
(123, 'La tía Julia y el escribidor', 'Novela', 7),
(124, 'Pantaleón y las visitadoras', 'Novela', 7),
(125, 'Travesuras de la niña mala', 'Novela', 7),
(126, 'El resplandor', 'Terror', 8),
(127, 'It', 'Terror', 8),
(128, 'Cementerio de animales', 'Terror', 8),
(129, 'Carrie', 'Terror', 8),
(130, 'Asesinato en el Orient Express', 'Misterio', 9),
(131, 'Diez negritos', 'Misterio', 9),
(132, 'El misterio de Pale Horse', 'Misterio', 9),
(133, 'Asesinato en Mesopotamia', 'Misterio', 9),
(134, 'La casa de los espíritus', 'Realismo mágico', 10),
(135, 'De amor y de sombra', 'Ficción', 10),
(136, 'Eva Luna', 'Ficción', 10),
(137, 'La ciudad de las bestias', 'Ficción', 10),
(138, 'El bosque de los pigmeos', 'Ficción', 10);

-- Creación de la tabla de editoriales
CREATE TABLE Editoriales (
    id_editorial INT PRIMARY KEY,
    nombre VARCHAR(100),
    ciudad VARCHAR(100)
);

-- Inserciones en la tabla de editoriales
INSERT INTO Editoriales (id_editorial, nombre, ciudad) VALUES
(1, 'Editorial Sudamericana', 'Buenos Aires'),
(2, 'Bloomsbury Publishing', 'Londres'),
(3, 'Shinchosha', 'Tokio'),
(4, 'Modern Library', 'Nueva York'),
(5, 'Penguin Random House', 'Londres'),
(6, 'Ediciones Cátedra', 'Madrid'),
(7, 'Planeta', 'Barcelona'),
(8, 'Doubleday', 'Nueva York'),
(9, 'Dodd, Mead & Co.', 'Nueva York'),
(10, 'Plaza & Janés', 'Barcelona'),
(11, 'Scribner', 'Nueva York'),
(12, 'Editorial Bruguera', 'Barcelona'),
(13, 'Penguin Classics', 'Londres'),
(14, 'Viking Press', 'Nueva York'),
(15, 'Houghton Mifflin Harcourt', 'Boston'),
(16, 'Penguin Books', 'Londres'),
(17, 'Grove Press', 'Nueva York'),
(18, 'Modern Library', 'Nueva York'),
(19, 'The Bodley Head', 'Londres'),
(20, 'Vintage Books', 'Nueva York'),
(21, 'Rocco', 'Río de Janeiro'),
(22, 'HarperCollins', 'Nueva York'),
(23, 'Michel Lévy Frères', 'París'),
(24, 'Gallimard', 'París'),
(25, 'Sur', 'Buenos Aires'),
(26, 'Lone Fisherman Press', 'Nueva York'),
(27, 'Roberts Brothers', 'Boston'),
(28, 'Macmillan Publishers', 'Londres'),
(29, 'Thomas Y. Crowell Co.', 'Nueva York'),
(30, 'Francisco Alves', 'Río de Janeiro'),
(31, 'Vintage Books', 'Nueva York'),
(32, 'Alfred A. Knopf', 'Nueva York'),
(33, 'Vintage Books', 'Nueva York'),
(34, 'Planeta', 'Barcelona'),
(35, 'Doubleday', 'Nueva York'),
(36, 'Penguin Classics', 'Londres'),
(37, 'Signet Classics', 'Nueva York'),
(38, 'Viking Press', 'Nueva York'),
(39, 'Ward, Lock & Co.', 'Londres'),
(40, 'Mowbray', 'Londres'),
(41, 'Plaza & Janés', 'Barcelona'),
(42, 'Seven Stories Press', 'Nueva York'),
(43, 'Alfred A. Knopf', 'Nueva York'),
(44, 'Faber and Faber', 'Londres'),
(45, 'Faber and Faber', 'Londres'),
(46, 'Secker and Warburg', 'Londres'),
(47, 'Ace Books', 'Nueva York'),
(48, 'William Morrow and Company', 'Nueva York'),
(49, 'Sur', 'Buenos Aires'),
(50, 'HarperOne', 'San Francisco');

-- Creación de la tabla de ediciones
CREATE TABLE Ediciones (
    id_edicion INT PRIMARY KEY,
    id_libro INT,
    id_editorial INT,
    año_publicacion INT,
    FOREIGN KEY (id_libro) REFERENCES Libros(id_libro),
    FOREIGN KEY (id_editorial) REFERENCES Editoriales(id_editorial)
);

-- Inserciones en la tabla de ediciones
INSERT INTO Ediciones (id_edicion, id_libro, id_editorial, año_publicacion) VALUES
(1, 1, 1, 1967),
(2, 2, 2, 1997),
(3, 3, 3, 1987),
(4, 4, 4, 1813),
(5, 5, 5, 1949),
(6, 6, 6, 1945),
(7, 7, 7, 1963),
(8, 8, 8, 1977),
(9, 9, 9, 1939),
(10, 10, 10, 1982),
(11, 11, 11, 1952),
(12, 12, 12, 1981),
(13, 13, 13, 1866),
(14, 14, 14, 1987),
(15, 15, 15, 1985),
(16, 16, 16, 1869),
(17, 17, 17, 1925),
(18, 18, 18, 1915),
(19, 19, 19, 1861),
(20, 20, 20, 1885),
(21, 21, 21, 1988),
(22, 22, 22, 1937),
(23, 23, 23, 1857),
(24, 24, 24, 1942),
(25, 25, 25, 1944),
(26, 26, 26, 1851),
(27, 27, 27, 1890),
(28, 28, 28, 1855),
(29, 29, 29, 1597),
(30, 30, 30, 1605),
(31, 31, 31, 1922),
(32, 32, 32, 1939),
(33, 33, 33, 1966),
(34, 34, 34, 1966),
(35, 35, 35, 1968),
(36, 36, 36, 1934),
(37, 37, 37, 1813),
(38, 38, 38, 1977),
(39, 39, 39, 1890),
(40, 40, 40, 1894),
(41, 41, 41, 1896),
(42, 42, 42, 1982),
(43, 43, 43, 1993),
(44, 44, 44, 2005),
(45, 45, 45, 1922),
(46, 46, 46, 1949),
(47, 47, 47, 1969),
(48, 48, 48, 2001),
(49, 49, 49, 1944),
(50, 50, 50, 1992),
(51, 51, 1, 1967),
(52, 52, 2, 1997),
(53, 53, 3, 1987),
(54, 54, 4, 1813),
(55, 55, 5, 1949),
(56, 56, 6, 1945),
(57, 57, 7, 1963),
(58, 58, 8, 1977),
(59, 59, 9, 1939),
(60, 60, 10, 1982),
(61, 61, 11, 1952),
(62, 62, 12, 1981),
(63, 63, 13, 1866),
(64, 64, 14, 1987),
(65, 65, 15, 1985),
(66, 66, 16, 1869),
(67, 67, 17, 1925),
(68, 68, 18, 1915),
(69, 69, 19, 1861),
(70, 70, 20, 1885),
(71, 71, 21, 1988),
(72, 72, 22, 1937),
(73, 73, 23, 1857),
(74, 74, 24, 1942),
(75, 75, 25, 1944),
(76, 76, 26, 1851),
(77, 77, 27, 1890),
(78, 78, 28, 1855),
(79, 79, 29, 1597),
(80, 80, 30, 1605),
(81, 81, 31, 1922),
(82, 82, 32, 1939),
(83, 83, 33, 1966),
(84, 84, 34, 1966),
(85, 85, 35, 1968),
(86, 86, 36, 1934),
(87, 87, 37, 1813),
(88, 88, 38, 1977),
(89, 89, 39, 1890),
(90, 90, 40, 1894),
(91, 91, 41, 1896),
(92, 92, 42, 1982),
(93, 93, 43, 1993),
(94, 94, 44, 2005),
(95, 95, 45, 1922),
(96, 96, 46, 1949),
(97, 97, 47, 1969),
(98, 98, 48, 2001),
(99, 99, 49, 1944),
(100, 100, 50, 1992);



set global log_bin_trust_function_creators = 1;

/*
 *  1. Desarrollar una función calculadora que reciba 2 números y un varchar operacion. Las operaciones 
 * serán 'SUMAR', 'RESTAR', 'MULTIPLICAR' y 'DIVIDIR'. Devolver el resultado de la operación
 */

delimiter €€
create function calcular(n1 int, n2 int, operacion varchar(50))
returns int
begin
	declare opera varchar(50);
	declare num1 int;
	declare num2 int;
	declare resultado int;
	set opera = operacion;
	set num1 = n1;
	set num2 = n2;
	if(opera like 'Sumar')then
		set resultado = num1 + num2;
	elseif(opera like 'Restar') then
		set resultado = num1 - num2;
	elseif(opera like 'Multiplicar')then
		set resultado = num1 * num2;
	elseif(opera like 'Dividir')then
		set resultado = num1/num2;
	end if;
return resultado;
end;
€€
delimiter ;


select calcular(3,3,'Dividir') as Resultado;



/*
 * 2.	Añade una columna puntuación a la tabla libros. Asignale un valor aleatorio del 0-5. 	
 *  Realiza una función que dado un año devuelva  devuelva el género con mejor media de ese año. 
 */ 

-- Creación de la columna Puntuación
alter table Libros add column Puntuacion int;

-- Asignar puntuaciones aleatoriamente
update Libros l 
set l.Puntuacion = rand() * 5
;
 -- Consulta para ver la mejor puntuación media dado año concreto
select l.genero
from Libros l 
inner join Ediciones e on e.id_libro = l.id_libro
where e.año_publicacion = 1977
GROUP by l.genero 
order by avg(l.Puntuacion) desc
limit 1
;

-- Función para obtener la mejor media dado un año por parámetros
delimiter €€
create function generoMejorMediaAnio(anio int)
returns varchar(100)
begin
	declare resultado varchar(100);
	set resultado = (select l.genero
					from Libros l 
					inner join Ediciones e on e.id_libro = l.id_libro
					where e.año_publicacion = anio
					GROUP by l.genero 
					order by avg(l.Puntuacion) desc
					limit 1);	
return resultado;
end;
€€
delimiter ;

drop function generoMejorMediaAnio;


select generoMejorMediaAnio(1987);



/* 3.	Crea una tabla géneros, que tenga como columnas:  id_genero, nombre_genero y puntuación_media.
 * Crea un procedimiento insertarGenero que, dado un género, lo inserte dentro de la tabla con su media calculada.
*/
-- Consulta para ver la media segun genero específico
select avg(l.Puntuacion )
from Libros l 
where genero = 'Romance'
;

-- Función para calcular la media segun genero
delimiter €€
create function calcularMediaGenero(nomGene varchar(100))
returns int
begin
	declare pMedia int;
	set pMedia = (select avg(l.Puntuacion )
				from Libros l 
				where genero = nomGene);
return pMedia;
end;
€€
delimiter ;

select calcularMediaGenero('Romance');

-- Creación de la tabla Genero
create table Genero (
	Id_genero int primary key,
	nombreGenero varchar(100), 
	puntuacionMedia int);

-- Procedimiento para insertar una fila en la tabla Genero
delimiter €€
create procedure insertarGenero (in idGene int, in nombreGenero varchar(100))
begin
	insert into Genero(Id_genero, nombreGenero, puntuacionMedia)
	values(idGene, nombreGenero, calcularMediaGenero(nombreGenero));
end
€€
delimiter ;

drop procedure insertarGenero;

call insertarGenero(2,'Fantasía');



/*
 * 4.	Crea una función siguienteEnLaLista que, dado un escritor, devuelva el escritor que tenga la siguiente puntuación media más alta. 
 */

-- Consulta para ver la puntuación media del autor indicado
select avg(l.Puntuacion )
from Autores a 
inner join Libros l on l.id_autor = a.id_autor
where a.nombre = 'Gabriel García Márquez'
;

-- Consulta para mostrar el siguiente escritor según la media.
select a.id_autor, avg(l.Puntuacion)
from Autores a 
inner join Libros l on l.id_autor = a.id_autor
group by a.id_autor
having (select avg(l.Puntuacion )
		from Autores a 
		inner join Libros l on l.id_autor = a.id_autor
		where a.nombre = 'Gabriel García Márquez') < avg(l.Puntuacion)
order by avg(l.Puntuacion) limit 1
;

-- Función que dado un escritor, nos devuelve el siguiente con más media

delimiter €€
create function siguienteEnLista(nombAutor varchar(100))
returns int
begin
	declare siguienteEscritor int;
	set siguienteEscritor = (select a.id_autor
							from Autores a 
							inner join Libros l on l.id_autor = a.id_autor
							group by a.id_autor
							having (select avg(l.Puntuacion )
									from Autores a 
									inner join Libros l on l.id_autor = a.id_autor
									where a.nombre = nombAutor) < avg(l.Puntuacion)
							order by avg(l.Puntuacion) limit 1);
	return siguienteEscritor;
end;
€€
delimiter ;

drop function siguienteEnLista;

select siguienteEnLista('Gabriel García Márquez') as idSiguienteAutor;


/*
 * 5.	Crea una función que, dada una editorial, devuelva 'Nueva' si ningún autor ha escrito con ella, 'En crecimiento' si han escrito 
   hasta 5 autores y 'Consolidada' a partir de ahí. 
 */ 

-- Consulta para mostrar el numero de autores que escribieron para una editorial
select count(a.id_autor)
from Ediciones e 
inner join Editoriales e2 on e2.id_editorial = e.id_editorial
inner join Libros l on l.id_libro = e.id_libro
inner join Autores a on a.id_autor = l.id_autor
where e2.id_editorial = 3
;

-- Función que devuelve un una calificacion basada en el numero de autores que publicaron en la editorial, se le pasa el id de la editorial por parámetros
delimiter €€ 
create function calificarEditorial(idEditorial int)
returns varchar(100)
begin
	declare resultado varchar(100);
	declare nAutores int;
	set nAutores = (select count(a.id_autor)
					from Ediciones e 
					inner join Editoriales e2 on e2.id_editorial = e.id_editorial
					inner join Libros l on l.id_libro = e.id_libro
					inner join Autores a on a.id_autor = l.id_autor
					where e2.id_editorial = idEditorial);
	if(nAutores = 0)then
		set resultado = 'Nueva';
	elseif(nAutores <=5)then
		set resultado = 'En crecimiento';
	else
		set resultado = 'Consolidada';
	end if;
return resultado;
end;
€€
delimiter ;

select calificarEditorial(3);



/*
 * 6. Desarrolla una función que reciba una nacionalidad y devuelva 'El mejor autor de la nacionalidad ... es ... y sú mejor libro es ...' en caso de
 * que la nacionalidad tenga algún autor. Si la nacionalidad no tiene ningún autor, devolverá 'La nacionalidad x no tiene ningún autor en la BD'
 * 
 * PD: CONCAT()
 */

-- Consulta para buscar autores segun nacionalidad

select CONCAT('El mejor autor de la nacionalidad ', a.nacionalidad, ' es ', a.nombre, ' y su mejor libro es ', l.titulo)
from Autores a 
inner join Libros l on a.id_autor = l.id_autor
where a.nacionalidad = 'Chilena'
order by l.Puntuacion desc
limit 1

delimiter €€
create function mejorPorNacionalidad(nombre varchar(100))
returns varchar(255)
begin
	declare resultado varchar(255);
	set resultado = (select CONCAT('El mejor autor de la nacionalidad ', a.nacionalidad, ' es ', a.nombre, ' y su mejor libro es ', l.titulo)
					from Autores a 
					inner join Libros l on a.id_autor = l.id_autor
					where a.nacionalidad = nombre
					order by l.Puntuacion desc
					limit 1);
return resultado;
end;
€€
delimiter ;

drop function mejorPorNacionalidad;

select mejorPorNacionalidad('Chilena')


/**
 * Realizar una función que reciba un genero y devuelva el número de libros que hay para ese genero,
 * sin usar la función count */

select l.id_libro
from Libros l 
where l.genero = 'Ficción'
;

delimiter €€
create function contarLibrosPorGenero(genero varchar(255))
returns int
begin
	declare generoActual varchar(255);
	declare nLibros int default 0;
	declare cursorG cursor for select l.id_libro from Libros l where l.genero = genero;
	declare continue handler for not found set @done=true;
	set @done = false;
	-- set nLibros = 0;
	open cursorG;
	bucle:loop	
		fetch cursorG into generoActual;
		
		if @done then 
			leave bucle;
		end if;
		
		set nLibros= nLibros + 1;
	end loop;
	close cursorG;
return nLibros;
end;

€€
delimiter ;

drop function contarLibrosPorGenero;

select contarLibrosPorGenero('Realismo Mágico');

alter table Genero add nLibros int;

select contarLibrosPorGenero(genero) from Libros l ;

update Genero g 
set nLibros = contarLibrosPorGenero(nombreGenero);


delimiter €€
create trigger actualizarNLibros
after insert on Libros
for each row 
begin
	update Genero
	set nLibros = nLibros + 1
	where nombreGenero = new.genero;
end
€€
delimiter ;

drop trigger actualizarNLibros;

insert into Libros (id_libro, titulo, genero, id_autor, Puntuacion)
values(140, 'Memorias de Fesac', 'Terror', 3, 6);


/***
 * Desarrollar un trigger que tras una modificación en un libro, actualice la puntuación media de su genero
 */

select avg(puntuacion) from Libros where genero = 'Terror'

delimiter €€
create trigger actualizarMedia
after update on Libros
for each row
begin
	update Genero
	set puntuacionMedia = (select avg(puntuacion) from Libros where genero = new.genero)
	where nombreGenero = new.genero;
end
€€
delimiter ;


-- para comprobar que el cambio se realiza sobre la columna concreta y no otra se usa un if dentro del cuerpo

delimiter €€
create trigger actualizarMedia1
after update on Libros
for each row
begin
	if new.puntucion != old.puntuacion then
		update Genero
		set puntuacionMedia = (select avg(puntuacion) from Libros where genero = new.genero)
		where nombreGenero = new.genero;
	end if;
end
€€
delimiter ;


update Libros l 
set Puntuacion = 6
where l.genero = 'Ficción especulativa';


alter table Genero add mejorAutor varchar(255);

/*
 * Autor con mejor media en el genero. Crear un procedimiento que añada el mejorAutor para todos los generos
 * */

select nombre
from Libros l 
inner join Autores a on a.id_autor = l.id_autor
where genero = 'Realismo mágico'
group by a.nombre
order by avg(puntuacion) desc
limit 1;

select nombreGenero from Genero g 


delimiter €€
create procedure mejorAutorG()
begin
	declare nombreA varchar(255);
	declare generoActual varchar(255);
	declare cursorG cursor for select nombreGenero from Genero g;
	declare continue handler for not found set @done = true;
	set @done = false;
	open cursorG;
	bucle:loop
		fetch cursorG into generoActual;
		if @done then
			leave bucle;
		end if;
		set nombreA = (select nombre
						from Libros l 
						inner join Autores a on a.id_autor = l.id_autor
						where genero = generoActual
						group by a.nombre
						order by avg(puntuacion) desc
						limit 1);
		update Genero g 
		set mejorAutor = nombreA
		where nombreGenero = generoActual;
	end loop;
	close cursorG;
end
€€
delimiter ;

drop procedure mejorAutorG;

call mejorAutorG();



