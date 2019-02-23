connect examen1/examen


--AND nom_residencia from residencias;

-- select i.nombre, i.id_inquilino, resi.alojamiento_solicitado
-- from inquilinos i, residencias resi
-- where resi.alojamiento_solicitado='R' between i.nombre and i.id_inquilino;


-- select h.nom_residencia from habitaciones where h.nom_residencia like 'RES%' ;

-- select  h.nom_residencia , i.nombre, i.id_inquilino
-- from habitaciones h, inquilinos i
-- where (h.nom_residencia like 'RES%') BETWEEN i.nombre and i.id_inquilino;


--6

-- select r.ciudad, r.nom_residencia, h.num_hab 
-- from residencias r
-- join habitaciones h ON r.nom_residencia=h.nom_residencia;
--ESTA BIEN

--1
-- SELECT DISTINCT ALOJAMIENTO_SOLICITADO FROM INQUILINOS;
-- SELECT count(*) AS GENTE_RESIDENCIA FROM INQUILINOS WHERE ALOJAMIENTO_SOLICITADO='R';
-- SELECT count(*) AS GENTE_PISO FROM INQUILINOS WHERE ALOJAMIENTO_SOLICITADO='P';

--3
-- SELECT CIUDAD, ID_PISO FROM PISOS WHERE CIUDAD='DUBAI';
-- SELECT ID_PISO, ID_EMPLEADO FROM INSPECCION_PISOS WHERE ID_PISO='PISO001';
-- SELECT NOMBRE, COD_POSTAL FROM EMPLEADOS WHERE ID_EMPLEADO='EMP01' OR ID_EMPLEADO='EMP02';

--9
-- SELECT max(num_hab) AS TOTAL FROM HABITACIONES WHERE nom_residencia LIKE 'RES%';


--select ID_EMPLEADO, nombre, count(ID_PISO) from empleados 

-- select count(INS.ID_PISO) AS TOTAL_HABITACIONES, INS.ID_EMPLEADO, E.NOMBRE
-- from INSPECCION_PISOS INS
-- join EMPLEADOS E  ON INS.ID_EMPLEADO=E.ID_EMPLEADO;

select distinct a.id_inquilino, i.nombre, h.nom_residencia from alquileres a
join inquilinos i on a.ID_INQUILINO=i.ID_INQUILINO
join habitaciones h on a.id_habitacion=h.id_habitacion
where a.ID_HABITACION<='HAB058' and i.ID_INQUILINO<='INQ003' ;





SELECT CIUDAD, ID_PISO 
FROM PISOS 
WHERE CIUDAD='DUBAI';



exit