DELIMITER $$
USE EMPRESA$$


/*1º*/

DROP TRIGGER IF EXISTS AUDITA_EMPLEADOS_PROYECTOS_INSERT$$
create trigger audita_empleados_proyectos_INSERT
    after insert on empleados_proyectos
for each row
begin

 insert into audita_empleados_proyectos
  values
(concat('INSERCCION-ALTA-REGISTRO -- usuario:  ', user(),'  fecha_hora:  ', now(),'  proyecto:   ',new.proyecto,
         '   empleado :  ', new.empleado));

end$$


/*2º*/

DROP TRIGGER IF EXISTS AUDITA_EMPLEADOS_PROYECTOS_DELETE$$
create trigger audita_empleados_proyectos_delete
     after delete on empleados_proyectos
for each row
begin

 insert into audita_empleados_proyectos
  values 
(concat('BORRADO--REGISTRO-- usuario:   ', user(),'  fecha y hora:  ', now(),'  proyecto:   ',old.proyecto,
          '  empleado: ', old.empleado));

end$$


/*3º*/

DROP TRIGGER IF EXISTS AUDITA_EMPLEADOS_PROYECTOS_UPDATE$$
create trigger audita_empleados_proyectos_update
    after update on empleados_proyectos
for each row
begin

 insert into audita_empleados_proyectos
  values
(concat('MODFICACION --REGISTRO--  usuario:  ', user(),'  fecha-hora:  ', now(),'  proyecto-empleado:  ',new.proyecto,
         ' -- ', new.empleado,  '  numero_horas_old - numero_horas_new  ',old.num_horas,'--', new.num_horas,
               ' precio hora old -- precio hora new   ',old.precio_hora,'---',new.precio_hora
             )
);

end$$