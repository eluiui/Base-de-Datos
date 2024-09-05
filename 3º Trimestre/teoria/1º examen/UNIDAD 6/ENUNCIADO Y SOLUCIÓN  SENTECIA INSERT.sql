   
/********************************************************
    SENTENCIA    INSERT INTO    
           TIENE DOS FORMATOS
                 INSERT INTO ----   CLAUSULA VALUES
                 INSER INTO ------  sentencia SELECT
*****************************************************************/


/** VAMOS A SUPONER AHORA ESTAS OPERACIONES:
    ENUNCIADO : SE CREA UN NUEVO PROYECTO QUE LANZA EL DEPARTAMENTO DE VENTAS,
    NOMBRE DEL PROYECTO ES NUEVO PROYECTO A, EL PRESUPUESTO ES DE 1200000,
    FINALIZACIÓN FINAL DE AÑO
    
    Y EN EL MISMO INSTANTE  ---> DOS OPERACIONES EN UNA TRASACCIÓN
    SE PONE A TRABAJAR EN ESTE NUEVO PROYECTO
    A TODOS LOS EMPLEADOS DE VENTAS , 80 HORAS SEMANALES
    
    Y LOS DOS DIRECTORES: DIRECTOR DE ADMINSTRACIÓN Y MARKETING, 50 HORAS SEMANALES
    UN PRECIO_HORA EL 3% DE SU SALARIO
    **/
	
   START TRANSACTION;
   
   INSERT INTO PROYECTOS
   (NOMBRE, DEPARTAMENTO, FECHA_INICIO,FECHA_PREV_FIN, PRESUPUESTO)
   VALUES
   (
    ' NUEVO PROYECTO A',
    (
     SELECT NUMERO
       FROM DEPARTAMENTOS
       WHERE NOMBRE='VENTAS'
     ), /* TIENE RETORNA UN DATO O VALOR*/
   
      CURRENT_DATE(),
      '2023-12-31',
      1200000   
   
   );
   
   INSERT INTO EMPLEADOS_PROYECTOS
   (EMPLEADO,PROYECTO,FECHA_INICIO, NUM_HORAS)
	SELECT ID_EMPLEADO,
           (
             SELECT ID_PROYECTO
             FROM PROYECTOS
             WHERE NOMBRE=' NUEVO PROYECTO A'
           ),
           CURRENT_DATE(),
           80
      FROM EMPLEADOS
      WHERE DEPARTAMENTO=(
                           SELECT NUMERO
                              FROM DEPARTAMENTOS
                              WHERE NOMBRE='VENTAS'
                          );
    
  /*LA COLUMNA PRECIO_HORA ES OBLIGATORIA CON VALOR POR DEFECTO
    NO LA INDICO EN INSERT SE PONDRÁ PARA CADA TUPLA EL VALOR POR DEFECTO
    DEFINIDO*/
	
    INSERT INTO EMPLEADOS_PROYECTOS
    (EMPLEADO, PROYECTO, FECHA_INICIO, NUM_HORAS, PRECIO_HORA)
    VALUES
    ( (SELECT  DIRECTOR
         FROM DEPARTAMENTOS
         WHERE NOMBRE='ADMINISTRACIÓN'
         ),
          (
             SELECT ID_PROYECTO
             FROM PROYECTOS
             WHERE NOMBRE=' NUEVO PROYECTO A'
           ), 
           CURRENT_DATE(),
           50,
          (
            SELECT  0.03*SALARIO
              FROM EMPLEADOS
              WHERE ID_EMPLEADO=(SELECT  DIRECTOR
                                    FROM DEPARTAMENTOS
                                     WHERE NOMBRE='ADMINISTRACIÓN'
                                 )
          
          )
    ),
    /*** SEGUNDA TUPLA A INSERTAR*/
    (  (SELECT  DIRECTOR
         FROM DEPARTAMENTOS
         WHERE NOMBRE='MARKETING'
         ),
         (
             SELECT ID_PROYECTO
             FROM PROYECTOS
             WHERE NOMBRE=' NUEVO PROYECTO A'
           ), 
         CURRENT_DATE(),
         50, 
         (
            SELECT  0.03*SALARIO
              FROM EMPLEADOS
              WHERE ID_EMPLEADO=(SELECT  DIRECTOR
                                    FROM DEPARTAMENTOS
                                     WHERE NOMBRE='MARKETING'
                                 )
          
          )
          
         );
         
         
           COMMIT;