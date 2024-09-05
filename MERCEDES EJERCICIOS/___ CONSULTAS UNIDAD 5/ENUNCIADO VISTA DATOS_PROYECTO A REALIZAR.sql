/* ENUNCIADO:
    NECESITAMOS OBTENER UNA VISTA LLAMADA DATOS_PROYECTOS
    QUE OBTENGA PARA CADA PROYECTO EXISTENTE EN LA BASE DE DATOS, LOS SIGUIENTES DATOS
    CLAVE_PROYECTO, NOMBRE_PROYECTO, PRESUPUESTO, 
    CLAVE DEL DEPARTAMENTO, NOMBRE DEL DEPARTAMENTO QUE LO LANZA, 
    FECHA DE COMIENZO DE TRABAJO, CANTIDAD DIÁS FALTAN PARA SU FINALIZACIÓN
    CANTIDAD DE EMPLEADOS TRABAJANDO EN PROYECTO, TOTAL HORAS DE TRABAJO
    CANTIDAD DE SUPERVISORES TRABAJANDO EN PROYECTO, 
    CANTIDAD DE EMPLEADOS QUE PERTENECEN AL MISMO DEPARTAMENTO QUE EL PROYECTO TRABAJANDO EN Él
    ********************/
    
    
    /** contesta  QUÉ pasos para comprobar
        si la relación proyecto tiene  un departamento que lo lanza es optativa u obligatoria
        e decir proyecto paticipa (0,1) o (1,1)
        ***/
        
        
        SELECT     P.ID_PROYECTO AS CLAVE_PROYECTO,
                   P.NOMBRE AS PROYECTO,
                   P.PRESUPUESTO AS PRESUPUESTO,
                   D.NUMERO AS CLAVE_DEPARTAMENTO_LANZA,
                   D.NOMBRE AS DEPARTAMENTO
             FROM PROYECTOS AS P  INNER JOIN DEPARTAMENTOS AS D
                                      ON P.DEPARTAMENTO=D.NUMERO ; /*(1,1)*/ 
                                      
   SELECT      /*POR CADA GRUPO...*/    
                   P.ID_PROYECTO AS CLAVE_PROYECTO,
                   P.NOMBRE AS PROYECTO,
                   P.PRESUPUESTO AS PRESUPUESTO,
                   D.NUMERO AS CLAVE_DEPARTAMENTO_LANZA,
                   D.NOMBRE AS DEPARTAMENTO,
                   MIN(EP.FECHA_INICIO) AS DIA_COMIENZO_TRABAJO,
                   DATEDIFF(P.FECHA_PREV_FIN, CURRENT_DATE()) AS DIAS_FALTAN_FIN,
                   COUNT(EP.EMPLEADO) AS CANTIDAD_EMPLEADOS_TRABAJAN,
                   SUM(EP.NUM_HORAS) AS CANTIDAD_HORAS_DE_TRABAJO
             FROM PROYECTOS AS P  INNER JOIN DEPARTAMENTOS AS D
                                      ON P.DEPARTAMENTO=D.NUMERO  /*(1,1)*/
                                         LEFT JOIN  EMPLEADOS_PROYECTOS AS EP
                                              ON P.ID_PROYECTO=EP.PROYECTO /*(0,N)*/
             GROUP BY P.ID_PROYECTO; /*EP.PROYECTO NO SIRVE PORQUE HE USADO LEFT*/                                 
                                      
   SELECT      /*POR CADA GRUPO...*/    
                   P.ID_PROYECTO AS CLAVE_PROYECTO,
                   P.NOMBRE AS PROYECTO,
                   P.PRESUPUESTO AS PRESUPUESTO,
                   D.NUMERO AS CLAVE_DEPARTAMENTO_LANZA,
                   D.NOMBRE AS DEPARTAMENTO,
                   MIN(EP.FECHA_INICIO) AS DIA_COMIENZO_TRABAJO,
                   DATEDIFF(P.FECHA_PREV_FIN, CURRENT_DATE()) AS DIAS_FALTAN_FIN,
                   COUNT( DISTINCT EP.EMPLEADO) AS CANTIDAD_EMPLEADOS_TRABAJAN,
                   /*SUM(EP.NUM_HORAS) AS CANTIDAD_HORAS_DE_TRABAJO,*/
                   (
                     SELECT  SUM(NUM_HORAS)
                       FROM EMPLEADOS_PROYECTOS
                       WHERE PROYECTO=P.ID_PROYECTO
                   
                   ) AS CANTIDAD_HORAS_DE_TRABAJO,
                   COUNT(DISTINCT EP2.EMPLEADO) AS CANTIDAD_SUPERVISORES_TRABAJANDO,
                   COUNT(DISTINCT EP3.EMPLEADO) AS CANTIDAD_EMPLEADOS_DEL_MISMO_DEP_TRABAJAN                   
             FROM PROYECTOS AS P  INNER JOIN DEPARTAMENTOS AS D
                                      ON P.DEPARTAMENTO=D.NUMERO  /*(1,1)*/
                                         LEFT JOIN  EMPLEADOS_PROYECTOS AS EP
                                              ON P.ID_PROYECTO=EP.PROYECTO /*(0,N)*/
                                                 LEFT JOIN EMPLEADOS_PROYECTOS AS EP2
                                                   ON P.ID_PROYECTO=EP2.PROYECTO 
                                                      AND
                                                      EP2.EMPLEADO IN (
                                                                         SELECT  DISTINCT SUPERVISOR
                                                                            FROM EMPLEADOS
                                                                            WHERE SUPERVISOR IS NOT NULL
                                                                         
                                                                      ) /*(0,N)*/
                                                 LEFT JOIN EMPLEADOS_PROYECTOS AS EP3
                                                      ON P.ID_PROYECTO=EP3.PROYECTO 
                                                         AND
                                                          /* Y TAMBIEN P.DEPARTAMENTO*/
                                                         D.NUMERO=(
                                                                         SELECT  DEPARTAMENTO
                                                                         FROM EMPLEADOS
                                                                         WHERE ID_EMPLEADO=EP3.EMPLEADO
                                                                   ) /*(0,N)*/
                                                                      
                                                
             GROUP BY P.ID_PROYECTO /*EP.PROYECTO NO SIRVE PORQUE HE USADO LEFT*/     
             ORDER BY P.ID_PROYECTO;
                                      
       CREATE VIEW DATOS_PROYECTOS
             AS 
             SELECT      /*POR CADA GRUPO...*/    
                   P.ID_PROYECTO AS CLAVE_PROYECTO,
                   P.NOMBRE AS PROYECTO,
                   P.PRESUPUESTO AS PRESUPUESTO,
                   D.NUMERO AS CLAVE_DEPARTAMENTO_LANZA,
                   D.NOMBRE AS DEPARTAMENTO,
                   MIN(EP.FECHA_INICIO) AS DIA_COMIENZO_TRABAJO,
                   DATEDIFF(P.FECHA_PREV_FIN, CURRENT_DATE()) AS DIAS_FALTAN_FIN,
                   COUNT( DISTINCT EP.EMPLEADO) AS CANTIDAD_EMPLEADOS_TRABAJAN,
                   /*SUM(EP.NUM_HORAS) AS CANTIDAD_HORAS_DE_TRABAJO,*/
                   (
                     SELECT  SUM(NUM_HORAS)
                       FROM EMPLEADOS_PROYECTOS
                       WHERE PROYECTO=P.ID_PROYECTO
                   
                   ) AS CANTIDAD_HORAS_DE_TRABAJO,
                   COUNT(DISTINCT EP2.EMPLEADO) AS CANTIDAD_SUPERVISORES_TRABAJANDO,
                   COUNT(DISTINCT EP3.EMPLEADO) AS CANTIDAD_EMPLEADOS_DEL_MISMO_DEP_TRABAJAN                   
             FROM PROYECTOS AS P  INNER JOIN DEPARTAMENTOS AS D
                                      ON P.DEPARTAMENTO=D.NUMERO  /*(1,1)*/
                                         LEFT JOIN  EMPLEADOS_PROYECTOS AS EP
                                              ON P.ID_PROYECTO=EP.PROYECTO /*(0,N)*/
                                                 LEFT JOIN EMPLEADOS_PROYECTOS AS EP2
                                                   ON P.ID_PROYECTO=EP2.PROYECTO 
                                                      AND
                                                      EP2.EMPLEADO IN (
                                                                         SELECT  DISTINCT SUPERVISOR
                                                                            FROM EMPLEADOS
                                                                            WHERE SUPERVISOR IS NOT NULL
                                                                         
                                                                      ) /*(0,N)*/
                                                 LEFT JOIN EMPLEADOS_PROYECTOS AS EP3
                                                      ON P.ID_PROYECTO=EP3.PROYECTO 
                                                         AND
                                                          /* Y TAMBIEN P.DEPARTAMENTO*/
                                                         D.NUMERO=(
                                                                         SELECT  DEPARTAMENTO
                                                                         FROM EMPLEADOS
                                                                         WHERE ID_EMPLEADO=EP3.EMPLEADO
                                                                   ) /*(0,N)*/
                                                                      
                                                
             GROUP BY P.ID_PROYECTO /*EP.PROYECTO NO SIRVE PORQUE HE USADO LEFT*/     
             ORDER BY P.ID_PROYECTO;
                                      
     /** VAMOS A LANZAR LA VISTA UNA VEZ**/
     /** DAME LOS NOMBRES DE PROYECTOS QUE TENGAN ALGÚN SUPERVISOR TRABAJANDO
        Y QUE TENGAN UN PRESUPUESTO SUPERIOR A 10000 EUROS*/                              
                                    
           SELECT PROYECTO
             FROM DATOS_PROYECTOS
             WHERE CANTIDAD_SUPERVISORES_TRABAJANDO
                   AND
                   PRESUPUESTO>10000;
                                    
                                      
     /** una vez   implementada la vista en la base de datos
         inserta un nuevo proyecto, sin nadie trabajando aún,lanza la vista y verifica su funcionamiento
         inserta un segundo proyecto, y pon a un supervisor trabajando en él,lanza la vista y verifica su funcionamiento 
         inserta u tercer proyecto, y pon a un empleado del mismo departamento trabajando en él
                   y a dos supervisores(claves 7 y 9), lanza la vista y verifica su funcionamiento 
                   ***/
                   
         SELECT * FROM PROYECTOS;   
         /**HEMOS EJECUTADO ESTA ORDEN, HEMOS INSERTADO UN PROYECTO*/
         
         INSERT INTO `empresa`.`PROYECTOS`
         (`NOMBRE`, `DEPARTAMENTO`, `FECHA_INICIO`, `FECHA_PREV_FIN`, `PRESUPUESTO`) 
         VALUES ('PROYECTO NUEVO A', '2', '2023-03-09', '2023-12-31', '120000');          
                   
        SELECT * FROM DATOS_PROYECTOS;
        
        INSERT INTO `empresa`.`PROYECTOS`
        (`NOMBRE`, `DEPARTAMENTO`, `FECHA_INICIO`, `FECHA_PREV_FIN`, `PRESUPUESTO`) 
        VALUES ('PROYECTO NUEVO B', '3', '2023-03-09', '2023-12-20', '500000');
        
        SELECT * FROM EMPLEADOS_PROYECTOS;
        
        INSERT INTO `empresa`.`EMPLEADOS_PROYECTOS` 
        (`EMPLEADO`, `PROYECTO`, `FECHA_INICIO`, `NUM_HORAS`, `PRECIO_HORA`) 
        VALUES ('3', '10', '2023-03-09', '12', '120');
INSERT INTO `empresa`.`EMPLEADOS_PROYECTOS`
 (`EMPLEADO`, `PROYECTO`, `FECHA_INICIO`, `NUM_HORAS`, `PRECIO_HORA`) 
 VALUES ('5', '10', '2023-03-09', '20', '110');
INSERT INTO `empresa`.`EMPLEADOS_PROYECTOS` 
(`EMPLEADO`, `PROYECTO`, `FECHA_INICIO`, `NUM_HORAS`, `PRECIO_HORA`) 
VALUES ('9', '10', '2023-03-09', '100', '120');

SELECT * FROM DATOS_PROYECTOS;
        