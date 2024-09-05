/**   PARA CADA PROYECTO QUE ESTÉ CON TRABAJO INICIADO, OBTENER:
     SU CLAVE, LA CANTIDAD DE EMPLEADOS TRABAJANDO EN ÉL, TOTAL HORAS DE TRABAJO,
     LA CANTIDAD DE EMPLEADOS SUPERVISADOS TRABAJANDO EN ÉL**/
     
	select p.id_proyecto as clave,
		count(ep.empleado) as cantidad_empleados,
        sum(ep.num_horas) as total_horas,
        count(e.supervisor is not null) as cantidad_empleados_supervisados
		
	from proyectos as p
	left join empleados_proyectos as ep
		on ep.proyecto=p.id_proyecto
	left join empleados as e
		on ep.empleado=e.id_empleado
	group by p.id_proyecto;
   
   
   /*** MODIFICA LA CONSULTA ANTERIOR:
          PARA CADA PROYECTO QUE ESTÉ CON TRABAJO INICIADO, Y TENGA MÁS DE 3 EMPLEADOS TRABAJANDO
          OBTENER:
          SU CLAVE, LA CANTIDAD DE EMPLEADOS TRABAJANDO EN ÉL, TOTAL HORAS DE TRABAJO,
          LA CANTIDAD DE EMPLEADOS SUPERVISADOS TRABAJANDO EN ÉL**/
          
     select p.id_proyecto as clave,
		count(ep.empleado) as cantidad_empleados,
        sum(ep.num_horas) as total_horas,
        count(e.supervisor is not null) as cantidad_empleados_supervisados
		
	from proyectos as p
	left join empleados_proyectos as ep
		on ep.proyecto=p.id_proyecto
	left join empleados as e
		on ep.empleado=e.id_empleado
	where count(ep.empleado)>3
	group by p.id_proyecto;     
          
          
          
     
/**PARA CADA POYECTO QUE ESTÉ CON TRABAJO INICIADO, OBTENER:
   SU CLAVE, NOMBRE DE PROYECTO Y PRESUPUESTO, CANTIDAD DE EMPLEADOS TRABAJANDO EN EL PROYECTO,
   CANTIDAD DE EMPLEADOS QUE PERTENEZCAN AL MISMO DEPARTAMENTO QUE EL PROYECTO TRABAJANDO EN Él
   
   *****/
   
   select p.id_proyecto as clave,
		p.nombre as nombre,
		count(ep.empleado) as cantidad_empleados,
        count(d.numero) as cantidad_empleados_departamento
		
	from proyectos as p
	left join empleados_proyectos as ep
		on ep.proyecto=p.id_proyecto
	left join departamentos as d
		on p.departamento=d.numero
	group by p.id_proyecto;   