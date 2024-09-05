SELECT *
   FROM EMPLEADOS
   WHERE DEPARTAMENTO=3;
  
  /* CREO UNA VISTA DE NOMBRE EMPLEADOS_VENTAS*/
  
  
   CREATE VIEW EMPLEADOS_VENTAS
       AS 
          SELECT *
              FROM EMPLEADOS
              WHERE DEPARTAMENTO=3;
     
  /** DETRÁS DE FROM HEMOS PUESTO IDENTIFICADOR DE UNA VISTA
      SE LANZA EL EJECUTABLE (LA CONSULTA )
      Y AHORA HACEMOS UN SELECT SOBRE DATOS EN MEMORIA DE ESA CONSULTA**/
      
  SELECT * FROM EMPLEADOS_VENTAS;
  
  
  select nombre, salario
      from empleados_ventas
      where salario>1000; 
  
  /** EMPLEADOS_VENTAS ES UN VENTANA O UN VISOR DE LA TABLA EMPLEADOS
      NO VEO TODA LA TABLA ENPLEADOS, SÓLO LOS EMPLEADOS DE VENTAS**/
      
 /** esta vista, empleados_ventas
      ES UNA VISTA ACTUALIZABLE,
          PORQUE  LA CONSULTA SUBYACENTE NO TIENE:
               GROUP BY, LEFT JOIN RIGHT JOIN ...
                     DISTINCT  COLUMNA..
                     **/
  /*PUEDO HACER ESTA OPERACIÓN ... /
  
  /* SUBIR SALARIO A TODOS LOS EMPLEADOS DE VENTAS UN 5%***/
  
  UPDATE EMPLEADOS_VENTAS
      SET SALARIO= SALARIO*1.05;
 SELECT * FROM EMPLEADOS_VENTAS;
 SELECT * FROM EMPLEADOS;
 
 /** SOY ROOT**/
 
 UPDATE EMPLEADOS
    SET SALARIO=SALARIO*1.1;
 /*SUBO SALARIO A TODOS LOS EMPLEADOS UN 10%*/  
 
 UPDATE empleados
    SET SALARIO=SALARIO*1.08
    WHERE DEPARTAMENTO=3 OR DEPARTAMENTO=4;
   /*SUBO SALARIO A TODOS LOS EMPLEADOS DE 3 Y 4 UN 8%*/  
   /** AHORA SOY UN USUARIO QUE SOLO TIENE ACCESO A  EMPLEADOS_VENTAS*/
   
   UPDATE EMPLEADOS_VENTAS
       SET SALARIO= 2500;
   
  
  /* VAMOS A CREAR UNA VISTA EN ESTA BASE DE DATOS
      DE NOMBRE DATOS_DIRECTORES
       QUE TENGA ESTAS COLUMNAS,
       NOMBRE, SALARIO, CANTIDAD DE EMPLEADOS QUE DIRIGE,
       CLAVE DEL DEAPARTAMENTO QUE DIRIGE Y NOMBRE DEL DEPARTAMENTO QUE DIRIGE
       CANTIDAD DE SUPERVISADOS EN EL DEPARTAMENTO QUE DIRIGE,
       CANTIDAD DE PROYECTOS DEL DEPARTAMNETO QUE DIRIGE,
       TOTAL DE PRESUPUESTO EN LOS DITINTOS PROYECTOS  INVERTIDO EN SU DEPARTAMENTO**/
       
       
       SELECT     ED.NOMBRE AS DIRECTOR,
                  ED.SALARIO AS SALARIO,
                  D.NUMERO AS CLAVE_DEPARTAMENTO,
                  D.NOMBRE AS DEPARTAMENTO,
                  COUNT(DISTINCT E.ID_EMPLEADO) AS CANTIDAD_EMPLEADOS_DIRIGE,
                  COUNT(DISTINCT ES.ID_EMPLEADO) AS CANTIDAD_SUPERVISADOS,
                  COUNT(DISTINCT P.ID_PROYECTO)  AS CANTIDAD_PROYECTOS_LANZADOS,
                   /* NO SIRVE SUM(P.PRESUPUESTO)*/
                   (
                     SELECT  SUM(PRESUPUESTO)
                        FROM PROYECTOS
                        WHERE DEPARTAMENTO=D.NUMERO
                                         
                   ) AS TOTAL_PRESUPUESTO
                  
          FROM  EMPLEADOS AS ED INNER JOIN  DEPARTAMENTOS AS D
                                   ON ED.ID_EMPLEADO=D.DIRECTOR  /*(0,1)*/
                                      LEFT JOIN EMPLEADOS AS E
                                          ON D.NUMERO=E.DEPARTAMENTO  /*(0,N), NO TENGO DISPARADOR
                                                                       QUE IMPIDA REGISTRAR UN DEPARTAMENTO
                                                                       SIN EMPLEADOS ASIGNADOS A ÉL*/
                                          LEFT JOIN  EMPLEADOS AS ES
                                               ON D.NUMERO=ES.DEPARTAMENTO 
                                                  AND
                                                  ES.SUPERVISOR IS NOT NULL  /*(0,N)*/
                                                   LEFT JOIN PROYECTOS AS P
                                                      ON D.NUMERO=P.DEPARTAMENTO /*(0,N)*/
                                                  
          GROUP BY ED.ID_EMPLEADO, D.DIRECTOR;                                
  
    CREATE VIEW  DATOS_DIRECTORES 
       AS
        SELECT     ED.NOMBRE AS DIRECTOR,
                  ED.SALARIO AS SALARIO,
                  D.NUMERO AS CLAVE_DEPARTAMENTO,
                  D.NOMBRE AS DEPARTAMENTO,
                  COUNT(DISTINCT E.ID_EMPLEADO) AS CANTIDAD_EMPLEADOS_DIRIGE,
                  COUNT(DISTINCT ES.ID_EMPLEADO) AS CANTIDAD_SUPERVISADOS,
                  COUNT(DISTINCT P.ID_PROYECTO)  AS CANTIDAD_PROYECTOS_LANZADOS,
                   /* NO SIRVE SUM(P.PRESUPUESTO)*/
                   (
                     SELECT  SUM(PRESUPUESTO)
                        FROM PROYECTOS
                        WHERE DEPARTAMENTO=D.NUMERO
                                         
                   ) AS TOTAL_PRESUPUESTO
                  
          FROM  EMPLEADOS AS ED INNER JOIN  DEPARTAMENTOS AS D
                                   ON ED.ID_EMPLEADO=D.DIRECTOR  /*(0,1)*/
                                      LEFT JOIN EMPLEADOS AS E
                                          ON D.NUMERO=E.DEPARTAMENTO  /*(0,N), NO TENGO DISPARADOR
                                                                       QUE IMPIDA REGISTRAR UN DEPARTAMENTO
                                                                       SIN EMPLEADOS ASIGNADOS A ÉL*/
                                          LEFT JOIN  EMPLEADOS AS ES
                                               ON D.NUMERO=ES.DEPARTAMENTO 
                                                  AND
                                                  ES.SUPERVISOR IS NOT NULL  /*(0,N)*/
                                                   LEFT JOIN PROYECTOS AS P
                                                      ON D.NUMERO=P.DEPARTAMENTO /*(0,N)*/
                                                  
          GROUP BY ED.ID_EMPLEADO, D.DIRECTOR;                                
  
  /** AHORA ESTAMO USANDO LA VISTA
      CUALQUIER USUARIO QUE TENGA PERMISOS DE LECTURA 
      SOBRE DATOS_DIRECTORES 
      **/
    SELECT *
      FROM DATOS_DIRECTORES;
              
   SELECT   *
     FROM DATOS_DIRECTORES
      WHERE CANTIDAD_SUPERVISADOS>2
            AND
            TOTAL_PRESUPUESTO>1000;