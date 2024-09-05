SELECT ID_EMPLEADO, NOMBRE
    FROM EMPLEADOS
    ORDER BY NOMBRE;
 SELECT ID_EMPLEADO, NOMBRE
    FROM EMPLEADOS
    ORDER BY NOMBRE  DESC;   
    
 /**LISTA DE NOMBRES DE MIS EMPLEADOS, EN ORDEN ALFABÉTICO**/   
 
 /** CRITERIO DE CLASIFICACIÓN ---> DATO NOMBRE
         VARIOS CRITERIOS DE CLASIFICACIÓN
               2º, 3º--**/
    SELECT ID_EMPLEADO, NOMBRE, SALARIO
    FROM EMPLEADOS
    ORDER BY SALARIO DESC, NOMBRE;           
       
      
  /*** LISTA DE NOMBRES DE LOS EMPLEADOS 
       DEL DEPARTAMENTO DE CLAVE 3**/
      SELECT  NOMBRE AS NOMBRE_EMPLEADO
          FROM EMPLEADOS
          WHERE DEPARTAMENTO=3;
         
      
         
    /****NOMBRES Y SALARIOS DE LOS EMPLEADOS
         QUE PERTENEZCAN A LOS DEPARTAMENTOS DE CLAVE
         2 Y 3 Y 4****/
         
         
      SELECT  NOMBRE, SALARIO
         FROM EMPLEADOS
         WHERE DEPARTAMENTO=2
                OR
               DEPARTAMENTO=3
                OR 
               DEPARTAMENTO=4;
               
        /**  USO DE OPERADOR IN**/    
        /**   COLUMNA IN (LISTA DE VALORES)**/
        
    SELECT  NOMBRE, SALARIO
         FROM EMPLEADOS
         WHERE   DEPARTAMENTO IN (2,3,4);
         
       
       /**NOMBRE DE LOS EMPLEADOS QUE NO PERTENEZCAN
          A LOS DEPARTAMENTOS UNO Y DOS**/
          
    SELECT  NOMBRE, SALARIO
       FROM EMPLEADOS
       WHERE DEPARTAMENTO !=1
              AND
             DEPARTAMENTO !=2;
    SELECT   NOMBRE, SALARIO
       FROM EMPLEADOS 
       WHERE DEPARTAMENTO NOT IN (1,2);
   
   /**NOMBRE Y SALARIO DE LOS EMPLEADOS QUE NO PERTENEZCAN
          A LOS DEPARTAMENTOS UNO Y DOS
          Y CUYO SALARIO SEA MAYOR QUE 2000**/
          
        SELECT  NOMBRE, SALARIO
           FROM EMPLEADOS
           WHERE DEPARTAMENTO NOT IN (1,2)
                   AND
                 SALARIO>2000;  
                 
         SELECT  NOMBRE, SALARIO
           FROM EMPLEADOS
           WHERE   (DEPARTAMENTO!=1 AND   DEPARTAMENTO!=2)
                    AND
                   SALARIO>2000;  
   /** PARENTISIS NO SON NECESARIOS, PERO LEEMOS MEJOR*/
                
                
    
                
  /**NOMBRE Y SALARIO DE LOS EMPLEADOS QUE NO PERTENEZCAN
          A LOS DEPARTAMENTOS UNO Y DOS
          O SU SALARIO SEA MAYOR QUE 2000**/
          
          
     
                
  /*** DAME LOS NOMBRES DE LOS EMPLEADOS
       QUE SU SALARIO SEA MAYOR QUE 1000 Y MENOR QUE
       2000**/
	     /** RANGO DE SALARIO [1000,2000]**/
       SELECT   NOMBRE 
          FROM EMPLEADOS
          WHERE SALARIO >= 1000
                 AND
                SALARIO<=2000; 
       
	   /***  USO  operador between*/
       
       SELECT   NOMBRE 
          FROM EMPLEADOS
          WHERE SALARIO BETWEEN 1000 AND 2000;                 
  
      /**[1000,2000]**/
      
      /*** SI LA BÚSQUEDA ES EN ESTE RANGO (1000, 2000]
           (1000,2000) NO PUEDO USAR BETWEEN**/
           SELECT   NOMBRE 
          FROM EMPLEADOS
          WHERE SALARIO > 1000
                 AND
                SALARIO < 2000; 
           
      
   /*** NOMBRES DE EMPLEADOS CUYO SALARIO
        NO ESTÁ COMPRENDIDO ENTRE 1000 Y 1500**/
        
    SELECT   NOMBRE 
          FROM EMPLEADOS
          WHERE SALARIO  NOT BETWEEN 1000 AND 1500;  
      
    /*** EXCLUIR SALARIOS DENTRO DE (1000,1500)**/
     SELECT   NOMBRE 
          FROM EMPLEADOS
          WHERE SALARIO <1000
                  OR
                SALARIO>1500;
    
    
    /*** DAME NOMBRE Y APELLIDOS , Y SALARIO
         DE LOS EMPLEADOS QUE SE LLAMEN FERNANDO**/
         
         
         /**** LIKE PATRÓN DE BÚSQUEDA EN UNA CADENA**/
         
        SELECT   NOMBRE 
          FROM EMPLEADOS
          WHERE SALARIO='FERNANDO';  /** ESTO NO SIRVE**/
          /** CAMBIO DE OPERADOR = NO SIRVE USO LIKE**/
          SELECT   NOMBRE 
          FROM EMPLEADOS
          WHERE NOMBRE LIKE '%FERNANDO%';
          
          /*** LOCALIZAR LAS TUPLAS QUE CONTENGAN 
          LA CADENA FERNANDO DENTRO DE SU COLUMNA NOMBRE**/
          
    
          
         /*** QUE EMPIECE POR  LA CADENA FERNANDO Y SIGA CUALQUIER CADENA**/ 
          
          
          
  /******* funciones de agregado, son rutinas...
         RETORNAN UN DATO, NUNCA UNA LISTA DE DATOS***/
         
    /*** COUNT(*)  CUENTA LAS TUPLAS SELECCIONADAS
         COUNT(COLUMNA)  CUENTA LAS TUPLAS SELECCIONADAS
                         QUE TENGA VALOR EL LA COLUMNA
         COUNT(DISTINCT COLUMNA)
                          CUENTA LAS TUPLAS SELECCIONADAS
                          QUE TENGA VALOR EN LA COLUMNA PERO VALOR DISTINTO
    ****************************************/
    
    
    /*** CUÁNTOS EMPLEADOS TENGO EN LA EMPRESA?**/
    
      SELECT  COUNT(*) AS CANTIDAD_EMPLEADOS
         FROM EMPLEADOS;
    /** CUÁNTOS DEPARTAMENTOS HAY?*/
      SELECT  COUNT(*) AS CANTIDAD_DEPARTAMETOS
         FROM DEPARTAMENTOS;
     /*** CUÁNTOS EMPLEADOS ESTÁN ASIGNADOS AL DEPARTAMENTO 
          DE CLAVE 3**/
          SELECT  COUNT(*)  AS CANTIDAD_EMPLEADOS_DEL_DEP_3
              FROM EMPLEADOS
              WHERE DEPARTAMENTO=3;
         
        /****** CUÁNTOS EMPLEADOS TIENEN SUPERVISOR***/
        /** VETE A TABLA EMPLEADOS, SELECCIONA 
            LAS TUPLAS CUYA COLUMNA SUPERVISOR
            TIENE VALOR**/
            
            /*** operador =  o != no sirve
                   supervisor !=  NULL*
                     dato != no espacio, no dato*/
          /*solución*/    
             SELECT  COUNT(*)
              FROM EMPLEADOS
              WHERE SUPERVISOR IS NOT NULL; 
          /*o también*/    
              SELECT  COUNT(*)
              FROM EMPLEADOS
              WHERE SUPERVISOR ; /* es cierto, tiene valor distinto de cero*/
          /* o también*/    
              SELECT  COUNT(SUPERVISOR)
                 FROM EMPLEADOS;
        
       /*** IS NOT NULL  , SI TIENE VALOR  
       ESTOY LOCALIZANDO A LOS SUPERVISADOS**/   
        
        
         
         
         /** CUANTOS EMPLEADOS NO TIENEN SUPERVISOR,
             CUANTOS  EMPLEADOS NO ESTÁN SUPERVISADOS**/
             
      SELECT COUNT(*) AS CANTIDAD_EMPLEADOS_NO_SUPERVISADOS
        FROM EMPLEADOS
        WHERE SUPERVISOR IS NULL;
             
         
         /**** IS NULL--- NO TIENEN VALOR**/
         
    /***  CUANTOS EMPLEADOS ESTÁN SUPERVISADOS POR EL EMPLEADO
              DE CLAVE 5**/
              
        SELECT  COUNT(*) AS SUPERVISADOS_POR_EMPLEADO_5
          FROM EMPLEADOS
          WHERE SUPERVISOR=5;
              
     /* empleados que apuntan al empleado de clave 5 en su columna supervisor**/       
                  
                  
          /*******  CUÁNTOS EMPLEADOS SON SUPERVISORES***/
       
       /**ESTO SERÍA : ¿CUÁNTOS EMPLEADOS ESTÁN SUPERVISADOS POR ALGUIEN?*/  
         
         SELECT  COUNT(SUPERVISOR) AS CANTIDAD_DE_SUPERVISADOS
            FROM EMPLEADOS;
  /** LA SOLUCIÓN ES ESTA:  cantidad de supervisores */          
     SELECT  COUNT(DISTINCT SUPERVISOR) AS CANTIDAD_DE_SUPERVISORES
            FROM EMPLEADOS;
            
         
         /** CUÁNTOS DEPARTAMENTOS HAY EN LA EMPRESA?***/
         /** OBTENER ESTO DE DOS FORMAS*/
         /**  primero DE FORMA  MÁS EFICIENTE**/
         
         SELECT  COUNT(*) AS CANTIDAD_DEPARTAMENTOS
           FROM DEPARTAMENTOS;
        /** DE OTRA FORMA, MENOS EFICIENTE,
           SUPONEMOS AQUÍ, QUER SOY UN USUARIO QUE NO PUEDE ACCEDER A 
           TABLA DEPARTAMENTOS Y TAMBIÉN QUE TODOS TIENEN  ALGÚN EMPLEADO**/
        
         /* SELECT
             FROM EMPLEADOS;
             WHERE DEPARTAMENTO IS NOT NULL; /*MERCEDES PONE UN CERO*/
             
           SELECT  COUNT(DISTINCT DEPARTAMENTO) AS CANTIDAD_DEPARTAMENTOS
              FROM EMPLEADOS;
            
         
         /** SUPONGO NO TENGO ACCESO A TABLA DEPARTAMENTOS
             Y TODOS LOS DEPARTAMENTOS TIENEN EMPLEADOS**/
             
          
             
      /****  EN CUÁNTOS PROYECTOS
             ESTÁ TRABAJANDO EL EMPLEADO DE CLAVE 5**/
          
        SELECT  COUNT(*) 
            FROM EMPLEADOS_PROYECTOS
            WHERE EMPLEADO=5;
            
          SELECT  *
            FROM EMPLEADOS_PROYECTOS
            WHERE EMPLEADO=5;  
     /*SELECCIONO LOS REGISTROS DE TRABAJO DEL EMPLEADO DE CLAVE 5*/  
     
         /** EN CUANTOS PROYECTOS ESTÁN TRABAJANDO
             LOS EMPLEADOS DE CLAVES 5,3, Y 1 ?
             ***/
    /** CANTIDAD DE REGISTROS DE TRABAJO DE ESTOS EMPLEADOS*/         
    SELECT COUNT(*)
       FROM EMPLEADOS_PROYECTOS
       WHERE EMPLEADO IN (5,3,1);
    SELECT COUNT(DISTINCT PROYECTO) AS CANTIDAD_DE_PROYECTOS_TRABAJAN
       FROM EMPLEADOS_PROYECTOS
       WHERE EMPLEADO IN (5,3,1);
   
    /** CANTIDAD DE REGISTROS DE TRABAJO DE ESTOS EMPLEADOS*/
   SELECT COUNT(*)
       FROM EMPLEADOS_PROYECTOS
       WHERE EMPLEADO =3
             OR
             EMPLEADO=5
             OR
             EMPLEADO=1;
             
   /** EN CUÁNTOS PROYECTOS Y TOTAL DE HORAS ,
             ESTÁN TRABAJANDO
             LOS EMPLEADOS DE CLAVES 5,3, Y 1 ,  ?
             ***/          
    SELECT  COUNT(DISTINCT PROYECTO) AS CANTIDAD_DE_PROYECTOS,
            SUM(NUM_HORAS) AS TOTAl_HORAS_TRABAJO
      FROM EMPLEADOS_PROYECTOS
      WHERE EMPLEADO IN (5,3,1);
                
 
 
 
 /** CUANTOS SALARIOS DISTINTOS HAY EN LA EMPRESA**/
      /*SOLUCIÓN*/
      SELECT  COUNT(DISTINCT SALARIO)
            FROM EMPLEADOS; 
         SELECT  SUM(SALARIO) AS TOTAL_EN_SALARIOS
            FROM EMPLEADOS;
            
         SELECT   MAX(SALARIO) AS EL_VALOR_DEL_MAYOR_SALARIO 
            FROM EMPLEADOS;
         
    /** CÚAL ES EL MAYOR SALARIO DEL DEPARTAMENTO DE CLAVE 3*/
    
    SELECT  MAX(SALARIO)
       FROM EMPLEADOS
       WHERE DEPARTAMENTO=3;
  /*SALARIO MEDIO DEL DEPARTAMNETO DE CLAVE 3*/  
  
     SELECT  AVG(SALARIO) AS SALARIO_MEDIO_DEP3
        FROM EMPLEADOS
        WHERE DEPARTAMENTO=3;
              
          /**** DIME EL SALARIO MEDIO DE LA EMPRESA*/
          
 /*** AVG(COLUMNA)  MEDIA ARITMÉTICA DE LOS VALORES 
       DE UNA COLUMNA
       ------> DOUBLE**/
       
       SELECT AVG(SALARIO) AS SALARIO_MEDIO_EMPRESA
         FROM EMPLEADOS;
  
  /**
     CÚANTOS EMPLEADOS,      SALARIO MAYOR, 
     SALARIO MENOR      Y SALARIO MEDIO
      HAY EN EL DEPARTAMENTO DE CLAVE 2*/
      
      SELECT  COUNT(*) AS CANTIDAD_EMPLEADOS,
              MAX(SALARIO) AS MAYOR_SALARIO,
              MIN(SALARIO) AS MENOR_SALARIO,
              AVG(SALARIO) AS SALARIO_MEDIO
         FROM EMPLEADOS
         WHERE DEPARTAMENTO=2;
      
      
                
                
                
              
                    
             /*** CÚAL ES EL VALOR DEL SALARIO MÁS ALTO
                  EN LA EMPRESA?***/
                SELECT  MAX(SALARIO)
                   FROM EMPLEADOS;
                /*** MAX(COLUMNA) ---- VALOR MAYOR**/  
                
             
                 
     
                  
            
                 
 /** SALARIO MEDIO DE LOS SUPERVISADOS*/
           SELECT  COUNT(*) AS CANTIDAD_SUPERVISADOS,
                   AVG(SALARIO) AS SALARIO_MEDIO_SUPERVISADOS
              FROM EMPLEADOS
              WHERE SUPERVISOR IS NOT NULL;
 /**SALARIO MEDIO DE LOS DEPARTAMENTOS 2 Y 3*/  
       SELECT  AVG(SALARIO)
           FROM EMPLEADOS
           WHERE DEPARTAMENTO=2 OR DEPARTAMENTO=3;
           
        SELECT  AVG(SALARIO)
           FROM EMPLEADOS 
           WHERE DEPARTAMENTO IN (2,3);
           
     select nombre, salario
        FROM EMPLEADOS
           WHERE DEPARTAMENTO=2 OR DEPARTAMENTO=3;
      /** esto ES INCORRECTO, estoy mezclando algo que no es una tabla...*/
      
       select nombre, salario, AVG(SALARIO)
        FROM EMPLEADOS
        WHERE DEPARTAMENTO=2 OR DEPARTAMENTO=3;     
           
           
 /*  INFORME DE :
    SALARIO MEDIO, MAYOR SALARIO Y CANTIDAD 
    DE LOS SUPERVISADOS QUE PERTENEZCAN A LOS
    DEPARTAMENTOS 2 O 3*/
  SELECT   COUNT(*) AS CANTIDAD_DE_EMPLEADOS,
           AVG(SALARIO) AS SU_SALARIO_MEDIO,
           MAX(SALARIO) AS VALOR_MAYOR_SALARIO
     FROM EMPLEADOS
     WHERE SUPERVISOR IS NOT NULL /* LA COLUMNA TIENE VALOR, ESTAR SUPERVISADO*/
           AND
           ( DEPARTAMENTO=2 OR DEPARTAMENTO=3);
 /*TAMBIÉN ASÍ*/    
  SELECT   COUNT(*) AS CANTIDAD_DE_EMPLEADOS,
           AVG(SALARIO) AS SU_SALARIO_MEDIO,
           MAX(SALARIO) AS VALOR_MAYOR_SALARIO
     FROM EMPLEADOS
     WHERE SUPERVISOR  /* LA COLUMNA TIENE VALOR, ESTAR SUPERVISADO*/
           AND
           DEPARTAMENTO IN (2,3);
  
                
                
           /**** MAYOR SALARIO DE LOS EMPLEADOS DEL DEPARTAMENTO
                DE CLAVE 3**/
                
        SELECT MAX(SALARIO) AS VALOR_MAYOR_SALARIO_DEP_3
           FROM EMPLEADOS
           WHERE DEPARTAMENTO=3;
                
              
                
            /*** CUANTOS EMPLEADOS TIENEN UN SALARIO
                  MAYOR QUE EL SALARIO MEDIO DE  LA EMPRESA**/
                  
      /* ESTA OPERACIÓN PRECISA DE UNA SUBCONSULTA, AÚN NO LO HEMOS VISTO**/            
        SELECT   COUNT(*)
                FROM EMPLEADOS /**VAMOS A CONTAR TUPLAS DE ESTA TABLA*/
                WHERE SALARIO>(  /** SALARIO> QUE UN DATO QUE NO TENGO*/
                               SELECT   AVG(SALARIO) 
                                FROM EMPLEADOS  
                              );       
            
            /*** NOMBRES Y DEPARTAMENTO
                 DE LOS EMPLEADOS
                 QUE TIENEN UN SALARIO
                 MAYOR QUE EL SALARIO MEDIO DE  LA EMPRESA***/
                 
   SELECT   NOMBRE, DEPARTAMENTO
                FROM EMPLEADOS
                WHERE SALARIO >(
                               SELECT   AVG(SALARIO) 
                               FROM EMPLEADOS  
                               ) ;   
                              
                              
     /***** CRITERIO DE CLASIFICACIÓN**
             POR DEFECTO  ESTÁN ORDENADOS POR CLAVE PRIMARIA
             SI NECESITO UN CRITERIO DE CLASIFICACIÓN DISTINTO
                ----> ORDER BY COL1
             PUEDO TENER VARIOS CRITERIOS DE CLASIFICACIÓN
             ----> SON ANIDADOS ***/
             
       /**LISTA DE NOMBRES Y SALARIOS
          DE LOS EMPLEADOS
          DE LOS DEPARTAMENTOS 3, 4 Y 2
          QUE ESTÁN SUPERVISADOS,
          ORDENADOS DE MAYOR A MENOR SALARIO
          Y EN ORDEN ALFABÉTICO
       **/
       
     SELECT NOMBRE, SALARIO
         FROM EMPLEADOS
         WHERE DEPARTAMENTO IN (3,4,2)
                AND
               SUPERVISOR IS NOT NULL
               
         ORDER BY SALARIO DESC, NOMBRE ASC;      
  /*LO MISMO SIN DECIR ASC*/
    SELECT NOMBRE, SALARIO
         FROM EMPLEADOS
         WHERE DEPARTAMENTO IN (3,4,2)
                AND
               SUPERVISOR IS NOT NULL
               
         ORDER BY SALARIO DESC, NOMBRE ;      
       
        
       
           
       
       
           
           
    /**** DAME   NOMBRE / NOMBRES   DEL EMPLEADO/EMPLEADOS MÁS JOVEN**/
          
     SELECT NOMBRE
        FROM EMPLEADOS
        WHERE FECHA_NAC = (
                              SELECT MAX(FECHA_NAC)
                                FROM EMPLEADOS
                          );
                          
  /*FECHA DE NACIMIENTO DEL EMPLEADO MÁS JOVEN*/      
      SELECT MAX(FECHA_NAC)
           FROM EMPLEADOS;  
         
    /**** NOMBRES DE LOS EMPLEADOS
         ORDENADOS POR SU EDAD**/
    SELECT  NOMBRE
       FROM EMPLEADOS;
   
   /* CUÁL ES EL CRITERIO DE CLASIFICACIÓN-- POR CLAVE PRIMARIA*/
     SELECT  NOMBRE
       FROM EMPLEADOS
       ORDER BY NOMBRE ASC; 
       
       SELECT  NOMBRE
         FROM EMPLEADOS
         ORDER BY NOMBRE;
        
            
     /*** EJEMPLO DE EXPRESIÓN O DATO CALCULADO**/
     
     /** DAME LOS DIAS QUE SE LLEVA TRABAJANDO
         EN CADA ASIGNACIÓN DE TRABAJO**/
         
         SELECT  DATEDIFF(CURRENT_DATE(), FECHA_INICIO) AS CANTIDAD_DIAS_DE_TRABAJO
            FROM EMPLEADOS_PROYECTOS;
            /* DE CADA TUPLA CALCULAS LA CANTIDAD DE DÍAS QUE LLEVAN INICIADO EL TRABAJO*/
         
         
        
     
         
     /** EN SELECT NO PONGO COLUMNA, PONGO EXPRESIÓN*/
                   
            
     /** para el proyecto de clave 1,
         obtener:
         clave de cada empleado trabajando en él
         y cantidad de días que lleva trabajando**/
         
    /*VEO EL PROYECTO DE CLAVE 1, ESTÁ EN TABLA PROYECTOS*/ 
       SELECT *
          FROM PROYECTOS
          WHERE ID_PROYECTO=1;
         
     /*QUIENES SON LOS EMPLEADOS (CLAVES) QUE ESTÁN TRABAJANDO
       EN EL PROYECTO DE CLAVE 1*/  
     SELECT  EMPLEADO AS EMPLEADO_TRABAJA
        FROM EMPLEADOS_PROYECTOS
        WHERE PROYECTO=1;
        
      SELECT
           EMPLEADO AS CLAVE_EMPLEADO_TRABAJA,
           FECHA_INICIO AS COMIENZO_A_TRABAJAR,
           DATEDIFF( CURRENT_DATE(), FECHA_INICIO) AS CANTIDAD_DIAS_LLEVA_TRABAJANDO
      FROM EMPLEADOS_PROYECTOS
      WHERE PROYECTO =1;
      
      
  /** USO FUNCIONES **/
  
  
  SELECT  NOMBRE, YEAR(FECHA_NAC), MONTH(FECHA_NAC), DAY(FECHA_NAC)
     FROM EMPLEADOS;
     
 SELECT  NOMBRE, YEAR(FECHA_NAC), MONTH(FECHA_NAC), DAY(FECHA_NAC)
     FROM EMPLEADOS
     ORDER BY FECHA_NAC DESC;  
     
SELECT   NOMBRE, YEAR(FECHA_INICIO) AS ANHO_LANZAMIENTO
   FROM PROYECTOS;
   
     