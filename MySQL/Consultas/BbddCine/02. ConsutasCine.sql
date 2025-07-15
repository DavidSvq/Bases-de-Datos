-- 1.	Escribe una consulta SQL para mostrar el nombre y la duración de todas las películas que tienen un rating en IMDb mayor a 8.

select i.Title, i.Runtime  from IMDB i 
where i.Rating > 8;

-- 2.	Escribe una consulta SQL para mostrar las películas del año 2016.

select * from IMDB i 
where i.Title like '%2016%';


-- 3.	Escribe una consulta SQL para mostrar el género con menos presupuesto medio.

select g.genre, avg(i.Budget)  from genre g  
inner join IMDB i on i.Movie_id = g.Movie_id
group by g.genre
order by avg(i.Budget )
limit 1;


-- 4.	Escribe una consulta SQL para los generos con más de 40 películas (No puede aparecer nulo como género).

select  g.genre , count(*) from genre g
where g.genre is not null
group by g.genre 
having count(*) > 40;


-- 5.	Escribe una consulta SQL para mostrar los géneros con más de 5 peliculas con puntuación por encima de la media.

select avg(i.Rating ) from IMDB i 

select g.genre, count(*) from genre g
inner join IMDB i on i.Movie_id = g.Movie_id
where i.Rating > (select avg(i.Rating) from IMDB i )
group by g.genre 
having count(*) > 5;

-- 6 Escribe una consulta SQL para mostrar el título de las películas que tienen una media
-- mayor que la media de alguno de sus géneros.

select i.Title from IMDB i 

-- Peliculas que han perdido dinero (Teniendo en cuenta que han gastado todo su presupuesto)

select * from IMDB i 
inner join genre g on g.Movie_id = i.Movie_id
inner join earning e on e.Movie_id = i.Movie_id 
where i.Budget > e.Worldwide 


