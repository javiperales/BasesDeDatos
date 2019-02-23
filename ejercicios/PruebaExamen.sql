/*1-ejercicio 1 examen de llamadas*/

select ab.nombr_abonado, llama.numer_telef, count(llama.numer_telef) as numero_de_llamadas from  llamada llama, abonado ab
  where llama.numer_telef = ab.numer_telef
    group by llama.numer_telef , ab.nombr_abonado;
    
/*2-ejercicio 2 examen*/

select nombr_abonado from abonado
where numer_telef in (
  select numer_telef from llamada
  group by numer_telef
    having sum(numer_pasos)>1000);


/*3-ejercicio 3 examen*/
select nombr_abonado , numer_telef from abonado
  where numer_telef in (
select numer_telef from llamada
  where ident_horar in (

select ident_horar from horario
  where tipo=2)
  group by numer_telef
  having count(ident_horar)<10)
  
/*4-ejercicio 4 examen*/

select nombr_abonado , numer_telef from abonado
  where numer_telef in (
    select numer_telef from llamada
      group by numer_telef
      having count(distinct(ident_horar))=(
        select count(ident_horar) from horario));
        
/*5-ejercicio 5 examen*/
select nombr_abonado , tipo, count(abonado.numer_telef) from llamada , horario  , abonado 
   where llamada.ident_horar = horario.ident_horar
  and
    abonado.numer_telef=llamada.numer_telef
    group by nombr_abonado , tipo;
  
/*6-ejercicio 6 ecamen*/

select nombr_abonado from abonado
  where numer_telef not in (
    select numer_telef from llamada
    where ident_horar in (
      select ident_horar from horario
      where tipo <> 1));
