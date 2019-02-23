disconnect system
connect ventas/1234

drop table categorias cascade constraints;
drop table clientes cascade constraints;
drop table empleados cascade constraints;
drop table detalles_pedidos cascade constraints;
drop table detalles_pedidos_historico cascade constraints;
drop table pedidos cascade constraints;
drop table pedidos_historico cascade constraints;
drop table productos_proveedores cascade constraints;
drop table productos cascade constraints;
drop table proveedores cascade constraints;
disconnect ventas
exit