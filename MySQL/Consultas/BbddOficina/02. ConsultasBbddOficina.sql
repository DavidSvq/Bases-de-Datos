-- Para los departamentos en los que algún empleado tiene comisión, hallar cuántos
-- empleados con comisión hay en promedio por cada extensión telefónica.

select idDepartamentoFK, extensionEmpleado, count(*) from empleados e 
where comisionEmpleado > 0
group by idDepartamentoFK , extensionEmpleado;

/*Obtener por orden creciente los números de extensiones telefónicas de los
departamentos que tienen más de dos y que son compartidas por menos de 4
empleados, excluyendo las que no son compartidas.*/
-- Primera consulta para sacar cuantos departamentes hay por extensión
select idDepartamentoFK from empleados e 
group by idDepartamentoFK , extensionEmpleado
having count(*) >= 2 and count(*) <= 4;

 -- SUBCONSULTA. -- Cuantos empleados habrá por departamento que compartan extensión como máximo entre cuatro empleados
select idDepartamentoFK, count(*) from empleados e 
where idDepartamentoFK in (select idDepartamentoFK from empleados e 
group by idDepartamentoFK , extensionEmpleado
having count(*) >= 2 and count(*) <= 4)
group by idDepartamentoFK;

/*Para los departamentos cuyo salario medio supera al de la empresa, hallar cuántas
extensiones telefónicas tienen.*/

select idDepartamentoFK , avg(salarioEmpleado) from empleados e 
group by idDepartamentoFK
having 


-- Obtener el salario medio por departamento para aquellos departamentos cuyo salario
-- máximo es inferior al salario medio de todos los empleados.

select avg(salarioEmpleado) from empleados e 

select idDepartamentoFK FK, avg(salarioEmpleado) as mediaSalario
from empleados e 
group by idDepartamentoFK
having max(salarioEmpleado) < (select avg(salarioEmpleado) from empleados e)

/*Funcion no agregada, es decir va entre el select y el from, YEAR para pasar la fecha al año*/
select idEmpleado, (2025 - YEAR(fechaNacimientoEmpleado))as anhosEmpleados from empleados e;

/*Hallar por departamentos la edad en años cumplidos del empleado más viejo del
departamento que tiene comisión. Ordenar el resultado por edades.*/

select idDepartamentoFK, (2025 - year(min(e.fechaNacimientoEmpleado))) as edadE from empleados e
where comisionEmpleado > 0
GROUP by idDepartamentoFK 
order by edadE desc;

-- CONSULTAS SENCILLAS

-- obtener los nombres de todos los centros de trabajo de la empresa clasificados por orden alfabético

select c.nombreCentroTrabajo  from centrostrabajo c 
group by c.nombreCentroTrabajo 
order by c.nombreCentroTrabajo;

select c.nombreCentroTrabajo  from centrostrabajo c 
group by c.nombreCentroTrabajo 
order by c.nombreCentroTrabajo desc;

-- obtener los nombres de los empleados que trabajan en el departamento 121

select e.nombreEmpleado  from empleados e 
where e.idDepartamentoFK = 121;

-- extraer todos los datos del departamento 121

select * from departamentos d 
where d.idDepartamento = 121;

-- obtener los nombres y salarios de los empleados con más de tres hijos por orden alfabético

select e.nombreEmpleado, e.salarioEmpleado, e.hijosEmpleado    from empleados e
where e.hijosEmpleado > 3
order by e.nombreEmpleado ;

-- Obtener la comisión, departamento y nombre, de los empleados cuyo salario es inferior a 1900€, clasificándolos por departamento en orden creciente,
-- por comisión en orden decreciente dentro de cada departamento.

select e.comisionEmpleado, e.idDepartamentoFK, e.nombreEmpleado  from empleados e
where e.salarioEmpleado < 1900
order by idDepartamentoFK, comisionEmpleado desc;

-- obtener por porden alfabético los nombres de los departamentos cuyo presupuesto sea superior a 10M

select d.nombreDepartamento, d.presupuestosDepartamento  from departamentos d
where d.presupuestosDepartamento > 10
order by d.nombreDepartamento ;

-- Obtener de manera ordenada los numeros de los departamentos(sin repetir) donde trabajan empleados cuyo salario sea inferior a 2000€

select distinct e.idDepartamentoFK  from empleados e -- comando DISTINCT usado para no obtener duplicados de un campo, en este caso el id
where e.salarioEmpleado < 2000
order by idDepartamentoFK 

-- Obtener los valores diferentes (y sin repetir) de comisiones que hay en el departamento 110

select distinct e.comisionEmpleado   from empleados e
where e.idDepartamentoFK = 110;

-- Hallar por orden alfabético, los nombres de los departamentos cuyo director lo es en funciones y no en propiedad

select d.nombreDepartamento  from departamentos d 
where d.tipoDirectorDepartamento = 'F'
order by d.nombreDepartamento ;

-- Obtener un listin telefónico de los empleados del departamento 121 incluyendo nombre del empleado, número de empleado y extensión telefónica.

select e.nombreEmpleado, e.idEmpleado, e.extensionEmpleado from empleados e
where e.idDepartamentoFK = 121
order by e.nombreEmpleado ;

-- Ordenar por orden creciente una relación de todos los números de extensiones telefónicas de los empleados

select e.nombreEmpleado, e.extensionEmpleado  from empleados e 
order by e.extensionEmpleado ;

-- Hallar la comisión, nombre y salario de los empleados con más de 3 hijos, clasificados por comisión, y dentro de comisión alfabéticamente

select e.comisionEmpleado, e.nombreEmpleado, e.salarioEmpleado  from empleados e
where e.hijosEmpleado > 3
order by e.comisionEmpleado, e.nombreEmpleado ;

-- Obtener salario y nombre de los empleados sin hijos por orden decreciente de salario y por orden alfabético dentro de salario.

select e.salarioEmpleado, e.nombreEmpleado  from empleados e 
where e.hijosEmpleado = 0
order by e.salarioEmpleado desc, e.nombreEmpleado ;

-- EXPRESIONES

-- Obtener los nombres y salarios anuales expresados en € de los empleados del departamento 100. Presentardo por orden decreciernte de salarios.

select e.nombreEmpleado , e.salarioEmpleado*12 as salarioAnual from empleados e
where e.idDepartamentoFK = 100
order by salarioAnual desc;

-- Obtener los nombres de los empleados cuya comisión es superior o igual al 50% de su salario, por orden alfabético.

select e.nombreEmpleado  from empleados e
where e.comisionEmpleado >= e.salarioEmpleado /2
order by e.nombreEmpleado;

-- En una campaña de ayuda familiar se ha decidido dar a los empleados una paga
-- extra de 500€ a partir del cuarto hijo inclusive. Obtener por orden alfabético para estos
-- empleados:nombre y salario total que van a cobrar incluyendo esta paga extra.

select e.nombreEmpleado,e.salarioEmpleado + 500 as salarioConExtra  from empleados e 
where e.hijosEmpleado >= 4
order by e.nombreEmpleado ;

-- Obtener una relación por orden alfabético de los departamentos cuyo presupuesto
-- es inferior a 5.000.000 €. El nombre de los departamentos vendrá precedido de las
-- palabras;'Departamento de'e irá en la misma columna que el nombre del departamento.

select Concat('DEPARTAMENTO DE ', d.nombreDepartamento) as NombreDepartamento from departamentos d 
where d.presupuestosDepartamento < 5 

-- Llamemos presupuesto medio mensual de un departamento al resultado de dividir
-- su presupuesto anual por 12. Supongamos que se decide aumentar los presupuestos
-- medios mensuales de todos los departamentos en un 10% a partir del mes de octubre
-- inclusive. Para los departamentos cuyo presupuesto mensual medio anterior a octubre
-- es más de 5.000.000 €, hallar por orden alfabético el nombre de departamento y su
-- presupuesto anual total después del incremento. NOTA: EN LA TABLA NO HAY NINGUN VALOR QUE CUMPLA EL REQUISITO

select d.nombreDepartamento, d.presupuestosDepartamento  ,d.presupuestosDepartamento*1.1 as presupuestoIncrementado from departamentos d
where ((d.presupuestosDepartamento*9)/12) > 5;

-- Supongamos que en los próximos tres años el coste de vida va a aumentar un 6%
-- anual y que se suben los salarios en la misma proporción,hallar para los empleados con
-- más de 4 hijos su nombre y su salario anual, actual y para cada uno de los próximos tres
-- años, clasificados por orden alfabético.

select nombreEmpleado, (e.salarioEmpleado * 12) as salarioAnual, e.salarioEmpleado * 12 * 1.06 as salario1Anual, 
e.salarioEmpleado * 12 * 1.06 * 1.06 as salario2Anual, e.salarioEmpleado * 12 * 1.06 * 1.06 * 1.06 as salario3Anual
from empleados e 
where e.hijosEmpleado > 4;

-- Hallar, por orden alfabético, los nombres de los empleados tales que si se les da una
-- gratificación de 1.000€ por hijo, el total de esta gratificación no supera a la décima parte
-- del salario anual. 

select e.nombreEmpleado, e.hijosEmpleado *1000 as PrimaPorHijos, e.salarioEmpleado * 12 * 0.1 as decimaParteSalarial  from empleados e
where e.hijosEmpleado * 1000 <= e.salarioEmpleado * 12 * 0.1 and e.hijosEmpleado > 0
order by e.nombreEmpleado ;

-- Para los empleados del departamento 112 hallar el nombre y el salario total de cada
-- uno (salario más comisión), por orden de salario total decreciente, y por orden alfabético
-- dentro de salario total.

select e.nombreEmpleado, (e.salarioEmpleado + e.comisionEmpleado) as SalarioTotal from empleados e 
where e.idDepartamentoFK = 112
order by SalarioTotal desc, e.nombreEmpleado ;

-- Hallar ordenado por número de empleado, el nombre y salario total (salario más
-- comisión) de los empleados cuyo salario total supera los 3.000 € mensuales.

select e.idEmpleado, e.nombreEmpleado, (e.salarioEmpleado + e.comisionEmpleado) as SalarioTotal from empleados e 
where (e.salarioEmpleado + e.comisionEmpleado) > 3000
order by e.idEmpleado;

-- Obtener los números de los departamentos en los que haya algún empleado cuya
-- comisión supere al 20 % de su salario.

select e.idDepartamentoFK, e.comisionEmpleado, e.salarioEmpleado * 0.2 as BigesimaParteSalario  from empleados e
where e.comisionEmpleado > e.salarioEmpleado * 0.2;

-- PREDICADOS WHERE, HAVING Y JOIN 

-- BASICOS

-- Obtener por orden alfabético los nombres de los empleados cuyos salarios igualan
-- o superan al de Claudia Fierro en más del 50%.

-- subconsulta--
select e.salarioEmpleado  from empleados e 
where e.nombreEmpleado = 'Fierro, Claudia'

select e.nombreEmpleado  from empleados e 
where e.salarioEmpleado >= (select e.salarioEmpleado  from empleados e
where e.nombreEmpleado = 'Fierro, Claudia')*1.5
order by e.nombreEmpleado ;

-- Para todos los empleados que tienen comisión, hallar sus salarios mensuales totales
-- incluyendo ésta. Obtenerlos por orden alfabético. Halla también el porcentaje que de su
-- salario total supone la comisión.

select  e.salarioEmpleado + e.comisionEmpleado as SalarioTotal, ((e.comisionEmpleado * 100) / e.salarioEmpleado) as porcentajeComisionSalario from empleados e
where e.comisionEmpleado > 0
order by SalarioTotal;

-- NULL . IS NULL e IS NOT NULL

-- Obtener los nombres de los departamentos que no dependen funcionalmente de
-- otro.

select d.nombreDepartamento  from departamentos d 
where d.idDepartamentoFK is null;

-- CUANTIFICADOS ALL COMPARA UN VALOR CON TODOS LOS DE LA LISTA DEVULETA POR LA SUBCONSULTA
              -- ANY (SOME TB) COMPARA UN VALOR CON CUALQUIER VALOR DEVUELTO DE LA SUBCONSULTA

-- Obtener por orden alfabético los nombres de los empleados cuyo salario supera al
-- máximo salario de los empleados del departamento 122.

-- subcontulta--
select e.salarioEmpleado  from empleados e 
where e.idDepartamentoFK = 122;
			  
select e.nombreEmpleado, e.salarioEmpleado   from empleados e
where e.salarioEmpleado > all(select e.salarioEmpleado  from empleados e 
where e.idDepartamentoFK = 122);

-- Obtener por orden alfabético los nombres de los empleados cuyo salario supera
-- en tres veces y media o más al mínimo salario de los empleados del departamento 122.

-- subcontulta--
select e.salarioEmpleado  from empleados e 
where e.idDepartamentoFK = 122
order by e.salarioEmpleado 
limit 1;

select e.nombreEmpleado, e.salarioEmpleado, (select e.salarioEmpleado  from empleados e where e.idDepartamentoFK = 122
order by e.salarioEmpleado limit 1) * 3 as salarioMinimoTriple
from empleados e 
where e.salarioEmpleado > (select e.salarioEmpleado  from empleados e 
where e.idDepartamentoFK = 122
order by e.salarioEmpleado 
limit 1) * 3.5 
order by e.nombreEmpleado ;

-- Obtener los nombres y salarios de los empleados cuyo salario coincide con la
-- comisión de algún otro o la suya propia. Ordenarlos alfabéticamente.

-- subconsulta --
select e.comisionEmpleado  from empleados e 

select e.nombreEmpleado, e.salarioEmpleado  from empleados e 
where e.salarioEmpleado = any (select e.comisionEmpleado  from empleados e)
order by e.nombreEmpleado 

-- Obtener por orden alfabético los nombres y salarios de los empleados cuyo salario
-- es inferior a la comisión más alta existente.

-- subconsulta --
select e.comisionEmpleado  from empleados e
order by e.comisionEmpleado desc
limit 1;

select e.nombreEmpleado, e.salarioEmpleado  from empleados e
where e.salarioEmpleado < (select e.comisionEmpleado  from empleados e
order by e.comisionEmpleado desc limit 1)
order by e.nombreEmpleado ;

-- Obtener por orden alfabético los nombres y salarios de los empleados cuyo salario
-- es inferior al cuádruplo de la comisión más alta existente.

-- subconsulta --
select e.comisionEmpleado  from empleados e
order by e.comisionEmpleado desc
limit 1;

select e.nombreEmpleado, e.salarioEmpleado  from empleados e 
where e.salarioEmpleado < ((select e.comisionEmpleado  from empleados e
order by e.comisionEmpleado desc limit 1)*4)
order by e.nombreEmpleado ;

-- BETWEEN SE USA PARA FILTRAR ENTRE DOS VALORES BETWEEN campo AND campo, AMBOS CAMPOS INCLUSIVES

-- Obtener por orden alfabético los nombres de los empleados cuyo salario está entre
-- 2.500 y 3.000 €.

select e.nombreEmpleado, e.salarioEmpleado  from empleados e 
where e.salarioEmpleado between 2500 and 3000
order by e.nombreEmpleado ;

-- Obtener por orden alfabético los nombres y salarios de los empleados cuyo salario,
-- dividido por su número de hijos cumpla una, o ambas, de las condiciones siguientes:
-- Que sea inferior a 1.200€.
-- Que sea superior al doble de su comisión.

select e.nombreEmpleado, e.salarioEmpleado  from empleados e
where (e.hijosEmpleado > 0 and ((e.salarioEmpleado/ e.hijosEmpleado)< 1200))
or (e.comisionEmpleado  > 0 and (e.comisionEmpleado * 2));

-- LIKE PARA BUSCAR TEXTO UN TEXTO CONCRETO. SI ES PARCIAL, SE USA % COMO SI FUERA UN ASTERISCO. WHERE campo LIKE '%TEXTO%'

-- Obtener por orden alfabético los nombres de los empleados cuyo primer apellido
-- es Mora o empieza por Mora.

select e.nombreEmpleado  from empleados e 
where e.nombreEmpleado like 'Mora%'
order by e.nombreEmpleado ;

-- Obtener los nombres de empleados cuyo nombre de pila empieza por Valeriana.

select e.nombreEmpleado  from empleados e 
where e.nombreEmpleado like '%Valeriana%';

-- Obtener por orden alfabético los nombres de empleados que tengan un apellido
-- de siete letras.

select e.nombreEmpleado  from empleados e 
where e.nombreEmpleado like '_______,%'
order by e.nombreEmpleado ;

-- Obtener por orden alfabético los nombres de empleados cuyo apellido tenga seis
-- o más letras.

select e.nombreEmpleado  from empleados e 
where e.nombreEmpleado like '%______,%'
order by e.nombreEmpleado 

-- Obtener los nombres de empleados cuyo apellido tenga tres letras o menos.

select e.nombreEmpleado  from empleados e 
where e.nombreEmpleado like '___,%'

-- Obtener por orden alfabético los nombres de empleados cuyo apellido termina en
-- EZ y su nombre de pila termina en O y tiene al menos tres letras.

select e.nombreEmpleado  from empleados e 
where e.nombreEmpleado like '%EZ,%__O'
order by e.nombreEmpleado ;

-- IN SE USA PARA ASIGNAR VARIOR VALORES A UN CAMPO EN EL WHERE. WHERE campo IN(valor, valor, valor)

-- Obtener por orden alfabético los nombres de los empleados cuya extensión
-- telefónica es 250 o 750.

select e.nombreEmpleado, e.extensionEmpleado  from empleados e 
where e.extensionEmpleado in (250, 750)
order by e.nombreEmpleado ;

-- Obtener por orden alfabético los nombres de los empleados que trabajan en el
-- mismo departamento que Pilar Gálvez o Dorotea Flor.

-- subconsulta para saber el departamento de Pilar --
select e.idDepartamentoFK from empleados e 
where e.nombreEmpleado = 'GALVEZ, PILAR';

-- subconsulta para saber el departamento de Dorotea --
select e.idDepartamentoFK from empleados e 
where e.nombreEmpleado = 'FLOR, DOROTEA';

select e.nombreEmpleado, e.idDepartamentoFK   from empleados e 
where e.idDepartamentoFK in ((select e.idDepartamentoFK from empleados e 
where e.nombreEmpleado = 'GALVEZ, PILAR'), (select e.idDepartamentoFK from empleados e 
where e.nombreEmpleado = 'FLOR, DOROTEA'))

-- EXISTS


-- Obtener los nombres de los centros de trabajo si hay alguno que esté en la calle
-- Atocha.

select c.nombreCentroTrabajo  from centrostrabajo c 
where c.direccionCentroTrabajo exists '%Atocha%'

-- COMPUESTOS 

-- Obtener por orden alfabético los nombres y comisiones de los empleados del
-- departamento 110 si hay en él algún empleado que tenga comisión.

select nombreEmpleado, comisionEmpleado from empleados e
where idDepartamentoFK = 110 and comisionEmpleado > 0 
order by nombreEmpleado ;

-- Obtener los nombres, salarios y fechas de ingreso de los empleados que o bien
-- ingresaron después de 01/01/88 o bien tienen un salario inferior a 2.000 €. Clasificados
-- por fecha y nombre.

select nombreEmpleado, salarioEmpleado, fechaIngresoEmpleado from empleados e
where fechaIngresoEmpleado > '1988-01-01' or salarioEmpleado < 2000
order by fechaIngresoEmpleado , nombreEmpleado ;


-- Obtener por orden alfabético los nombres de los departamentos que no sean de
-- Dirección ni de Sectores.

select nombreDepartamento from departamentos d 
where nombreDepartamento not like '%Dirección%' 
and nombreDepartamento not like 'Sector%';

-- OTROS EJERCICIOS

-- Hallar por orden de número de empleado el nombre y salario total (salario más
-- comisión) de los empleados cuyo salario total supera al salario mínimo en 3.000 €
-- mensuales.

-- subconsulta para hallar el salario mínimo --
select MIN(salarioEmpleado) from empleados e 

select idEmpleado, nombreEmpleado, (salarioEmpleado + comisionEmpleado) as SalarioTotal from empleados e 
where (salarioEmpleado + comisionEmpleado) > ((select MIN(salarioEmpleado) from empleados e) + 3000);


-- Para los empleados que no tienen comisión, obtener por orden alfabético el
-- nombre y el cociente entre su salario y el número de hijos.

select nombreEmpleado, (salarioEmpleado/hijosEmpleado) as RatioSueldoHijos from empleados e
where comisionEmpleado = 0  and e.hijosEmpleado > 0
order by nombreEmpleado ;

-- Se desea hacer un regalo de un 1% del salario a los empleados en el día de su
-- onomástica. Hallar, por orden alfabético, los nombres y cuantía de los regalos en € para
-- los que celebren su santo el día de San Honorio.

select nombreEmpleado, (salarioEmpleado * 0.01) as bonificacion from empleados e 
where nombreEmpleado like '%Honori%'
order by nombreEmpleado ;

-- Obtener por orden alfabético, los nombres y salarios de los empleados del
-- departamento 111 que tienen comisión si hay alguno de ellos cuya comisión supere el
-- 15% de su salario.

select nombreEmpleado, salarioEmpleado from empleados e 
where e.idDepartamentoFK = 111 and (comisionEmpleado > (salarioEmpleado * 0.15))
order by nombreEmpleado;

-- En la fiesta de Reyes se desea organizar un espectáculo para los hijos de los
-- empleados, que se representará en dos días diferentes. El primer día asistirán los
-- empleados cuyo apellido empiece por las letras desde A hasta L, ambas inclusive. El
-- segundo día se cursarán las invitaciones para el resto.A cada empleado se le asignarán
-- tantas invitaciones gratuitas como hijos tenga y dos más. Además, en la fiesta, se
-- entregará a cada empleado un obsequio por hijo. Obtener una lista por orden alfabético
-- de los nombres a quienes hay que invitar el primer día de la representación, incluyendo
-- también cuántas invitaciones corresponden a cada nombre y cuántos regalos hay que
-- preparar para él.

select nombreEmpleado, (hijosEmpleado +2) as numeroEntradas, hijosEmpleado as numeroRegalos from empleados e 
where hijosEmpleado > 0 and nombreEmpleado between 'A%' and 'M%'
order by nombreEmpleado ;


-- Hallar, por orden alfabético, los nombres y salarios de empleados de los
-- departamentos 110 y 111 que o bien no tengan hijos o bien su salario por hijo supere a
-- 1.000 €, si hay alguno sin comisión en los departamentos 111 o 112.

select nombreEmpleado, salarioEmpleado from empleados e 
where (idDepartamentoFK = 110 or 111) and (hijosEmpleado = 0) or ((hijosEmpleado > 0) and (salarioEmpleado / hijosEmpleado) > 1000)
order by nombreEmpleado ;

-- Hallar, por orden alfabético, los nombres de los departamentos que o bien tienen
-- director es en funciones o bien en propiedad y su presupuesto anual excede a 5.000.000

select nombreDepartamento from departamentos d 
where tipoDirectorDepartamento = 'F' or presupuestosDepartamento > 5;

-- FUNCIONES ESCALARES --

-- LENGHT -- MIDE LA LONGITUD DE UNA PALABRA O CADENA DE CARACTERES

-- Obtener por orden alfabético los nombres de empleados que tengan al menos 13
-- letras.

select nombreEmpleado from empleados e 
where (length(nombreEmpleado) - 2) >= 13
order by nombreEmpleado ;

-- SUBSTRING -- SE HA DE INDICAR POR PARAMETROS (STRING DEL QUE SUSTRAER, COMIENZO Y LENGTH NUMERO DE CARACTERES QUE SE QUIEREN EXTRAER)
			 -- SE USA DESPUES DEL SELECT

-- Obtener los nombres abreviados para los departamentos tomando sus primeras
-- nueve letras, por ordenalfabético.

select substring(nombreDepartamento, 1, 9) from departamentos d;

-- Obtener los números de departamento, y los cinco caracteres siguientes al de la
-- posición duodécima de sus nombres, mostrándolos por orden de número de
-- departamento.

select idDepartamentoFK, substring(nombreDepartamento, 12, 17) from departamentos d 
order by idDepartamentoFK;

-- Obtener los números de departamentos, y para los nombres de éstos con más de
-- 12 caracteres extraes los cinco siguientes, mostrándolos por orden de número de
-- departamento.

select idDepartamentoFK, substring(nombreDepartamento, 12, 17) from departamentos d 
where length(nombreDepartamento) > 12
order by idDepartamentoFK ;

-- Obtener los tres últimos caracteres de los nombres de departamento por orden
-- alfabético.

select substring(nombreDepartamento, length(nombreDepartamento) - 3, length(nombreDepartamento)) as inicialesFinales
from departamentos d 
order by inicialesFinales ;

-- OTROS EJERCICIOS --

-- Hallar los nombres de los empleados que no tienen comisión, clasificados de
-- manera que aparezcan primero aquellos cuyos nombres son más cortos.

select nombreEmpleado from empleados e 
where comisionEmpleado = 0 
order by length(nombreEmpleado);

-- Hallar, por orden alfabético, los nombres de empleados suprimiendo las tres
-- últimas letras de los nombres de pila,para los empleados cuyos nombres de pila tengan
-- más de 6 letras.

select substring(nombreEmpleado, 1, length(nombreEmpleado) - 3 ) as nombrecortado from empleados e 
where length(nombreEmpleado) > 6 

-- UTILIZACIÓN DE FECHAS Y HORAS

-- DATOS DE TIEMPO

-- Se desea modificar la fecha de ingreso de Valeriana Mora(empleado número 430)
-- poniendo el 3 de mayo de 1988.

select null from empleados
where 



-- Se desea saber el nombre y fecha de nacimiento del empleado 110.

select nombreEmpleado, fechaNacimientoEmpleado from empleados e 
where idEmpleado = 110;

-- Extraer de la tabla de empleados los nombres de los que han ingresado
-- posteriormente al año 1970.

select nombreEmpleado, fechaIngresoEmpleado from empleados e 
where fechaIngresoEmpleado > '1970-12-31'

-- Modificar la fecha de ingreso de Valeriana Mora(empleado número 430)poniendo
-- la del día de hoy.

select * from empleados e 

-- Obtener los nombres y fechas de nacimiento de los empleados del departamento
-- 100, en formato dd/mm/yyyy, de más viejo a más joven.

select nombreEmpleado, date_format(fechaNacimientoEmpleado, get_format(date, 'EUR')) as FechaNacimiento from empleados e
where idDepartamentoFK = 100
order by FechaNacimiento;

-- DEVUELVE LA FECHA ACTUAL
SELECT FROM_UNIXTIME(UNIX_TIMESTAMP(),'%D %M %Y') as FechaActual;

-- Para los empleados que ingresaron durante el año 1988, después del mes de mayo,
-- hallar, su nombre y cuántos días llevaban trabajando en la empresa a primeros de año
-- de 1989, por ordenalfabético.

select nombreEmpleado, datediff(1989-01-01, 1988-05-31) as diferenciaDias from empleados e 
where fechaIngresoEmpleado > '1987-12-31' and fechaIngresoEmpleado < '1988-12-31'






-- FUNCIONES COLUMNAS --

-- Hallar el salario medio, el mínimo y el máximo para el colectivo formado por todos
-- los empleados.

select avg(salarioEmpleado) as salarioMedio, min(salarioEmpleado) as salarioMinimo, max(salarioEmpleado) as salarioMaximo 
from empleados e ;

-- Hallar los mismos valores que en la consulta anterior pero sólo para los empleados
-- del departamento 100.

select avg(salarioEmpleado) as salarioMedio, min(salarioEmpleado) as salarioMinimo, max(salarioEmpleado) as salarioMaximo 
from empleados e 
where idDepartamentoFK = 100;

-- Obtener por orden alfabético los salarios y nombres de los empleados cuyo salario
-- se diferencia con el máximo en menos de un 40% de éste.

select nombreEmpleado, salarioEmpleado from empleados e 
where salarioEmpleado < ((select max(salarioEmpleado) from empleados e2) * 0.4);

-- Hallar la edad en años cumplidos del empleado más viejo del departamento 110.

select nombreEmpleado , (2025 - YEAR(fechaNacimientoEmpleado))as anhosEmpleados
from empleados e
where idDepartamentoFK = 110
order by anhosEmpleados desc limit 1 ;

-- Hallar el número de empleados de la empresa.

select count(idEmpleado) as numeroEmpleados from empleados e ;

-- Hallar el número de empleados y de extensiones telefónicas del departamento 112.

select count(idempleado) as numeroEmpleadosDel112, count(extensionEmpleado) as numeroExtensionesDel112 from empleados e 
where idDepartamentoFK = 112 ;

-- Hallar cuántos empleados hay cuya fecha de nacimiento sea anterior al año 1979.

select count(fechaNacimientoEmpleado) as empleadosNacidosAntesDel79 from empleados e 
where fechaNacimientoEmpleado < '1978-12-31' ;

-- Hallar el número de empleados del departamento 112, así como cuántas comisiones
-- hay y la suma y media de sus comisiones.

-- subconsultas /* Para hallar el numero de empleados, la media y suma de las comisiones del departamento 112*/
select count(idDepartamentoFK)from empleados e where idDepartamentoFK = 112;
select avg(comisionEmpleado)from empleados e where idDepartamentoFK = 112;
select sum(comisionEmpleado)from empleados e where idDepartamentoFK = 112;
/*############################################################################################################*/

select count(comisionEmpleado) as comisonesDel112, 
(select count(idDepartamentoFK)from empleados e where idDepartamentoFK = 112) as empleadosEnEl112,
(select avg(comisionEmpleado)from empleados e where idDepartamentoFK = 112) as mediaComionDel112, 
(select sum(comisionEmpleado)from empleados e where idDepartamentoFK = 112) as TotalComisionDel112
from empleados e 
where comisionEmpleado > 0 and idDepartamentoFK = 112;

-- Hallar cuántas comisiones diferentes hay y su valor medio.

select count(distinct(comisionEmpleado)) as comisionesExistentes, avg(comisionEmpleado) as comisionMedia
from empleados e
where comisionEmpleado > 0 ;

-- Hallar la edad media en años de los empleados del departamento 100.

select avg(2025 - YEAR(fechaNacimientoEmpleado))as mediaAnhosEmpleados
from empleados e 
where idDepartamentoFK = 100;

-- Hallar la media del número de hijos de los empleados del departamento 123.

select avg(hijosEmpleado) as mediaHijosDel122
from empleados e
where idDepartamentoFK = 122;

-- Hallar cuántos departamentos hay y el presupuesto anual medio de ellos.

select count(idDepartamento) as departamentos, avg(presupuestosDepartamento) as mediaPresupueto
from departamentos d ;

-- Hallar cuántos departamentos hay y el presupuesto anual medio de ellos para los
-- departamentos que no tienen director en propiedad.

select count(idDepartamento) as departamentos, avg(presupuestosDepartamento) as mediaPresupueto
from departamentos d 
where tipoDirectorDepartamento = 'P';

-- Para los departamentos 111 y 112, hallar la media de los años de servicio de sus
-- empleados en el día de hoy.

select avg((2025 - YEAR(fechaIngresoEmpleado))) as mediaAnhosTrabajadosEmpleados
from empleados e
where idDepartamentoFK = 111 or e.idDepartamentoFK = 112;

-- Para los departamentos 111 y 112, hallar la media de los años de servicio de sus
-- empleados hasta el día 31/12/86.



-- Hallar por orden de número de empleado el nombre y salario total (salario más
-- comisión) de los empleados cuyo salario total supera al salario mínimo en 3.000 €
-- mensuales.

-- subconsulta -- Para obtener el salario mínimo
select min(salarioEmpleado) from empleados e 

select idEmpleado, nombreEmpleado, (salarioEmpleado + comisionEmpleado) as salarioTotal
from empleados e 
where (salarioEmpleado + comisionEmpleado)- 3000 > (select min(salarioEmpleado) from empleados e)
order by idEmpleado ;

-- Para los empleados que han ingresado en la empresa en los últimos 5 años, hallar
-- la edad media en años cumplidos de la edad a la que han ingresado.

select avg(2020 - YEAR(fechaNacimientoEmpleado))as mediaAnhosEmpleados
from empleados e 
where fechaIngresoEmpleado > 2020-01-22;

-- Hallar la masa salarial anual(salario más comisión) de la empresa(se suponen 14
-- pagas anuales).

select sum((salarioEmpleado + comisionEmpleado) * 14) as masaSalarial
from empleados e ;

-- Hallar cuántos empleados han ingresado en el año actual.


-- Hallar el salario medio de los empleados cuyo salario no supera en más del 20% al
-- salario mínimo de los empleados que tienen algún hijo y su salario medio por hijo es
-- mayor que 1.000 €.

select min(salarioEmpleado) from empleados e where hijosEmpleado > 0;
select avg(salarioEmpleado/hijosEmpleado) from empleados e where hijosEmpleado > 0;
select salarioEmpleado/hijosEmpleado from empleados e where hijosEmpleado > 0;

select avg(salarioEmpleado) as salarioMedio
from empleados e 
where salarioEmpleado < ((select min(salarioEmpleado) from empleados e where hijosEmpleado > 0) * 1.2);

-- Hallar la diferencia entre el salario más alto y el más bajo.

SELECT max(salarioEmpleado) as salarioMax, min(salarioEmpleado) as salarioMin, (max(salarioEmpleado) - min(salarioEmpleado)) as diferenciaEntreSalarios from empleados e 

-- Hallar la edad media en años cumplidos en el día de hoy de los empleados que
-- tienen más de 2 hijos.

select avg(2025 - YEAR(fechaNacimientoEmpleado))as mediaAnhosEmpleadosMasDe2Hijos
from empleados e
where hijosEmpleado > 2;

-- Hallar el presupuesto medio de los departamentos cuyo presupuesto supera al
-- presupuesto medio de los departamentos.

-- subconsulta para hallar el presupuesto medio --
select avg(presupuestosDepartamento) from departamentos d;

select avg(d.presupuestosDepartamento)
from departamentos d 
where d.presupuestosDepartamento > (select avg(presupuestosDepartamento) from departamentos d);

-- CONSULTA POR AGRUPACIÓN DE FILAS 
-- GROUP BY 

-- Hallar para cada departamento el salario medio, el mínimo y el máximo.

select idDepartamentoFK, avg(salarioEmpleado) as salarioMedio, max(salarioEmpleado) as salarioMax, min(salarioEmpleado) as salarioMin
from empleados e 
group by idDepartamentoFK ;

-- Hallar por departamentos la edad en años cumplidos del empleado más viejo del
-- departamento que tiene comisión. Ordenar el resultado por edades.

select idDepartamentoFK, max(2025 - year(fechaNacimientoEmpleado)) as anhosEmpleados
from empleados e 
where comisionEmpleado > 0
group by idDepartamentoFK
order by anhosEmpleados ;

-- Agrupando por departamento y número de hijos, hallar cuántos empleados hay en
-- cada grupo.

select count(idEmpleado) as trabajadoresPorDepartamento from empleados e
group by e.idDepartamentoFK and e.hijosEmpleado ;

-- HAVING SUSTITUYE EL WHERE PERO DESPUES DE AGRUPAR

-- Hallar el salario máximo y el mínimo para cada grupo de empleados con igual
-- número de hijos y que tienen al menos uno, y sólo si hay más de un empleado en el
-- grupo y el salario máximo de éste excede a 2.000 €.

select min(salarioEmpleado) as salarioMin, max(salarioEmpleado) as salarioMax
from empleados e
group by hijosEmpleado 
having hijosEmpleado > 0;

-- Hallar el salario medio por departamento para aquellos departamentos cuyo salario
-- máximo es inferior al salario medio de todos los empleados.

select avg(salarioEmpleado) as salarioMedio
from empleados e 
group by idDepartamentoFK 
having max(salarioEmpleado) > avg(salarioEmpleado) ;

-- Hallar el salario medio y la edad media en años para cada grupo de empleados con
-- igual comisión y para los que no la tengan.

select avg(salarioEmpleado) as salarioMedio, avg(2025 - year(fechaNacimientoEmpleado)) as mediaAnhosEmpleados, comisionEmpleado, count(idEmpleado) as numeroEmpleados
from empleados e 
group by comisionEmpleado ;

-- Para los departamentos en los que la antigüedad media de sus empleados
-- superaba a la de la empresa, hallar el salario mínimo, el medio y el máximo.

-- subconsulta para calcular la antiguedad media
select avg(2025- year(fechaIngresoEmpleado)) from empleados e ;

select min(salarioEmpleado) as salarioMinimo, avg(salarioEmpleado) as mediaSalario, max(salarioEmpleado) as salarioMax
from empleados e 
group by idDepartamentoFK 
having avg(2025- year(fechaIngresoEmpleado)) > (select avg(2025- year(fechaIngresoEmpleado)) from empleados e) ;

-- Para cada departamento, hallar la media de la comisión con respecto a los
-- empleados que la reciben y con respecto al total de empleados.

select avg(comisionEmpleado), idDepartamentoFK 
from empleados e 
group by idDepartamentoFK ;

-- Para cada extensión telefónica, hallar cuántos empleados la usan y el salario medio
-- de éstos.

select count(idEmpleado) as numeroEmpleados, avg(salarioEmpleado) as salarioMedio
from empleados e 
group by extensionEmpleado ;
-- Para cada extensión telefónica y cada departamento hallar cuántos empleados la
-- usan y el salario medio de éstos.

SELECT count(extensionEmpleado) as UsoDeExtensionEmpleados, avg(salarioEmpleado) as salarioMedio, extensionEmpleado, idDepartamentoFK 
FROM empleados e 
group by extensionEmpleado, idDepartamentoFK ;

-- Hallar los números de extensión telefónica mayores de los diversos departamentos,
-- sin incluir los números de éstos.

select max(extensionEmpleado)
from empleados e 
group by idDepartamentoFK;

-- Para cada extensión telefónica, hallar el número de departamento a los que sirve.

select count(idDepartamentoFK ) as numeroDepartamentosPorExtension, extensionEmpleado 
from empleados e 
group by e.extensionEmpleado ;

-- Para los departamentos en los que algún empleado tiene comisión,hallar cuantos
-- empleados hay en promedio por cada extensión telefónica.

select count(e.idEmpleado) as empleadosPorExtension, idDepartamentoFK, extensionEmpleado 
from empleados e 
where comisionEmpleado > 0
group by extensionEmpleado, idDepartamentoFK ;

-- Obtener por orden creciente los números de extensiones telefónicas de los
-- departamentos que tienen más de dos y que son compartidas por menos de 4
-- empleados, excluyendo las que no son compartidas.

select count(extensionEmpleado) extensionesPorDepartamento, extensionEmpleado 
from empleados e 
group by extensionEmpleado 
having count(extensionEmpleado) > 2 and count(idEmpleado < 4) ;

-- Para los departamentos cuyo salario medio supera al de la empresa, hallar cuántas
-- extensiones telefónicas tienen.

-- subconsulta para hallar el salario medio de la empresa
select avg(salarioEmpleado) from empleados e ;

select count(extensionEmpleado) as extensionesPorDepartamentos
from empleados e
group by idDepartamentoFK 
having avg(salarioEmpleado) > (select avg(salarioEmpleado) from empleados e) ;
-- Para cada centro, hallar los presupuestos medios de los departamentos dirigidos
-- en propiedad y en funciones, excluyendo del resultado el número del centro.

select avg(presupuestosDepartamento) as mediaPresupuesto, idDepartamentoFK , tipoDirectorDepartamento 
from departamentos d 
group by d.idDepartamentoFK, tipoDirectorDepartamento ;

-- Hallar el máximo valor de la suma de los salarios de los departamentos.

select sum(salarioEmpleado) as sumaSalariosPorDepartamento, idDepartamentoFK 
from empleados e 
group by idDepartamentoFK ;

-- CONSULTAS SOBRE VARIAS TABLAS

-- Obtener los nombres de los departamentos que tienen un presupuesto superior a
-- 10.000.000 €, así como el nombre del centro de trabajo donde se encuentran ubicados,
-- clasificados por orden alfabético.

select d.nombreDepartamento, c.nombreCentroTrabajo, d.presupuestosDepartamento 
from departamentos d 
inner join centrostrabajo c on c.idCentroTrabajo = d.idCentroTrabajoFK 
where d.presupuestosDepartamento > 10
order by d.nombreDepartamento ;

-- Para cada departamento con presupuesto inferiora 6.000.000 €, hallar el nombre del
-- centro donde está ubicado y el máximo salario de sus empleados, si éste excede a 2.000
-- €. Clasificar alfabéticamente por nombre de departamento.

select c.nombreCentroTrabajo, e.salarioEmpleado, d.nombreDepartamento 
from departamentos d 
inner join centrostrabajo c on c.idCentroTrabajo = d.idCentroTrabajoFK 
inner join empleados e on e.idDepartamentoFK = d.idDepartamentoFK 
where d.presupuestosDepartamento < 6 and e.salarioEmpleado > 2000 
order by d.nombreDepartamento ;

-- Hallar por orden alfabético los nombres de los departamentos que dependende los
-- que tienen un presupuesto inferior a 5.000.000 €.

select nombreDepartamento 
from departamentos d 
where idDepartamentoFK is not null and presupuestosDepartamento < 5
order by nombreDepartamento ;

-- Obtener por orden alfabético los nombres y salarios medios de los departamentos
-- cuyo salario medio supera al salario medio de la empresa.

-- subconsulta para hallar la media salarial
select avg(salarioEmpleado) from empleados e;

select avg(e.salarioEmpleado) as mediaSalarial, e.idDepartamentoFK, nombreDepartamento 
from  empleados e 
inner join departamentos d on e.idDepartamentoFK = d.idDepartamento 
group by e.idDepartamentoFK, nombreDepartamento
having avg(e.salarioEmpleado) > (select avg(salarioEmpleado) from empleados e);

-- Obtener por orden alfabético los nombres de los departamentos ubicados en la calle
-- de Atocha.

select d.nombreDepartamento, c.direccionCentroTrabajo 
from departamentos d 
inner join centrostrabajo c on c.idCentroTrabajo = d.idCentroTrabajoFK
where c.direccionCentroTrabajo like '%Atocha%'
order by c.nombreCentroTrabajo ;

-- Obtener por orden alfabético los nombres de los departamentos cuyo presupuesto
-- es inferior a la mitad de la suma de los salarios anuales de sus empleados.
select sum(salarioEmpleado * 12) from empleados e 

select d.nombreDepartamento 
from empleados e 
inner join departamentos d on d.idDepartamentoFK = e.idDepartamentoFK 
where d.presupuestosDepartamento < ((select sum(salarioEmpleado * 12) from empleados e )/2)
group by d.nombreDepartamento 
order by d.nombreDepartamento ;

-- Obtener por orden alfabético los nombres de los empleados cuyo salario supera al
-- salario medio de su departamento.

-- subconsulta --
select avg(salarioEmpleado) from empleados e group by idDepartamentoFK 






-- Realizar una consulta que devuelva el departamento con menos presupuesto por empleados

select e.idDepartamentoFK, d.presupuestosDepartamento/count(*) as presupuestosDep from empleados e
inner join departamentos d on d.idDepartamento = e.idDepartamentoFK 
group by e.idDepartamentoFK
order by presupuestosDep
limit 1;

-- La dirección donde trabajan todos los Antonios

select c.direccionCentroTrabajo, e.nombreEmpleado  from centrostrabajo c
inner join departamentos d on d.idCentroTrabajoFK = c.idCentroTrabajo
inner join empleados e on e.idDepartamentoFK = d.idDepartamento 
where e.nombreEmpleado like '%Antonio%';

-- 









