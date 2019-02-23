
connect examen1/examen

--1 muestra los tipos de alojamientos que se pueden solicitar
--y el numero de inquilinos que ha solicitado cada uno. (0,5 PUNTOS)
select  alojamiento_solicitado, COUNT(*)
	from inquilinos
	group by alojamiento_solicitado;

--2 muestra el nombre, id_inquilino y nombre de la RESIDENCIA, de los inquilinos que han vivido en residencias. (0,5 PUNTOS)
select distinct nombre, id_inquilino, nom_residencia
	from inquilinos
	  join alquileres using (id_inquilino)
	  join habitaciones using (id_habitacion)
	  join residencias using (nom_residencia);

--3 muestra el nombre y codigo postal de los empleados que han inspeccionado pisos situados en DUBAI CIUDAD, no subconsultas(0,5PTS)

select DISTINCT empleados.nombre,empleados.cod_postal
	from empleados,inspeccion_pisos,pisos
	where empleados.id_empleado=inspeccion_pisos.id_empleado AND inspeccion_pisos.id_piso=pisos.id_piso 
	AND pisos.ciudad='Dubai';

--4 muestra el id_empleado de los empleados que han inspeccionado el piso donde ha tenido alquilada una habitacion ROBERTO BLANES
--SOLO SUBCONSULTAS. 1 PUNTO.

select id_empleado
	from inspeccion_pisos
	where id_piso in(
	    select id_piso
	    from habitaciones
	    where id_habitacion in(
	        select id_habitacion
	        from alquileres
	        where id_inquilino in(
	            select id_inquilino
	            from inquilinos
	            where nombre like '%Roberto%' AND apellido like '%Blanes%'
	            )
	        )
	    );

--5A id_empleado, nombre y numero de habitaciones que ha supervisado cada empleado.(0,5 PUNTOS)

--5B id_Empleado, nombre y numero de habitaciones supervisadas del empleado que mas habitaciones ha supervisado. (1PUNTO)

--6 nombre de la residencia, numero habitaciones que tiene cada una y la ciudad donde están. 1PUNTO.

select nom_residencia,n_habitaciones, ciudad
	from (select count(*)||' habitaciones' as n_habitaciones,nom_residencia
	      from habitaciones
	      where nom_residencia not like 'null'
	      group by nom_residencia)
	join residencias using (nom_residencia);

--7 nombre inquilinos, id de habitacion que han ocupado, alquiler por semestre y ciudad donde está la habitación, de los 
--inquilinos que han vivido en las habitaciones mas baratas de (1.5 PUNTOS)

select distinct id_habitacion, i.nombre, alquiler_semestre, p.ciudad
	from habitaciones
		join alquileres a using (id_habitacion)
		join inquilinos i using (id_inquilino)
		join pisos p using (id_piso)
	where alquiler_semestre=(select min_alq
	                          from (select alquiler_semestre as min_alq
	                                from habitaciones
					where id_piso not like 'null'
	                                group by alquiler_semestre
	                                order by alquiler_semestre asc)
	                          where rownum<2);

--8 nombre y apellidos de los inquilinos e id de piso de los que han vivido en el/los pisos que tienen mas habitaciones (1,5PTS)

select distinct i.nombre,i.apellido,id_piso,id_habitacion
	from habitaciones
	 join alquileres a using (id_habitacion)
	 join inquilinos i using (id_inquilino)
	where id_piso in(select id_piso
	                from pisos
	                where num_habitaciones=(select max_habitaciones
	                                        from (select num_habitaciones as max_habitaciones
	                                              from pisos
	                                              order by num_habitaciones desc)
	                                        where rownum<2)   
	                );

--9 nombre de la residencia qe más habitaciones tiene. (1PUNTO)

select n_habitaciones,nom_residencia
	from (select count(*)as n_habitaciones,nom_residencia
	      from habitaciones
	      where nom_residencia not like 'null'
	      group by nom_residencia
	      order by n_habitaciones desc)
	where rownum<2;

--10 nombre y apellido del inquilino que más dias se ha alojado en habitaciones de Booking Airlines. (1PUNTO)

select nombre,apellido
	from inquilinos
	where id_inquilino in(select id_inquilino
	                      from (select id_inquilino, sum(total_dias) as total
	                            from (select id_inquilino, id_habitacion, (fecha_salida-fecha_inicio) as total_dias 
	                                  from alquileres)
	                            group by id_inquilino
	                            order by sum(total_dias) desc)
	                      where rownum<2);


exit