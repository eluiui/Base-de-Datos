    /** EN LA BASE DE DATOS EMPRESA
    HACHO POR JESUS BLANCO

         1  PARA LOS EMPLEADOS QUE PERTENEZCAN A LOS DEPARTAMENTOS DE  VENTAS Y MARKETING
        OBTENER SU NOMBRE Y CANTIDAD DE PROYECTOS EN LOS QUE TRABAJAN
        ***/
SELECT NOMBRE,NUMERO
	FROM DEPARTAMENTOS
    WHERE NUMERO=2;

SELECT E.NOMBRE AS NOMBRE_EMPLEADO,
       D.NOMBRE AS NOMBRE_DEPARTAMENTO,
       COUNT(EP.PROYECTO) AS CANTIDAD_PROYECTOS
	FROM EMPLEADOS AS E INNER JOIN DEPARTAMENTOS AS D
						  ON E.DEPARTAMENTO=D.NUMERO
							LEFT JOIN empleados_proyectos AS EP
							   ON E.ID_EMPLEADO=EP.EMPLEADO
	WHERE D.Nombre IN ('ventas','marketing')
	gROUP BY E.ID_EMPLEADO
    order by D.NOMBRE;
    
    /*otra forma mas eficiente*/
SELECT E.NOMBRE AS NOMBRE_EMPLEADO,
       D.NOMBRE AS NOMBRE_DEPARTAMENTO,
       COUNT(EP.PROYECTO) AS CANTIDAD_PROYECTOS
	FROM EMPLEADOS AS E INNER JOIN DEPARTAMENTOS AS D
						  ON E.DEPARTAMENTO=D.NUMERO
                           AND 
                             (D.NOMBRE='VENTAS' OR D.NOMBRE='MARKETING')
							    LEFT JOIN empleados_proyectos AS EP
							       ON E.ID_EMPLEADO=EP.EMPLEADO
	gROUP BY E.ID_EMPLEADO
    order by D.NOMBRE;
    
    /*otra forma*/
SELECT E.NOMBRE AS NOMBRE_EMPLEADO,
       (
		SELECT COUNT(*)
			FROM EMPLEADOS_PROYECTOS
			WHERE EMPLEADO=E.ID_EMPLEADO
		) AS CANTIDAD_PROYECTOS
	FROM EMPLEADOS AS E 
    WHERE E.DEPARTAMENTO=(SELECT NUMERO
                               FROM DEPARTAMENTOS
							   WHERE NOMBRE ='VENTAS')
		  OR 
		  E.DEPARTAMENTO=(SELECT NUMERO
							   FROM DEPARTAMENTOS
							   WHERE NOMBRE ='mARKETING');
	/*OTRA MAS*/
    
    SELECT E.NOMBRE AS NOMBRE_EMPLEADO,
       (
		SELECT COUNT(*)
			FROM EMPLEADOS_PROYECTOS
			WHERE EMPLEADO=E.ID_EMPLEADO
		) AS CANTIDAD_PROYECTOS
	FROM EMPLEADOS AS E 
    WHERE E.DEPARTAMENTO IN (SELECT NUMERO
                               FROM DEPARTAMENTOS
							   WHERE NOMBRE IN ('VENTAS''mARKETING') );
    
        
   /** 2  PARA TODOS LOS EMPLEADOS OBTENER
          SU NOMBRE Y CANTIDAD DE PROYECTOS EN LOS QUE TRABAJAN
          QUE HAYAN SIDO LANZADOS POR LOS DEPARTAMENTOS DE VENTAS O MARKETING**/
SELECT E.NOMBRE AS NOMBRE_EMPLEADO,
      (
		SELECT COUNT(*)
			FROM EMPLEADOS_PROYECTOS
			WHERE EMPLEADO=E.ID_EMPLEADO
                  AND 
                  PROYECTO IN(
                              SELECT ID_PROYECTO
                                FROM PROYECTOS
                                WHERE DEPARTAMENTO IN (
                                                       SELECT NUMERO
                                                          FROM DEPARTAMENTOS
														   WHERE NOMBRE IN('VENTAS','mARKETING')
													   )
						     )
		) AS CANTIDAD_PROYECTOS
	FROM EMPLEADOS AS E;
    
    /*DE OTRA FORMA*/
    
SELECT E.NOMBRE AS NOMBRE_EMPLEADO,
      (
		SELECT COUNT(*)
			FROM EMPLEADOS_PROYECTOS
			WHERE EMPLEADO=E.ID_EMPLEADO
                  AND 
                  PROYECTO IN(
                              SELECT ID_PROYECTO
                                FROM PROYECTOS AS P INNER JOIN DEPARTAMENTOS AS D
                                                       ON P.DEPARTAMENTO=D.NUMERO
														   AND
                                                           D.NOMBRE IN('VENTAS','mARKETING')
						     )
		) AS CANTIDAD_PROYECTOS
	FROM EMPLEADOS AS E;   
    
    /*DE OTRA FORMA MAS*/
    
    SELECT  E.NOMBRE AS NOMBRE_EMPLEADO,
			COUNT(EP.PROYECTO) AS CANTIDAD_PROYECTOS
		FROM EMPLEADOS AS E LEFT JOIN EMPLEADOS_PROYECTOS AS EP
                                ON E.ID_EMPLEADO=EP.EMPLEADO/*(0,N)*/
		WHERE EP.PROYECTO IN(
                              SELECT P.ID_PROYECTO
								FROM PROYECTOS AS P INNER JOIN DEPARTAMENTOS AS D
                                                       ON P.DEPARTAMENTO=D.NUMERO
                                                          AND
														  D.NOMBRE IN ('VENTAS','mARKETING')
                                                       
                            )
                            OR EP.PROYECTO IS NULL
		GROUP BY E.ID_EMPLEADO;