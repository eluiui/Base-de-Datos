/*obtener para cada EMPLEADO SU NOMBRE SU SALARIO 
EL NOMBRE DE SU DEPARTAMENTO Y LA CANTIDAD DE EMPLEADOS A LOS QUE SUPERVISA
A)INFORME PARA SOLO EMPLEADOS QUE SUPERVISA*/
SELECT E.NOMBRE AS NOMBRE_EMPLEADO,
       E.SALARIO AS SALARIO_EMPLEADO,
       D.NOMBRE AS NOMBRE_DEPARTAMENTO,
       COUNT(*) AS CANTIDAD_SUPERVISADOS
	FROM EMPLEADOS AS E INNER JOIN DEPARTAMENTOS AS D
                          ON E.DEPARTAMENTO=D.NUMERO /*(1,1)*/
                             INNER JOIN EMPLEADOS AS ESADOS
                                ON E.ID_EMPLEADO=ESADOS.SUPERVISOR/*(1,1)*/
	GROUP BY E.ID_EMPLEADO;
                                
/*B)INFORME PARA TODOS LOS EMPLEADOS DE LA EMPRESA*/
SELECT E.NOMBRE AS NOMBRE_EMPLEADO,
       E.SALARIO AS SALARIO_EMPLEADO,
       D.NOMBRE AS NOMBRE_DEPARTAMENTO,
       COUNT(ESADOS.ID_EMPLEADO) AS CANTIDAD_EMPLEADOS
	FROM EMPLEADOS AS E INNER JOIN DEPARTAMENTOS AS D
                          ON E.DEPARTAMENTO=D.NUMERO /*(1,1)*/
                             LEFT JOIN EMPLEADOS AS ESADOS
                                ON E.ID_EMPLEADO=ESADOS.SUPERVISOR/*(0,1)*/
	GROUP BY E.ID_EMPLEADO;
    
/*A PARTIR DELINFORME ANTERIOR AÑADIR PARA CADA EMPLEADO LA CANTIDAD 
DE PROYECTOS EN LOS QUE TRABAJA*/
SELECT E.NOMBRE AS NOMBRE_EMPLEADO,
       E.SALARIO AS SALARIO_EMPLEADO,
       D.NOMBRE AS NOMBRE_DEPARTAMENTO,
       COUNT(DISTINCT ESADOS.ID_EMPLEADO) AS CANTIDAD_EMPLEADOS,
       COUNT(DISTINCT EP.PROYECTO) AS CANTIDAD_PROYECTOS
	FROM EMPLEADOS AS E INNER JOIN DEPARTAMENTOS AS D
                          ON E.DEPARTAMENTO=D.NUMERO /*(1,1)*/
                             LEFT JOIN EMPLEADOS AS ESADOS
                                ON E.ID_EMPLEADO=ESADOS.SUPERVISOR/*(0,1)*/
                                  LEFT JOIN EMPLEADOS_PROYECTOS AS EP
                                    ON E.ID_EMPLEADO=EP.EMPLEADO/*(0,1)*/
	GROUP BY E.ID_EMPLEADO;
    
/*AÑADIR A ESTE INFORME PARA CADA EMPLEADO LA 
CANTIDAD DE EMPLEADOS QUE DIRIGE*/
SELECT E.NOMBRE AS NOMBRE_EMPLEADO,
       E.SALARIO AS SALARIO_EMPLEADO,
       D.NOMBRE AS NOMBRE_DEPARTAMENTO,
       COUNT(DISTINCT ESADOS.ID_EMPLEADO) AS CANTIDAD_EMPLEADOS,
       COUNT(DISTINCT EP.PROYECTO) AS CANTIDAD_PROYECTOS,
       COUNT(DISTINCT ED.ID_EMPLEADO) AS CANTIDAD_EMPLEADOS_DIRIGIDOS
	FROM EMPLEADOS AS E INNER JOIN DEPARTAMENTOS AS D
                          ON E.DEPARTAMENTO=D.NUMERO /*(1,1)*/
                             LEFT JOIN EMPLEADOS AS ESADOS
                                ON E.ID_EMPLEADO=ESADOS.SUPERVISOR/*(0,1)*/
                                  LEFT JOIN EMPLEADOS_PROYECTOS AS EP
                                    ON E.ID_EMPLEADO=EP.EMPLEADO/*(0,1)*/
									  LEFT JOIN EMPLEADOS AS ED
                                        ON E.ID_EMPLEADO=(SELECT DIRECTOR 
                                                             FROM DEPARTAMENTOS
                                                             WHERE NUMERO=ED.DEPARTAMENTO
                                                             )
	GROUP BY E.ID_EMPLEADO;
    
    /*PARA CADA DIRECTOR SU NOMBRE SALARIO NOMBRE DEL DEPARTAMENTO QUE DIRIGE Y 
    CANTIDAD EMPLEADOS A LOS QUE DIRIGE */
    /*UNA FORMA DE HACERLO*/
    SELECT ED.NOMBRE AS NOMBRE_DIRECTOR,
           ED.SALARIO AS SALARIO_DIRECTOR,
           D.NOMBRE AS NOMBRE_DEPARTAMENTO,
           COUNT(E.ID_EMPLEADO) AS CANTIDAD_EMPLEADOS_DIRIGIDOS
		FROM EMPLEADOS AS ED INNER JOIN DEPARTAMENTOS AS D
						      ON ED.ID_EMPLEADO=D.DIRECTOR/*(0,1)*/
                                INNER JOIN EMPLEADOS AS E
                                  ON D.NUMERO=E.DEPARTAMENTO
		GROUP BY ED.ID_EMPLEADO, D.DIRECTOR , D.NUMERO;
     /*OTRA FORMA DE HACERLO*/
	SELECT ED.NOMBRE AS NOMBRE_DIRECTOR,
           ED.SALARIO AS SALARIO_DIRECTOR
		FROM EMPLEADOS AS ED
        WHERE ED.ID_EMPLEADO IN (SELECT DIRECTOR 
                                     FROM DEPARTAMENTOS
                                     );
                                     
	/*PARA CADA EMPLEADO OBTENER  SU NOMBRE Y NOMBRE DE SU DEPARTAMENTO*/
    SELECT  E.NOMBRE AS NOMBRE_EMPLEADO,
            D.NOMBRE AS NOMBRE_DEPARTAMENTO
		FROM EMPLEADO AS E INNER JOIN DEPARTAMENTO AS D
                             ON E.DEPARTAMENTO=D.NUMERO;
                             
	SELECT NOMBRE AS EMPLEADO,
           (
           SELECT NOMBRE 
			FROM DEPARTAMENTOS 
            WHERE NUMERO=E.DEPARTAMENTO
            ) AS SU_DEPARTAMENTO
		FROM EMPLEADOS AS E;