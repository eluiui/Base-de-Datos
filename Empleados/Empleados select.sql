use empresa;
Select *from empleados;
/*como no hay where le digo que selecione todas las tuplas
----------------------------------------------------------------------*/

/*nombre y salario de los empleadosque pertenecen  al departamento de clave 1*/
Select nombre, salario
	from empleados
    where Departamento=1;
    
/* clave y salario de los empleados que no pertenecen a los departamentos de clave uno o dos*/
Select id_empleado, salario
	from empleados
	where departamento !=1 and departamento !=2;

/*ordenamos por salario y a igual salario por clave primaria*/
Select nombre, salario
	from empleados
    where Departamento=1
    order by salario desc;
    
    
Select id_empleado ,nombre ,departamento
	from empleados
    where salario>1000
		and 
        (departamento=2 or departamento=3 or departamento=4);
        
/* operador iny operador no in*/
/*obtener nombre y fecha DE NACIMIENMTO DE LOS EMPELADOS PERTENECIENTES A LOS DEPARtamentod */