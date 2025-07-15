-- nombre de los pokemon del tipo id 1

select pok_name from pokemon p 
inner join pokemon_types pt on pt.pok_id = p.pok_id
where pt.type_id = 1 ;

-- los pokemons que tienen el moviento surf y una versión especifica
select pok_name, move_name from pokemon p 
inner join pokemon_moves pm on pm.pok_id = p.pok_id 
inner join moves m on m.move_id = pm.move_id 
where move_name = 'surf' and pm.version_group_id = 1;

-- sacar de todos los pokemon su nombre y su evolución --

select pok_name, p.pok_id, pem.pok_id as evolucionId from pokemon p 
inner join pokemon_evolution_matchup pem on p.pok_id = pem.evolves_from_species_id;

select tablaPrimero.pok_name, tablaEvolucion.pok_name
from pokemon tablaPrimero
left join pokemon_evolution_matchup pem on tablaPrimero.pok_id = pem.evolves_from_species_id 
left join pokemon tablaEvolucion on tablaEvolucion.pok_id = pem.pok_id 

-- sacar la tercera evolucion

select tablaPrimero.pok_name, tablaEvolucion.pok_name, tablaEvolucionSegunda.pok_name 
from pokemon tablaPrimero
left join pokemon_evolution_matchup pem on tablaPrimero.pok_id = pem.evolves_from_species_id 
left join pokemon tablaEvolucion on tablaEvolucion.pok_id = pem.pok_id 
left join pokemon_evolution_matchup pem2 on tablaEvolucion.pok_id = pem2.evolves_from_species_id
left join pokemon tablaEvolucionSegunda on tablaEvolucionSegunda.pok_id = pem2.pok_id;

-- sacar el movimiento con más pokemon utilizados

select m.move_id, m.move_name, count(*) as numerosMovimiento from pokemon p 
inner join pokemon_moves pm on pm.pok_id = p.pok_id 
inner join moves m on m.move_id = pm.move_id 
group by m.move_id 
order by count(*) DESC 
limit 1;










