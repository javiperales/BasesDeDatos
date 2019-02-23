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
  
  
--ejercicio 13
create or replace Procedure Ejercicio13_Hoja2
Is
    Cursor Tabla Is
    Select Numero_Pedido, Id_Cliente, Id_Empleado, 
            Fecha_Pedido, P.Nombre, Cantidad, Precio, Precio*Cantidad
    From Pedidos Natural Join Detalles_Pedidos Natural Join Productos P Join Clientes Using(Id_Cliente)
    ORDER BY apellidos, numero_pedido, numero_producto;

    Cursor Tabla_Comodin(P_Numero_Ped Number) Is
    Select Count(*), Sum(Precio*Cantidad)  From Detalles_Pedidos
    where numero_pedido=p_numero_ped;

    V_Num_Ped Number;
    V_Id_Cli Number;
    V_Id_Emp Number;
    V_Fech Date;
    V_Nom_Prod VARCHAR(100);
    V_Cant Number;
    V_Precio Number;
    V_Importe Number;
    V_Lineas_Pedido Number;
    V_Comodin Number:=0;
    V_Total_Pedido Number;
    V_Num_Ped_Comodin Number:=0;
    v_importe_total NUMBER:=0;
Begin
       Open Tabla;
       Fetch Tabla Into V_Num_Ped, V_Id_Cli, V_Id_Emp, V_Fech,V_Nom_Prod, V_Cant, V_Precio, V_Importe ;
       V_Num_Ped_Comodin:=V_Num_Ped;
       Open Tabla_Comodin(V_Num_Ped);
       Fetch Tabla_Comodin Into V_Lineas_Pedido, V_Total_Pedido ;
       While (Tabla%Found) Loop 
            Dbms_Output.Put_Line ('  Datos del pedido: ' || V_Num_Ped ||  ' --> Cliente: ' || V_Id_Cli || ' / Empleado que atendió: ' ||V_Id_Emp ||' / Fecha: ' ||V_Fech);
            While (V_Num_Ped_Comodin = V_Num_Ped And Tabla%Found) Loop
                Dbms_Output.Put_Line('      Nombre de producto: ' ||V_Nom_Prod || ' / unidades pedidas: ' || V_Cant ||' / precio por unidad: ' || V_Precio || '€');
                Fetch Tabla Into V_Num_Ped, V_Id_Cli, V_Id_Emp, V_Fech,V_Nom_Prod, V_Cant, V_Precio, V_Importe ;
            End Loop;
            Dbms_Output.Put_Line('    Número de líneas del pedido: ' || V_Lineas_Pedido);
            Dbms_Output.Put_Line('    Importe total del pedido: ' || V_Total_Pedido ||'€');
            v_importe_total:=v_importe_total + V_Total_Pedido;
            V_num_ped_comodin:=v_num_ped;
            Close Tabla_Comodin;
            Open Tabla_Comodin(V_Num_Ped);
            Fetch Tabla_Comodin Into V_Lineas_Pedido, V_Total_Pedido ;
       End Loop;
       Close Tabla;
       Dbms_Output.Put_Line('');
       Dbms_Output.Put_Line('');
       Dbms_Output.Put_Line('Importe total: ' || v_importe_total ||'€');


Exception
    When No_Data_Found Then
      Dbms_Output.Put_Line ('No se han encontrado datos...'); 
End;
execute EJERCICIO13_HOJA2;
   
                                       
                                       
/*/*4)	Escribe un trigger que cada vez que se modifiquen las columnas cantidad o precio 
de la tabla detalles_pedidos actualice el 
precio total del pedido correspondiente en la tabla pedidos.	*/


/*2)	Crea una tabla que se llame EMPLEADOVIP que recogerá el identificador de los empleados
y sus ventas. Tendrá los siguientes campos: id_empleado e importe_acumulado. 
Escribe un procedimiento que inserte en la tabla anterior los datos de los empleados 
y el importe acumulado por cada uno de ellos (el dinero recaudado, no el número de ventas) 
hasta el momento sean superiores a la venta promedio por empleado.
NOTA: para saber si hay que insertar o no en la tabla anterior los datos de un pedido
que ha servido un empleado necesitamos saber cuánto ha vendido en total.
En este ejercicio sólo se puede abrir, recorrer y cerrar el cursor que se utilice 
un máximo de dos veces.
Crea un trigger que cada vez que haya una inserción en pedidos actualice la tabla
EMPLEADOVIP y nos muestre por pantalla todos los datos y el importe acumulado de los tres 
mejores empleados.	*/

