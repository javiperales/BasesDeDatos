CREATE OR REPLACE PROCEDURE VER_PEDIDO
AS
    CURSOR CUR1 IS
        SELECT Distinct CLI.APELLIDOS,PED.FECHA_PEDIDO
        FROM CLIENTES CLI JOIN PEDIDOS PED
        ON PED.ID_CLIENTE=CLI.ID_CLIENTE
        GROUP BY CLI.APELLIDOS,PED.FECHA_PEDIDO
        ORDER BY CLI.APELLIDOS,PED.FECHA_PEDIDO;
        V_REG_C_PEDIDO CUR1%ROWTYPE;
BEGIN
    OPEN CUR1;
    FETCH CUR1 INTO V_REG_C_PEDIDO;
    WHILE CUR1%FOUND LOOP
         DBMS_OUTPUT.PUT_LINE('APELLIDOS: '||V_REG_C_PEDIDO.APELLIDOS||' FECHA DE PEDIDO: '|| V_REG_C_PEDIDO.FECHA_PEDIDO);
        FETCH CUR1 INTO V_REG_C_PEDIDO;
    END LOOP;
    CLOSE CUR1;
END VER_PEDIDO;

--set serveroutput on;
execute VER_PEDIDO;
        
/*2*/
/*2-codificar un procedimiento que muestre la descripcion de cada categoria 
y el numero de productos que tiene*/

create or replace procedure ejer2
is
cursor cur2 is select categorias.descripcion, count(productos.numero_producto) as cantidad from
   categorias, productos
   where categorias.id_categoria=productos.id_categoria
    group by categorias.descripcion;
    
    v_cur2 cur2%rowtype;
    
    begin
        open cur2;
        fetch cur2 into v_cur2;
        while cur2%found loop
      
            dbms_output.put_line(v_cur2.descripcion ||'**' || v_cur2.cantidad);
         fetch cur2 into v_cur2;
        end loop;
        close cur2;
        dbms_output.put_line('*************************************');
          for v_cur2 in cur2 loop
            dbms_output.put_line(v_cur2.descripcion ||'**' || v_cur2.cantidad);
            end loop;
            
          
    end;
    execute ejer2;
    
/*3*/
/*escribir un procedimiento que reciba una cadena y visualice el apellido y el
identificador de empleado de todos los empleados cuyo apellido contenga la cadena especificada
Al finalizar visualizar el numero de empleados mostrado*/
    create or replace procedure ejer3 (p_apellido EMPLEADOS.APELLIDOS%type)
    is
    cursor cur3 is select apellidos, id_empleado from empleados
         where apellidos like '%'|| p_apellido ||'%';
    v_cur3 cur3%rowtype;
    v_cont number;
    begin 
    v_cont:=0;
    open cur3;
    fetch cur3 into v_cur3;
        while cur3%found loop
            dbms_output.put_line(v_cur3.id_empleado ||'***' || v_cur3.apellidos);
            v_cont:=v_cont+1;
            fetch cur3 into v_cur3;
        end loop;
        dbms_output.put_line(v_cont);
        close cur3;
    end;
    execute ejer3('Viescas');

/*4*/
create or replace procedure ejer4
as
cursor cur4 is select clientes.apellidos, sum(pedidos.precio_total) as total_gastado from clientes,
pedidos where clientes.id_cliente=pedidos.id_cliente
    group by clientes.apellidos
    order by sum(pedidos.precio_total) desc;
    
    v_cur4 cur4%rowtype;
    begin
    open cur4;
    for cont in 0..4 loop
     fetch cur4 into v_cur4;
    exit when cur4%notfound;
        DBMS_OUTPUT.PUT_LINE (v_cur4.apellidos ||'**' || v_cur4.total_gastado);
    end loop;
    close cur4;
    end;

    execute ejer4;
        /*ejer4*/
        /*escribir un programa que visualice el apellido y el total gastado de los cinco clientes
que mas han gastado*/

create or replace procedure ejer4
as
cursor cur4 is select clientes.apellidos, sum(pedidos.precio_total) as total_gastado from clientes,
pedidos where clientes.id_cliente=pedidos.id_cliente
    group by clientes.apellidos
    order by sum(pedidos.precio_total) desc;
    
    v_cur4 cur4%rowtype;
    v_cont number;
begin
v_cont:=0;
    open cur4; 
    fetch cur4 into v_cur4;
    while cur4%found and  v_cont<5 loop
        DBMS_OUTPUT.PUT_LINE (v_cur4.apellidos ||'**' || v_cur4.total_gastado);
        v_cont:=v_cont+1;
         fetch cur4 into v_cur4;
      END LOOP;
close cur4;
end;
execute ejer4;

create or replace procedure ejer4
as
cursor cur4 is select clientes.apellidos, sum(pedidos.precio_total) as total_gastado from clientes,
pedidos where clientes.id_cliente=pedidos.id_cliente
    group by clientes.apellidos
    order by sum(pedidos.precio_total) desc;
    
    v_cur4 cur4%rowtype;
    begin
     open cur4;
     for cont in 0..4 loop
        fetch cur4 into v_cur4;
        exit when cur4%notfound;
        DBMS_OUTPUT.PUT_LINE (v_cur4.apellidos ||'**' || v_cur4.total_gastado);
    end loop;
    close cur4;
end;
    execute ejer4;
/*5*/
    create or replace procedure EJERCICIO5
as 
    cursor CUR1 is
    select NOMBRE,ID_CATEGORIA,sum(CANTIDAD)as SUMA
    from PRODUCTOS join DETALLES_PEDIDOS using(NUMERO_PRODUCTO)
    group by NOMBRE,ID_CATEGORIA
    order by ID_CATEGORIA,SUMA asc;
    V_REG_DATOS CUR1%ROWTYPE;
    CONTADOR NUMBER;
    V_ID_CAT PRODUCTOS.ID_CATEGORIA%type;

begin
    open CUR1;
    fetch CUR1 into V_REG_DATOS;
    while CUR1%FOUND loop
    V_ID_CAT:=V_REG_DATOS.ID_CATEGORIA;
    CONTADOR:=0;
        while CUR1%FOUND and V_REG_DATOS.ID_CATEGORIA=V_ID_CAT loop
            CONTADOR:=CONTADOR + 1;
            if CONTADOR <=2 then
                DBMS_OUTPUT.PUT_LINE('PRODUCTO '||CONTADOR||' DE LA CATEGORIA '||V_REG_DATOS.ID_CATEGORIA);
                DBMS_OUTPUT.PUT_LINE('         '||V_REG_DATOS.NOMBRE ||' -- '||V_REG_DATOS.ID_CATEGORIA||' -- '||V_REG_DATOS.SUMA);
            end if;
        fetch CUR1 into V_REG_DATOS;
        end loop;
    end loop;
close CUR1;
end EJERCICIO5;

--EXECUTE EJERCICIO5;
        /*5 oscar*/
create or replace procedure EJERCICIO5
as 
    cursor CUR1 is
    select NOMBRE,ID_CATEGORIA,sum(CANTIDAD)as SUMA
    from PRODUCTOS join DETALLES_PEDIDOS using(NUMERO_PRODUCTO)
    group by NOMBRE,ID_CATEGORIA
    order by ID_CATEGORIA,SUMA asc;
    V_REG_DATOS CUR1%ROWTYPE;
    CONTADOR NUMBER;
    V_ID_CAT PRODUCTOS.ID_CATEGORIA%type;
    
begin
    open CUR1;
    fetch CUR1 into V_REG_DATOS;
    while CUR1%FOUND loop
    V_ID_CAT:=V_REG_DATOS.ID_CATEGORIA;
    CONTADOR:=0;
        while CUR1%FOUND and V_REG_DATOS.ID_CATEGORIA=V_ID_CAT loop
            CONTADOR:=CONTADOR + 1;
            if CONTADOR <=2 then
                DBMS_OUTPUT.PUT_LINE('PRODUCTO '||CONTADOR||' DE LA CATEGORIA '||V_REG_DATOS.ID_CATEGORIA);
                DBMS_OUTPUT.PUT_LINE('         '||V_REG_DATOS.NOMBRE ||' -- '||V_REG_DATOS.ID_CATEGORIA||' -- '||V_REG_DATOS.SUMA);
            end if;
        fetch CUR1 into V_REG_DATOS;
        end loop;
    end loop;
close CUR1;
end EJERCICIO5;

EXECUTE EJERCICIO5;
set serveroutput on;
        
/*6 escribir un programa que muestre en formato similar a las rupturas de control los siguientes datos:
a.para cada producto: nombre y precio_venta.
b. para cada categoria: numero de productos y valor de los productos en stock de esa categoria
c. al final del listado: numero total de productos y valor de todos los productos en stock*/


create or replace procedure ejer6
as
 cursor cur1 is
   select distinct c.id_categoria, c.descripcion, p.numero_producto, p.nombre, p.precio_venta,p.stock
    from categorias c join productos p on (c.id_categoria=p.id_categoria)
    order by c.id_categoria, p.numero_producto;
    
 vregcur1 cur1%rowtype;
 v_id_cat_aux categorias.id_categoria%type;
 v_contaprod_por_cat number;
 v_valor_por_cat number;
 v_contaprod_total number;
 v_valor_total number;
 begin
   v_contaprod_total:=0; v_valor_total:=0;
   open cur1;
   fetch cur1 into vregcur1;
   while cur1%found loop
        v_id_cat_aux:=vregcur1.id_categoria; v_valor_por_cat:=0; v_contaprod_por_cat:=0;
        DBMS_OUTPUT.PUT_LINE('CATEGORIA: '|| v_id_cat_aux);
        while cur1%found and v_id_cat_aux=vregcur1.id_categoria loop
           v_contaprod_por_cat:=v_contaprod_por_cat + 1;
           v_valor_por_cat:= v_valor_por_cat + vregcur1.stock*vregcur1.precio_venta;
           dbms_output.put_line('Producto: '||vregcur1.nombre||' , precio: '||vregcur1.precio_venta);
           fetch cur1 into vregcur1;
         end loop;
         dbms_output.put_line('Numero de productos de la categoria '||v_id_cat_aux ||': '||
                                v_contaprod_por_cat||' valor inventario: '|| v_valor_por_cat);
        v_contaprod_total:=v_contaprod_total + v_contaprod_por_cat;
        v_valor_total:= v_valor_total + v_valor_por_cat;
   end loop;
   dbms_output.put_line('Numero total de productos: '||v_contaprod_total||' valor inventario: '|| v_valor_total);   
   close cur1;
 end;

EXECUTE ejer6;



/*7desarrollar un procedimiento que permita insertar nuevas categorias segun las siguientes especificaciones
-se pasara al procedimiento la descripcion
-el procedimiento insertara la fila asignando como numero de categoria el siguiente al numero mayor de la tabla
-se incluira la gestion de posibles errores*/

    create  or replace procedure ejer7(p_descripcion categorias.descripcion%type)
        as
            v_id_cat categorias.id_categoria%type;
            v_num categorias.id_categoria%type;
            
            categoria_repetida exception;
            
            begin
                select max(id_categoria) into v_num from categorias;
                select id_categoria into v_id_cat from categorias
                where descripcion=p_descripcion;
                
                raise categoria_repetida;
                
                exception
                    when NO_DATA_FOUND then
                        select (trunc(v_num,-1)+10) into v_id_cat from dual;
                        insert into categorias values(v_id_cat, p_descripcion);
                        
                            when categoria_repetida then
                                dbms_output.put_line('Error, categoria repetida');
                            end ejer7;
set serveroutput on;

execute ejer7('Ropa');

/*8 escribir un procedimiento que reciba todos los datos de un nuevo producto y procese la transaccion de alta, gestionando posibles errores*/

    create or replace procedure ejer8 (p_numero_producto productos.numero_producto%type,
                                        p_nombre         productos.nombre%type,
                                        p_descripcion    productos.descripcion%type,
                                        p_precio_venta   productos.precio_venta%type,
                                        p_stock          productos.stock%type,
                                        p_id_categoria    productos.id_categoria%type)
as


  begin
    insert into productos values (p_numero_producto ,p_nombre,p_descripcion,p_precio_venta,p_stock,p_id_categoria);
    exception 
        when DUP_VAL_ON_INDEX then
            dbms_output.put_line('identificador ya existente en la tabla producto');
                when others then
                    dbms_output.put_line('ha sucedido un error');
                    end ejer8;




execute ejer8(999,'osquitar','es el mas berraco',0,1000,4);

/*9 codificar un procedimiento que reciba como parametros un numero de categoria , un importe y un porcentaje
, y que suba el precio a todos los productos de la categoria indicada llamada.
la subida sera el porcentaje o el importe que se indica en la llamada(el que sea mas beneficioso para la empresa en cada caso)*/

create or replace procedure ejer9 (p_categoria categorias.id_categoria%type,
                                    p_importe productos.precio_venta%type,
                                    p_porcentaje number)
                                    
is
cursor cur9 is select * from productos 
    where id_categoria=p_categoria for update of precio_venta;
    
    begin
        for v_cur9 in cur9 loop
            if(v_cur9.precio_venta*p_porcentaje)>p_importe then
                update productos
                set precio_venta=precio_venta+v_cur9.precio_venta*p_porcentaje/100
                    where current of cur9;
            else
                update productos
                    set precio_venta=precio_venta+p_importe
                    where current of cur9;
                    end if;
                    end loop;
                    end ejer9;
   

        
--ejer10
create or replace procedure ejer10 (p_categoria productos.id_categoria%type, p_porcentaje productos.precio_venta%type)
is
cursor cur10 is select * from productos 
    where id_categoria=p_categoria for update of precio_venta;
    
    begin
        for v_cur10 in cur10 loop
            update productos
                set precio_venta=precio_venta+v_cur10.precio_venta*p_porcentaje/100
                    where current of cur10;
                    end loop;
                    end ejer10;                   
    set SERVEROUTPUT ON;
    execute ejer10(4,2);
    
    --ejer11
    create or replace procedure ejer11(p_categoria productos.id_categoria%type, p_porcentaje productos.precio_venta%type)
    is
    cursor cur11 is select numero_producto,id_categoria, precio_venta ,ROWID from productos
        where id_categoria=p_categoria;
        begin
            for v_cur11 in cur11 loop
                update productos
                    set precio_venta=precio_venta+v_cur11.precio_venta*p_porcentaje/100
                        where rowid=v_cur11.rowid;
                        end loop;
                        end ejer11;
                execute ejer11(1,2);

 /*12escribir un preocedimiento que suba el precio de todos los productos cuyo
precio de venta sea menor que el precio medio de su categoria.La subida sera del 50% de la diferencia entre el precio_venta del producto y la media de su categoria
Se debera hacer que la transaccion no se quede a medias, y se gestionaran los posibles errores*/

create or replace procedure ejer12
is
cursor cur12 is select distinct numero_producto, id_categoria, precio_venta from productos
group by numero_producto asc;

v_cur12 cur12%rowtype;
v_precio_medio number;
begin
    open  cur12;
    loop
        fetch cur12 into v_cur12;
        exit when cur12%notfound;
    select avg(precio_venta) into v_precio_medio from productos
        where id_categoria=v_cur12.id_categoria 
        group by id_categoria;
        
        if(v_cur12.precio_venta<v_precio_medio) then
            update productos set precio_venta=precio_venta+((v_precio_medio-precio_venta)*0.5)
                where numero_producto=v_cur12.numero_producto;
                end if;
                end loop;
                close cur12;
                commit;
                exception
                    when others then
                        dbms_output.put_line('actualizacion no realizada');
                        rollback;
                        end ejer12;
    execute ejer12;




                  --tabla multiplicar
  create or replace procedure tabla(p_num1 number, p_num2 number)
  is
  v_cont number;
  begin
    v_cont:=0;
    while v_cont<=p_num2 loop
        dbms_output.put_line(v_cont*p_num1);
        v_cont:=v_cont+1;
        end loop;
        end tabla;
        execute tabla(7,3);
        set serveroutput on;

    --ejer13

    create or replace procedure ejer13
    	as
   cursor cur13 is
   select id_cliente, numero_pedido,c.apellidos,e.apellidos as empleapell, fecha_pedido,pr.nombre,d.cantidad,d.cantidad,d.precio,precio_total 
   from clientes c join pedidos using(id_cliente) join empleados e using(id_empleado) join detalles_pedidos d using (numero_pedido)
   join productos pr using (numero_producto) order by c.apellidos, id_cliente, numero_pedido;






   
 --ejer13
    create or replace procedure ejer13
    	as
   cursor cur13 is
   select id_cliente, numero_pedido,c.apellidos,e.apellidos as empleapell, fecha_pedido,pr.nombre,d.cantidad,d.precio,precio_total 
   from clientes c join pedidos using(id_cliente) join empleados e using(id_empleado) join detalles_pedidos d using (numero_pedido)
   join productos pr using (numero_producto) order by c.apellidos, id_cliente, numero_pedido;
   
    v_cur13 cur13%rowtype;
    v_numero_pedido number(38,0);
    v_apellido_cliente v_cur13.apellidos%type;
    v_apellido_emple v_cur13.empleapell%type;
    v_fecha_pedido v_cur13.fecha_pedido%type;
    v_nombre_producto v_cur13.nombre%type; 
    v_ud_pedidas number; --productos que estan en la tabla dp
    v_precio_unidad v_cur13.precio%type; --precio por unidad de dp
    v_cont_lineas number;
    v_id_cliente v_cur13.id_cliente%type;
    v_total_ped number;
    v_importe_total number;
    v_importe_total_pedidos number;
    v_cont_ped number(38,0);
    v_mayor number;
    v_importe_total_cli number;
    v_mayor_id_cli number;
    v_menor_id_cli number;
    cont number;
    --empiezo
    begin
    cont:=0;
    v_cont_ped := 1;
   -- v_cont_lineas := 0; 
  /*  select max(numero_pedido) into v_mayor from detalles_pedidos; 
    select max(id_cliente) into v_mayor_id_cli from clientes; 
    select min(id_cliente) into v_menor_id_cli from clientes;
    select count(numero_pedido) into v_cont_lineas from detalles_pedidos
        where numero_pedido=v_cont_ped;  */
    open cur13;
    loop --bucle
    fetch cur13 into v_cur13;
    exit when cur13%notfound;   
      --datos de pedido
        DBMS_OUTPUT.PUT_LINE('datos pedido ' || v_cur13.numero_pedido || ' cliente ' || v_cur13.apellidos  || ' empleado que lo atendio ' || v_cur13.empleapell || 
        ' fecha ' || v_cur13.fecha_pedido || ' nombre del producto ' || v_cur13.nombre 
        || ' precio unidad ' || v_cur13.precio ||  ' importe total del pedido ' || v_cur13.precio_total);
        dbms_output.put_line('---------------------------------------------------------------------');
        
   
        select sum(precio*cantidad) into v_importe_total_cli from detalles_pedidos
                where numero_pedido in (
                    select numero_pedido from pedidos
                        where id_cliente=v_cur13.id_cliente);
       dbms_output.put_line('importe total de todos los pedidos del cliente' || v_cur13.id_cliente||' ha gastado ' ||v_importe_total_cli);
        
      
       
        
        end loop;
             
       select  sum(precio*cantidad) as total into v_importe_total_pedidos  from detalles_pedidos; --precio total de todos los pedidos
        dbms_output.put_line(' importe total de todos los pedidos ' ||v_importe_total_pedidos );
         
        close cur13;
         
    end ejer13;
    
    
 --execute ejer13; 
  
  --alter session set events = 'immediate trace name flush_cache';
  
   --set serveroutput on;
