alter table empleados2 add(foreign key(mgr) references empleados2(dni));
/*ejercicio1 crea un trigger sobre la tabla emp para que no se permita que un empleado sea jefe(mgr) de mas 
de cinco empleados*/

create or replace trigger prueba11
before insert on empleados2
for each row 
declare
supervisa integer;
begin
select count(*) into supervisa from empleados2 where mgr = :new.mgr;
if(supervisa > 4) then
    raise_application_error(-20600, :new.mgr || 'no se puede superar mas de 5');
end if;
end;

/* ejercicio2 crea un trigger para impedir que se aumente el salario de un empleado en mas de un 20%*/

create or replace trigger prueba22
before insert or update on empleados2
for each row
begin
if(:new.salario> :old.salario*1.20) then
    raise_application_error(-20611, :new.salario || 'no puede se puede aumentar mas de un 20%');
    end if;
    end;

   /*ejercicio3 crea una tabla que inserte una fila en la tabla empleados cuando se borra una fila en la tabla empleados
#los datos ue se insertan son correspondientes al empleado que se da de baja en la tabla salgo en las columnas usuario
y fecha que se grabaran del sistema user y sysdate
#el comando que dispara el trigger es after delete
*/

create table empleados_baja
(
dni char(4) primary key,
nomemp varchar2(15),
mgr char(4),
salario integer,
usuario varchar2(15),
fecha date);


create or replace trigger bajas1
after delete on empleados2
for each row
begin
insert into empleados_baja
values(:old.dni, :old.nomemp,:old.mgr,:old.salario, user, sysdate);
end;

/*ejercicio7 creamos un trigger que se active cuando modificamos algun campo en la tabla empleados2
y almacene en otra tabla 'control cambios' el nombre del usuario, que realiza la actualizacion , la fecha,
el dato que se cambia y el nuevo valor*/

create or replace trigger ejer7
before insert or delete or update on empleados2
for each row
begin
    if updating('dni') then
        insert into control_cambios values (user,sysdate,:old.dni, :new.dni);
        end if;
     if updating('nomemp') then
        insert into control_cambios values (user,sysdate,:old.nomemp, :new.nomemp);
        end if;
     if updating('mgr') then
        insert into control_cambios values (user,sysdate,:old.mgr, :new.mgr);
        end if;
    if updating('salario') then
        insert into control_cambios values (user,sysdate,:old.salario, :new.salario);
        end if;
        
    if inserting then
        insert into control_cambios values (user,sysdate,null,:new.documento);
        end if;
  if deleting  then
    insert into control_cambios values (user,sysdate,:old.documento,null);
    end if;
end;


/*ejercicio 8 el disparador tr_actualizar_pecio_libros* debe de cntrolar
el precio que se esta actualizando, si supera los 50 euros, se debe de redondear a tal valor entero hacia abajo 
empleando("floor")*/

create or replace trigger tr_actualizar_precio_libros
before update of precio_libro on libros
for each row
if(:new.precio_libro>50) then
    :new.precio_libro:=floor(:new.precio_libro);
    end if;
    insert into control values(user,sysdate,:new.codigo,:old.precio,:new.precio);
    end tr_actualizar_precio_libros;

