

/*71. Calcula cuánto se ha recaudado en total con todos los pedidos*/
select sum(precio_total)
from pedidos;

/*72. Muestra el precio más alto de cada categoría y el identificador de la categoría a la que pertenece ese precio*/
select max(precio_venta), id_categoria
from productos
group by (id_categoria);

/*73. Calcula el precio de venta medio de los productos de cada categoría, junto con el identificador de la categoría*/
select avg(precio_venta), id_categoria
from productos
group by (id_categoria);

/*74. Muestra el precio más alto de cada categoría junto con el identificador y la descripción de la categoría a la que pertenece ese precio,
ordenado por identificador de la categoría*/
select max(precio_venta), id_categoria, c.descripcion
from productos p join categorias c using (id_categoria)
group by (id_categoria, c.descripcion)
order by id_categoria;

/*75. Muestra el número de productos que hay en cada categoría*/
select id_categoria, count(*)
from productos
group by id_categoria;

/*76. Ahora muestra la descripción e identificador de la categoría que tiene más productos junto con el número de productos que tiene*/

select id_categoria, c.descripcion, numero_productos
from ((
  select id_categoria, count(*) as numero_productos
  from productos
  group by id_categoria
  order by numero_productos desc) join categorias c using (id_categoria))
where rownum<=1;

/*77. Selecciona cuánto dinero se ha gastado en total en cada categoría el cliente con identificador 1001*/
select id_categoria, sum(precio_total)
from pedidos p join detalles_pedidos dp using (numero_pedido)
        join productos pr using (numero_producto)
where id_cliente=1001
group by (id_categoria);

/*78. Muestra la descripción de las categorías que tengan más de 5 productos en venta*/

select descripcion
from categorias
where id_categoria in (
        select id_categoria
        from productos
        group by id_categoria
        having count(*)>5);

/*79. Muestra nombre, apellidos e identificador de los clientes que se han gastado más de 400000 € en productos de la categoría 1*/
select nombre, apellidos, id_cliente
from clientes
where id_cliente in (
    select id_cliente
    from pedidos p join detalles_pedidos dp using (numero_pedido)
                    join productos pr using (numero_producto)
    where id_categoria=1
    group by (id_cliente)
    having sum(precio_total)>400000);

/*80. Muestra para cada empleado cuánto dinero ha hecho en pedidos*/
select sum(precio_total), id_empleado
from pedidos
group by id_empleado;

/*81. Muestra cuánto han recaudado en pedidos los empleados 701,702 y 703*/
select sum(precio_total), id_empleado
from pedidos
where id_empleado in (701,702,703)
group by id_empleado;


/*82. Ahora muestra los 3 empleados que más dinero han recaudado en pedidos. 
Debe aparecer el identificador del empleado, el nombre y el dinero recaudado*/
select *
from (
    select sum(precio_total), id_empleado, nombre
    from pedidos join empleados using(id_empleado)
    group by id_empleado,nombre
    order by sum(precio_total) desc)
where rownum<=3; 

/*83. Busca el representante o representantes que menos días de envió tengan para algún producto.
Debes mostrar nombre de representantes junto con el nombre del producto que tiene menos días de envío*/
select r.nombre, pr.nombre, dias_envio
from (
    select id_rep,numero_producto, dias_envio
    from productos_representantes
    where dias_envio =(
      select min(dias_envio)
      from productos_representantes)) join representantes r using(id_rep)
                                      join productos pr using(numero_producto);

--94) Visualiza	 el	 salario	 medio	 de	 cada	 departamento	 junto	 con	 el	 número	 de departamento.
select round(avg(salario)) as salario , depart.dept_no from depart join  emple  on depart.dept_no=emple.dept_no
group by  depart.dept_no;
--95) A	 partir	 de	 la	 tabla	 EMPLE	 visualizar	 el	 número	 de	 vendedores	 del	 departamento ‘VENTAS’.
select count(oficio) as numero_empleados from emple join  depart using (dept_no)
  where dnombre like 'VENTAS' and oficio like 'VENDEDOR';
  
--96) Partiendo	 de	 la	 tabla	 EMPLE,	 visualizar	 por	 cada	 oficio	 de	 los	 empleados	 del departamento	‘VENTAS’	la	suma	de	salarios

select emple.oficio, sum(salario) from emple join depart using (dept_no) 
  where dnombre like 'VENTAS'
  GROUP BY oficio, salario;

--97) Seleccionar	 aquellos	 apellidos	 de	 la	 tabla	 EMPLE	 cuyo	 salario	 sea	 igual	 a	 la media	de	su	salario	en	su	departamento.

select apellido, salario from emple
  where (salario, dept_no) in
    ( select avg(salario) , dept_no
      from emple
        group by dept_no);
        
--98) Visualiza	el	número	de	empleados	que	tiene	cada	departamento.
select count(emp_no), dept_no as numero_empleados  from emple join depart using (dept_no)
  group by  dept_no;
  
--99) Visualiza	 el	 número	 de	 empleados	 de	 cada	 departamento	 cuyo	 oficio	 sea ‘EMPLEADO’.
select count(emp_no), oficio from emple join depart using (dept_no)
  where oficio like 'EMPLEADO'
  group by dept_no , oficio;
  
--100) Visualiza	 el	 número	 de	 departamento	 del	 departamento	 que	 tenga	 más	empleados
select * from (
  select count(emp_no), dept_no from emple 
    group by  dept_no
    order by sum(emp_no) desc )
    where rownum=1;
    
--101) Buscar	 los	 departamentos que	 tienen	 más	 de	 dos	 personas	 trabajando	 en	 la	misma profesión
select dept_no , count(*) as numero_empleados from emple
  group by dept_no, oficio
  having count(*)>2;
  
--102) Dada	la	tabla	LIBRERÍA	visualizar	por	cada	estante	la	suma	de	los	ejemplares.
select estante , sum(ejemplares)
from libreria
group by estante;

--103) Visualizar	el	estante con	más	ejemplares	de	la	tabla	LIBRERÍA.

select * from (select estante , sum(ejemplares)
from libreria
group by estante
order by estante) 
where rownum=1 ; 