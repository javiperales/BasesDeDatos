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
        ' fecha ' || v_cur13.fecha_pedido || ' nombre del producto ' || v_cur13.nombre || ' unidades pedidas ' || v_ud_pedidas
        || ' precio unidad ' || v_cur13.precio || ' numero de lineas del pedido ' || v_cont_lineas || ' importe total del pedido ' || v_cur13.precio_total);
        
        dbms_output.put_line('importe total de todos los pedidos del cliente' || v_importe_total_cli);
        dbms_output.put_line(' importe total de todos los pedidos ' ||v_importe_total_pedidos );
        
        
       -- select  sum(precio*cantidad) as total from detalles_pedidos; --precio total de todos los pedidos
       
        
        end loop;
        close cur13;
         
    end ejer13;
    
    
 execute ejer13; 
  
  --alter session set events = 'immediate trace name flush_cache';
  
   
