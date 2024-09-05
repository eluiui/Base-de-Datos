
/********* Combinación inner join de tablas
                    combinación interna ******************************************

/**  1 PARA CADA EMPLEADO DE LA EMPRESA
  SU CLAVE, SU NOMBRE Y SALARIO Y
    EL NOMBRE DEL DEPARTAMENTO
    AL QUE PERTENECE**/
    
    /***** LOS DATOS QUE ME PIDEN NO ESTÁN EN LA MISMA TABLA
        ESTÁN EN DOS TABLAS DISTINTAS
        
      SU CLAVE, SU NOMBRE Y SALARIO  ESTÁN  EN EMPLEADOS
      EL NOMBRE DEL DEPARTAMENTO ESTÁ EN LA TABLA DEPARTAMENTOS
      ***/
      
      /*** NECESITO MÁS DE UNA TABLA
           DOS TABLAS**/
           
      SELECT  E.ID_EMPLEADO AS CLAVE_EMPLEADO,
              E.NOMBRE AS EMPLEADO,
              E.SALARIO AS SALARIO,
              D.NOMBRE AS SU_DEPARTAMENTO
              
         FROM EMPLEADOS AS E INNER JOIN DEPARTAMENTOS AS D
                               ON E.DEPARTAMENTO=D.NUMERO;
      
      
     
                                /** REL E (1,1)**/
             /**** A CADA TUPLA DE E LE CORRESPONDE UNA TUPLA DE TABLA D**/                   
             /** TODOS LOS EMPLEADOS TIENEN UNA TUPLA EN D PARA COMBINAR - PEGAR**/                   
      
      
      /***2   POR CADA EMPLEADO  QUE ESTÁ SUPERVISADO
              OBTENER SU CLAVE Y SU NOMBRE
              Y EL NOMBRE DE SU SUPERVISOR**/
              
              SELECT  E.ID_EMPLEADO AS CLAVE_SUPERVISADO,
                      E.NOMBRE AS SUPERVISADO,
                      E.SUPERVISOR AS CLAVE_SUPERVISOR, /*ES.ID_EMPLEADO*/
                      ES.NOMBRE AS SUPERVISOR
                FROM EMPLEADOS AS E INNER JOIN EMPLEADOS AS ES
                                     ON E.SUPERVISOR=ES.ID_EMPLEADO; /*(0,1)*/
              
     
	 
	 
      /*** NO TODOS LOS EMPLEADOS TIENEN TUPLA PARA PEGAR,
           LOS QUE TIENEN SUPERVISOR = NULL NO ENCUENTRAN TUPLA EN EL LADO
                DERECHO---> 
                DESAPARECEN DE LA CONSULTA
                E SON 20 TUPLAS, SÓLO 11 ENCUENTRAN TUPLA PARA COMBINAR
                11 ESTÁN SUPERVISADOS***/
  /** PEGAR A CADA EMPLEADO LA TUPLA DE SU SUPERVISOR**/    
      
      
                                    /*REL E (0,1)*/                           
       /** ESTE INNER ME SIRVE PARA SELECCIONAR A LOS SUPERVISADOS**/                             
   
   /***                       
         3 PARA CADA EMPLEADO QUE ESTÉ SUPERVISADO
         OBTENER SU NOMBRE Y SALARIO Y EL NOMBRE DE SU DEPARTAMENTO**/
     
       
	 
     SELECT   E.NOMBRE  AS EMPLEADO_SUPERVISADO,
              E.SALARIO AS SU_SALARIO ,
              E.DEPARTAMENTO AS CLAVE_SU_DEPARTAMENTO,
              D.NOMBRE AS SU_DEPARTAMENTO
              
          FROM EMPLEADOS AS E INNER JOIN DEPARTAMENTOS AS D
                                ON E.DEPARTAMENTO=D.NUMERO  /*(1,1)*/
          WHERE E.SUPERVISOR IS NOT NULL; /* WHERE SUPERVISOR*/
	 
	 
   SELECT  E.NOMBRE AS SUPERVISADO,
           E.SALARIO AS SU_SALARIO,
           D.NOMBRE AS SU_DEPARTAMENTO
     FROM EMPLEADOS AS E INNER JOIN EMPLEADOS AS ES
                           ON E.SUPERVISOR=ES.ID_EMPLEADO /*(0,1)*/
                              INNER JOIN DEPARTAMENTOS AS D
                                 ON E.DEPARTAMENTO=D.NUMERO; /*(1,1)*/
                               
   
  /* CON EL PRIMER INNER JOIN HE SELECCIONADO A LOS SUPERVISADOS
      Y LUEGO SÓLO A ESTOS LE PEGO SU DEPARTAMENTO
      AUNQUE NO SE PIDE INFORMACIÓN DEL SUPERVISOR, 
      HEMOS COMBINADO A SU SUPERVISOR PARA 
      SELECCIONAR TUPLAS*/
  
 /**  4 PARA CADA EMPLEADO QUE ESTÉ SUPERVISADO, 
      SU NOMBRE, EL NOMBRE DE SU SUPERVISOR
      EL NOMBRE DE SU DIRECTOR**/
      
      SELECT   E.NOMBRE AS EMPLEADO_SUPERVISADO,
               ES.NOMBRE AS SU_SUPERVISOR,
               ED.NOMBRE AS SU_DIRECTOR
               
          FROM EMPLEADOS AS E INNER JOIN EMPLEADOS AS ES
                               ON E.SUPERVISOR=ES.ID_EMPLEADO /*(0,1)*/
                                  INNER JOIN DEPARTAMENTOS AS D
                                       ON E.DEPARTAMENTO=D.NUMERO /*(1,1)*/
                                          INNER JOIN EMPLEADOS AS ED   /*(1,1)*/
                                              ON D.DIRECTOR=ED.ID_EMPLEADO;
                                         
                                  
 /*EL ORDEN DE LAS TABLAS A COMBINAR ES IMPORTANTE!!!!! XQ CON EL PRIMER INNER
    HAGO DOS COSAS SELECCIONO TUPLAS Y COMBINO, entonces hago la consulta más eficientemente**/
    


   /*** 5 PARA CADA DEPARTAMENTO DE LA EMPRESA,
      OBTENER UN INFORME CON:
      NOMBRE DEL DEPARTAMENTO,
      CANTIDAD DE EMPLEADOS ASIGNADOS A ÉL
      ******/
      
       SELECT   D.NOMBRE AS DEPARTAMENTO,
                COUNT(*) as CANTIDAD_EMPLEADOS,
                AVG(SALARIO) AS SALARIO_MEDIO_DEP
           FROM DEPARTAMENTOS AS D INNER JOIN EMPLEADOS AS E
                                    ON D.NUMERO=E.DEPARTAMENTO /*(0,N)*/
                                    /*PARTICIPA MÍNIMA DE DEPARTAMENTO CERO, PORQUE NO TENGO UNA RUTINA QUE IMPIDA QUE E
                                       UN DEPARTAMENTO NO TENGA NINGÚN EMPLEADO
                                       LO IMPORTANTE UN DEPARTAMNETO PARTICIPA A MUCHOS*/
          GROUP BY D.NUMERO;
          /*ESTA CONSULTA ES POR DEPARTAMENTO,
            EL INNER JOIN ANTERIOR HACE QUE UN  DEPARTAMENTO SE CLONE
            N  VECES, UNA POR CADA EMPLEADO, DEPARTAMENTO PARTICIPA A MUCHOS
            POR ESO, SI O SI NECESITAREMOS USAR GROUP BY*/
          /* GROUP BY D.NUMERO, D.NOMBRE, E.DEPARTAMENTO 
             */ 
 /* SI EN ESTE INSTANTE, UN DEPARTAMENTO,  QUE ES UNA TUPLA DE LA TABLA DEPARTAMENTOS,
    NO ESTÁ REFERENCIDO NI UNA SOLA VEZ EN LA TABLA EMPLEADOS, 
    NO TIENE NINGÚN EMPLEADO ASIGNADO,ESTA CONSULTA HACE DESAPARECER A ESE DEPARTAMENTO,
    NO LO VERÍAMOS EN LA SALIDA**/
    
    SELECT * FROM DEPARTAMENTOS;
    /*AQUÍ ESTAMOS INSERTANDO UN NUEVO DEPARTAMENTO, POR LO TANTO ESTAMOS REFERENCIADO A UN NUEVO DIRECTOR**/
    INSERT INTO `empresa`.`DEPARTAMENTOS` 
    (`NOMBRE`, `DIRECTOR`, `PRIMA_SUELDO`, `FECHA_INICIO`) 
    VALUES ('PRUEBA', '5', '2000', '2023-02-16');
    /*AHORA EN LOS DATOS DE LA BASE DE DATOS, EXISTE UN DEPARTAMENTO QUE NO TIENE EMPLEADOS
      ASIGNADOS**/
    SELECT * FROM DEPARTAMENTOS;
    SELECT      D.NOMBRE AS DEPARTAMENTO,
                COUNT(*) as CANTIDAD_EMPLEADOS,
                AVG(SALARIO) AS SALARIO_MEDIO_DEP
           FROM DEPARTAMENTOS AS D INNER JOIN EMPLEADOS AS E
                                    ON D.NUMERO=E.DEPARTAMENTO /*(0,N)*/
                                    /*PARTICIPA MÍNIMA DE DEPARTAMENTO CERO, PORQUE NO TENGO UNA RUTINA QUE IMPIDA QUE E
                                       UN DEPARTAMENTO NO TENGA NINGÚN EMPLEADO
                                       LO IMPORTANTE UN DEPARTAMNETO PARTICIPA A MUCHOS*/
          GROUP BY D.NUMERO;
    
    /* PARA NO PERDER A ESE DEPARTAMENTO, TENGO QUE USAR UNA COMBINACIÓN EXTERNA
       DEBO USAR LEFT JOIN*/
       
       SELECT *
       FROM DEPARTAMENTOS AS D LEFT JOIN EMPLEADOS AS E
                                    ON D.NUMERO=E.DEPARTAMENTO; /*(0,N)*/
                                    
      /*LA CONSULTA SERÍA ASÍ, SINO QUEREMOS PERDER NINGÚN DEPARTAMENTO**/
      
      SELECT   D.NUMERO AS CLAVE_DEPARTAMENTO,
               D.NOMBRE AS DEPARTAMENTO,
               COUNT(E.ID_EMPLEADO)  AS CANTIDAD_EMPLEADOS
         FROM DEPARTAMENTOS AS D LEFT JOIN  EMPLEADOS AS E
                                     ON D.NUMERO=E.DEPARTAMENTO /*(0,N)*/
         GROUP BY D.NUMERO;                            
       /** COMBINACIÓN EXTERNA LEFT , LE PEGA UNA TUPLA A LA DERECHA VACÍA**/
       
   /** 6 AÑADE AL INFORME ANTERIOR EL NOMBRE Y SALARIO DE SU DIRECTOR Y 
       EL SALARIO MEDIO DEL DEPARTAMNETO (DE LOS EMPLEADOS ASIGNADOS AL DEPARTAMENTO)
       */                            
 /*  ATENCIÓN EN ESTA CONSULTA ,SI HAY UN DEPARTAMENTO SIN EMPLEADOS NO LO VEO EN LA TABLA FINAL RESULTANTE QUE CONSTRUYE
     SELECT, PORQUE HEMOS UTILIZADO UN JOIN DE TIPO INNER*/
 
SELECT          D.NOMBRE AS DEPARTAMENTO,
                COUNT(*) as CANTIDAD_EMPLEADOS,
                AVG(E.SALARIO) AS SALARIO_MEDIO_DEP,
                ED.NOMBRE AS SU_DIRECTOR,
                ED.SALARIO AS SALARIO_SU_DIRECTOR
           FROM DEPARTAMENTOS AS D INNER JOIN EMPLEADOS AS ED
                                       ON D.DIRECTOR=ED.ID_EMPLEADO /*(1,1)*/
                                        INNER JOIN EMPLEADOS AS E
                                           ON D.NUMERO=E.DEPARTAMENTO /*(0,N)*/
                                    
          GROUP BY D.NUMERO;
 
 /* SI EN EL ENUNCIADO ME DICE: VISUALIZA  A TODOS LOS DEPARTAMNETOS, AUNQUE
    NO TENGAN EMPLEADOS, NO PUEDO USAR INNER
    TENGO QUE EMPLEAR LEFT, LEFT/RIGHT, EN GENERAL CUALQUIER COMBINACIÓN EXTERNA, MÁS COSTOSA QUE INNER
    POR LA FORMA EN QUE INTERNAMENTE SE EJECUTA INNER**/
    
    SELECT      D.NOMBRE AS DEPARTAMENTO,
                COUNT(E.ID_EMPLEADO) as CANTIDAD_EMPLEADOS_ASIGNADO,
                
                ED.NOMBRE AS SU_DIRECTOR,
                ED.SALARIO AS SALARIO_SU_DIRECTOR
           FROM DEPARTAMENTOS AS D INNER JOIN EMPLEADOS AS ED
                                       ON D.DIRECTOR=ED.ID_EMPLEADO /*(1,1)*/
                                        LEFT JOIN EMPLEADOS AS E
                                           ON D.NUMERO=E.DEPARTAMENTO /*(0,N)*/
                                    
          GROUP BY D.NUMERO;
 
 /***
     OBTENER PARA CADA DEPARTAMENTO
        SU CLAVE, NOMBRE,
        EL NOMBRE Y SALARIO DE SU DIRECTOR,
        LA CANTIDAD DE EMPLEADOS ASIGNADOS AL DEPARTAMENTO
        LA CANTIDAD DE PROYECTOS QUE TIENE LANZADOS
        ****/
        
        SELECT   D.NUMERO AS CLAVE_DEPARTAMENTO,
                 D.NOMBRE AS DEPARTAMENTO
           FROM DEPARTAMENTOS AS D;
           
           
         SELECT   /*POR CADA TUPLA SELECCIONADA*/
                  D.NUMERO AS CLAVE_DEPARTAMENTO,
                  D.NOMBRE AS DEPARTAMENTO,
                  ED.NOMBRE AS SU_DIRECTOR,
                  ED.SALARIO AS SALARIO_SU_DIRECTOR
           FROM DEPARTAMENTOS AS D  INNER  JOIN EMPLEADOS AS ED
                                         ON D.DIRECTOR=ED.ID_EMPLEADO;/*(1,1)*/
             
        SELECT    /*POR CADA GRUPO ME DAS**/
                  D.NUMERO AS CLAVE_DEPARTAMENTO,
                  D.NOMBRE AS DEPARTAMENTO,
                  ED.NOMBRE AS SU_DIRECTOR,
                  ED.SALARIO AS SALARIO_SU_DIRECTOR,
                  COUNT(E.ID_EMPLEADO) AS CANTIDAD_EMPLEADOS_ASIGNADOS /* NO SIRVE COUNT(*)*/
           FROM DEPARTAMENTOS AS D  INNER  JOIN EMPLEADOS AS ED
                                         ON D.DIRECTOR=ED.ID_EMPLEADO/*(1,1)*/
                                             LEFT JOIN EMPLEADOS AS E
                                                   ON D.NUMERO=E.DEPARTAMENTO /*(0,N)*/
           GROUP BY  D.NUMERO,D.NOMBRE ; /*PUEDO USAR EN GROUP BY D.NOMBRE xq es ak*/                                      
        
        
       SELECT    /*POR CADA GRUPO ME DAS**/
                  D.NUMERO AS CLAVE_DEPARTAMENTO,
                  D.NOMBRE AS DEPARTAMENTO,
                  ED.NOMBRE AS SU_DIRECTOR,
                  ED.SALARIO AS SALARIO_SU_DIRECTOR, /*PODEMOS PEDIR CUALQUIER COLUMNA DEL LADO D Y ED*/ 
                  COUNT(DISTINCT E.ID_EMPLEADO) AS CANTIDAD_EMPLEADOS_ASIGNADOS,
                  COUNT(DISTINCT P.ID_PROYECTO) AS CANTIDAD_PROYECTOS_LANZADOS 
                    /*USO COUNT(DISTINCT COLUMNA) XQ  HAY MÁS DE UNA  RELACIÓN A MUCHOS EN LA CONSULTA*/
           FROM DEPARTAMENTOS AS D  INNER  JOIN EMPLEADOS AS ED
                                         ON D.DIRECTOR=ED.ID_EMPLEADO/*(1,1)*/
                                             LEFT JOIN EMPLEADOS AS E
                                                   ON D.NUMERO=E.DEPARTAMENTO /*(0,N)*/
                                                    LEFT JOIN PROYECTOS AS P
                                                           ON D.NUMERO=P.DEPARTAMENTO /*(0,N)*/
             /** ATENCIÓN!!   TENGO INCORPORADA MÁS DE UNA VEZ RELACIÓN A N*/                                          
           GROUP BY  D.NUMERO,D.NOMBRE ; /*PUEDO USAR EN GROUP BY D.NOMBRE xq es ak*/  
           
 /* EN ESTA CONSULTA HEMOS UTILIZADO MÁS DE UNA VEZ UNA RELACIÓN A MUCHOS, EL SEGUNDO Y TERCER JOIN INCORPORA UNA RELACIÓN (0,N)
    ---->TENGO QUE USAR COUNT(DISTINCT COLUMNA)**/
    
    
 
   
         /*PARA CADA DIRECTOR, SU NOMBRE Y SALARIO
          NOMBRE DEL DEPARTAMENTO QUE DIRIGE,
          Y SALARIO MEDIO DE LOS EMPLEADOS A LOS QUE DIRIGE**/
          
          SELECT    /*DE CADA TUPLA*/
                    ED.NOMBRE AS DIRECTOR,
                    ED.SALARIO AS SALARIO_DIRECTOR,
                    D.NOMBRE AS DEPARTAMENTO_QUE_DIRIGE
             FROM EMPLEADOS AS ED INNER JOIN DEPARTAMENTOS AS D
                                    ON ED.ID_EMPLEADO=D.DIRECTOR;  /*(0,1)*/ /*SELECCIONAMOS A LOS EMPLEADOS DIRECTORES*/
                                    
          SELECT    /*DE CADA TUPLA*/
                    ED.NOMBRE AS DIRECTOR,
                    ED.SALARIO AS SALARIO_DIRECTOR,
                    D.NOMBRE AS DEPARTAMENTO_QUE_DIRIGE,
                    COUNT(E.ID_EMPLEADO) AS CANTIDAD_DE_EMPLEADOS_DIRIGE,
                    AVG(E.SALARIO) AS SALARIO_MEDIO_EMPLEADOS_DIRIGE
             FROM EMPLEADOS AS ED INNER JOIN DEPARTAMENTOS AS D
                                    ON ED.ID_EMPLEADO=D.DIRECTOR   /*(0,1)*/ /*SELECCIONAMOS A LOS EMPLEADOS DIRECTORES*/
                                      LEFT JOIN  EMPLEADOS AS E
                                            ON D.NUMERO=E.DEPARTAMENTO /*(0,N) USO LEFT
                                                                        PORQUE NO PUEDO PERDER A NINGÚN DIRECTOR, AUNQUE
                                                                        NO TENGA EMPLEADOS EN EL DEPARTAMENTO QUE DIRIGE*/ 
            GROUP BY   D.DIRECTOR,D.NUMERO,ED.ID_EMPLEADO;
            
            
            
       /** NOMBRE Y SALARIO DE LOS DIRECTORES DE DEPARTAMENTO */
                                               
           SELECT   ED.NOMBRE AS DIRECTOR,
                    ED.SALARIO  AS SALARIO_DIRECTOR
             FROM EMPLEADOS AS ED INNER JOIN DEPARTAMENTOS AS D
                                    ON ED.ID_EMPLEADO=D.DIRECTOR;
                                        /** EL NOMBRE Y SALARIO ESTÁN EN  TABLA EMPLEADOS,
                                            NO NECESITO DATOS DE OTRA TABLA.
                                            SIN EMBARGO PARA SELECCIONAR A LOS DIRECTORES  HE DECIDIDO TRAER
                                            LA TABLA DEPARTAMENTOS EN UN INNER JOIN**/
                            
 
  /** DE OTRA FORMA, VAMOS A SELECCIONAR A LOS DIRECTORES CON UNA SUBCONULTA
      SELECCIONA LAS TUPLAS DE LA TABLA EMPLEADOS QUE ESTÁN EN ESTA LISTA QUE TE PASO
      ***/
      
      SELECT   E.NOMBRE,
               E.SALARIO
         FROM EMPLEADOS  AS E
         WHERE E.ID_EMPLEADO  IN (  ); /*SELECCIONO TUPLAS DE EMPLEADOS QUE SU CLAVE PRIMARIA ESTÁN EN  EN ESTA
                                          LISTA*/
         
      /** ESTA ES LA LISTA DE CLAVES PRIMARIAS DE LOS DIRECTORES*/
      SELECT   DIRECTOR
         FROM DEPARTAMENTOS;
         
         
        SELECT   E.NOMBRE,
                 E.SALARIO
          FROM EMPLEADOS  AS E
          WHERE E.ID_EMPLEADO  IN ( 
                                     SELECT   DIRECTOR
                                       FROM DEPARTAMENTOS
                                       /*ESTA ES UNA SUBCONSULTA, SE EJECUTA UNA VEZ
                                         DEJA AQUÍ LA LISTA DE CLAVES PRIMARIAS DE LOS DIRECTORES
                                        */ ); 
      
     /* NOMBRES DE LOS EMPLEADOS CUYO SALARIO ES MAYOR QUE EL SALARIO MEDIO DE LA EMPRESA*/
     
     /*TENGO QUE OBTENER EL SALARIO MEDIO DE LA EMPRESA, ESTE DATO NO LO TENGO*/
     
     SELECT  AVG(SALARIO)
         FROM EMPLEADOS;
   
      SELECT    NOMBRE
          FROM EMPLEADOS AS E
          WHERE E.SALARIO>(
                           SELECT  AVG(SALARIO)
                            FROM EMPLEADOS  /*ESTA SUBCONSULTA SE EJECUTA UNA VEZ, Y DEJA AQUÍ UN DATO*/
                          );
      /* ESTE WHERE SE VERIFICA PARA CADA TUPLA, UNA VEZ PARA CADA EMPLEADO*/
          
          
          
 /*** PARA CADA EMPLEADO
      SU NOMBRE Y SALARIO 
      Y LA CANTIDAD DE PROYECTOS EN LOS QUE ESTÁ TRABAJANDO
      FECHA DEL PRIMER DÍA DE TRABAJO ASIGNADO (DESDE QUÉ FECHA ESTÁ ASIGNADO A ALGÚN PROYECTO)
      (SÓLO ME INTERESAN EN EL INFORME LOS EMPLEADOS QUE ESTÁN TRABAJANDO EN ALGÚN PROYECTO)**/
      
      SELECT    E.NOMBRE AS EMPLEADO,
                E.SALARIO AS SALARIO,
                COUNT(*)  AS CANTIDAD_PROYECTOS_TRABAJA,
                MIN(EP.FECHA_INICIO) AS PRIMER_DIA_TRABAJO
                
                
          FROM EMPLEADOS AS E INNER JOIN EMPLEADOS_PROYECTOS AS EP
                                   ON E.ID_EMPLEADO=EP.EMPLEADO  /*(0,N)*/
      
          GROUP BY E.ID_EMPLEADO;  
          
   /*** PARA CADA EMPLEADO:
      SU CLAVE 
      CANTIDAD DE PROYECTOS EN LOS QUE ESTÁ TRABAJANDO
      FECHA DEL PRIMER DÍA DE TRABAJO ASIGNADO (DESDE QUÉ FECHA ESTÁ ASIGNADO A ALGÚN PROYECTO)
      (SÓLO ME INTERESAN EN EL INFORME LOS EMPLEADOS QUE ESTÁN TRABAJANDO EN ALGÚN PROYECTO)**/    
      
      SELECT       
                EMPLEADO AS CLAVE_EMPLEADO,
                COUNT(*)  AS CANTIDAD_PROYECTOS_TRABAJA,
                MIN(FECHA_INICIO) AS PRIMER_DIA_TRABAJO
      
           FROM  EMPLEADOS_PROYECTOS 
           GROUP BY EMPLEADO;
      /** EN ESTE CASO, NO ES UNA CONSULTA MULTITABLA **/
      
      
      
      /*** PARA TODOS LOS EMPLEADOS DE LA EMPRESA
          SU CLAVE 
          CANTIDAD DE PROYECTOS EN LOS QUE ESTÁ TRABAJANDO
          
    ****/
    
    /* TENGO QUE USAR EN LA CONSULTA LA  TABLA EMPLEADOS, PORQUE EN EMPLEADOS_PROYECTOS PUEDE QUE NO ESTÉN TODOS*/
    
    SELECT      E.ID_EMPLEADO AS CLAVE_EMPLEADO,
                COUNT(EP.PROYECTO) AS CANTIDAD_PROYECTOS_TRABAJA
        FROM EMPLEADOS AS E LEFT JOIN EMPLEADOS_PROYECTOS AS EP
                                ON E.ID_EMPLEADO=EP.EMPLEADO  /*(0,N)*/  /** 0 USO LEFT, N USO GROUP BY*/
        GROUP BY E.ID_EMPLEADO;    
        
        
        /* DE OTRA FORMA**/
        
        
        SELECT    
                     E.ID_EMPLEADO AS CLAVE_EMPLEADO, 
                     (
                        SELECT  COUNT(*)
                           FROM EMPLEADOS_PROYECTOS
                           WHERE EMPLEADO=E.ID_EMPLEADO
                     
                     
                     ) AS CANTIDAD_PROYECTOS_TRABAJA  /*ESTO ES UNA SUBCONSULTA QUE SE EJECUTA UNA VEZ PARA CADA TUPLA*/
        
            FROM EMPLEADOS AS E;
    
          
  /** AÑADE A ESTE INFORME:      
      LA CANTIDAD DE EMPLEADOS A LOS QUE SUPERVISA 
      Y  LA CANTIDAD DE EMPLEADOS A LOS QUE DIRIGE*/     
      
      
      SELECT    E.NOMBRE AS EMPLEADO,
                E.SALARIO AS SALARIO,
                COUNT(DISTINCT EP.PROYECTO)  AS CANTIDAD_PROYECTOS_TRABAJA,
                MIN(EP.FECHA_INICIO) AS PRIMER_DIA_TRABAJO,
                COUNT( DISTINCT ES.ID_EMPLEADO) AS CANTIDAD_EMPLEADOS_SUPERVISA,
                COUNT(DISTINCT E2.ID_EMPLEADO) AS CANTIDAD_EMPLEADOS_DIRIGE
                
          
          FROM EMPLEADOS AS E INNER JOIN EMPLEADOS_PROYECTOS AS EP
                                   ON E.ID_EMPLEADO=EP.EMPLEADO   /*(0,N)*/ /*SELECCIONAMOS A LOS EMPLEADOS DEL INFORME**/
                                       LEFT JOIN EMPLEADOS  AS ES
                                             ON E.ID_EMPLEADO=ES.SUPERVISOR  /*(0,N)*/
                                               LEFT JOIN EMPLEADOS AS E2 
                                                     ON  E.ID_EMPLEADO = (
                                                                            SELECT  DIRECTOR
                                                                               FROM DEPARTAMENTOS
                                                                               WHERE NUMERO=E2.DEPARTAMENTO
                                                                               /**SELECCIONO UNA TUPLA,
                                                                                   LA DEL DEPARTAMENTO DE E2 */                                                    
                                                                         ) 
      
          GROUP BY E.ID_EMPLEADO;  
          
          
   /* DE OTRA FORMA**/       
      
       SELECT    E.NOMBRE AS EMPLEADO,
                 E.SALARIO AS SALARIO,
                 COUNT(DISTINCT EP.PROYECTO)  AS CANTIDAD_PROYECTOS_TRABAJA,
                 MIN(EP.FECHA_INICIO) AS PRIMER_DIA_TRABAJO,
                 (                    
                   SELECT  COUNT(*)
                      FROM EMPLEADOS
                      WHERE SUPERVISOR=E.ID_EMPLEADO
                                 
                 ) AS CANTIDAD_EMPLEADOS_SUPERVISA,
                 
                 (
                              
                 SELECT   COUNT(*)
                    FROM EMPLEADOS
                    WHERE DEPARTAMENTO = (
                                             SELECT NUMERO
                                                FROM DEPARTAMENTOS
                                                WHERE DIRECTOR=E.ID_EMPLEADO
                                            )
                 
                 
                 ) AS CANTIDAD_EMPLEADOS_DIRIGE
                
          
          FROM EMPLEADOS AS E INNER JOIN EMPLEADOS_PROYECTOS AS EP
                                   ON E.ID_EMPLEADO=EP.EMPLEADO 
                                   /*(0,N)*/ /*SELECCIONAMOS A LOS EMPLEADOS DEL INFORME**/
                       
      
          GROUP BY E.ID_EMPLEADO;  
      
      
  /** AÑADE A ESTE INFORME 
         TOTAL DE HORAS DE TRABAJO EN LOS DISTINTOS PROYECTOS*/
    
    /************************* VOLVER A EXPLICAR EN CLASE,  LA ULTIMA COLUMNA  DE SELECCIÓN 
                    TIENE QUE HACERSE SI O SI CON SUBCONSULTA CORRELACCIONADA**/
         SELECT    E.NOMBRE AS EMPLEADO,
                E.SALARIO AS SALARIO,
                COUNT(DISTINCT EP.PROYECTO)  AS CANTIDAD_PROYECTOS_TRABAJA,
                MIN(EP.FECHA_INICIO) AS PRIMER_DIA_TRABAJO,
                COUNT( DISTINCT ES.ID_EMPLEADO) AS CANTIDAD_EMPLEADOS_SUPERVISA,
                COUNT(DISTINCT E2.ID_EMPLEADO) AS CANTIDAD_EMPLEADOS_DIRIGE,
                (
                  SELECT  SUM(NUM_HORAS)
                     FROM EMPLEADOS_PROYECTOS
                     WHERE EMPLEADO=E.ID_EMPLEADO        
                
                
                ) AS TOTAL_HORAS_TRABAJO_DISTINTOS_PROYECTOS
                
          
          FROM EMPLEADOS AS E INNER JOIN EMPLEADOS_PROYECTOS AS EP
                                   ON E.ID_EMPLEADO=EP.EMPLEADO   /*(0,N)*/ /*SELECCIONAMOS A LOS EMPLEADOS DEL INFORME**/
                                       LEFT JOIN EMPLEADOS  AS ES
                                             ON E.ID_EMPLEADO=ES.SUPERVISOR  /*(0,N)*/
                                               LEFT JOIN EMPLEADOS AS E2 
                                                     ON  E.ID_EMPLEADO = (
                                                                            SELECT  DIRECTOR
                                                                               FROM DEPARTAMENTOS
                                                                               WHERE NUMERO=E2.DEPARTAMENTO
                                                                               /**SELECCIONO UNA TUPLA,
                                                                                   LA DEL DEPARTAMENTO DE E2 */                                                    
                                                                         ) 
      
          GROUP BY E.ID_EMPLEADO;  
            
          
      
      
        /*1 CUÁNTOS TUPLAS HAY EN TABLA EMPLEADOS_PROYECTOS**/  
        
         SELECT   COUNT(*)
            FROM EMPLEADOS_PROYECTOS;
     
        /*2  CLAVES DE LOS EMPLEADOS**/
        
        SELECT ID_EMPLEADO
           FROM EMPLEADOS;
        
                
       /**3 CLAVES DE LOS EMPLEADOS QUE ESTÁN TRABAJANDO EN ALGÚN PROYECTO**/
       
          SELECT  DISTINCT EMPLEADO
             FROM EMPLEADOS_PROYECTOS;
             
             
        /** ESTA OTRA SOLUCIÓN, NO ES LA ADECUADA, NO ES EFICIENTE
             PORQUE NO NECESITAMOS NINGÚN DATO DE AGRUPAMIENTO***/
        
        SELECT   EMPLEADO
          FROM EMPLEADOS_PROYECTOS
          GROUP BY EMPLEADO;
       
       /***** 4 CLAVES DE EMPLEADOS TRABAJANDO EN ALGÚN PROYECTO QUE SEAN SUPERVISORES*/
      
     SELECT   DISTINCT EMPLEADO
         FROM EMPLEADOS_PROYECTOS
         WHERE EMPLEADO IN (
                                SELECT  DISTINCT SUPERVISOR
                                   FROM EMPLEADOS
                                   WHERE SUPERVISOR IS NOT NULL
                           );
     
     
  /*** DE OTRA FORMA**/
  
        SELECT    DISTINCT  EP.EMPLEADO
             FROM EMPLEADOS_PROYECTOS AS EP INNER JOIN EMPLEADOS AS E
                                         ON EP.EMPLEADO=E.ID_EMPLEADO  /*COMBINO EL REGISTRO DE TRABAJO CON LA TUPLA DEL EMPLEADO */
                                            AND                       /*PERO SÓLO SI ES SUPERVISOR. ENTONCES ESTE INNER JOIN ME SIRVE PARA SELECCCIONAR*/
                                            E.ID_EMPLEADO  IN ( 
                                                                   SELECT DISTINCT SUPERVISOR
                                                                   FROM EMPLEADOS
                                                                   WHERE SUPERVISOR IS NOT NULL
                                            
                                                              );
                                                              
                                                              
         SELECT    DISTINCT  EP.EMPLEADO
             FROM EMPLEADOS_PROYECTOS AS EP INNER JOIN EMPLEADOS AS E
                                         ON EP.EMPLEADO=E.ID_EMPLEADO  /*COMBINO EL REGISTRO DE TRABAJO CON LA TUPLA DEL EMPLEADO */
            WHERE E.ID_EMPLEADO IN  (  SELECT DISTINCT SUPERVISOR
                                         FROM EMPLEADOS
                                         WHERE SUPERVISOR IS NOT NULL
                                   );                                             
                                             
     
      
      /** 5 PARA CADA PROYECTO, QUE TENGA ALGÚN EMPLEADO TRABAJANDO,
          OBTENER:
          SU NOMBRE, SU PRESUPUESTO, EL NOMBRE DEL DEPARTAMENTO QUE LO LANZA,
          LA CANTIDAD DE EMPLEADOS QUE TRABAJAN EN EL PROYECTO 
          TOTAL HORAS DE TRABAJO EMPLEADAS EN EL PROYECTO
      *****/    
      
      
      SELECT      P.NOMBRE AS PROYECTO,
                  P.PRESUPUESTO AS PRESUPUESTO,
                  (
                    SELECT NOMBRE
                     FROM DEPARTAMENTOS
                     WHERE NUMERO=P.DEPARTAMENTO
                  ) AS DEPARTAMENTO_LANZA,
                  
                  COUNT(*) AS CANTIDAD_EMPLEADOS_TRABAJAN,
                  SUM(NUM_HORAS) AS TOTAL_HORAS_TRABAJO
          FROM EMPLEADOS_PROYECTOS AS EP INNER JOIN PROYECTOS AS P
                                       ON EP.PROYECTO=P.ID_PROYECTO
          GROUP BY EP.PROYECTO, P.ID_PROYECTO;
      
      
      /*DE OTRA FORMA*/
     
     
     SELECT      P.NOMBRE AS PROYECTO,
                  P.PRESUPUESTO AS PRESUPUESTO,
                  D.NOMBRE  AS DEPARTAMENTO_LANZA,
                  
                  COUNT(*) AS CANTIDAD_EMPLEADOS_TRABAJAN,
                  SUM(NUM_HORAS) AS TOTAL_HORAS_TRABAJO
          FROM EMPLEADOS_PROYECTOS AS EP INNER JOIN PROYECTOS AS P
                                       ON EP.PROYECTO=P.ID_PROYECTO
                                           INNER JOIN DEPARTAMENTOS AS D
                                              ON P.DEPARTAMENTO=D.NUMERO
          GROUP BY EP.PROYECTO, P.ID_PROYECTO;
      
      
          
      /*** PRIMERO COMBINAMOS CADA TUPLA DE PROYECTO CON LA TUPLA DEL 
      DEPARTAMENTO QUE LO LANZA, PARTICIPACIÓN DE PROYECTO
      ES (1,1), NO PIERDO NINGÚN PROYECTO XQ TODOS COMBINAN UNA VEZ
      LUEGO A CADA PROYECTO LO COMBINAMOS CON LAS TUPLAS DE TABLA
      EMPLEADOS_PROYECTOS , LA PARTICIPACIÓN DE PROYECTO ES (0,N)
      , ENTONCES PUEDO PERDER PROYECTOS DE LA CONSULTA, TODOS LOS QUE NO ESTÉN EN
      ESTE INSTANTE REFERENCIADOS EN LA TABLA EMPLEADOS_PROYECTOS,
      Y OTROS PROYECTOS SE CLONAN N VECES__> NECESITO AGRUPAR
      ******************/
      
      
   
          
          
       /*** 6 POR CADA  EMPLEADO SUPERVISADO EN LA EMPRESA
            OBTENER:
            SU NOMBRE Y SALARIO,
            EL NOMBRE Y SALARIO  DE SU SUPERVISOR,
            EL NOMBRE DEL DEPARTAMENTO AL QUE PERTENECE
            EL NOMBRE Y SALARIO DE SU DIRECTOR **/
            
       
       
       
       
       
       SELECT   
                /*POR CADA TUPLA SELECCIONADA*/
                E.NOMBRE AS EMPLEADO,
                E.SALARIO AS SU_SALARIO,
                ES.NOMBRE AS SU_SUPERVISOR,
                ES.SALARIO AS SALARIO_SUPERVISOR,
                D.NOMBRE AS SU_DEPARTAMENTO,
                ED.NOMBRE AS SU_DIRECTOR,
                ED.SALARIO AS SALARIO_SU_DIRECTOR
       
              
           FROM EMPLEADOS AS E INNER JOIN EMPLEADOS AS ES
                                ON E.SUPERVISOR=ES.ID_EMPLEADO /*(0,1)  AQUÍ SELECCIONAMOS A LOS EMPLEADOS SUPERVISADOS EN LA EMPLRESA 
                                                                  DEBO HACERLO PRIMERO*/
                                    INNER JOIN DEPARTAMENTOS AS D
                                         ON E.DEPARTAMENTO=D.NUMERO  /**SU DEPARTAMENTO  (1,1)*/
                                            INNER JOIN EMPLEADOS AS ED  /** SU DIRECTOR: EL DIRECTOR DE SU DEPARTAMENTO (1,1)*/ 
                                                ON D.DIRECTOR=ED.ID_EMPLEADO;
            
      
            
            
            
       /****  EN ESTA CONSULTA NO HAY QUE AGRUPAR PORQUE TODAS LAS RELACIONES QUE USO EN LA CONSULTA
       SON CON PATICIPACIÓN MÁXIMO 1
       ATENCIÓN DE TODAS LAS COMBINACIONES LA PRIMERa DEBE SER LA QUE ME SIRVE PARA SELECCIONAR A LOS EMPLEADOS SUPERVISADOS***/     
            
      
            
            
    /** SI en la consulta NO ME PIDEN DATOS DE SU SUPERVISOR, ¿CÓMO LA HACES ???**/       
    /*** POR CADA  EMPLEADOS SUPERVISADO EN LA EMPRESA
            OBTENER:
            SU NOMBRE Y SALARIO,
            EL NOMBRE DEL DEPARTAMENTO AL QUE PERTENECE
            EL NOMBRE Y SALARIO DE SU DIRECTOR **/     
            
            
       SELECT   
                /*POR CADA TUPLA SELECCIONADA*/
                E.NOMBRE AS EMPLEADO,
                E.SALARIO AS SU_SALARIO,
                D.NOMBRE AS SU_DEPARTAMENTO,
                ED.NOMBRE AS SU_DIRECTOR,
                ED.SALARIO AS SALARIO_SU_DIRECTOR
       
              
           FROM EMPLEADOS AS E  INNER JOIN DEPARTAMENTOS AS D
                                         ON E.DEPARTAMENTO=D.NUMERO  /**SU DEPARTAMENTO  (1,1)*/
                                            AND
                                            E.SUPERVISOR IS NOT NULL
                                             INNER JOIN EMPLEADOS AS ED  /** SU DIRECTOR: EL DIRECTOR DE SU DEPARTAMENTO (1,1)*/ 
                                                ON D.DIRECTOR=ED.ID_EMPLEADO;      
            
            
            
       /** HEMOS "TRAÍDO WHERE E.UPERVISOR IS NOT NULL    AL PRIMER INNER MÁS EFICIENTE QUE ESTO **/ 
       
        SELECT   
                /*POR CADA TUPLA SELECCIONADA*/
                E.NOMBRE AS EMPLEADO,
                E.SALARIO AS SU_SALARIO,
                D.NOMBRE AS SU_DEPARTAMENTO,
                ED.NOMBRE AS SU_DIRECTOR,
                ED.SALARIO AS SALARIO_SU_DIRECTOR
       
              
           FROM EMPLEADOS AS E  INNER JOIN DEPARTAMENTOS AS D
                                         ON E.DEPARTAMENTO=D.NUMERO  /**SU DEPARTAMENTO  (1,1)*/
                                            INNER JOIN EMPLEADOS AS ED  /** SU DIRECTOR: EL DIRECTOR DE SU DEPARTAMENTO (1,1)*/ 
                                                     ON D.DIRECTOR=ED.ID_EMPLEADO
           WHERE E.SUPERVISOR IS NOT NULL;      
            
       
       
       
       
            
    