-- ******** TABLA DEPART: ***********

DROP TABLE DEPART cascade constraints; 

CREATE TABLE DEPART (
 DEPT_NO  NUMBER(2) NOT NULL,
 DNOMBRE  VARCHAR2(14), 
 LOC      VARCHAR2(14) ) ;

INSERT INTO DEPART VALUES (10,'CONTABILIDAD','SEVILLA');
INSERT INTO DEPART VALUES (20,'INVESTIGACI�N','MADRID');
INSERT INTO DEPART VALUES (30,'VENTAS','BARCELONA');
INSERT INTO DEPART VALUES (40,'PRODUCCI�N','BILBAO');
COMMIT;


-- ******** TABLA EMPLE: *************

ALTER SESSION SET NLS_DATE_FORMAT='DD/MM/YYYY';

DROP TABLE EMPLE cascade constraints; 

CREATE TABLE EMPLE (
 EMP_NO    NUMBER(4) NOT NULL,
 APELLIDO  VARCHAR2(10)  ,
 OFICIO    VARCHAR2(10)  ,
 DIR       NUMBER(4) ,
 FECHA_ALT DATE      ,
 SALARIO   NUMBER(10),
 COMISION  NUMBER(10),
 DEPT_NO   NUMBER(2) NOT NULL) ;

INSERT INTO EMPLE VALUES (7369,'S�NCHEZ','EMPLEADO',7902,'17/12/1980',
                        104000,NULL,20);
INSERT INTO EMPLE VALUES (7499,'ARROYO','VENDEDOR',7698,'20/02/1980',
                        208000,39000,30);
INSERT INTO EMPLE VALUES (7521,'SALA','VENDEDOR',7698,'22/02/2001',
                        162500,65000,30);
INSERT INTO EMPLE VALUES (7566,'JIM�NEZ','DIRECTOR',7839,'02/04/2001',
                        386750,NULL,20);
INSERT INTO EMPLE VALUES (7654,'MART�N','VENDEDOR',7698,'29/09/2001',
                        162500,182000,30);
INSERT INTO EMPLE VALUES (7698,'NEGRO','DIRECTOR',7839,'01/05/2001',
                        370500,NULL,30);
INSERT INTO EMPLE VALUES (7782,'CEREZO','DIRECTOR',7839,'09/06/2001',
                        318500,NULL,10);
INSERT INTO EMPLE VALUES (7788,'GIL','ANALISTA',7566,'09/11/2001',
                        390000,NULL,20);
INSERT INTO EMPLE VALUES (7839,'REY','PRESIDENTE',NULL,'17/11/2001',
                        650000,NULL,10);
INSERT INTO EMPLE VALUES (7844,'TOVAR','VENDEDOR',7698,'08/09/2001',
                        195000,0,30);
INSERT INTO EMPLE VALUES (7876,'ALONSO','EMPLEADO',7788,'23/09/2001',
                        143000,NULL,20);
INSERT INTO EMPLE VALUES (7900,'JIMENO','EMPLEADO',7698,'03/12/2001',
                        123500,NULL,30);
INSERT INTO EMPLE VALUES (7902,'FERN�NDEZ','ANALISTA',7566,'03/12/2001',
                        390000,NULL,20);
INSERT INTO EMPLE VALUES (7934,'MU�OZ','EMPLEADO',7782,'23/01/1992',
                        169000,NULL,10);

COMMIT;

-- ******** TABLA NOTAS_ALUMNOS: ***********

Drop table notas_alumnos cascade constraints;

create table notas_alumnos
 (
   NOMBRE_ALUMNO VARCHAR2(25) NOT NULL ,
   nota1 number(2),
   nota2 number(2),
   nota3 number(2)
 ) ;
 
insert into NOTAS_ALUMNOS VALUES ('Alcalde Garc�a, M. Luisa',5,5,5);
insert into NOTAS_ALUMNOS VALUES ('Benito Mart�n, Luis',7,6,8);
insert into NOTAS_ALUMNOS VALUES ('Casas Mart�nez, Manuel',7,5,5);
insert into NOTAS_ALUMNOS VALUES ('Corregidor S�nchez, Ana',6,9,8);
insert into NOTAS_ALUMNOS VALUES ('D�az S�nchez, Mar�a',NULL,NULL,7);
COMMIT;

-- ******** TABLA LIBRERIA: *************

Drop table LIBRERIA cascade constraints;

create table LIBRERIA
 (TEMA CHAR(15) NOT NULL ,
  ESTANTE CHAR(1),
  EJEMPLARES NUMBER(2)
 ) ;

INSERT INTO LIBRERIA VALUES ('Inform�tica', 'A',15);
INSERT INTO LIBRERIA VALUES ('Econom�a',    'A',10);
INSERT INTO LIBRERIA VALUES ('Deportes',    'B',8);
INSERT INTO LIBRERIA VALUES ('Filosof�a',   'C',7);
INSERT INTO LIBRERIA VALUES ('Dibujo',      'C',10);
INSERT INTO LIBRERIA VALUES ('Medicina',    'C',16);
INSERT INTO LIBRERIA VALUES ('Biolog�a',    'A',11);
INSERT INTO LIBRERIA VALUES ('Geolog�a',    'D',7);
INSERT INTO LIBRERIA VALUES ('Sociedad',    'D',9);
INSERT INTO LIBRERIA VALUES ('Labores',     'B',20);
INSERT INTO LIBRERIA VALUES ('Jardiner�a',    'E',6);
COMMIT;

-- ******** TABLAS ALUMNOS, ASIGNATURAS, NOTAS: ***********

DROP TABLE ALUMNOS cascade constraints;

CREATE TABLE ALUMNOS
(
  DNI VARCHAR2(10) NOT NULL,
  APENOM VARCHAR2(30),
  DIREC VARCHAR2(30),
  POBLA  VARCHAR2(15),
  TELEF  VARCHAR2(10)  
) ;

DROP TABLE ASIGNATURAS cascade constraints;

CREATE TABLE ASIGNATURAS
(
  COD NUMBER(2) NOT NULL,
  NOMBRE VARCHAR2(25)
) ;

DROP TABLE NOTAS cascade constraints;

CREATE TABLE NOTAS
(
  DNI VARCHAR2(10) NOT NULL,
  COD NUMBER(2) NOT NULL,
  NOTA NUMBER(2)
) ;

INSERT INTO ASIGNATURAS VALUES (1,'Prog. Leng. Estr.');
INSERT INTO ASIGNATURAS VALUES (2,'Sist. Inform�ticos');
INSERT INTO ASIGNATURAS VALUES (3,'An�lisis');
INSERT INTO ASIGNATURAS VALUES (4,'FOL');
INSERT INTO ASIGNATURAS VALUES (5,'RET');
INSERT INTO ASIGNATURAS VALUES (6,'Entornos Gr�ficos');
INSERT INTO ASIGNATURAS VALUES (7,'Aplic. Entornos 4�Gen');

INSERT INTO ALUMNOS VALUES
('12344345','Alcalde Garc�a, Elena', 'C/Las Matas, 24','Madrid','917766545');

INSERT INTO ALUMNOS VALUES
('4448242','Cerrato Vela, Luis', 'C/Mina 28 - 3A', 'Madrid','916566545');

INSERT INTO ALUMNOS VALUES
('56882942','D�az Fern�ndez, Mar�a', 'C/Luis Vives 25', 'M�stoles','915577545');

INSERT INTO NOTAS VALUES('12344345', 1,6);
INSERT INTO NOTAS VALUES('12344345', 2,5);
INSERT INTO NOTAS VALUES('12344345', 3,6);

INSERT INTO NOTAS VALUES('4448242', 4,6);
INSERT INTO NOTAS VALUES('4448242', 5,8);
INSERT INTO NOTAS VALUES('4448242', 6,4);
INSERT INTO NOTAS VALUES('4448242', 7,5);

INSERT INTO NOTAS VALUES('56882942', 4,8);
INSERT INTO NOTAS VALUES('56882942', 5,7);
INSERT INTO NOTAS VALUES('56882942', 6,8);
INSERT INTO NOTAS VALUES('56882942', 7,9);

COMMIT;

-- ******** FIN ***********************


--94) Visualiza	 el	 salario	 medio	 de	 cada	 departamento	 junto	 con	 el	 n�mero	 de departamento.
select round(avg(salario)) as salario , depart.dept_no from depart join  emple  on depart.dept_no=emple.dept_no
group by  depart.dept_no;
--95) A	 partir	 de	 la	 tabla	 EMPLE	 visualizar	 el	 n�mero	 de	 vendedores	 del	 departamento �VENTAS�.
select count(oficio) as numero_empleados from emple join  depart using (dept_no)
  where dnombre like 'VENTAS' and oficio like 'VENDEDOR';
  
--96) Partiendo	 de	 la	 tabla	 EMPLE,	 visualizar	 por	 cada	 oficio	 de	 los	 empleados	 del departamento	�VENTAS�	la	suma	de	salarios

select emple.oficio, sum(salario) from emple join depart using (dept_no) 
  where dnombre like 'VENTAS'
  GROUP BY oficio, salario;

--97) Seleccionar	 aquellos	 apellidos	 de	 la	 tabla	 EMPLE	 cuyo	 salario	 sea	 igual	 a	 la media	de	su	salario	en	su	departamento.

select apellido, salario from emple
  where (salario, dept_no) in
    ( select avg(salario) , dept_no
      from emple
        group by dept_no);
        
--98) Visualiza	el	n�mero	de	empleados	que	tiene	cada	departamento.
select count(emp_no), dept_no as numero_empleados  from emple join depart using (dept_no)
  group by  dept_no;
  
--99) Visualiza	 el	 n�mero	 de	 empleados	 de	 cada	 departamento	 cuyo	 oficio	 sea �EMPLEADO�.
select count(emp_no), oficio from emple join depart using (dept_no)
  where oficio like 'EMPLEADO'
  group by dept_no , oficio;
  
--100) Visualiza	 el	 n�mero	 de	 departamento	 del	 departamento	 que	 tenga	 m�s	empleados
select * from (
  select count(emp_no), dept_no from emple 
    group by  dept_no
    order by sum(emp_no) desc )
    where rownum=1;
    
--101) Buscar	 los	 departamentos que	 tienen	 m�s	 de	 dos	 personas	 trabajando	 en	 la	misma profesi�n
select dept_no , count(*) as numero_empleados from emple
  group by dept_no, oficio
  having count(*)>2;
  
--102) Dada	la	tabla	LIBRER�A	visualizar	por	cada	estante	la	suma	de	los	ejemplares.
select estante , sum(ejemplares)
from libreria
group by estante;

--103) Visualizar	el	estante con	m�s	ejemplares	de	la	tabla	LIBRER�A.

select * from (select estante , sum(ejemplares)
from libreria
group by estante
order by estante) 
where rownum=1 ; 