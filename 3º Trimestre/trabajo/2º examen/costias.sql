update empleados
	set salario=salario*1.02
    where id_empleado in (
                          select director
							from departamentos
                           );
                           
update empleados as e inner join departamentos as d
                   on e.id_empleado=d.director
	set salario=salario*1.02
    where num_empleados_dep(d.numero)>3;
    /*en where uso la funcion que acabo de crear*/
    
        /*con uso fincion*/
select nombre as departamento,
       num_empleados_dep(numero)
	from departamentos;

 /*sin uso de funcion */   
select nombre as departamento,
       (
       select count(*)
		from empleados as e
        where departamento=d.numero
       ) as cantidad_empleados
	from departamentos as d;
    
    
select d.nombre as departamento,
	   count(e.id_empleado) as cantidad_empleados
	from departamentos as d left join empleados as e
							 on d.numero=e.departamento
	group by d.numero;
