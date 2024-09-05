/** NOS DAN LA ORDEN DE REDEFINIR EL VALOR POR DEFECTO 
    PARA LA COLUMNA OBLIGATORIA
    PRECIO_HORA DE LA TABLA EMPLEADOS_PROYECTOS,
    QUE ES UNA TABLA PARA GUARDAR LAS OCURRENCIAS
    DE LA RELACIÓN DE TIPO (N:M) 
    EMPLEADO TRABAJA EN PROYECTO/PROYECTO TIENE EMPLEADO TRABAJANDO
    EL VALOR POR DEFECTO SERÁ PARA ESA COLUMNA 150.3 EUROS LA HORA*/
    
    /*SOLUCIÓN: REDEFINIR DEFINICIÓN DE TABLA---> USO DE SENTENCIA ALTER*/
    
    ALTER TABLE EMPLEADOS_PROYECTOS 
       MODIFY COLUMN PRECIO_HORA FLOAT NOT NULL DEFAULT 150.3; 
       
    DESCRIBE EMPLEADOS_PROYECTOS;   
    


/*
  A todos los registros de trabajo
  en donde tengamos un proyecto de ventas
  les asignamos el precio de hora de trabajao  definido en la tabla
  por defecto**/
  
  /*** SOLUCIÓN  1
       SELECCIONO LAS TUPLAS DE LA TABLA E_P A MODIFICAR
       EMPLEADO EN WHERE UNA SUBCONSULTA*/
  UPDATE  EMPLEADOS_PROYECTOS AS EP
     SET PRECIO_HORA= DEFAULT
     WHERE PROYECTO IN (
                           SELECT  ID_PROYECTO
                              FROM PROYECTOS
                              WHERE DEPARTAMENTO=(
                                                   SELECT NUMERO
                                                     FROM DEPARTAMENTOS
                                                     WHERE NOMBRE='VENTAS'
                                                 ) 
                        );
                        
  /**SOLUCIÓN 2 
     SELECCIONO LAS TUPLAS DE LA TABLA E_P A MODIFICAR CON UPDATE
       EMPLEADO LA OPCCIÓN DE COMBINAR CON INNER LAS TUPLAS DE E_P
        Y TUPLAS DE PROYECTOS DE VENTAS*/
  
  UPDATE EMPLEADOS_PROYECTOS AS EP INNER JOIN PROYECTOS AS P 
                                     ON EP.PROYECTO=P.ID_PROYECTO
                                         AND
                                         P.DEPARTAMENTO=(
                                                           SELECT NUMERO
                                                            FROM DEPARTAMENTOS
                                                            WHERE NOMBRE='VENTAS'
                                                         )
        SET PRECIO_HORA= DEFAULT;  
   /**SOLUCIÓN 3 
     SELECCIONO LAS TUPLAS DE LA TABLA E_P A MODIFICAR CON UPDATE
       EMPLEADO LA OPCCIÓN DE COMBINAR CON INNER LAS TUPLAS DE E_P
        Y TUPLAS DE PROYECTOS DE VENTAS*/    
   
   UPDATE EMPLEADOS_PROYECTOS AS EP INNER JOIN PROYECTOS AS P 
                                     ON EP.PROYECTO=P.ID_PROYECTO
                                        INNER JOIN DEPARTAMENTOS AS D
                                           ON P.DEPARTAMENTO=D.NUMERO
                                              AND
                                              D.NOMBRE='VENTAS'
        SET PRECIO_HORA= DEFAULT;  
     
 
                            
  /*** Definimos para la columna num_horas
        de esta tabla un valor por defecto igual a 150 horas***/  
        
        
     ALTER TABLE EMPLEADOS_PROYECTOS 
        MODIFY NUM_HORAS INTEGER NOT NULL DEFAULT 150;
  
  
 
  
  /***   EJERCICIO 
  se registra un nuevo proyecto
  nombre 'sostenibilidad', pertenece al departamento de administración,
  la fecha de finalización se prevee final de junio,
  su presupuesto será de un importe igual 
  a la  media de presupuestos de la empresa
  
  se incorporan al nuevo proyecto 
  todos los supervisores
  y todos los directores de la empresa con los valores por defecto
  
  ********************/
  
  /** PARA CALCULAR DATO QUE NECESITO **/
 START TRANSACTION; 
  
    SELECT AVG(PRESUPUESTO) INTO @DATO
       FROM PROYECTOS;
       
    /** ENTRE ESTA LECTURA PARA CALCULAR DATO
        Y EL INSERT NO PUEDE OTRO USUARIO CAMBIAR IMPORTE DE LOS PRESUPUESTOS DE LOS PROYECTOS
        ***/
        
  
  INSERT INTO  PROYECTOS 
  (ID_PROYECTO,NOMBRE,DEPARTAMENTO,FECHA_INICIO,FECHA_PREV_FIN, PRESUPUESTO)
  VALUES
  (
    NULL,
    'SOSTENIBILIDAD',
    (
      SELECT  NUMERO
        FROM DEPARTAMENTOS
        WHERE NOMBRE='ADMINISTRACION'
    ),
    CURRENT_DATE(),
    '2023-06-30',
   @DATO
  );
    /** VAMOS A REGISTRAR EN EL TRABAJO DE ESTE PROYECTO A LOS SUPERVISORES CON LOS VALORES POR DEFECTO
    PARA LAS COLUMNAS NUM_HORAS Y PRECIO_HORA*/
    
  INSERT INTO EMPLEADOS_PROYECTOS 
    (EMPLEADO, PROYECTO, FECHA_INICIO)
       
    SELECT    DISTINCT SUPERVISOR,
              (
                SELECT ID_PROYECTO
                   FROM PROYECTOS
                   WHERE NOMBRE='SOSTENIBILIDAD'
              ),
              CURRENT_DATE()
       FROM EMPLEADOS 
       WHERE SUPERVISOR IS NOT NULL;
    
  /** VAMOS A INSERTAR AHORA A TRABAJAR EN ESTE NUEVO PROYECTO A LOS DIRECTORES
      CON LOS VALORES POR DEFECTO PARA LAS COLUMNAS NUM_HORAS Y PRECIO_HORA**/
  
  
  INSERT INTO EMPLEADOS_PROYECTOS 
    (EMPLEADO, PROYECTO, FECHA_INICIO)
       
     SELECT   DIRECTOR,
              (
                SELECT ID_PROYECTO
                   FROM PROYECTOS
                   WHERE NOMBRE='SOSTENIBILIDAD'
              ),
              CURRENT_DATE()
       FROM  DEPARTAMENTOS;
  
  /**  ATENCIÓN !! SI UN SUPERVISOR PUEDE SER DIRECTOR O VICEVERSA,
      ENTONCES ESTA SOLUCIÓN DARÍA ERROR PORQUE
      INTENTARÍA INSERTAR LA MISMA TUPLA DOS VECES
    */
  COMMIT;
  
  
  
  /*** COMO SERÍA LA CONSULTA PARA  OBTENER LA LISTA DE DIRECTORES QUE NO SEAN SUPERVISORES**/
     SELECT  DIRECTOR
        FROM DEPARTAMENTOS
        WHERE DIRECTOR NOT IN (
                                   SELECT  DISTINCT SUPERVISOR
                                    FROM EMPLEADOS
                                    WHERE SUPERVISOR IS NOT NULL
        
                               );
  
  /** ENTONCES LA SENTENCIA A EJECUTAR EN SEGUNDO LUGAR, DESPUÉS DE HABER 
  INSERTADO A LOS SUPERVISORES  SERÍA ESTA**/
  
  INSERT INTO EMPLEADOS_PROYECTOS 
    (EMPLEADO, PROYECTO, FECHA_INICIO)
       
     SELECT   DIRECTOR,
              (
                SELECT ID_PROYECTO
                   FROM PROYECTOS
                   WHERE NOMBRE='SOSTENIBILIDAD'
              ),
              CURRENT_DATE()
       FROM DEPARTAMENTOS 
         WHERE DIRECTOR NOT IN (
                                   SELECT  DISTINCT SUPERVISOR
                                    FROM EMPLEADOS
                                    WHERE SUPERVISOR IS NOT NULL
                                );    
       
  