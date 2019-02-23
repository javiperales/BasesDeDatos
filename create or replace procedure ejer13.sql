create or replace procedure ejer13
as
    cursor c1 IS
select id_cliente, numero_pedido, c.apellidos, e.apellidos as empleapell, fecha_pedido,
    pr.nombre, d.cantidad, d.precio, precio_total
    from clientes c join pedidos using (id_cliente) 
    join empleados e using (id_empleado)
    join detalles_pedidos d using (numero_pedido)
    join productos pr using(numero_producto)
    order by c.apellidos, id_cliente, numero_pedido;
    
    v_c1 c1%ROWTYPE; -- variable de cursor, donde ponemos la row del cursor
    v_cont number;
    total_importe number;
    total_importe_por_cliente number;
    total_importe_pedido number;
    ultimo_cliente clientes.id_cliente%TYPE;
    ultimo_pedido pedidos.numero_pedido%TYPE;
    num_lineas number; -- contamos el numero de lineas por pedido

begin
    total_importe := 0;
    total_importe_por_cliente := 0;
    total_importe_pedido := 0 ;
    num_lineas := 0;
    open c1; 
    fetch c1 into v_c1; -- este fetch sirve para inicializar el v_c1, para entrar en el loop con una linea leida/cargada
    -- Inicializar cliente
    ultimo_cliente := v_c1.id_cliente; 
    dbms_output.put_line('***************************************************');
    loop
      dbms_output.put_line('Datos del pedido: '||v_c1.numero_pedido|| ' Cliente: '||v_c1.apellidos|| ' Empleado que atendió: '||v_c1.empleapell|| ' Fecha: '||v_c1.fecha_pedido); --Aquí pintamos los datos
      ultimo_pedido := v_c1.numero_pedido;
      while c1%FOUND and ultimo_pedido = v_c1.numero_pedido loop --mientras el cursor tiene datos y mientras el num de pedido no cambie entra
          dbms_output.put_line('Nombre del producto: '||v_c1.nombre|| ' Unidades pedidas: '||v_c1.cantidad|| ' Precio por unidad: '||v_c1.precio);
          num_lineas := num_lineas + 1; --contador de lineas
          total_importe_pedido := v_c1.precio_total;
          total_importe_por_cliente := total_importe_por_cliente + (v_c1.precio*v_c1.cantidad);
          ultimo_pedido := v_c1.numero_pedido;
          fetch c1 into v_c1;
      end loop;
      dbms_output.put_line('Número de líneas del pedido: '||num_lineas);
      num_lineas := 0 ; -- una vez impreso, reinicializamos el numero de lineas a cero
      dbms_output.put_line('Importe total del pedido: '||total_importe_pedido);
      dbms_output.put_line('-------------------------------');
      total_importe_pedido := 0; -- lo mismo que con num_lineas
       -- Si el cliente es nuevo, imprimir mensaje de fin de cliente e inicializar a 0 contadores de cliente
      if (v_c1.id_cliente <> ultimo_cliente)--entra en el if cuando cambia el id_cliente
      then
        dbms_output.put_line('Importe total de todos los pedidos del cliente: '||total_importe_por_cliente);
        dbms_output.put_line(' - - - ');
        total_importe_por_cliente := 0;
        ultimo_cliente := v_c1.id_cliente;
      end if;   
    if (c1%notfound) --el cursor ya no tiene datos
      then 
        dbms_output.put_line('Importe total de todos los pedidos: '||total_importe);
        dbms_output.put_line('***************************************************');
        exit; -- Sale del loop (31)
      end if;    
      -- Acumulaciones de todos los pedidos
      total_importe := total_importe + (v_c1.precio*v_c1.cantidad);
    end loop;
    close c1;
end ejer13;