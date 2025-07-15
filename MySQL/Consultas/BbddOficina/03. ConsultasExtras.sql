-- Aumentar el salario en 50€ a todos los empleados que trabajan en atocha

UPDATE empleados e
inner join departamentos d on d.idDepartamento = e.idDepartamentoFK 
inner join centrostrabajo c on c.idCentroTrabajo = d.idCentroTrabajoFK 
set e.salarioEmpleado = e.salarioEmpleado + 50
where c.direccionCentroTrabajo = 'C/ ATOCHA, 405, MADRID';

-- Consulta para comprobar la subida
select e.salarioEmpleado, c.direccionCentroTrabajo from empleados e 
inner join departamentos d on d.idDepartamento = e.idDepartamentoFK 
inner join centrostrabajo c on c.idCentroTrabajo = d.idCentroTrabajoFK 
where c.direccionCentroTrabajo = 'C/ ATOCHA, 405, MADRID';

/*Se quiere llevar un control de los empleados con familia numerosa. Para ello vamos a añadir una
 * nueva columna "esNumerosa" que valdra "SI" en caso de que tenga 3 hijos o mas y "NO" en caso contrario.
 */
alter table empleados drop esnumerosa varchar(2);

alter table empleados add familiaNumerosa varchar(2);

update empleados e set e.familiaNumerosa = 'No';

update empleados e set e.familiaNumerosa = 'Si'
where e.hijosEmpleado >= 3 ;


/*De cara a la conciliación familiar, queremos saber cuál es el departamenteo con más 
 * familias numerosas, añade un columna conciliar en el departamento que se sea SI para el
 * departamento con más familias numerosas y No para el resto.*/

alter table departamentos add MasNumerosaFamilia varchar(2) default 'No';

select idDepartamentoFK from empleados e 
where familiaNumerosa = 'Si'
group by idDepartamentofk
order by count(*) desc limit 1;

/*update departamentos d set Conciliar = 'No'*/

update departamentos d set Conciliar = 'Si'
where idDepartamento = (select idDepartamentoFK from empleados e 
where familiaNumerosa = 'Si' group by idDepartamentoFK order by count(*) desc limit 1);

update departamentos d set MasNumerosaFamilia='Si'
where idDepartamento = (select idDepartamentoFK from empleados e 
where familiaNumerosa = 'Si'
group by idDepartamentofk
order by count(*) desc limit 1) ;

-- Se puede utilizar una subconsulta donde se pondria una tabla
select sub.idDepartamento
from (select idDepartamento, nombreDepartamento from departamentos d where Conciliar = 'No') sub ;


select * from empleados e 
inner join (select idDepartamentoFK, AVG(salarioEmpleado) as mediaSalarioDepartamento from empleados group by idDepartamentoFK) sub 
on sub.idDepartamentoFK = e.idDepartamentoFK 
where salarioEmpleado < mediaSalarioDepartamento ;

select e.idDepartamentoFK, count(*) from empleados e 
inner join (select idDepartamentoFK, AVG(salarioEmpleado) as mediaSalarioDepartamento from empleados group by idDepartamentoFK) sub 
on sub.idDepartamentoFK = e.idDepartamentoFK 
where salarioEmpleado < mediaSalarioDepartamento 
group by idDepartamentoFK ;

-- Realizar una consulta, que devuelva los departamentos que ninguno de sus empleados cobra por debajo de la media

select idDepartamento, count(*) from departamentos d
inner join empleados e on d.idDepartamento = e.idDepartamentoFK 
group by idDepartamento ;


select * from departamentos d 
where not idDepartamento  in (select e.idDepartamentoFK from empleados e 
inner join (select idDepartamentoFK, AVG(salarioEmpleado) as mediaSalarioDepartamento from empleados group by idDepartamentoFK) sub 
on sub.idDepartamentoFK = e.idDepartamentoFK 
where salarioEmpleado < mediaSalarioDepartamento 
group by idDepartamentoFK) ;

-- 
