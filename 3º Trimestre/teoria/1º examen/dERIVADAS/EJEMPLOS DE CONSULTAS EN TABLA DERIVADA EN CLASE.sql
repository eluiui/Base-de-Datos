/** OBTENER PARA CADA EMPLEADO,
     SU CLAVE, CANTIDAD PROYECTOS TRABAJA,
      Y TOTAL DE HORAS QUE TRABAJA**/
      
SELECT  EP.EMPLEADO AS CLAVE,
        COUNT(*) AS CANTIDAD_PROYECTOS,
        SUM(EP.NUM_HORAS) AS TOTAL_HORAS
    FROM EMPLEADOS_PROYECTOS AS EP
    GROUP BY EP.EMPLEADO;
    
/** INFORME PARA LOS EMPLEADOS QUE TRABAJAN EN MÁS DE DOS PROYECTOS**/

  SELECT  EP.EMPLEADO AS CLAVE,
        COUNT(*) AS CANTIDAD_PROYECTOS,
        SUM(EP.NUM_HORAS) AS TOTAL_HORAS
    FROM EMPLEADOS_PROYECTOS AS EP
    GROUP BY EP.EMPLEADO
    HAVING COUNT(*) >2;  
    
    
/* CLAVE DE EL/LOS EMPLEADOS
    QUE ES EL QUE MÁS PROYECTOS TRABAJA 
   **/
   
   
   SELECT  EP.EMPLEADO AS CLAVE,
           COUNT(*) AS CANTIDAD_PROYECTOS
        
    FROM EMPLEADOS_PROYECTOS AS EP
    GROUP BY EP.EMPLEADO;
  /* AHORA ESTA CONSULTA, SE CONVIERTE EN UNA SUBCONSULTA DETRAS DE FROM
   ---> HACER UNA CONSULTA EN TABLA DERIVADA**/
 /** DIME EL VALOR DE LA MAYOR CANTIDAD DE PROYECTOS EN LOS QUE TRABAJA
    ALGÚN EMPLEADO*/
   SELECT    MAX(CANTIDAD_PROYECTOS)
      FROM 
      (
      SELECT  EP.EMPLEADO AS CLAVE,
               COUNT(*) AS CANTIDAD_PROYECTOS
        
         FROM EMPLEADOS_PROYECTOS AS EP
         GROUP BY EP.EMPLEADO
      
      ) AS TABLA_DERIVADA ;
      
      
  
    
      