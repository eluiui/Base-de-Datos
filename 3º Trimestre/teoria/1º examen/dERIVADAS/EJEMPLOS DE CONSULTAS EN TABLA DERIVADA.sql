/****consultas en tabla derivada****************/

/** primera consulta: por ejemplo:
     para cada empleado obtener
     su clave y la cantidad de proyectos
     en los que trabaja, 
     (sólo empleados con algún egistro de trabajo)**/
select
      empleado as clave,
      count(*) as cantidad_proyectos_trabaja 
       
    from empleados_proyectos as ep
    group by ep.empleado;
    
   /*** segundo enunciado:
        dame el valor de la media de cantidad de proyectos
        en los que trabaja un empleado**/
    /** osea, por termino medio, cuál es la cantidad de proyectos
        en los que trabajan los empleados de mi empresa
    **********/    
    /**** TENGO QUE OBTENER AVG DE UNA COLUMNA QUE PREVIAMENTE
           HAY QUE CALCULAR****/
    /*** ESO ES LO QUE HACE NECESARIO USAR CONSULTAS EN TABLAS DERIVADAS;
         DETRÁS DE CLÁUSULA FROM PONEMOS UNA SUBCONSULTA CON ALIAS
         ENTONCES, LEEMOS DE TABLA : ALIAS, TABLA QUE DEVUELVE LA SUBCONSULTA
         *************/
           
      select  avg(cantidad_proyectos_trabaja)
         from 
         (
         select
               empleado as clave,
               count(*) as cantidad_proyectos_trabaja 
       
         from empleados_proyectos as ep
         group by ep.empleado
        
         
         ) as tabla_derivada;
         
         
  /*** TERCER ENUNCIADO:
       dame la clave/claves del empleado/S que trabajan en más proyectos
       que  la media **/  
       
       
   /*** primero obtengo mediante una consulta en tabla derivada
        el valor de la media**/   
   select  avg(cantidad_proyectos_trabaja)  into @dato
         from 
         (
         select
               empleado as clave,
               count(*) as cantidad_proyectos_trabaja 
       
         from empleados_proyectos as ep
         group by ep.empleado
        
         
         ) as tabla_derivada;    
  
 /*** ahora obtengo el resultado:*/  
    select   clave
        from
        
         (select
               empleado as clave,
               count(*) as cantidad_proyectos_trabaja 
       
           from empleados_proyectos as ep
          group by ep.empleado
        
         
         ) as tabla_derivada 
         where cantidad_proyectos_trabaja >=@dato;
         
         
     /** sin usar variable de sesión**/   
     
    select   clave
        from
        
         (select
               empleado as clave,
               count(*) as cantidad_proyectos_trabaja 
       
           from empleados_proyectos as ep
          group by ep.empleado
        
         
         ) as tabla_derivada 
         where cantidad_proyectos_trabaja >=
             (
             select  avg(cantidad_proyectos_trabaja)
                 from 
                  (
                       select
                           empleado as clave,
                           count(*) as cantidad_proyectos_trabaja 
       
                        from empleados_proyectos as ep
                       group by ep.empleado
        
         
                  ) as tabla_derivada
             
             
             ); 
     
     
     /*** dame la clave del empleado de ventas que sea el empleado
          que trabaja en más proyectos de entre todos los ventas**/
          
          /** primero diseño esta consulta**/
          
         select   empleado as clave_EMPLEADO_VENTAS,
                  count(*) as cantidad_proyectos_trabaja
             from empleados_proyectos
             where empleado in (
                                 select  id_empleado
                                    from empleados
                                    where departamento=(
                                                         select numero
                                                            from departamentos
                                                            where nombre='ventas'
                                                       )
                               )
             group by empleado;
          
       /** ahora necesitamos leer de esta consulta,
           entonces aparece necesidad de usar consulta en tabla derivada
           ***/
           
           
           
           select  max(cantidad_proyectos_trabaja) 
               from 
                (
                
                 select   empleado as clave,
                           count(*) as cantidad_proyectos_trabaja
                 from empleados_proyectos
                  where empleado in (
                                 select  id_empleado
                                    from empleados
                                    where departamento=(
                                                         select numero
                                                            from departamentos
                                                            where nombre='ventas'
                                                       )
                               )
             group by empleado
                
                
                
                ) as datos;
                
                
    /* EL DATO LO PODEMOS GUARDAR EN MEMORIA EN UNA VARIABLE DE SESIÓN */
    
    
    
    select  max(cantidad_proyectos_trabaja) into @max
               from 
                (
                
                 select   empleado as clave,
                           count(*) as cantidad_proyectos_trabaja
                 from empleados_proyectos
                  where empleado in (
                                 select  id_empleado
                                    from empleados
                                    where departamento=(
                                                         select numero
                                                            from departamentos
                                                            where nombre='ventas'
                                                       )
                               )
             group by empleado
                
                
                
                ) as datos;
                
    /** dime la clave/claves de los enpleados de ventas
       que son los más trabajadores,
        es decir, están trabajando en el mayor  número de proyectos de entre todos los de ventas**/
        
       SELECT @MAX; 
        
        SELECT    CLAVE
           FROM 
                (               
                 select    empleado as clave,
                           count(*) as cantidad_proyectos_trabaja
                 from empleados_proyectos
                  where empleado in (
                                 select  id_empleado
                                    from empleados
                                    where departamento=(
                                                         select numero
                                                            from departamentos
                                                            where nombre='ventas'
                                                       )
                               )
             group by empleado           
                
           ) as datos
           WHERE  CANTIDAD_PROYECTOS_TRABAJA=@MAX;
                
   /** SIN USAR VARIABLE DE SESIÓN , SI USAR @MAX**/        
           
           
       SELECT    CLAVE
           FROM 
                (               
                 select   empleado as clave,
                           count(*) as cantidad_proyectos_trabaja
                 from empleados_proyectos
                  where empleado in (
                                 select  id_empleado
                                    from empleados
                                    where departamento=(
                                                         select numero
                                                            from departamentos
                                                            where nombre='ventas'
                                                       )
                               )
             group by empleado           
                
           ) as datos
           WHERE  CANTIDAD_PROYECTOS_TRABAJA =
                ( select  max(cantidad_proyectos_trabaja) 
                     from 
                          (
                
                           select   empleado as clave,
                           count(*) as cantidad_proyectos_trabaja
                        from empleados_proyectos
                        where empleado in (
                                 select  id_empleado
                                    from empleados
                                    where departamento=(
                                                         select numero
                                                            from departamentos
                                                            where nombre='ventas'
                                                       )
                               )
                      group by empleado
                
                
                
                        ) as datos
               ) ;
                
                                              
                
               
          
           
                
                
                