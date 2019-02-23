connect maria1/maria

CREATE TABLE categorias (
	id_categoria int primary key,
	descripcion varchar2(75)
);

CREATE TABLE clientes (
	id_cliente int primary key,
	nombre varchar2(25),
	apellidos varchar2(25) ,
	direccion varchar2(50) ,
	ciudad varchar2(30) ,
	provincia varchar2(15) ,
	cod_postal VARCHAR2(10) ,
	codigo_area int default 0,
	telefono varchar2(9) 
);

CREATE TABLE empleados (
	id_empleado int primary key,
	nombre varchar2(25) ,
	apellidos varchar2(25),
	direccion varchar2(50) ,
	ciudad varchar2(30)  ,
	provincia varchar2(10) ,
	cod_postal varchar2(10) ,
	codigo_area int default 0,
	telefono varchar2(8) 
);

CREATE TABLE pedidos (
	numero_pedido int primary key ,
	fecha_pedido date,
	fecha_envio date ,
	id_cliente int ,
	id_empleado int  ,
	precio_total number(7,2),
	constraint pedidos_fk_cliente foreign key (id_cliente) references clientes,
	constraint pedidos_fk_empleado foreign key (id_empleado) references empleados
);

CREATE TABLE productos (
	numero_producto int primary key ,
	nombre varchar2(50),
	descripcion varchar2(100) ,
	precio_venta number(6,2) default 0,
	stock int default 0,
	id_categoria int default 0,
	constraint productos_fk_categoria foreign key (id_categoria) references categorias
);

CREATE TABLE detalles_pedidos (
	numero_pedido int ,
	numero_producto int ,
	precio number(6,2) default 0,
	cantidad int default 0,
	constraint detalle_pedido_pk primary key(numero_pedido, numero_producto),
	constraint detalle_pedido_fk_pedido foreign key (numero_pedido) references pedidos,
	constraint detalle_pedido_fk_producto foreign key (numero_producto) references productos
);

CREATE TABLE pedidos_historico (
	numero_pedido int primary key,
	fecha_pedido date,
	fecha_envio date ,
	id_cliente int ,
	id_empleado int  ,
	precio_total number(5,2)
);

CREATE TABLE detalles_pedidos_historico(
	numero_pedido int ,
	numero_producto int ,
	precio number(5,2) default 0,
	cantidad int default 0,
	constraint detalle_pedido_fk_h_pedido foreign key (numero_pedido) references pedidos_historico
);

CREATE TABLE proveedores (
	id_prov int primary key,
	nombre varchar2(25)  ,
	direccion varchar2(50)  ,
	ciudad varchar2(30)  ,
	provincia varchar2(15)  ,
	cod_postal varchar2(10)  ,
	telefono varchar2(15)  ,
	fax varchar2(15)  ,
	pag_web varchar2(150)  ,
	email varchar2(50) 
);


CREATE TABLE productos_proveedores (
	numero_producto int,
	id_prov int,
	precio_por_mayor number(6,2),
	dias_envio int,	
	constraint prod_prov_fk_prod foreign key (numero_producto) references productos,
	constraint prod_prov_fk_vend foreign key (id_prov) references proveedores	
);

alter session set nls_date_format='YYYY-MM-DD';