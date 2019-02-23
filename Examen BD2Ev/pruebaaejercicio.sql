connect maria1/maria

-- 20) Mostrar una lista de los nombres y número de teléfono de los proveedores de las
-- provincias de MADRID y CACERES.
Select nombre, telefono 
from proveedores 
where provincia='MADRID' or provincia='CACERES' ;
-- 21) Mostrar los datos de los pedidos del cliente 1001 en los que las fechas de pedido y envío
-- coincidan.
SELECT * 
from pedidos 
where id_cliente=1001 AND FECHA_PEDIDO=FECHA_ENVIO;

-- 22) Mostrar los datos de los pedidos del cliente 1001 o que cumplan que la fecha de envío es 4
-- días posterior a la fecha de pedido.
SELECT * 
from pedidos 
where id_cliente=1001 OR FECHA_PEDIDO=FECHA_ENVIO-4;

-- 23) Mostrar nombre, apellidos, provincia y código postal de los clientes que se apelliden
-- Pelayo en la provincia de CACERES o de los clientes cuyo código postal termine en 9.
SELECT NOMBRE, APELLIDOS, PROVINCIA, COD_POSTAL 
FROM CLIENTES 
where apellidos='Pelayo' AND provincia='CACERES'
or  COD_POSTAL LIKE '%9';
-- 24) Mostrar nombre, apellidos, provincia y código postal de los clientes que se apelliden
-- Pelayo y de cualquier otro cliente que viva en la provincia de CACERES o tenga un código
-- postal que termine en 9.
SELECT NOMBRE, APELLIDOS, PROVINCIA, COD_POSTAL 
FROM CLIENTES 
where apellidos='Pelayo' OR PROVINCIA='CACERES' OR
COD_POSTAL LIKE '%9'; 

-- 25) Mostrar los datos de los proveedores que tienen su sede en CACERES, ORENSE o MADRID.
select * 
from proveedores 
where provincia IN ('CACERES', 'ORENSE', 'MADRID');
-- 26) Listar los clientes cuyo apellido empieza por H.
select * 
from clientes 
where apellidos like 'H%';
-- 27) Listar los clientes que no viven en Robledo ni en Somosierra.
select * 
from clientes 
where CIUDAD NOT IN ('Robledo', 'Somosierra');
-- 28) Mostrar el número de pedido, el id_cliente y la fecha de pedido de todos los pedidos que
-- ha realizado el cliente 1001 ordenado por fecha de pedido.
select id_cliente, numero_pedido, FECHA_PEDIDO 
from pedidos 
where id_cliente=1001 order by fecha_pedido;
-- 29) Mostrar un listado en orden alfabético de los nombres de productos que empiezan por
-- 'Dog'.
select nombre 
from productos 
where nombre like 'Dog%' order by nombre;
-- 30) Listar los nombres de todos los proveedores con sede en Batres, Belmonte o Robledo.
select nombre 
from proveedores 
where ciudad in ('Batres', 'Belmonte', 'Robledo');
--moir ajjskjdjs, jansjs, sjsjjmnms29392,j3i39393
-- 31) Mostrar en orden alfabético la lista de los nombres de productos cuyo precio de venta sea
-- igual o superior a 125.00 euros.
select nombre 
from productos 
where precio_venta >= 125.00;
-- 32) Listar en orden alfabético los nombres de los proveedores que no tienen página web.
select nombre 
from proveedores 
where pag_web is null order by nombre;
-- 33) Intersección: Listar los número de pedidos en los que se han pedido tanto bicicletas
-- (sabiendo que sus números de producto son 1, 2, 6 y 11) como cascos (sabiendo que sus
-- números de producto son 10, 25 y 26).

-- 34) Diferencia: Listar los número de pedidos que han comprado alguna bicicleta (sabiendo que
-- sus números de producto son 1, 2, 6 y 11) pero no cascos (sabiendo que sus números de
-- producto son 10, 25 y 26).

-- 35) Unión: Listar los número de pedidos que han comprado alguna bicicleta (sabiendo que sus
-- números de producto son 1, 2, 6 y 11) o algún casco (sabiendo que sus números de
-- producto son 10, 25 y 26).


-- Hacerlo de dos maneras, haciendo uso de UNION y sin hacer uso de UNION.
-- 36) Clientes y empleados que tienen el mismo nombre.
select nombre 
from empleados JOIN clientes USING (nombre); 
-- 37) Clientes cuyos nombres no coinciden con los de ningún empleado.

-- 38) Ciudades en las que viven clientes pero ningún empleado.
SELECT NOMBRE
FROM CLIENTES
WHERE NOMBRE LIKE 'M%';

select nombre from clientes;


exit