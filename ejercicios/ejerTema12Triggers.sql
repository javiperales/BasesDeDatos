/*1-ejercicio 1 triggers*/
--creamos una tabla llamada auditacategorias
create table auditacategorias
( fecha varchar2(20),
id_categoria varchar2(10),
tipo_operacion varchar2(50));

create or replace trigger t_audita_categoria
after 
delete or insert on categorias
for each row

 begin
    if inserting then
        insert into auditacategorias(fecha, id_categorias, tipo_operacion)
        values(to_char(sysdate, 'DD/MM/YY*HH24:MI*')  ,:new.id_categoria    ,'inserccion' )
        
        
    elsif deleting then
        insert into audicategorias(fecha, id_categoria, tipo_operacion)
        values(to_char(sysdate, 'DD/MM/YY*HH24:MI*')  ,:old.id_categoria    ,'borrado' )
        
        
    end if;
    
    
    
    
 end;

/*ejercicio 3 examen*/
/*3)	Realiza un bloque anónimo que muestre un listado en pantalla detallando 
el importe total vendido de cada producto, el total vendido por categoría y el total vendido
por la empresa con el formato que se indica a continuación:	
Total producto (Nombre del producto):       XXXXX
Total producto (Nombre del producto):       XXXXX
             Total categoria (identificador de la categoría):    XXXXXXXXXX
Total producto (Nombre del producto):       XXXXX
---
             Total categoria (identificador de la categoría):    XXXXXXXXXX

                                       TOTAL VENTAS:        XXXXXXXXXXXXX*/ 
   declare                                     
                                       
   Cursor cur_producto is
        Select productos.id_categoria,detalles_pedidos.numero_producto, productos.nombre, 
        sum(precio*cantidad) as total_prod, productos.stock
        from detalles_pedidos join productos on detalles_pedidos.numero_producto = productos.numero_producto
        group by detalles_pedidos.numero_producto, productos.nombre, productos.stock,productos.id_categoria
        order by productos.id_categoria,detalles_pedidos.numero_producto, productos.nombre, productos.stock;
        
v_cur_producto cur_producto%rowtype;

Cursor cur_categorias is
        Select productos.id_categoria, sum(precio*cantidad) as total_cat
        from detalles_pedidos join productos on detalles_pedidos.numero_producto = productos.numero_producto
                join categorias on categorias.id_categoria = productos.id_categoria
        group by productos.id_categoria
        order by productos.id_categoria;                                      
                                       
                                       
  v_cur_categorias cur_categorias%rowtype;                                     
                                       
   v_total_vendido number;
   v_total_vendido_cat number;
   v_total_empre number;
   v_id_cat number;
   begin
   v_total_vendido:=0;
   v_total_vendido_cat:=0;
   v_total_empre:=0;
    open cur_producto;
    open cur_categorias;
    fetch cur_producto into v_cur_producto;
    v_id_cat:= v_cur_producto.id_categoria;
   while cur_producto%found loop
   -- v_total_vendido:=v_total_vendido+v_cur_producto.total_prod;
        dbms_output.put_line( '   nombre '||v_cur_producto.nombre ||'total de los productos vendidos' || v_cur_producto.total_prod );
   fetch cur_producto into v_cur_producto;
   
   if v_id_cat != v_cur_producto.id_categoria then    
     fetch cur_categorias into v_cur_categorias;
     dbms_output.put_line('total vendidode la categoria '||v_id_cat ||'**'||v_cur_categorias.total_cat);
     v_id_cat:=v_cur_producto.id_categoria;
     v_total_empre:=v_total_empre+v_cur_categorias.total_cat;   
     end if;
   end loop;
   close cur_producto;
   close cur_categorias;
   dbms_output.put_line('total gastado de la empresa' || v_total_empre);
  end; 
  
  set serveroutput on;

  /*ejercicio 4 triggers*/

create or replace trigger trigger_ejercicio3
before insert or update on clientes
for each row 
begin
if inserting then
    :new.id_cliente:=seg_id_cliente.nextval;
    :new.tipo_modificacion:='inserccion';
elsif updating then
    :new.tipo_modificacion:='actualizacion';
 end if;
 :new.modificacion_por:= user;
 :new.fecha_modificacion:=sysdate;
end;

/*crea un trigger que no permita insertar clientes nuevos en la base de datos cuyo
codigo postal no se encuentre en la tabla poblaciones*/
create or replace trigger ejer5
after insert on clientes
for each row 
declare
v_cod_postal poblaciones.cod_postal%type;
begin
select distinct cod_postal into v_cod_postal from poblaciones
where cod_postal=:new.cod_postal;
end;


create or replace trigger ejer51
before insert on clientes
for each row
declare
cursor curpob is select cod_postal from poblaciones 
    where cod_postal=:new.cod_postal;
    v_cur_pob curpob%rowtype;
    
    nohaycodpostal exception;
begin
    open curpob;
    fetch curpob into v_cur_pob;
    if curpob%notfound then
        raise nohaycodpostal;
    end if;
end;

insert into clientes (id_cliente,nombre,apellidos,cod_postal)
values(5000,'nombreprueba','apellidos','50620');

