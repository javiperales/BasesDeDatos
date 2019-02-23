DROP TABLE DEPARTAMENTOS CASCADE CONSTRAINTS;
DROP TABLE ASIGNATURAS CASCADE CONSTRAINTS;
DROP TABLE ESTUDIANTES CASCADE CONSTRAINTS;
DROP TABLE PROFESORES CASCADE CONSTRAINTS;
DROP TABLE EXAMENES CASCADE CONSTRAINTS;

CREATE TABLE DEPARTAMENTOS (
   NUM_DEP INTEGER NOT NULL,
   DEPT_NOMBRE VARCHAR2(20),
   JEFE INTEGER,
   PRESUPUESTO NUMBER(10),
   GASTO_PREVISTO NUMBER(10),
   PRIMARY KEY (NUM_DEP)
);

CREATE TABLE ASIGNATURAS (
   NUM_ASIG INTEGER PRIMARY KEY,
   ASIG_NOMBRE VARCHAR2(20),
   NUM_DEP INTEGER,
   CREDITOS NUMBER(2) CHECK (CREDITOS > 0 AND CREDITOS <= 10),
   NOTA_APROBADO NUMBER(2) DEFAULT 65,
   CONSTRAINT EASIG_FK_DEPT FOREIGN KEY (NUM_DEP) REFERENCES DEPARTAMENTOS 
);

CREATE TABLE ESTUDIANTES (
   APELLIDO VARCHAR2(15) NOT NULL,
   NOMBRE VARCHAR2(15),
   FECHA_NAC DATE,
   NUM_ESTUDIANTE INTEGER PRIMARY KEY,
   NUM_DEP INTEGER,
   CURSO NUMBER(1),
   CONSTRAINT EST_FK_DEPT FOREIGN KEY(NUM_DEP) REFERENCES DEPARTAMENTOS
);

CREATE TABLE PROFESORES (
   APELLIDO VARCHAR2(15) NOT NULL,
   NOMBRE VARCHAR2(15),
   NUM_PROF INTEGER PRIMARY KEY,
   NUM_DEP INTEGER,
   NUM_ASIG INTEGER,
   CATEGORIA CHAR,
   SUELDO NUMBER(6) CHECK (SUELDO < 100000) ,
   FECHA_CONTRATO DATE,
   CONSTRAINT PROF_FK_DEPT FOREIGN KEY(NUM_DEP) REFERENCES DEPARTAMENTOS,
   CONSTRAINT PROF_FK_ASIG FOREIGN KEY(NUM_ASIG) REFERENCES ASIGNATURAS
);



CREATE TABLE EXAMENES (
   NUM_ASIG INTEGER NOT NULL,
   NUM_ESTUDIANTE INTEGER NOT NULL,
   NOTA NUMBER(3),
   FECHA DATE,
   CONSTRAINT EXAM_FK_ASIG FOREIGN KEY (NUM_ASIG) REFERENCES ASIGNATURAS,
   CONSTRAINT EXAM_FK_ESTUD FOREIGN KEY (NUM_ESTUDIANTE) REFERENCES ESTUDIANTES
);


--***************INSERTS****************************
-- en DEPARTAMENTOS

INSERT INTO DEPARTAMENTOS VALUES (1, 'Tecnologia', 9, 5780000, 6200000);
INSERT INTO DEPARTAMENTOS VALUES (2, 'Humanidades', 5, 753000, 643000);
INSERT INTO DEPARTAMENTOS VALUES (3, 'Administrativo', 3, 2510000, 1220000);
INSERT INTO DEPARTAMENTOS VALUES (4, 'F.O.L.', 2, 78000, 210000);
INSERT INTO DEPARTAMENTOS VALUES (5, 'Ciencias', 8, 4680000, 4250000);
INSERT INTO DEPARTAMENTOS VALUES (6, 'Ciencias de la Salud', 7, 6895000, 6932000);


-- en ASIGNATURAS

INSERT INTO ASIGNATURAS VALUES (1, 'Matematicas', 1, 2, 65);
INSERT INTO ASIGNATURAS VALUES (2, 'Literatura', 2, 1, 60);
INSERT INTO ASIGNATURAS VALUES (3, 'Dibujo tecnico', 1, 1, 71);
INSERT INTO ASIGNATURAS VALUES (4, 'Contabilidad', 3, 1, 67);
INSERT INTO ASIGNATURAS VALUES (5, 'Legislacion laboral', 4, 2, 52);
INSERT INTO ASIGNATURAS VALUES (6, 'Quimica', 5, 3, 57);
INSERT INTO ASIGNATURAS VALUES (7, 'Fisiologia', 6, 3, 76);
INSERT INTO ASIGNATURAS VALUES (8, 'Anatomia', 6, 1, 76);
INSERT INTO ASIGNATURAS VALUES (9, 'Electronica', 1, 3, 71);
INSERT INTO ASIGNATURAS VALUES (10, 'Marketing', 3, 2, 56);
INSERT INTO ASIGNATURAS VALUES (11, 'Heraldica', 2, 2, 60);

--en ESTUDIANTES

INSERT INTO ESTUDIANTES VALUES ('Dominguez', 'Federico', '26-11-1996', 1, 4, 2);
INSERT INTO ESTUDIANTES VALUES ('Alvarez', 'Angel', '26-11-1996', 2, 4, 2);
INSERT INTO ESTUDIANTES VALUES ('Aguado', 'Felipe', '13-07-1993', 3, 3, 1);
INSERT INTO ESTUDIANTES VALUES ('Pardo', 'Margarita', '07-12-1996', 4, 2, 1);
INSERT INTO ESTUDIANTES VALUES ('Jara', 'Gloria', '24-01-1996', 5, 2, 1);
INSERT INTO ESTUDIANTES VALUES ('Salinas', 'Guadalupe', '20-02-1997', 6, 2, 2);
INSERT INTO ESTUDIANTES VALUES ('Baena', 'Abel', '13-03-1997', 7, 4, 1);
INSERT INTO ESTUDIANTES VALUES ('Bayona', 'Jose', '19-04-1996', 8, 3, 3);
INSERT INTO ESTUDIANTES VALUES ('Maestre', 'Roberto', '23-05-1993', 9, 1, 1);
INSERT INTO ESTUDIANTES VALUES ('Gargallo', 'Hector', '21-06-1997', 10, 2, 1);
INSERT INTO ESTUDIANTES VALUES ('Godoy', 'Susana', '30-07-1994', 11, 4, 2);
INSERT INTO ESTUDIANTES VALUES ('Heredia', 'Jaime', '11-08-1995', 12, 1, 3);
INSERT INTO ESTUDIANTES VALUES ('Mendoza', 'Juan', '14-09-1997', 13, 1, 3);
INSERT INTO ESTUDIANTES VALUES ('Martinez', 'Francisco', '24-10-1994', 14, 3, 2);
INSERT INTO ESTUDIANTES VALUES ('Laguna', 'Hugo', '16-11-1997', 15, 5, 1);
INSERT INTO ESTUDIANTES VALUES ('Vives', 'Guillermo', '05-12-1995', 16, 1, 1);
INSERT INTO ESTUDIANTES VALUES ('Martinez', 'Laura', '22-11-1996', 17, 5, 1);


-- en PROFESORES

INSERT INTO PROFESORES VALUES ('Jordan', 'Roberto', 1, 1, 9, 'E', 24000, '25-03-2013');
INSERT INTO PROFESORES VALUES ('Salcedo', 'Teresa', 2, 4, 5, 'D', 31800, '30-09-2011');
INSERT INTO PROFESORES VALUES ('Nieto', 'Manuel', 3, 3, 4, 'A', 86790, '26-05-1994');
INSERT INTO PROFESORES VALUES ('Campos', 'Jose', 4, 5, 3, 'C', 43570, '23-02-2005');
INSERT INTO PROFESORES VALUES ('Ramos', 'Sara', 5, 2, 2, 'C', 40900, '01-01-2010');
INSERT INTO PROFESORES VALUES ('Fernandez', 'Gonzalo', 6, 4, 5, 'D', 34210, '28-03-1990');
INSERT INTO PROFESORES VALUES ('Pereira', 'Alfonso', 7, 6, 7, 'D', 32700, '06-02-1991');
INSERT INTO PROFESORES VALUES ('Gonzalez', 'Samuel', 8, 5, 6, 'D', 27800, '23-04-1994');
INSERT INTO PROFESORES VALUES ('Perez', 'Luis', 9, 1, 9, 'C', 36200, '01-04-2006');
INSERT INTO PROFESORES VALUES ('Sanchez', 'Maria', 10, 2, 2, 'B', 62100, '03-11-2007');
INSERT INTO PROFESORES VALUES ('Gutierrez', 'Izarbe', 11, 6, 7, 'D', 34300, '01-09-2009');
INSERT INTO PROFESORES VALUES ('Colmenar', 'Antonio', 12, 4, 5, 'C', 39100, '19-10-2002');
INSERT INTO PROFESORES VALUES ('Aznar', 'Alicia', 13, 5, 1, 'A', 80100, '15-01-2003');
INSERT INTO PROFESORES VALUES ('Quilez', 'Vicente', 14, 6, 8, 'C', 41700, '19-04-2003');
INSERT INTO PROFESORES VALUES ('Torres', 'Eduardo', 15, 3, 10, 'E', 23500, '26-05-2003');
INSERT INTO PROFESORES VALUES ('Torres', 'Eduardo', 16, 3, null, 'E', 23500, '17-06-2003');

-- en EXAMENES

INSERT INTO EXAMENES VALUES (1, 1, 76, '23-05-2014');
INSERT INTO EXAMENES VALUES (9, 1, 42, '20-05-2014');
INSERT INTO EXAMENES VALUES (3, 1, 67, '15-05-2014');
INSERT INTO EXAMENES VALUES (2, 2, 52, '05-06-2014');
INSERT INTO EXAMENES VALUES (2, 3, 89, '08-06-2014');
INSERT INTO EXAMENES VALUES (2, 3, 51, '11-05-2014');
INSERT INTO EXAMENES VALUES (4, 4, 34, '11-05-2014');
INSERT INTO EXAMENES VALUES (10, 4, 49, '26-06-2014');
INSERT INTO EXAMENES VALUES (5, 5, 62, '03-05-2014');
INSERT INTO EXAMENES VALUES (5, 6, 70, '17-05-2014');
INSERT INTO EXAMENES VALUES (5, 7, 36, '23-05-2014');
INSERT INTO EXAMENES VALUES (5, 8, 52, '20-05-2014');
INSERT INTO EXAMENES VALUES (6, 11, 73, '08-06-2014');
INSERT INTO EXAMENES VALUES (6, 9, 67, '15-05-2014');
INSERT INTO EXAMENES VALUES (6, 10, 82, '05-06-2014');
INSERT INTO EXAMENES VALUES (7, 12, 27, '11-05-2014');
INSERT INTO EXAMENES VALUES (8, 12, 56, '11-05-2014');
INSERT INTO EXAMENES VALUES (8, 13, 67, '26-06-2014');
INSERT INTO EXAMENES VALUES (7, 13, 63, '03-05-2014');
INSERT INTO EXAMENES VALUES (9, 14, 70, '23-05-2014');
INSERT INTO EXAMENES VALUES (1, 14, 60, '26-05-2014');
INSERT INTO EXAMENES VALUES (3, 14, 63, '03-06-2014');
INSERT INTO EXAMENES VALUES (6, 14, 65, '17-06-2014');
INSERT INTO EXAMENES VALUES (2, 17, 72, '18-05-2014');
INSERT INTO EXAMENES VALUES (4, 17, 80, '02-06-2014');

COMMIT;
--1
select d.num_dep, count(*) as total_dep from departamentos d, estudiantes e
where d.num_dep=e.num_dep
group by d.num_dep
order by  d.num_dep

--2
select e.num_estudiante,count(ex.num_estudiante) as examenes_realizados  from estudiantes e, examenes ex
where e.num_estudiante=ex.num_estudiante and e.apellido like 'Martinez'
group by e.num_estudiante

--3
select distinct  dep.dept_nombre, count(asig.num_dep)as asignaturas_imparten from departamentos dep, asignaturas asig
where dep.num_dep=asig.num_dep
group by dep.dept_nombre
having count(asig.num_dep)=(select max(count(asig.num_dep)) from departamentos dep, asignaturas asig
  where dep.num_dep=asig.num_dep
  group by dep.dept_nombre);




--5
select * from profesores
  where sueldo <(
    select avg(sueldo) from profesores )
    
--6
select * from examenes
where num_estudiante in (
  select num_estudiante from estudiantes
    where num_dep  in (
      select num_dep from departamentos
        where dept_nombre not like 'Administrativo'))
        
--7
select * from estudiantes 
  where num_estudiante in (
  select num_estudiante from examenes
    where nota>50
    group by * )
    
   /*SELECT E.ID_EMPLEADO,E.NOMBRE,COUNT(IP.ID_EMPLEADO) AS TOTAL
FROM EMPLEADOS E,INSPECCION_PISOS IP
WHERE E.ID_EMPLEADO=IP.ID_EMPLEADO
GROUP BY E.ID_EMPLEADO,E.NOMBRE
HAVING COUNT(IP.ID_EMPLEADO) = (SELECT MAX(COUNT(IP.ID_EMPLEADO)) 
                                FROM EMPLEADOS E,INSPECCION_PISOS IP
WHERE E.ID_EMPLEADO=IP.ID_EMPLEADO
GROUP BY E.ID_EMPLEADO,E.NOMBRE);*/

select num_estudiante , count(*) as examenes_aprobados from examenes 
where nota>=50
group by num_estudiante
  having count(*) =(select max(count(*)) from examenes
    group by num_estudiante);
    
--4
select num_asig, count(*)as numero_aprobados from examenes
  where nota>=50
  group by num_asig
  order by num_asig asc
  
--9
create table excelentes as
select * from examenes
  where nota>=76;
  select * from excelentes
  
  --10
  update examenes set nota=nota-4
    where num_asig in (
      select num_asig from profesores 
        where num_dep in (
          select num_dep from departamentos
            where dept_nombre like 'Tecnologia'))
            
--8
select num_dep, count(num_dep)as profesores_por_departamento from profesores
  group by num_dep
  having count(num_dep)>2
  order by num_dep
  
  