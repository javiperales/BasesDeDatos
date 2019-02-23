--drop table llamada;

create table llamada  (
ident_llamada varchar2(20) primary key not null,
ident_horar varchar2(20),
numer_telef number(9),
numer_pasos number)

--drop table horario
create table horario (
ident_horar varchar2(20) ,
tipo number(2),
prec_paso number(10,2),
constraint ident_horar_pk primary key(ident_horar))

create table abonado (
numer_telef number(9) primary key,
nombr_abonado varchar2(20))

insert into llamada values ('1111','1111', '666555333', '10');
insert into llamada values ('2222','2222', '666555223', '5');
insert into llamada values ('7676','5555', '666566633', '6');

insert into horario values ('1111', '1', '2');
insert into horario values ('2222', '2', '3');
insert into horario values ('7676', '2', '4');

insert into abonado values (666555333, 'juan');
insert into abonado values (666555223, 'alberto');
insert into abonado values (666566633, 'oscarin');


select ab.numer_telef , ab.nombr_abonado , llama.ident_llamada , count(llama.ident_llamada) as numero from abonado ab join llamada llama on ab.numer_telef=llama.numer_telef

select nombr_abonado from abonado
where numer_telef in (
  select numer_telef from llamada
    where numer_pasos=1000);
    
