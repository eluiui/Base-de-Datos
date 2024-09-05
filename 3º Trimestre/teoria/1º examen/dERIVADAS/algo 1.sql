/*
  A todos los registros de trabajo
  en donde tengamos un proyecto de ventas
  les asignamos el precio de hora de trabajao  definido en la tabla
  por defecto**/
  
  /*1º SOLUCION*/
  USE EMPRESA;
   UPDATE EMPLEADOS_PROYECTOS AS EP
	SET PRECIO_HORA=DEFAULT
	WHERE PROYECTO IN(
					  SELECT ID_PROYECTO
						FROM PROYECTOS
                        WHERE DEPARTAMENTO =(
                                              SELECT NUMERO
												FROM DEPARTAMENTOS
                                                WHERE NOMBRE='VENTAS'
                                              )
                      );
  /*2º SOLUCION*/
  UPDATE EMPLEADOS_PROYECTOS AS EP INNER JOIN PROYECTOS AS P
                                     ON P.ID_PROYECTO=EP.PROYECTO
										AND P.DEPARTAMENTO=(SELECT D.NUMERO
												               FROM DEPARTAMENTOS AS D
															   WHERE NOMBRE='VENTAS'
														     )
	SET PRECIO_HORA=DEFAULT;
	
   
  /*** Definimos para la columna num_horas de esta tabla un valor por defecto igual a 150 horas***/   
 ALTER TABLE EMPLEADOS_PROYECTOS
     MODIFY COLUMN NUM_HORAS INT NOT NULL DEFAULT 150;
 
  
  /*** se registra un nuevo proyecto
  nombre 'sostenibilidad', pertenece al departamento de administración,la fecha de finalización se prevee final de junio,
  su presupuesto será de un importe igual a la  media de presupuestos de la empresa
  
  se incorporan al nuevo proyecto todos los supervisores y todos los directores de la empresa con los valores por defecto
  
  ********************/
  
    SELECT AVG(PRESUPUESTO) INTO @DATO
	FROM PROYECTOS;
  
  START TRANSACTION;
  INSERT INTO PROYECTOS
  (NOMBRE,DEPARTAMENTO,FECHA_INICIO,FECHA_FIN,PRESUPUESTO)
  VALUES
  (
  'SOSTENIBILIDAD',
   (
   SELECT NUMERO
	FROM DEPARTAMENTOS 
    WHERE NOMBRE='ADMINISTRACION'
   ),
  current_date(),
  '2023-06-30',
@DATO
  );

INSERT INTO EMPLEADOS_PROYECTOS
(EMPLEADO, PROYECTO,FECHA_INICIO)

SELECT DISTINCT SUPERVISOR,
			(
            SELECT ID_PROYECTO
				FROM PROYECTOS
                WHERE NOMBRE='SOSTENIBILIDAD'
            ),
            CURRENT_DATE()
		FROM EMPLEADOS
        WHERE SUPERVISOR IS NOT NULL;
        
INSERT INTO EMPLEADOS_PROYECTOS
(EMPLEADO, PROYECTO,FECHA_INICIO)

SELECT DIRECTOR,
			(
            SELECT ID_PROYECTO
				FROM PROYECTOS
                WHERE NOMBRE='SOSTENIBILIDAD'
            ),
            CURRENT_DATE()
		FROM DEPARTAMENTOS;
COMMIT;