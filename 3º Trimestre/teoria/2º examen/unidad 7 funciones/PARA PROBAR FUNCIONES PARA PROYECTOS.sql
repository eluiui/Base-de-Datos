SELECT
       NOMBRE,
       DEPARTAMENTO,
       FECHA_LANZAMIENTO,
       NUM_DIAS_CREADO(ID_PROYECTO)
   FROM PROYECTOS;
   
   SELECT NUM_DIAS_CREADO(1234);
/*** LISTA DE NOMBRES Y PRESUPUESTO
      DE LOS PROYECTOS
      QUE HACE MÁS DE 100 DÍAS QUE HAN SIDO CREADOS**/
   SELECT   NOMBRE, PRESUPUESTO
     FROM PROYECTOS
     WHERE NUM_DIAS_CREADO(ID_PROYECTO)>100;
     
   /**  MISMA CONSULTA SIN LA FUNCIÓN*/  
   SELECT   NOMBRE, PRESUPUESTO
     FROM PROYECTOS
     WHERE ID_PROYECTO IN 
                        (
                           SELECT ID_PROYECTO
                             FROM PROYECTOS
                             WHERE DATEDIFF(CURRENT_DATE, FECHA_INICIO) >100
                        
                        );
                        
      /** NO EXISTE PROYECTO DE CLAVE 1209**/                  
     SELECT NUM_DIAS_CREADO(1209);  
     
     SELECT
       NOMBRE,
       DEPARTAMENTO  AS PROYECTO,
       FECHA_LANZAMIENTO  AS DIA_LANZADO,
       NUM_DIAS_CREADO(ID_PROYECTO) AS DIAS_LANZADO,
       PRIMER_DIA_TRABAJO(ID_PROYECTO) AS DIAS_DE_TRABAJO
   FROM PROYECTOS;
     
     
  SELECT   NOMBRE  AS PROYECTO,
           PRESUPUESTO  AS PRESUPUESTO,
           CANTIDAD_DIRECTORES_TRABAJAN(ID_PROYECTO) AS NUM_DIRECTORES_TRABAJAN
     FROM PROYECTOS;
     
     /** SUBIR UN 2% EL PRESUPUESTO DE LOS PROYECTOS
         DON ESTÉN TRABAJANDO ALGUN DIRECTOR**/
     
                                 
                              
       UPDATE PROYECTOS 
         SET PRESUPUESTO= PRESUPUESTO*1.02  
         WHERE CANTIDAD_DIRECTORES_TRABAJAN(ID_PROYECTO) !=0;
         
         
      /** LA ORDEN SIN LA EXISTENCIA DE LA FUNCIÓN**/
     UPDATE PROYECTOS  AS P
         SET P.PRESUPUESTO= P.PRESUPUESTO*1.02
         WHERE P.ID_PROYECTO IN 
         
                              (
                                 SELECT     PROYECTO
                                    FROM EMPLEADOS_PROYECTOS
                                    WHERE PROYECTO=P.ID_PROYECTO
                                           AND
                                          EMPLEADO IN (
                                                         SELECT DIRECTOR
                                                            FROM DEPARTAMENTOS
                                                      )
                              
                              );   
         
         