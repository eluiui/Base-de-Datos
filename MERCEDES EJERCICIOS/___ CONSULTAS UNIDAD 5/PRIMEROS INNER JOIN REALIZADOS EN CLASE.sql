/** obtener para cada empleado,
    su nombre y salario y nombre de su departamento**/
    
    
    SELECT  E.NOMBRE, E.SALARIO
       FROM EMPLEADOS AS E; 
       
       /** E SE LLAMA ALIAS O NOMBRE CORTO DE UNA TABLA*/
       
   SELECT  *
      FROM EMPLEADOS AS E INNER JOIN DEPARTAMENTOS AS D
                            ON E.DEPARTAMENTO=D.NUMERO;
                                 /* participación de E (1,1)*/
                                 
     SELECT  E.NOMBRE AS EMPLEADO,
             E.SALARIO AS SUELDO,
             D.NOMBRE AS SU_DEPARTAMENTO
     
        FROM EMPLEADOS AS E INNER JOIN DEPARTAMENTOS AS D
                            ON E.DEPARTAMENTO=D.NUMERO;
                                 /* participación de E (1,1)*/    
                                 
                                 
/* PARA CADA EMPLEADO supervisado:
   OBTENER SU NOMBRE, SU SALARIO
   Y EL NOMBRE Y SALARIO
    DE SU SUPERVISOR*/
 /* A CADA EMPLEADO LE "PEGO O COMBINO" LA TUPLA DE SU SUPERVISOR*/  
 SELECT *
    FROM  EMPLEADOS AS E INNER JOIN EMPLEADOS AS ES
                          ON E.SUPERVISOR=ES.ID_EMPLEADO ; 
                                  /*participación de E (0,1)*/
   
  SELECT  E.NOMBRE AS EMPLEADO,
          E.SALARIO AS SALARIO_SUPERVISADO,
          ES.NOMBRE AS SU_SUPERVISOR,
          ES.SALARIO AS SALARIO_SUPERVISOR,
          ES.SALARIO- E.SALARIO AS DIFERENCIA_SALARIOS
    FROM  EMPLEADOS AS E INNER JOIN EMPLEADOS AS ES
                          ON E.SUPERVISOR=ES.ID_EMPLEADO ; 
                                  /*participación de E (0,1)*/ 
         
         
/*** OBTENER PARA CADA PROYECTO
     SU CLAVE, SU NOMBRE,  SU PRESUPUESTO,
     EL NOMBRE DEL DEPARTAMENTO QUE LO LANZA
     Y LA CLAVE DEL DIRECTOR DE ESE DEPARTAMENTO**/
     
    SELECT P.NOMBRE AS PROYECTO,
           P.PRESUPUESTO AS PRESUPUESTO,
           D.NOMBRE AS DEPARTAMNETO_LANZA,
           D.DIRECTOR AS CLAVE_DIRECTOR
       FROM PROYECTOS AS P INNER JOIN DEPARTAMENTOS AS D
                            ON P.DEPARTAMENTO=D.NUMERO ; 
                                    /* participación de P(1,1)
                                       fk=pk */
     
   /** PARA CADA EMPLEADO OBTENER:
      SU NOMBRE, SALARIO, FECHA DE NACIMIENTO,
      EL NOMBRE DE SU DEPARTAMENTO,
      EL NOMBRE Y SALARIO DE SU DIRECTOR
      ***/
      
  /* VAMOS A COMBINAR TRES TABLAS
      EMPLEADOS, DEPARTAMENTOS Y EMPLEADOS
      **/
      
      SELECT  E.NOMBRE AS EMPLEADO,
              E.SALARIO AS SALARIO_EMPLEADO,
              E.FECHA_NAC AS FECH_NAC_EMPLEADO,
              D.NOMBRE AS SU_DEPARTAMENTO,
              ED.NOMBRE AS SU_DIRECTOR,
              ED.SALARIO AS SALARIO_SU_DIRECTOR,
              ED.FECHA_NAC AS FECH_NAC_SU_DIRECTOR
         FROM EMPLEADOS AS E INNER JOIN DEPARTAMENTOS AS D
                              ON E.DEPARTAMENTO=D.NUMERO /*participación de E(1,1)*/
                                INNER JOIN  EMPLEADOS AS ED
                                  ON D.DIRECTOR=ED.ID_EMPLEADO; /*(1,1)*/
      
      
    /* OBTENER PARA CADA PROYECTO, que tenga iniciado su trabajo,
        SU CLAVE, SU NOMBRE Y PRESUPUESTO
        LA CANTIDAD DE EMPLEADOS TRABAJANDO EN EL PROYECTO
        Y TOTAL HORAS DE TRABAJO EN EL PROYECTO
        
      **/
      
  /** A CADA PROYECTO "LE PEGO LO COMBINO" CON LAS TUPLAS DE EMPLEADOS_PROYECTOS
      DONDE ESTÁ REFERENCIADO
      LE PEGO LOS REGISTROS DE SU TRABAJO
      **/
      
      
      SELECT *
        FROM PROYECTOS AS P INNER JOIN EMPLEADOS_PROYECTOS AS EP
                              ON P.ID_PROYECTO=EP.PROYECTO 
                                     /*proyecto participa (0,n)*/
        GROUP BY P.ID_PROYECTO; /*EP.PROYECTO*/
        
        
         SELECT  P.ID_PROYECTO AS CLAVE_PROYECTO,
                 P.NOMBRE AS PROYECTO,
                 P.PRESUPUESTO AS PRESUPUESTO_PROYECTO,
                 COUNT(*) AS CANTIDAD_EMPLEADOS_TRABAJANDO,
                 SUM(NUM_HORAS) AS TOTAL_HORAS_TRABAJO
                 
         
        FROM PROYECTOS AS P INNER JOIN EMPLEADOS_PROYECTOS AS EP
                              ON P.ID_PROYECTO=EP.PROYECTO 
                                     /*proyecto participa (0,n)*/
        GROUP BY P.ID_PROYECTO; /*EP.PROYECTO*/
        