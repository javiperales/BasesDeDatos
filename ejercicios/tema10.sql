/*84) calcula el precio total de los pedidos de nuestros clientes*/
select sum(precio) from detalles_pedidos;

/*84) profesor*/
update pedidos p
set p.precio_total=(
  select sum(dp.precio*dp.cantidad) from detalles_pedidos dp
  where dp.numero_pedido=p.numero_pedido
  group by dp.numero_pedido);


/*85)comprueba si la precision de los campos numericos de las tablas pedidos, pedidos_historico, detalles_pedidos y detalles_pedidos_historico coincide
si no es asi modificalas para que haya coincidencia*/
alter table detalles_pedidos_historico 
  modify precio number(6,2);
  
  alter table pedidos_historico 
  modify precio_total number(7,2);
/* 86)nuestra empresa es lider del mercado y permite hacer lo que le apetezca. Por eso ha decidido que aplicara con efecto retroactivo las ultimas subidas de precio
para eso los datos que hasta ahora teniamos en la tabla PEDIDOS y los guardemos en la tabla PEDIDOS_HISTORICOS y lo mismo haremos con detalles_pedidos y detalles_pedidos_historico
 confirmalo lo mas tarde posible*/
 insert into pedidos_historico
 select * from pedidos;
 
 insert into detalles_pedidos_historico
 select * from detalles_pedidos;
 
insert into detalles_pedidos
  select * from pedidos;
/*88) Tenemos que subir un 4% los precios de los productos de la categoría 'Ropa' y
deshacer los cambios lo más tarde posible.
a) Mostrar un listado con los nombres de los productos, el precio actual y el precio que
tendrán después de la subida.
b) Actualizar los precios de venta de dichos productos subiéndolos un 4%.*/


select numero_producto, nombre, id_categoria, precio_venta ,precio_venta*1.04 as precio_subido from productos
  where id_categoria in (
    select id_categoria from categorias
      where descripcion like 'Ropa');
      
update productos set precio_venta=precio_venta*1.04 
  where precio_venta in (
    select p.precio_venta from productos p , categorias c
      where c.descripcion like 'Ropa' and c.id_categoria=p.id_categoria);
      
update productos
set precio_venta=precio_venta*1.04
  where id_categoria 
    ( select id_categoria from categorias
      where upper(descripcion)='ROPA');
 
/*89) Incrementar un 5% los precios de los productos de la categoría 'Ropa', a continuación
actualiza los precios en DETALLES_PEDIDOS para que se correspondan con los que hay en
la tabla productos y por último actualiza en la tabla PEDIDOS el precio total de cada pedido
de acuerdo a los nuevos precios de los productos. Confirmarlo lo más tarde posible.*/
update productos set precio_venta=precio_venta*1.05 
  where precio_venta in (
    select p.precio_venta from productos p , categorias c
      where c.descripcion like 'Ropa' and c.id_categoria=p.id_categoria);
      
commit;

update detalles_pedidos dp
set (precio)=
  (select p.precio_venta from productos p 
    where dp.numero_producto=p.numero_producto);
    
update pedidos p 
  set (p.precio_total)=
  ( select sum(precio*cantidad) from detalles_pedidos dp 
    where p.numero_pedido=dp.numero_pedido);



/*90) A partir de la tabla pedidos crea la tabla SALDOS_PENDIENTES con los mismos campos
que la tabla pedidos y en el campo PRECIO_TOTAL el valor de la diferencia entre el
PRECIO_TOTAL actualizado y el PRECIO_TOTAL antes de la actualización (éste último se
encuentra en la tabla PEDIDOS_HISTORICO).*/
drop table saldos_pendientes;
create table saldos_pendientes(
numero_pedido number(20) primary key,
fecha_pedido date,
fecha_envio date,
id_cliente number(20),
id_empleado number(20),
precio_total number(20,2));

/*select ph.precio_total-pe.precio_total from pedidos pe join pedidos_historico ph 
on ph.numero_pedido=pe.numero_pedido;*/

create table saldos_pendientes
as
select p.numero_pedido, p.fecha_pedido, p.fecha_envio , p.id_cliente , p.id_empleado , (p.precio_total-ph.precio_total) precio_total
from pedidos p join pedidos_historico ph on p.numero_pedido=ph.numero_pedido;

/*91) Ejecuta la sentencia rollback. ¿Qué pasa? ¿Por qué?*/

rollback;

/*92) Mostrar el nombre del proveedor y el promedio por proveedor del número de días
que se tarda en realizar el envío de los productos. Hay que mostrar aquellos cuyo
promedio sea mayor que el promedio de todos los proveedores.*/

select prov.nombre , prov.id_rep , avg(pp.dias_envio) as promedio_dias from proveedores prov join productos_proveedores pp on prov.id_rep=pp.id_rep
group by prov.nombre , prov.id_rep
having avg(pp.dias_envio) > (select avg(dias_envio) from productos_proveedores);

/*93) Hacer una consulta que muestre el nombre del producto y el total vendido de aquellos
productos que superan el promedio de ventas de su categoría.*/

select prod1.id_categoria , prod1.nombre , sum(dp1.precio*dp1.cantidad) total_vendido
from productos prod1 join detalles_pedidos dp1 on (prod1.numero_producto=dp1.numero_producto)
group by prod1.id_categoria , prod1.nombre
having sum(dp1.precio*dp1.cantidad) > ( 
        select avg(dp2.precio*dp2.cantidad) from productos prod2 join detalles_pedidos dp2 on prod2.numero_producto = dp2.numero_producto
          where prod2.id_categoria=prod1.id_categoria
          group by prod2.id_categoria);
          
/*94) Listar por cada cliente y fecha de pedido el nombre completo y el coste total del
pedido si éste supera los 1000 euros. El coste del pedido hay que calcularlo a partir de la
tabla DETALLES_PEDIDOS.*/

select cli.nombre, cli.apellidos, pe.fecha_pedido , pe.precio_total from clientes cli join pedidos pe on cli.id_cliente=pe.id_cliente
group by cli.nombre, cli.apellidos , pe.fecha_pedido , pe.precio_total;

select pe.fecha_pedido , cli.nombre , cli.apellidos , sum(dp.cantidad*dp.precio) from clientes cli join pedidos pe on pe.id_cliente=cli.id_cliente
                                                                                 join detalles_pedidos dp on pe.numero_pedido=dp.numero_pedido
group by pe.fecha_pedido , cli.nombre , cli.apellidos
having sum(dp.cantidad*dp.precio)>1000;

/*95) ¿Cuántos pedidos hay de un sólo producto?*/

select sum(count(numero_pedido))  from detalles_pedidos
group by numero_pedido
having count(*)=1 
order by numero_pedido;

/*96) Hacer un descuento del 2% en los pedidos que se han enviado con una demora
superior a 30 días desde la fecha del pedido.
Hay que modificar el precio en cada línea de detalles_pedidos y luego, a partir de
detalles_pedidos recalcular el precio_total del pedido*/

update detalles_pedidos set precio=precio*0.98
  where numero_pedido in (
    select numero_pedido from pedidos
      where fecha_envio-fecha_pedido>10);
      
update pedidos pe set precio_total = (
  select sum(precio*cantidad) from detalles_pedidos dp
    where dp.numero_pedido=pe.numero_pedido
    group by numero_pedido)
    where fecha_envio-fecha_pedido>30;
    
/*97) Aplicar un 5% de descuento a todos los pedidos de los clientes que hicieron una
compra superior a 20000 € en el mes de octubre de 2007.
Hay que modificar el precio en cada línea de detalles_pedidos y luego, a partir de
detalles_pedidos recalcular el precio_total del pedido*/


select id_cliente from pedidos
  where to_char(fecha_pedido, 'MM-YYYY')='10-2007'
  group by id_cliente 
  having sum(precio_total)>20000;
  
  
  update detalles_pedidos set precio=precio*0.95
    where numero_pedido in (
      select numero_pedido from pedidos 
        where id_cliente in ( select id_cliente from pedidos
        where to_char(fecha_pedido, 'MM-YYYY')='10-2007'
          group by id_cliente
          having sum(precio_total)>20000));
  
/*98) Hacer que el precio de venta de todos los productos de la categoría 2 sea al menos un
45% superior al precio del proveedor que tenga el precio más barato para dicho producto.
Redondear los precios sin decimales.*/

  
update productos pro set pro.precio_venta=ROUND(1.45*
  (select min(pp.precio_por_mayor) from productos_proveedores pp 
   where pp.numero_producto=pro.numero_producto),0)
  
  where pro.id_categoria=2 and pro.precio_venta=ROUND(1.45*
  (select min(pp.precio_por_mayor) from productos_proveedores pp 
   where pp.numero_producto=pro.numero_producto));
   
/*99) Poner como precio de venta de los productos de la categoría 'Accesorios' el máximo
precio al por mayor que nos pongan los proveedores para ese producto más un 35%.*/

/*select pro.precio_venta, cat.descripcion from productos pro join categorias cat on pro.id_categoria=cat.id_categoria
where cat.descripcion like 'Accesorios';  
  
update productos pro set pro.precio_venta=ROUND(1.35*
(select max(pp.precio_por_mayor) from productos_proveedores pp 
  where pp.numero_producto=pro.numero_producto),0)
  
where categorias like 'Accesorios' and pro.precio_venta=ROUND(1.35*
(select max(pp.precio_por_mayor) from productos_proveedores pp 
  where pp.numero_producto=pro.numero_producto));*/

update productos pro set pro.precio_venta=(
  select max(pp.precio_por_mayor) from productos_proveedores pp 
  where pp.numero_producto=pro.numero_producto)*1.35
  
  where pro.id_categoria=(
    select id_categoria from categorias
      where descripcion like 'Accesorios');
      
/*100) Añadir una nueva empleada con los siguientes datos: Susana Maroto, Pinares 16,
Villamanta, MADRID, 28610, código de área 425 y número de teléfono 555-7825.*/

insert into empleados
(id_empleado , nombre, apellidos, direccion, ciudad, provincia, cod_postal, codigo_area, telefono)
values((select max(id_empleado) from empleados)+1,'Susana','Maroto', 'Pinares 16', 'Villamanta', 'MADRID' , '28610' , 425, '555-7825');

/*101) Hemos contratado al cliente David Sanz. Añade una fila a la tabla EMPLEADOS con
todos los datos de David Sanz que están en la tabla Clientes. El id_empleado ha de ser el
siguiente al mayor valor de id_empleado que hay en la tabla.*/
insert into empleados ((select max(id_empleado)+1)
select * from clientes 
  where nombre='David' and apellidos='Sanz');

insert into empleados(
select((select max(id_empleado) from empleados)+1),nombre, apellidos, direccion, ciudad, provincia, cod_postal, codigo_area, telefono
  from clientes
    where nombre='David' and apellidos='Sanz');
    
/*102) Insertar un nuevo producto en la tabla de PRODUCTOS con los siguientes valores:
• El numero_producto ha de ser el siguiente al mayor valor de numero_producto
que hay en la tabla.
• nombre: Super Mega Spinner
• precio_venta: 895
• id_categoria: el valor que tenga en la tabla CATEGORIAS la categoria 'Bicicletas'*/

  insert into productos (numero_producto, nombre, precio_venta, id_categoria)
  values ((select max(numero_producto) from productos)+1,'Super Mega Spinner', 895, select( id_categoria
    from categorias
      where descripcion='Biciletas');
      
      
 /*103) Insertar un nuevo cliente con los siguientes datos:
• El id_cliente ha de ser el siguiente al mayor valor de id_cliente que hay en la tabla.
• María Baquero
• Cantarranas 17
• Braojos
• MADRID
• 28737
• área 425
• teléfono: 555-9876*/   

insert into clientes select max(id_cliente)+1,
                         'María','Baquero','Cantarranas 17','Braojos',
                          'MADRID','28737','425','555-9876'
                      from clientes;
                      
/*104) Insertar un nuevo proveedor llamado 'Super Mega Bicicletas'. El id_prov ha de ser el
siguiente al mayor valor de id_prov que hay en la tabla. El resto de los datos son:
•	calle Principal 12
•	Castroviejo
•	LA RIOJA
•	26637
•	TELF: (941) 555-6543
•	FAX: (941) 555-6542
•	pag_web:http://www.supermegabicicletas.com
•	email: ventas@supermegabicicletas.com

*/
insert into proveedores 
    select max(id_prov)+1,
         'Super Mega Bicicletas','calle Principal 12','Castroviejo',
         'LA RIOJA', '26637','(941) 555-6543', '(941) 555-6542',
         'http://www.supermegabicicletas.com',
         'ventas@supermegabicicletas.com'
    from proveedores;
    
    
   

