/** llamada a función num_empleados_dep ***/

SELECT   NOMBRE AS DEPARTAMENTO,
         Num_empleados_dep(numero) as cantidad_empleados
    FROM DEPARTAMENTOS;
/** esta consulta usando la función que hemos implementado,
    está ocultando una subconsulta.... sería como esta solución**/
    
select   nombre as departamento,
         (
            select  count(*)
               from empleados
               where departamento= numero
           
         ) as cantidad_empleados
    from departamentos;    
    
    select    d.nombre as departamento,
              count(e.id_empleado) as cantidad_empleados
       from departamentos as d left join  empleados as e
                               on d.numero=e.departamento /*(0,n)*/
      group by d.numero;                         
    
  select num_empleados_dep(clave_departamento('administracion'));
  
  
/** no existe departamneto de clave 100**/

select num_empleados_dep(100);


/* llamada a función num_empleados_nomb_dep *****************/

SELECT NUM_EMPLEADOS_NOMB_DEP('VENTAS') AS CANTIDAD_EMPLEADOS;
SELECT NUM_EMPLEADOS_NOMB_DEP('HOLA, BUENAS');

/*** PARA CADA DEPARTAMENTO
OBTENER SU NOMBRE Y LA CANTIDAD DE EMPLEADOS
QUE TIENE**/


    
    
SELECT   NOMBRE AS DEPARTAMENTO,
         NUM_EMPLEADOS_NOMB_DEP(NOMBRE) AS CANTIDAD_EMPLEADOS
    FROM DEPARTAMENTOS;
    
    
   /*** llamada a función director************/ 
    SELECT Nombre_DIRECTOR(1234);
    select nombre_director(1);
    
    /** OBTENER DE CADA DEPARTAMENTO
     SU NOMBRE Y EL NOMBRE DE SU DIRECTOR*/
    SELECT   NOMBRE AS DEPARTAMENTO,
             NOMBRE_DIRECTOR(NUMERO) AS SU_DIRECTOR
        FROM DEPARTAMENTOS;
    
    
    SELECT   NOMBRE AS DEPARTAMENTO,
             DIRECTOR(NUMERO) AS SU_DIRECTOR,
             NUM_EMPLEADOS_DEP(NUMERO) AS CANTIDAD_EMPLEADOS
        FROM DEPARTAMENTOS;
 /** la consulta sin uso de funciones implementadas**/       
        
        SELECT
               NOMBRE AS DEPARTAMENTO,
               (
                 SELECT   NOMBRE
                   FROM EMPLEADOS
                   WHERE ID_EMPLEADO= DIRECTOR
                                                   
               
               ) AS NOMBRE_DIRECTOR,
               (
                 SELECT  COUNT(*)
                    FROM EMPLEADOS
                    WHERE DEPARTAMENTO=NUMERO
               
               ) AS CANTIDAD_EMPLEADOS
            FROM DEPARTAMENTOS;
 /** la misma consulta de otra forma************/
 SELECT
               D.NOMBRE AS DEPARTAMENTO,
               (
                 SELECT   NOMBRE
                   FROM EMPLEADOS
                   WHERE ID_EMPLEADO= D.DIRECTOR
                                                   
               
               ) AS NOMBRE_DIRECTOR,
               COUNT(E.ID_EMPLEADO) AS CANTIDAD_EMPLEADOS
               
   FROM DEPARTAMENTOS AS D  LEFT JOIN EMPLEADOS AS E
                               ON D.NUMERO=E.DEPARTAMENTO
   GROUP BY D.NUMERO; 
   
   /** la misma de otra forma, colocando a  la derecha la tabla 
        departamnetos  **/
        
   SELECT
               D.NOMBRE AS DEPARTAMENTO,
               (
                 SELECT   NOMBRE
                   FROM EMPLEADOS
                   WHERE ID_EMPLEADO= D.DIRECTOR
                                                   
               
               ) AS NOMBRE_DIRECTOR,
               COUNT(E.ID_EMPLEADO) AS CANTIDAD_EMPLEADOS
               
   FROM EMPLEADOS AS E RIGHT JOIN DEPARTAMENTOS AS D
                            ON D.NUMERO=E.DEPARTAMENTO
   GROUP BY D.NUMERO;                             
     
   /* DAME LA LISTA DE NOMBRES DE DIRECTORES CUYOS DEPARTAMENTO 
   TENGAN MÁS DE 3 EMPLEADOS**/
   
   SELECT     DIRECTOR(NUMERO) AS NOMBRE_DIRECTOR
       FROM DEPARTAMENTOS
       WHERE NUM_EMPLEADOS_DEP(NUMERO)>3;
       
   /** de otra forma**/    
   SELECT      D.NOMBRE,
               DIRECTOR(D.NUMERO) AS SU_DIRECTOR
        FROM DEPARTAMENTOS AS D 
        WHERE (
                 SELECT  COUNT(*)
                    FROM EMPLEADOS
                    WHERE DEPARTAMENTO=D.NUMERO
        
              ) >3; /* subconsulta correlacionada en cláusula where**/
       
   /** otra forma, si cantidad de departamentos es muy grande
       más eficiente**/ 
   SELECT     D.NOMBRE AS DEPARTAMENTO,
              DIRECTOR(D.NUMERO) AS SU_DIRECTOR 
       FROM DEPARTAMENTOS AS D LEFT JOIN EMPLEADOS AS E
                                ON D.NUMERO=E.DEPARTAMENTO
       GROUP BY D.NUMERO
       HAVING  COUNT(E.ID_EMPLEADO)>3; 
       
       
       
 /* DAME NOMBRE, Y FECHA  DE NACIMIENTO Y SALARIO
   DE LOS DIRECTORES**/
   /** usamos función SI_DIRECTOR  **/
   
   SELECT  NOMBRE, SALARIO, FECHA_NAC
       FROM EMPLEADOS 
       WHERE SI_DIRECTOR(ID_EMPLEADO);
       
   /*PARA LOS EMPLEADOS QUE NO SON DIRECTORES
    Y PERTENECEN A VENTAS Y A MARKETING
      SU NOMBRE Y SU FECHA DE NAC**/
      
     
     SELECT    NOMBRE, FECHA_NAC
         FROM EMPLEADOS
         WHERE !SI_DIRECTOR(ID_EMPLEADO)
                AND
                DEPARTAMENTO IN (
                                   SELECT   NUMERO
                                       FROM DEPARTAMENTOS
                                       WHERE NOMBRE IN ('VENTAS', 'MARKETING')
                                 );
                                 
    /*** LA MISMA ESCRITA MÁS FEA**/                             
  SELECT    NOMBRE, FECHA_NAC
         FROM EMPLEADOS
         WHERE SI_DIRECTOR(ID_EMPLEADO)=FALSE
                AND
                DEPARTAMENTO IN (
                                   SELECT   NUMERO
                                       FROM DEPARTAMENTOS
                                       WHERE NOMBRE IN ('VENTAS', 'MARKETING')
                                 );                               
            
 /** PROBAMOS FUNCIONES SALARIO_MEDIO, SALARIO_MEDIO_SUPERVISORES
     Y SALARIO_MEDIO_DEP***/
     
SELECT SALARIO_MEDIO_SUPERVISORES();
SELECT SALARIO_MEDIO();
SELECT SALARIO_MEDIO_DEP(2);
SELECT SALARIO_MEDIO_DEP(clave_departamento('ventas'));
SELECT SALARIO_MEDIO_DEP( 1000) ;/* NO EXISTE DEPARTAMENTO DE CLAVE 1000*/
/*AHORA EL ARGUMENTO DE LA FUNCIÓN LO OBTENEMOS
MEDIANTE UNA SUBCONSULTA**/

SELECT  SALARIO_MEDIO_DEP ( ( 
                             SELECT NUMERO
                             FROM DEPARTAMENTOS
                             WHERE NOMBRE='VENTAS'
                            )
                          );
                           
  SELECT  SALARIO_MEDIO_DEP ( ( 
                             SELECT NUMERO
                             FROM DEPARTAMENTOS
                             WHERE NOMBRE='VENTAS'
                            )
                           ) AS SALARIO_MEDIO_VENTAS;   
                           
                           
   SELECT SALARIO_MEDIO_DEP(120); 
   SELECT SALARIO_MEDIO_DEP(CLAVE_DEPARTAMENTO('VENTAS'));
   
   /*** OBTENER LOS NOMBRES DE LOS EMPLEADOS QUE TENGAN
      UN SALARIO MAYOR 
      QUE EL SALARIO MEDIO DE LOS SUPERVISORES**/
      
      
      SELECT   NOMBRE
         FROM EMPLEADOS
         WHERE SALARIO > SALARIO_MEDIO_SUPERVISORES();
      
      /*****************  ESTA CONSULTA PUEDE SUSTITUIRSE
      POR ESTA OTRA 
      USANDO VARIABLE DE SESIÓN
      ***/
      
      SELECT SALARIO_MEDIO_SUPERVISORES() INTO @DATOSALARIO;
      SELECT   NOMBRE
         FROM EMPLEADOS
         WHERE SALARIO >@DATOSALARIO;
         
     /*******************  PROBAR FUNCIONES SI_SUPERVISOR
           Y NUM_SUPERVISADOS  ********************/    
 /*** PARA CADA EMPLEADO QUE  SEA SUPERVISOR
    OBTENER SU NOMBRE Y CANTIDAD DE SUPERVISOR*/
    
    SELECT 
             NOMBRE,
             NUM_SUPERVISADOS(ID_EMPLEADO)
    FROM EMPLEADOS
    WHERE SI_SUPERVISOR(ID_EMPLEADO);
    
    /** DE OTRA FORMA **/
    SELECT  NOMBRE
       FROM EMPLEADOS
       WHERE NUM_SUPERVISADOS(ID_EMPLEADO);     
      
   /** dame el nombre del director de ventas**/
   
   select  director(clave_departamento('ventas') );
   /** otra posibilidad**/
   select director (  (
                         select numero
                            from departamentos
                            where nombre='ventas'
                      )
                    ) as director;
                    
     /*** otra forma , sin funciones**/
     
     select    nombre
           from  empleados
           where id_empleado = (
                                  select  director
                                     from departamentos
                                     where nombre='ventas'
                               );
/********************************************************************/                    
  /**nombres de los directores de ventas y administración**/
  
 select  director(clave_departamento('ventas'))
  union
 select  director(clave_departamento('administracion'));
 
 
  
   
/**  LA MISMA CONSULTA SIN FUNCIONES**/


select   nombre
    from empleados
    where id_empleado in (
                           select  director
                                     from departamentos
                                     where nombre='ventas'
                                           or
                                           nombre='administracion'
    
                         );
   /** O DE ESTA OTRA FORMA**/                      
   select *
      from empleados as e inner join departamentos as d
                             on e.id_empleado=d.director 
                                 and
                                 d.nombre in ('ventas','administracion');
  /** O E ESTA FORMA QUE ESTA ES LA MISMA **/
   
   select  e.nombre
      from empleados as e inner join departamentos as d
                             on e.id_empleado=d.director
      where d.nombre  in ('ventas','administracion');                      
   
 /*para los directores de ventas y administración
  sus nombres y la cantidad de proyectos
  lanzados por el departamento que dirigen
  **/
 select  d.nombre as departamento,
         e.nombre as director,
         
         count(p.id_proyecto) as cantidad_proyectos_lanzados
         
      from empleados as e inner join departamentos as d
                             on e.id_empleado=d.director   /*(0,1)*/
                                 and
                                 d.nombre in ('ventas','administracion')
                                   left join proyectos as p  /*(0,n)*/
                                      on d.numero=p.departamento
   group by d.numero, d.director,e.id_empleado ;  
   
 /*************************************
 AHORA LA MISMA CONSULTA
                  CON NUESTRAS FUNCIONES
 ************************************/
   
 select  'VENTAS' AS DEPARTAMENTO,
         director(clave_departamento('ventas')) AS DIRECTOR,
         NUM_PROYECTOS_DEP(clave_departamento('ventas')) AS CANTIDAD_PROYECTOS
  union
 select  'ADMINISTRACION' AS DEPARTAMENTO,
         director(clave_departamento('administracion')) AS DIRECTOR,
         NUM_PROYECTOS_DEP(clave_departamento('administracion')) AS CANTIDAD_PROYECTOS;
 
 
/***************************************************/ 
 select  director(clave_departamento('administracion'));      
   
   
/*************
PROBAMOS FUNCIÓN NUM_PROYECTOS_DEP ***************/

/*  PARA  CADA DEPARTAMENTO DAME EL NÚMERO DE EMPLEADOS 
  Y LA CANTIDAD DE PROYECTOS LANZADOS
  
  **/
  
  SELECT    NOMBRE AS DEPARTAMENTO,
            NUM_EMPLEADOS_DEP(NUMERO) AS CANTIDAD_EMPLEADOS,
            NUM_PROYECTOS_DEP(NUMERO) AS CANTIDAD_PROYECTOS
      FROM DEPARTAMENTOS;
   
   
 SELECT NUM_PROYECTOS_DEP(2);  
 SELECT NUM_PROYECTOS_DEP(145);   /** NO EXISTE ESTE DEPARTAMNETO 145**/
              
  /***** SUBIR EL SUELDO UN 2% A LOS EMPLEADOS DE VENTAS**/
 
 UPDATE empleados
     SET SALARIO=SALARIO*1.02
     WHERE DEPARTAMENTO=CLAVE_DEPARTAMENTO('VENTAS');
     
 /*** LANZAR FUNCIÓN HORAS_TRABAJO_DEP  PARA PROBARLA**/ 
   
   SELECT  HORAS_TRABAJO_DEP(300); 
   /** NO EXISTE DEPARTAMENTO 300*/
   SELECT  HORAS_TRABAJO_DEP(CLAVE_DEPARTAMENTO('PERSONAL') );
   
    /**** PARA LOS DEPARTAMENTOS
       CON MÁS DE 100 HORAS DE TRABAJO EN LOS DISTINTOS
       PROYECTOS EN ESTE MOMENTO,OBTENER:
       SU CLAVE, SU NOMBRE, Y EL NOMBRE DE SU DIRECTOR**/
    /** SOLUCIÓN CON NUESTRAS FUNCIONES**/
    SELECT      NUMERO AS CLAVE_DEPARTAMENTO,
                NOMBRE AS DEPARTAMENTO,
                DIRECTOR(NUMERO) AS SU_DIRECTOR
        FROM DEPARTAMENTOS
        WHERE HORAS_TRABAJO_DEP( NUMERO)   > 100;   
        
   /** CONSULTA DE OTRA FORMA, SIN FUNCIONES**/     
   SELECT    D.NUMERO,
             D.NOMBRE,
             DIRECTOR(D.NUMERO)
        FROM DEPARTAMENTOS AS D INNER JOIN EMPLEADOS_PROYECTOS AS EP
                                  ON EP.EMPLEADO IN (
                                                       SELECT ID_EMPLEADO
                                                          FROM EMPLEADOS
                                                          WHERE DEPARTAMENTO=D.NUMERO
                                                    )
        GROUP BY D.NUMERO
        HAVING SUM(NUM_HORAS)>100;                                            
                                   
   /**!!!!!! FIJARSE AQUÍ CONDICIÓN DE COMBINACIÓN ON.....
      ENTRE LA TABLA DEPARTAMENTOS Y LA TABLA EMPLEADOS_PROYECTOS
      NO HAY UNA RELACIÓN DIRECTA, ES DECIR UNA REFERENCIA , NO USAMOS
      EXPRESIÓN FK=PK
      
      SIN EMBARGO HEMOS DISEÑADO UNA EXPRESIÓN QUE LAS RELACIONA:
       CADA TUPLA DE DEPARTAMENTO LA COMBINO CON LA/LAS TUPLAS DE EMPLEADOS_PROYECTOS
       DONDE EMPLEADO ESTÁ ASIGNADO A EL  DEPARTAMENTO
       ************/
 
 
     
         
  
  