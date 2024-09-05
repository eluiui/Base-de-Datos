/*** para cada empleado obtener
     su nombre, salario,
     el nombre de su departamento
     y la cantidad de empleados a los que supervisa
          a) informe para sólo empleados que supervisan
          b) informe para todos los empleados de la empresa
     ****/
     
     
     /*opción a)*/
     
     
     SELECT      E.NOMBRE AS EMPLEADO,
                 E.SALARIO AS SU_SALARIO,
                 D.NOMBRE AS SU_DEPARTAMENTO,
                 COUNT(*)  AS CANTIDAD_DE_SUPERVISADOS
          FROM EMPLEADOS AS E INNER JOIN DEPARTAMENTOS AS D
                                ON E.DEPARTAMENTO=D.NUMERO  /*(1,1)*/
                                    INNER JOIN EMPLEADOS AS ESADOS
                                          ON E.ID_EMPLEADO=ESADOS.SUPERVISOR  /*(0,N)*/
                                  /*CON JOIN DE TIPO INNER ME QUEDO, SELECCIONO A LOS SUPERVISORES*/
          GROUP BY E.ID_EMPLEADO;  
          
          
          /*b) informe para todos los empleados de la empresa*/
          
          
          SELECT    E.NOMBRE AS EMPLEADO,
                    E.SALARIO AS SU_SALARIO,
                    D.NOMBRE AS SU_DEPARTAMENTO,
                    COUNT(ESADOS.ID_EMPLEADO) AS CANTIDAD_DE_EMPLEADOS_SUPERVISADOS
              FROM EMPLEADOS AS E INNER JOIN DEPARTAMENTOS AS D
                                ON E.DEPARTAMENTO=D.NUMERO  /*(1,1)*/
                                   LEFT JOIN EMPLEADOS AS ESADOS
                                        ON E.ID_EMPLEADO=ESADOS.SUPERVISOR /*(0,N)*/
              GROUP BY E.ID_EMPLEADO; 
              
              /* EN ESTA SEGUNDA OPCIÓN ME PIDEN TODOS LOS EMPLEADOS,Ç
                 Y NO TODOS COMBINAN, PORQUE NO TODOS  SON SUPERVISORES
                 NECESITO USAR LEFT JOIN**/
                 
           /** A PARTIR DEL INFORME ANTERIOR, OBTENER TAMBIÉN, AÑADIR
           PARA CADA EMPLEADO LA CANTIDAD DE PROYECTOS EN LOS QUE TRABAJA**/
           
           SELECT    E.NOMBRE AS EMPLEADO,
                     E.SALARIO AS SU_SALARIO,
                     E.FECHA_NAC AS SU_FECHA_NACIMIENTO,
                     D.NOMBRE AS SU_DEPARTAMENTO,
                     D.DIRECTOR AS CLAVE_DE_SU_DIRECTOR,
                     COUNT(DISTINCT ESADOS.ID_EMPLEADO) AS CANTIDAD_DE_EMPLEADOS_SUPERVISADOS,
                     COUNT(DISTINCT EP.PROYECTO) AS CANTIDAD_DE_PROYECTOS_TRABAJA
              FROM EMPLEADOS AS E INNER JOIN DEPARTAMENTOS AS D
                                ON E.DEPARTAMENTO=D.NUMERO  /*(1,1)*/
                                   LEFT JOIN EMPLEADOS AS ESADOS
                                        ON E.ID_EMPLEADO=ESADOS.SUPERVISOR /*(0,N)*/
                                           LEFT JOIN EMPLEADOS_PROYECTOS AS EP
                                                  ON E.ID_EMPLEADO=EP.EMPLEADO /*(0,N)**/
              GROUP BY E.ID_EMPLEADO; 
              
              /*HEMOS UTILIZADO MÁS DE UNA COMBINACIÓN A MUCHOS**/
              
              
   /* A ESTE INFORME, AÑADIR PARA CADA EMPLEADO ADEMÁS LA CANTIDAD DE EMPLEADOS QUE DIRIGE  */       
     SELECT    E.NOMBRE AS EMPLEADO,
                     E.SALARIO AS SU_SALARIO,
                     E.FECHA_NAC AS SU_FECHA_NACIMIENTO,
                     D.NOMBRE AS SU_DEPARTAMENTO,
                     D.DIRECTOR AS CLAVE_DE_SU_DIRECTOR,
                     COUNT(DISTINCT ESADOS.ID_EMPLEADO) AS CANTIDAD_DE_EMPLEADOS_SUPERVISADOS,
                     COUNT(DISTINCT EP.PROYECTO) AS CANTIDAD_DE_PROYECTOS_TRABAJA
              FROM EMPLEADOS AS E INNER JOIN DEPARTAMENTOS AS D
                                ON E.DEPARTAMENTO=D.NUMERO  /*(1,1)*/
                                   LEFT JOIN EMPLEADOS AS ESADOS
                                        ON E.ID_EMPLEADO=ESADOS.SUPERVISOR /*(0,N)*/
                                           LEFT JOIN EMPLEADOS_PROYECTOS AS EP
                                                  ON E.ID_EMPLEADO=EP.EMPLEADO /*(0,N)**/
                                                     LEFT JOIN EMPLEADOS AS E2
                                                           ON E.ID_EMPLEADO = ( LA CLAVE  DIRECTOR DEL DEPARTAMENTO DE E2)
                                                           
              GROUP BY E.ID_EMPLEADO; 
          
          
  SELECT             E.NOMBRE AS EMPLEADO,
                     E.SALARIO AS SU_SALARIO,
                     E.FECHA_NAC AS SU_FECHA_NACIMIENTO,
                     D.NOMBRE AS SU_DEPARTAMENTO,
                     D.DIRECTOR AS CLAVE_DE_SU_DIRECTOR,
                     COUNT(DISTINCT ESADOS.ID_EMPLEADO) AS CANTIDAD_DE_EMPLEADOS_SUPERVISADOS,
                     COUNT(DISTINCT EP.PROYECTO) AS CANTIDAD_DE_PROYECTOS_TRABAJA,
                     COUNT(DISTINCT E2.ID_EMPLEADO) AS CANTIDAD_EMPLEADOS_DIRIGIDOS
              FROM EMPLEADOS AS E INNER JOIN DEPARTAMENTOS AS D
                                ON E.DEPARTAMENTO=D.NUMERO  /*(1,1)*/
                                   LEFT JOIN EMPLEADOS AS ESADOS
                                        ON E.ID_EMPLEADO=ESADOS.SUPERVISOR /*(0,N)*/
                                           LEFT JOIN EMPLEADOS_PROYECTOS AS EP
                                                  ON E.ID_EMPLEADO=EP.EMPLEADO /*(0,N)**/
                                                     LEFT JOIN EMPLEADOS AS E2 /*LEFT PORQUE NO TODOS LOS E, SON DIRECTORES Y NO QUIERO PERDERLOS*/
                                                           ON E.ID_EMPLEADO = (SELECT  DIRECTOR
                                                                                 FROM   DEPARTAMENTOS 
                                                                                 WHERE NUMERO=E2.DEPARTAMENTO 
                                                                               )
                                                           
              GROUP BY E.ID_EMPLEADO;       
              
              
  /*****
      PARA CADA DIRECTOR, SU NOMBRE, SALARIO,
      NOMBRE DEL DEPARTAMENTO QUE DIRIGE Y CANTIDAD DE EMPLEADOS A LOS QUE DIRIGE**/
      
      
    SELECT    /*DE CADA TUPLA SELECCIONADA*/
               ED.NOMBRE AS DIRECTOR,
               ED.SALARIO AS SU_SALARIO,
               D.NOMBRE AS DEPARTAMENTO_DIRIGE
        FROM EMPLEADOS AS ED INNER JOIN DEPARTAMENTOS AS D
                               ON ED.ID_EMPLEADO=D.DIRECTOR; /*(0,1)*/ 
      
     SELECT    /*DE CADA GRUPO*/
               ED.NOMBRE AS DIRECTOR,
               ED.SALARIO AS SU_SALARIO,
               D.NOMBRE AS DEPARTAMENTO_DIRIGE,
               COUNT(E2.ID_EMPLEADO) AS CANTIDAD_EMPLEADOS_DIRIGE
        FROM EMPLEADOS AS ED INNER JOIN DEPARTAMENTOS AS D
                               ON ED.ID_EMPLEADO=D.DIRECTOR /*(0,1)*/ 
                                  LEFT JOIN EMPLEADOS AS E2
                                            ON D.NUMERO=E2.DEPARTAMENTO  /*(0,N)*/
        GROUP BY ED.ID_EMPLEADO, D.DIRECTOR,D.NUMERO ;                                   
       
      
   /***** DE OTRA FORMA DE SELECCIONAR A LOS DIRECTORES SIN USAR INNER JOIN 
      PARA CADA DIRECTOR, SU NOMBRE, SALARIO,
      **/   
      
      
      SELECT   ED.NOMBRE AS DIRECTOR,
               ED.SALARIO AS SU-SALARIO
          FROM EMPLEADOS AS ED
          WHERE ED.ID_EMPLEADO IN ( LISTA DE CLAVES QUE TE PASO  );
          
          
      SELECT   ED.NOMBRE AS DIRECTOR,
               ED.SALARIO AS SU_SALARIO
          FROM EMPLEADOS AS ED
          WHERE ED.ID_EMPLEADO IN ( 
                                     SELECT  DIRECTOR
                                       FROM DEPARTAMENTOS
                                  );  
      
      
      /*** PARA CADA EMPLEADO SU NOMBRE Y NOMBRE DE SU DEPARTAMENTO*/  
      
      SELECT       E.NOMBRE AS EMPLEADO,
                   D.NOMBRE AS SU_DEPARTAMENTO
          FROM EMPLEADOS AS E INNER JOIN DEPARTAMENTOS AS D
                                ON E.DEPARTAMENTO=D.NUMERO;  /*(1,1)*/
                                
                                
      SELECT      /*PARA CADA TUPLA SELECCIONADA*/
                 NOMBRE AS EMPLEADO,
                 (
                   SELECT  NOMBRE
                      FROM DEPARTAMENTOS
                      WHERE NUMERO=E.DEPARTAMENTO
                 ) AS SU_DEPARTAMENTO  
                 /*ESTA SUBCONSULTA SE EJECUTA UNA VEZ POR CADA TUPLA E*/
                 
          FROM EMPLEADOS AS E; 
          
      /* REALIZAR EN CASA Y ENTREGAR EN EL AULA VIRTUAL**/  

	  
    /**PARA LOS EMPLEADOS QUE PERTENEZCAN A LOS DEPARTAMENTOS DE  VENTAS Y MARKETING
        OBTENER SU NOMBRE Y CANTIDAD DE PROYECTOS EN LOS QUE TRABAJAN
        ***/
        
        SELECT    E.NOMBRE AS EMPLEADO,
                  D.NOMBRE AS SU_DEPARTAMENTO,
                  COUNT(EP.PROYECTO) AS CANTIDAD_PROYECTOS_TRABAJA
            FROM EMPLEADOS AS E INNER JOIN DEPARTAMENTOS AS D
                                 ON E.DEPARTAMENTO=D.NUMERO /*(1,1) PERTENECER A DPTO*/
                                    LEFT JOIN EMPLEADOS_PROYECTOS AS EP
                                           ON E.ID_EMPLEADO=EP.EMPLEADO /*(0,N)*/
            WHERE D.NOMBRE='VENTAS' OR D.NOMBRE='MARKETING'
            GROUP BY E.ID_EMPLEADO;
        
   /* OTRA FORMA MÁS EFICIENTE**/
   
   SELECT    E.NOMBRE AS EMPLEADO,
                  D.NOMBRE AS SU_DEPARTAMENTO,
                  COUNT(EP.PROYECTO) AS CANTIDAD_PROYECTOS_TRABAJA
            FROM EMPLEADOS AS E INNER JOIN DEPARTAMENTOS AS D
                                 ON  E.DEPARTAMENTO=D.NUMERO /*(1,1) PERTENECER A DPTO*/
                                        AND
                                     (D.NOMBRE='VENTAS' OR D.NOMBRE='MARKETING')
                                      LEFT JOIN EMPLEADOS_PROYECTOS AS EP
                                           ON E.ID_EMPLEADO=EP.EMPLEADO /*(0,N)*/
            GROUP BY E.ID_EMPLEADO;
            
/*** DE OTRA FORMA: UTILIZANDO UNA SUBCONSULTA PARA SELECCIONAR EMPLEADOS)*/            
         
         
           SELECT       /*POR CADA TUPLA SELECCIONADA.*/
                       E.NOMBRE AS EMPLEADO,
                        (
                           SELECT COUNT(*)
                               FROM EMPLEADOS_PROYECTOS
                               WHERE EMPLEADO=E.ID_EMPLEADO
                                               /*ESTO ES UNA SUBCONSULTA CORRELACIONADA*/
                        ) AS CANTIDAD_PROYECTOS_TRABAJA
                     
              FROM EMPLEADOS AS E
              WHERE  E.DEPARTAMENTO = (   SELECT  NUMERO
                                           FROM DEPARTAMENTOS
                                           WHERE NOMBRE='VENTAS'
                                      )  /* ESTA CONSULTA SEGURO RETORNA UN DATRO XQ NOMBRE ES AK*/
                     OR 
                     E.DEPARTAMENTO= (   SELECT  NUMERO
                                           FROM DEPARTAMENTOS
                                           WHERE NOMBRE='MARKETING'   
                                    ); 
                                    
    /* O TAMBIÉN*/                                 
        
          SELECT       /*POR CADA TUPLA SELECCIONADA.*/
                       E.NOMBRE AS EMPLEADO,
                        (
                           SELECT COUNT(*)
                               FROM EMPLEADOS_PROYECTOS
                               WHERE EMPLEADO=E.ID_EMPLEADO
                                               /*ESTO ES UNA SUBCONSULTA CORRELACIONADA*/
                        ) AS CANTIDAD_PROYECTOS_TRABAJA                 
              FROM EMPLEADOS AS E
              WHERE  E.DEPARTAMENTO IN  (   
                                           SELECT  NUMERO
                                             FROM DEPARTAMENTOS
                                             WHERE NOMBRE='VENTAS'  OR NOMBRE='MARKETING'
                                        );  
                     
        
         
        
        
        
        
   /**PARA TODOS LOS EMPLEADOS
       SU NOMBRE Y CANTIDAD DE PROYECTOS EN LOS QUE TRABAJAN
          PROYECTOS  QUE SEAN DE LANZADOS POR VENTAS O MARKETING**/        
        
        
        
    SELECT   
            E.NOMBRE AS EMPLEADO,
            (
                SELECT   COUNT(*)
                   FROM EMPLEADOS_PROYECTOS 
                   WHERE EMPLEADO=E.ID_EMPLEADO  /*EMPLEADO EN EL QUE VOY, CORRELACIONDA*/
                         AND
                         PROYECTO IN ( 
                                       SELECT ID_PROYECTO
                                         FROM PROYECTOS
                                         WHERE DEPARTAMENTO IN (
                                                                   SELECT  NUMERO
                                                                      FROM DEPARTAMENTOS
                                                                      WHERE NOMBRE='VENTAS' OR NOMBRE='MARKETING'
                                                               )
                                     )
            
            )  AS CANTIDAD_PROYECTOS_TRABAJA_DE_VENTAS_O_MARKETING
            
        FROM EMPLEADOS AS E;
     /*HEMOS USADO SUBCONSULTAS ANIDADAS**/   
        
    
    
/** DE OTRA FORMA PARECIDA*/    
    
    
    SELECT   
            E.NOMBRE AS EMPLEADO,
            (
                SELECT   COUNT(*)
                   FROM EMPLEADOS_PROYECTOS 
                   WHERE EMPLEADO=E.ID_EMPLEADO  /*EMPLEADO EN EL QUE VOY, CORRELACIONDA*/
                         AND
                         PROYECTO IN ( 
                                       SELECT   P.ID_PROYECTO
                                           FROM PROYECTOS AS P INNER JOIN DEPARTAMENTOS AS D
                                                                  ON P.DEPARTAMENTO=D.NUMERO
                                                                     AND
                                                                     (D.NOMBRE='MARKETING' OR D.NOMBRE='VENTAS')
                                     )
            
            )  AS CANTIDAD_PROYECTOS_TRABAJA_DE_VENTAS_O_MARKETING
            
        FROM EMPLEADOS AS E;
        
    
   /** DE OTRA FORMA**/
   
     SELECT     /*POR CADA GRUPO*/
     
               E.NOMBRE AS EMPLEADO,
               COUNT(EP.PROYECTO) AS CANTIDAD_PROYECTOS_TRABAJA_DE_MARKETING_O_VENTAS
        FROM EMPLEADOS AS E LEFT JOIN EMPLEADOS_PROYECTOS AS EP
                                       ON E.ID_EMPLEADO=EP.EMPLEADO  /*(0,N)*/
        WHERE EP.PROYECTO IN ( 
                                SELECT   P.ID_PROYECTO
                                 FROM PROYECTOS AS P INNER JOIN DEPARTAMENTOS AS D
                                                       ON  P.DEPARTAMENTO=D.NUMERO
                                                           AND
                                                          (D.NOMBRE='MARKETING' OR D.NOMBRE='VENTAS')
                              )
                          OR EP.PROYECTO IS NULL
        
        GROUP BY E.ID_EMPLEADO;
    

    
  