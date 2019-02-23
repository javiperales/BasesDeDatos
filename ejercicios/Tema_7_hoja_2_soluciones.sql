/*39. Listar todos los números de pedidos que han vendido algún producto cuyo número de producto es 
mayor que el producto con nombre 'Shinoman 105 SC Frenos'
No deben repetirse números de pedido*/
select distinct numero_pedido
from pedidos natural join detalles_pedidos
where numero_producto > (select numero_producto
						from productos
						where nombre like 'Shinoman 105 SC Frenos');
						
/*40 Selecciona todos los nombres de representantes que llevan productos que empiezan por la letra C y 
se enviaron en pedidos antes del 1 de Marzo del 2008*/
select r.nombre
from representantes r 
where id_rep in(
  select id_rep
  from productos_representantes
  where numero_producto in (
    select numero_producto
    from productos
    where UPPER(nombre) like 'C%' and numero_producto in (
      select numero_producto
      from pedidos
      where fecha_envio<'2008-03-01'
    )
  )
);

/*41. Selecciona todos los nombres de representantes que llevan productos que empiezan por la letra C y no se han vendido*/

select r.nombre
from representantes r 
where id_rep in(
  select id_rep
  from productos_representantes
  where numero_producto in (
    select numero_producto
    from productos
    where UPPER(nombre) like 'C%' and numero_producto not in (
      select numero_producto
      from detalles_pedidos
    )
  )
);

--En este si lo hacemos multitabla, a la hora de unir las tablas numero_producto con detalles_pedidos habría que usar 
--  'left outer join' o no aparecerían los que se pide mostrar

/*42. Intersección: Listar los clientes que han comprado tanto bicicletas 
(productos que contengan la cadena 'Bike' en el nombre) 
como cascos (productos que contengan la cadena 'Casco' en el nombre). (Cruce de tablas)*/

          select id_cliente
          from pedidos
          where numero_pedido in (
                    select numero_pedido
                    from detalles_pedidos
                    where numero_producto in (
                            select numero_producto
                            from productos
                            where upper(nombre) like '%BIKE%'
                            ))
intersect
          select id_cliente
          from pedidos
          where numero_pedido in (
                    select numero_pedido
                    from detalles_pedidos
                    where numero_producto in (
                            select numero_producto
                            from productos
                            where upper(nombre) like '%CASCO%'
                            ));
                            
select id_cliente
from productos p join detalles_pedidos using (numero_producto)
                  join pedidos using (numero_pedido)
                  join clientes c using (id_cliente)
where upper(p.nombre) like '%BIKE%'
intersect
select id_cliente
from productos p join detalles_pedidos using (numero_producto)
                  join pedidos using (numero_pedido)
                  join clientes c using (id_cliente)
where upper(p.nombre) like '%CASCO%';

/*43. Diferencia: Listar los clientes que han comprado alguna bicicletas  (productos que contengan la cadena 'Bike' en el nombre) 
pero no cascos (productos que contengan la cadena 'Casco' en el nombre). (Cruce de tablas)*/
          select id_cliente
          from pedidos
          where numero_pedido in (
                    select numero_pedido
                    from detalles_pedidos
                    where numero_producto in (
                            select numero_producto
                            from productos
                            where upper(nombre) like '%BIKE%'
                            ))
minus
          select id_cliente
          from pedidos
          where numero_pedido in (
                    select numero_pedido
                    from detalles_pedidos
                    where numero_producto in (
                            select numero_producto
                            from productos
                            where upper(nombre) like '%CASCO%'
                            ));
                            
select id_cliente
from productos p join detalles_pedidos using (numero_producto)
                  join pedidos using (numero_pedido)
                  join clientes c using (id_cliente)
where upper(p.nombre) like '%BIKE%'
minus
select id_cliente
from productos p join detalles_pedidos using (numero_producto)
                  join pedidos using (numero_pedido)
                  join clientes c using (id_cliente)
where upper(p.nombre) like '%CASCO%';

/*44. Unión: Listar los clientes que han comprado alguna bicicleta (productos que contengan la cadena 'Bike' en el nombre) 
o algún casco (productos que contengan la cadena 'Casco' en el nombre). (Cruce de tablas)*/
          select id_cliente
          from pedidos
          where numero_pedido in (
                    select numero_pedido
                    from detalles_pedidos
                    where numero_producto in (
                            select numero_producto
                            from productos
                            where upper(nombre) like '%BIKE%'
                            ))
union
          select id_cliente
          from pedidos
          where numero_pedido in (
                    select numero_pedido
                    from detalles_pedidos
                    where numero_producto in (
                            select numero_producto
                            from productos
                            where upper(nombre) like '%CASCO%'
                            ));
                            
select id_cliente
from productos p join detalles_pedidos using (numero_producto)
                  join pedidos using (numero_pedido)
                  join clientes c using (id_cliente)
where upper(p.nombre) like '%BIKE%'
union
select id_cliente
from productos p join detalles_pedidos using (numero_producto)
                  join pedidos using (numero_pedido)
                  join clientes c using (id_cliente)
where upper(p.nombre) like '%CASCO%';

select distinct(id_cliente)
from pedidos
where numero_pedido in (
  select numero_pedido
  from detalles_pedidos
  where numero_producto in (
    select numero_producto
    from productos
    where upper(nombre) like '%BIKE%' or upper(nombre) like '%CASCO%'
  )
);

/*45. Clientes que viven en una ciudad que no coincide con ninguna de los empleados.*/
select id_cliente, nombre
from clientes
where ciudad not in (select ciudad
                    from empleados);
                    
/*46. Lista de los clientes que han encargado algún producto que contenga la cadena 'Bike'
en el nombre seguida de la lista de los que han encargado algún producto que contenga 
la cadena 'Casco' en el nombre*/
select distinct id_cliente , 'bicis'
from productos p join detalles_pedidos using (numero_producto)
                  join pedidos using (numero_pedido)
                  join clientes c using (id_cliente)
where upper(p.nombre) like '%BIKE%'
union all
select distinct id_cliente, 'cascos'
from productos p join detalles_pedidos using (numero_producto)
                  join pedidos using (numero_pedido)
                  join clientes c using (id_cliente)
where upper(p.nombre) like '%CASCO%';

/*47. Seleccionar los nombres de los productos que pertenecen a la categoría 'Componentes'*/
select nombre
from productos
where id_categoria = (
        select id_categoria
        from categorias
        where upper(descripcion) like 'COMPONENTES');
        

select nombre
from productos join categorias c using(id_categoria)
where upper(c.descripcion) like 'COMPONENTES';

/*48. Selecciona los productos cuyo precio sea mayor que el de todos los demás*/
select *
from productos
where precio_venta >= all (select precio_venta
                            from productos);

/*49. Selecciona los productos cuyo precio sea menor que el producto 
'Eagle SA-120 Pedales sin clip', ordenados por el precio de venta*/
select *
from productos
where precio_venta < (select precio_Venta
                      from productos
                      where nombre like 'Eagle SA-120 Pedales sin clip')
order by precio_venta;

/*50. Actualizar la descripción de la categoría 5 a 'Baca para el coche'.
Seleccionar todos los productos que no pertenecen a las categorías 'Ruedas' 
ni 'Baca para el coche'*/
update categorias
set descripcion = 'Baca para el coche'
where id_categoria=5;

select distinct nombre
from productos
where id_categoria in (select id_categoria 
                        from categorias
                        where descripcion not like 'Ruedas' and 
                              descripcion not like 'Baca para el coche' );

select distinct nombre
from productos
where id_categoria not in (select id_categoria 
                        from categorias
                        where descripcion like 'Ruedas' or 
                              descripcion like 'Baca para el coche' );

select nombre
from productos join categorias c using (id_categoria)
where c.descripcion not in ('Ruedas','Baca para el coche');

/*51. Seleccionar los productos cuyo precio de venta sea mayor que cualquier 
producto de la categoría 'Componentes'*/
select *
from productos 
where precio_venta > any (select precio_venta
                          from productos
                          where id_categoria in (select id_categoria
                                        from categorias
                                        where upper(descripcion) like 'COMPONENTES'));

/*52. Selecciona los clientes que son de la misma ciudad que el cliente con id 1001, 
en la lista no tiene que salir el cliente 1001*/
select nombre
from clientes
where id_cliente != 1001 and ciudad = (select ciudad
                                        from clientes
                                        where id_cliente = 1001);


/*53. Encuentra los productos que tienen el precio de venta mínimo de su categoría*/
select nombre
from productos p1
where precio_venta <= all (select precio_venta
                          from productos p2
                          where p2.id_categoria=p1.id_categoria);
/*54. Selecciona las categorías que no tienen productos*/
select *
from categorias
where id_categoria not in (select id_categoria
                          from productos);




















