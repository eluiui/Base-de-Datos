/***  DIME DE CADA SUPERVISOR EN CUANTOS PROYECTOS TRABAJA,
       SOLO INTERESAN LOS SUPERVISORES
       QUE ESTÁN TRABAJANDO EN ALGÚN PROYECTO
      **/

SELECT   EMPLEADO AS CLAVE_SUPERVISOR,
         COUNT(*) AS CANTIDAD_PROYECTOS_TRABAJA
   FROM EMPLEADOS_PROYECTOS AS EP
   WHERE EMPLEADO IN (
                        SELECT DISTINCT  SUPERVISOR
                           FROM EMPLEADOS
                           WHERE SUPERVISOR IS NOT NULL
                           
                       
                     )
   GROUP BY EMPLEADO;  
   
  /** DIME EL VALOR MAYOR DE CANTIDAD DE PROYECTOS
      EN LOS QUE TRABAJA UN SUPERVIOR**/
      
  /*AQUI NECESITO HACER UNA CONSULTA EN TABLA DERIVADA*/    
      
  SELECT   MAX(CANTIDAD_PROYECTOS_TRABAJA) AS VALOR
    FROM (
           SELECT   EMPLEADO AS CLAVE_SUPERVISOR,
                    COUNT(*) AS CANTIDAD_PROYECTOS_TRABAJA
             FROM EMPLEADOS_PROYECTOS AS EP
             WHERE EMPLEADO IN (
                        SELECT DISTINCT  SUPERVISOR
                           FROM EMPLEADOS
                           WHERE SUPERVISOR IS NOT NULL
                           
                       
                     )
            GROUP BY EMPLEADO
    
    
             ) AS TABLA_DERIVADA;
   
     /** DIME QUIEN ES , DAME SU CLAVE,
         EL SUPERVISOR QUE ES EL QUE MÁS PROYECTOS TRABAJA
         **/                 
                     
  SELECT   CLAVE_SUPERVISOR
     FROM 
     (
     
       SELECT   EMPLEADO AS CLAVE_SUPERVISOR,
         COUNT(*) AS CANTIDAD_PROYECTOS_TRABAJA
        FROM EMPLEADOS_PROYECTOS AS EP
        WHERE EMPLEADO IN (
                        SELECT DISTINCT  SUPERVISOR
                           FROM EMPLEADOS
                           WHERE SUPERVISOR IS NOT NULL
                           
                       
                     )
        GROUP BY EMPLEADO
     
     
     ) AS TABLA_DERIVADA
     WHERE CANTIDAD_PROYECTOS_TRABAJA =
           (
            SELECT   MAX(CANTIDAD_PROYECTOS_TRABAJA) 
            FROM 
              (
                    SELECT   EMPLEADO AS CLAVE_SUPERVISOR,
                    COUNT(*) AS CANTIDAD_PROYECTOS_TRABAJA
             FROM EMPLEADOS_PROYECTOS AS EP
             WHERE EMPLEADO IN (
                        SELECT DISTINCT  SUPERVISOR
                           FROM EMPLEADOS
                           WHERE SUPERVISOR IS NOT NULL
                           
                       
                     )
            GROUP BY EMPLEADO
    
    
             ) AS TABLA_DERIVADA         
           
           
           
           
           );