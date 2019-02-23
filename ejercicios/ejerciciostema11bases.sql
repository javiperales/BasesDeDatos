/*1. Crear una vista DEP30 que contiene el APELLIDO, el OFICIO, y el SALARIO de los empleados de la tabla EMPLE 
del departamento 30. Después comprobar descripción y contenido.*/
create view dep30  as 
select apellido, oficio, salario from emple
  where dept_no=30;

desc dep30;

/*2. Hacer lo mismo que en el ejercicio anterior dando nombres distintos a las columnas.
Para reemplazar la vista, que ya existe al haberla creado en el ejercicio anterior, acuérdate de utilizar la sentencia OR REPLACE.*/

create or replace view dep30 (ape, ofi, sala) as
select apellido, oficio, salario from emple
  where dept_no=30;
  
  desc dep30;
  
  /*3. Crear la vista VDEP a partir de la tabla DEPART con las columnas dept_no y dnombre.
  A partir de la vista anterior cambiar el nombre del departamento 20 a ‘nuevo20’.*/
  create view vdep as
    select dept_no , dnombre from depart;
    
    update vdep
      set dnombre='nuevo20'
        where dept_no=20;
        
  /*4. Crear una vista a partir de las tablas EMPLE y DEPART que contenga las columnas EMP_NO, APELLIDO, DEPT_NO y DNOMBRE.
  Probar a insertar, a modificar y a borrar filas.*/
  create view empleDepart as
  select em.emp_no , em.apellido, dep.dept_no , dep.dnombre from emple em join depart dep on em.dept_no=dep.dept_no;
  
  --select * from empledepart;
 --desc empledepart; 
 
insert into empleDepart values (1111,'apellido', 22 , 'dep111');

--cuando una vista esta generada a partir de varias tablas, da error al insertar , borrar y actualizar datos
  update empleDepart 
    set dept_no=10 where apellido='JIMENO'
    
    
/*5. Crear una vista llamada pagos a partir de las filas de la tabla EMPLE, cuyo departamento sea el 10.
Las columnas de la vista se llamarán NOMBRE, SAL_MES. SAL_AN y DEPT_NO. El NOMBRE es la columna APELLIDO,
al que aplicamos la función INITCAP(), SAL_MES es el SALARIO, SAL_AN es el salario*12.
Modificar individualmente cada columna y ver qué ocurre.*/

create view pagos (nombre, sal_mes,sal_an, dept_no) as
  select initcap(apellido), salario, salario*12, dept_no from emple 
    where dept_no=10
  
  select * from pagos;  
  
  desc pagos;
  
  /*6. Crear la vista VMEDIA a partir de las tablas EMPLE y DEPART. La vista contendrá por cada departamento el número de departamento,
el nombre, la media de salario y el máximo salario.
Visualizar su contenido y tratar de borrar filas, insertar y modificar.*/

create view vmedia(dept_no, nombre, salario_medio, salario_maximo) as
  select d.dept_no ,d.dnombre, avg(em.salario), max(salario) from emple em join depart d on em.dept_no=d.dept_no
  group by d.dept_no, d.dnombre, em.apellido
  
  select * from vmedia;
  desc vmedia;

  /*6. Crear la vista VMEDIA a partir de las tablas EMPLE y DEPART. La vista contendrá por cada departamento el número de departamento,
el nombre, la media de salario y el máximo salario.
Visualizar su contenido y tratar de borrar filas, insertar y modificar.*/

create view vmedia(dept_no, nombre, salario_medio, salario_maximo) as
  select d.dept_no ,d.dnombre,round(nvl(avg(em.salario),0),1), max(salario) from emple em join depart d on em.dept_no=d.dept_no
  group by d.dept_no, d.dnombre, em.apellido
  
  select * from vmedia;
  desc vmedia;
  
  drop view vmedia;
  


/*create or replace view vmedia(dept_no,nombre,salario_med,salario_max) as 
select d.dept_no,d.dnombre,round(nvl(avg(e.salario),0),1),max(salario)
from depart d
left outer join emple e on e.dept_no = d.dept_no
group by d.dept_no,d.dnombre
order by d.dept_no asc;*/

7--
create synonym t11.departamentos for t11.depart;
8--
create synonym T11.conser for T11.vmedia;
9--
CREATE USER administrador IDENTIFIED BY admin
DEFAULT TABLESPACE USERS 
TEMPORARY TABLESPACE TEMP
QUOTA 500K on USERS;

USERNAME                          USER_ID CREATED
------------------------------ ---------- -------- 
ADMINISTRADOR                          54 10/03/16

12--

create session to administrador;
13--

alter user administrador
identified by admi;
14--
alter user administrador account lock;

15-16--

grant create user to administrador;


CREATE USER prueba00 IDENTIFIED BY prueba00
DEFAULT TABLESPACE USERS 
TEMPORARY TABLESPACE TEMP
QUOTA 500K on USERS;

17--

CREATE USER prueba1 IDENTIFIED BY prueba1
DEFAULT TABLESPACE USERS 
TEMPORARY TABLESPACE TEMP;
grant connect to prueba1;
grant create table to prueba1;
grant resource to prueba1;

18--

alter USER prueba1 IDENTIFIED BY prueba1
DEFAULT TABLESPACE USERS 
TEMPORARY TABLESPACE TEMP
QUOTA 500K on users;

19--
alter user prueba1 identified by pru1
default tablespace users
temporary tablespace temp
quota 500k on users;

grant alter profile to prueba1;
grant alter tablespace to prueba1;
grant alter user to prueba1;


20--
--en system 
alter user administrador account unlock;
grant alter user to administrador;
grant alter tablespace to administrador;
grant alter profile to administrador;
grant create user to administrador;
  grant create session to ora1;
    grant create table to ora1;

create user ora1 identified by ora1
default tablespace users
temporary tablespace temp
quota 500k on users;

--en ora1
create table prueba (
nombre varchar2(20),
apellido varchar2(20))
insuficientes privilegios

/*21*/
grant drop user to administrador;
drop user ora1;

/*22*/
select * from dba_sys_privs
  where privilege like 'CREATE USER'
  -- la opcion admin option significa si puede dar permisos a otros usuarios

  /*23*/
  select * from dba_sys_privs
  where privilege like 'CREATE SESSION'

  /*24*/
  alter user hr account unlock;
  select * from user_tables;

  /*25*/
grant connect to oracle4;
grant resource to oracle4;
grant select on hr.employees to oracle4;

  create table nombres (
nombre varchar2(20),
apellidos varchar2(20))

/*26*/
-- en usuario oracle4
create table employees as (
select * from hr.employees)

select * from hr.employees;
/*27*/
--en usuarui oracle4 
select * from hr.countries;
no, tabla no existente

/*28*/
grant insert on hr.countries to oracle4;

/*29*/
insert into hr.countries(country_id,country_name) values ('ES','España');
/*30*/
--en system
grant delete hr.countries to oracle4;

delete hr.countries where
country_id like 'ES'

/*31*/
--desde usuario hr
create table pais as 
select * from countries
 /*32*/

grant drop any table to oracle4;
 drop table hr.pais
 /*33*/
 grant all on oracle4.employees to public 

  /*34*/
  create table tabla2 (
campo1 varchar2(15),
campo2 varchar2(15),
campo3 varchar2(15));
  grant update(campo2) on oracle4.tabla2 to hr;
    update  oracle4.tabla2 set campo2 ='zz';
commit;

/*35*/
drop table hr.countries cascade constraint;

/*36*/
grant create user , grant any privilege, grant any object privilege to oracle4;
/*37*/
create user oracle4a identified by oracle4a 
default tablespace users
quota unlimited on users;

grant select on hr.jobs to oracle4a;
grant update (country_name) on hr.countries to public;

  /*38*/
  select * from user_tab_privs

  /*39*/
select * from dba_sys_privs
  where grantee like 'ORACLE4A'
  -- no hay ningun resultado
  /*40*/
  create role administrador
    -- no tiene privilegios
    /*41*/
    create role administrador;
    --en usuario system no deja por que tiene el mismo nombre que un usuario

    /*42*/
    select * from dba_sys_privs
  where privilege like 'CREATE ROLE'

    GRANTEE                        PRIVILEGE                                ADMIN_OPTION
------------------------------ ---------------------------------------- ------------
DBA                            CREATE ROLE                              YES          
EXAMENSORPRESA                 CREATE ROLE                              YES          
LLAMADAS                       CREATE ROLE                              YES          
BD2PERALES                     CREATE ROLE                              YES          
TABLAEMPLEADOS                 CREATE ROLE                              YES          
SYS                            CREATE ROLE                              NO           
IMP_FULL_DATABASE              CREATE ROLE                              NO           
EXAMEN2EV2017                  CREATE ROLE                              YES          
VENTAS                         CREATE ROLE                              YES          
EJERCICIOS_1                   CREATE ROLE                              YES          
EXAMENPRUEBA                   CREATE ROLE                              YES          
APEX_040000                    CREATE ROLE                              NO           
PROPIESTARIOSYANIMALES         CREATE ROLE                              NO           
TEMA11                         CREATE ROLE                              YES          
ORACLE4                        CREATE ROLE                              NO           

 15 filas seleccionadas 

/*43*/
  create role admin;
    grant create session ,  create user ,  create role to admin;
  grant admin to administrador
    /*44*/
     create role admin;
  grant create session ,  create user ,  create role to admin;
  grant admin to administrador

    /*45*/
    select * from dba_sys_privs
  where grantee like 'ADMINISTRADOR'

GRANTEE                        PRIVILEGE                                ADMIN_OPTION
------------------------------ ---------------------------------------- ------------
ADMINISTRADOR                  ALTER USER                               NO           
ADMINISTRADOR                  CREATE SESSION                           NO           
ADMINISTRADOR                  ALTER PROFILE                            NO           
ADMINISTRADOR                  ALTER TABLESPACE                         NO           
ADMINISTRADOR                  CREATE USER                              NO           
ADMINISTRADOR                  DROP USER                                NO           

 6 filas seleccionadas 

   REVOKE ALTER USER FROM ADMINISTRADOR;
   REVOKE ALTER USER FROM ADMINISTRADOR;
  REVOKE CREATE SESSION FROM ADMINISTRADOR;
  REVOKE ALTER PROFILE FROM ADMINISTRADOR;
  REVOKE ALTER TABLESPACE FROM ADMINISTRADOR;
  REVOKE DROP USER FROM ADMINISTRADOR;
  REVOKE CREATE USER FROM ADMINISTRADOR;
  grant admin to administrador

/*46*/
create role opera_jobs;


grant insert any table to opera_jobs;
grant select any table to opera_jobs;
grant drop any table to opera_jobs;
grant create user to opera_jobs;

grant insert  on hr.jobs to opera_jobs;
grant select on hr.jobs to opera_jobs;
grant delete on hr.jobs to opera_jobs; 
grant create user on hr.jobs to opera_jobs;

  /*47*/
select * from dba_sys_privs
  where grantee like 'opera_jobs' 

/**48/
create user oracle5 identified by oracle5
default tablespace users
quota unlimited on users;

grant opera_jobs to oracle4 , oracle5
  insert into hr.jobs values ('SA_TA','XXXXX',200,9000);
--si deja

/*49*/
revoke create user from opera_jobs;
/*50*/
revoke opera_jobs from oracle5

/*51*/
drop role opera_jobs
role OPERA_JOBS borrado.
/*52*/
  no hay limite de sesiones
  no hay tiempo de actividad
  no hay tiempo de inactividad
  hay un maximo de 10 intentos

/*53*/
grant create profile to administrador;

create profile pruebas1
limit sessions_per_user 2
idle_time 2
failed_login_attempts 2;

/*54*/
alter user oracle4
profile pruebas1

/*55*/

alter profile pruebas1
limit idle_time 3
conect_time 400;

/*56*/
select * from dba_profiles
where profile like 'PRUEBAS1'

/*57*/
drop profile pruebas1 cascade;