create or replace procedure ejercicio1
as
cursor cur1 is select clientes.apellidos, pedidos.fecha_pedido from clientes, pedidos
    where clientes.id_cliente=pedidos.id_cliente
    order by clientes.apellidos asc;
    
    v_reg_c_cur1 cur1%type;
    begin
    
    open cur1;
    loop
        fetch cur1 into v_reg_c_cur1;
        exit when cur1%notfound;
        dbms_output.put_line(v_reg_c_cur1.apellidos || '||'||v_reg_c_cur1.fecha_pedido);
        end loop;
        close cur1;
        end;
        
/*2*/
create or replace procedure ejercicio2
as
cursor cur2 is select categorias.descripcion , count(productos.numero_producto) as cantidad from categorias , productos
    where categorias.id_categoria=productos.id_categoria
    group by categorias.descripcion;
    
    v_cur2 cur2%rowtype;
    begin
    open cur2;
    loop
    fetch cur2 into v_cur2;
    exit when cur2%notfound;
    dbms_output.put_line( v_cur2.descripcion || ' || ' || v_cur2.cantidad );
    end loop;
    close cur2;
    end;
    
    
/*3*/
create or replace procedure ejer3(cadena empleados.apellidos%TYPE )
as
 cursor cur3 is select apellidos , id_empleado from empleados
    where apellidos like '%'|| cadena || '%';
    
cursor cur31 is select count(*) as cantidad from empleados
   where apellidos like '%'|| cadena || '%'; 
   
   v_cur3 cur3%rowtype;
   v_cur31 cur31%rowtype;
   begin
   open cur3;
   loop
    fetch cur3 into v_cur3;
    exit when cur3%notfound;
    dbms_output.put_line(v_cur3.apellidos || ' | ' || v_cur3.id_empleado);
    end loop;
    close cur3;
    open cur31;
    fetch cur31 into v_cur31;
    exit when cur31%notfound;
    dbms_output.put_line('');
    dbms_output.put_line('Nº empleados mostrados: ' || v_cur31);
    close cur31;
    end;

/*4*/
create or replace procedure ejer4
as
cursor cur4 in select clientes.apellidos, sum(pedidos.precio_total) as total_gastado from clientes, pedidos
    where clientes.id_cliente=pedidos.id_cliente
        group by clientes.apellidos
            order by sum(pedidos.precio_total) desc;
            
    v_cur4 cur4%rowtype;
    begin
    open cur4;
    for cont in 0..4 loop
        fetch cur4 into v_cur4;
        exit when cur4%notfound;
        dbms_output.put_line(v_cur4.apellidos || '| ' || v_cur4.total_gastado);
        end loop;
        close cur4;
        end;

































    
    
