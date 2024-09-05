/******* 1º EJERCICIO *********************************************
  NECESITAMOS INCORPORAR A LA BASE DE DATOS
    LO SIGUIENTE:

     A CADA PROYECTO LE ASIGNAMOS
     UN ENPLEADO QUE ES SU TUTOR DE PROYECTO,
	 ESTO ES OBLIGATORIO PARA TODOS LOS PROYECTOS,DE MODO QUE,
	 UN PROYECTO NO PODRÁ ESTAR REGISTRADO
	 SIN SU CORRESPONDIENTE TUTOR.
     EL TUTOR PUEDE SER CUALQUIER EMPLEADO, 
	 SE REGISTRA TAMBIÉN LA FECHA DE ASIGNACIÓN DE LA TUTORÍA.
     UN EMPLEADO  PUEDE SER EN CADA INSTANTE TUTOR DE VARIOS  PROYECTOS**/

/* REALIZAR OPERACIONES NECESARIAS PARA PODER REFLEJAR ESTA  NUEVA 
     INFORMACIÓN EN LA BASE DE DATOS ***/

/* ASIGNAR  A CADA PROYECTO EXISTENTE EN ESTE MOMENTO 
     COMO TUTOR AL JEFE DE DEPARTAMENTO QUE CREA 
	 O LANZA EL PROYECTO DESDE FECHA ACTUAL**/

/******   2º EJERCICIO  *************************************************************/

/** CREAR UNA VISTA  LLAMADA VISTA_PROYECTOS
        QUE CONTENGA  PARA CADA PROYECTO:

             SU CLAVE, NOMBRE DE PROYECTO,
             NOMBRE DE SU TUTOR DE PROYECTO,
             CANTIDAD DE EMPLEADOS TRABAJANDO EN ÉL,
              FECHA DE PRIMERA ASIGNACIÓN DE TRABAJO A ALGÚN EMPLEADO,
             CLAVE Y NOMBRE DEL DEPARTAMENTO QUE LO CREA
			 CANTIDAD DE EMPLEADOS DEL DEPARTAMENTO
   			   QUE CREA EL PROYECTO QUE TRABAJAN EN ÉL 
			  
**/


/**********  3º    ******************************************/

/*DESEAMOS OBTENER UNA TABLA CON LA SIGUIENTE INFORMACIÓN
  PARA CADA FAMILIAR,  SU NIF, SU NOMBRE, FECHA DE NACIMIENTO, NIF Y NOMBRE DEL EMPLEADO
  QUE LO HA REGISTRADO Y PARENTESCO CON EL EMPLEADO,
  LOS REGISTROS DE ESTE FICHERO NOS INTERESAN ORDENADOS POR CLAVE DE
  DEPARTAMENTO AL QUE PERTENECE EL EMPLEADO Y POR NIF DE EMPLEADO******/

/*** A CONTINUACIÓN AGILIZAR LAS FUTURAS CONSULTAS A ESTE FICHERO,
     CREAR UN ÍNDICE SOBRE COLUMNA NIF_FAMILIAR, OTRO SOBRE COLUMNA NIF_EMPLEADO
     Y UN ÍNDICE EN NOMBRE FAMILIAR Y NOMBRE EMPLEADO PERO NO COMPLETOS CON 10 PRIMEROS
     CARACTERES**/

/******     4º INVESTIGAR ÍNDICES EXISTENTES PARA LA TABLA EMPLEADOS 

    CUÁL ES LA ORDEN QUE DEBES UTILIZAR ?
    ANALIZA  DETALLADAMENTE EL INFORME OBTENIDO DESDE LA EJECUCIÓN DE LA SENTENCIA


            OBSERVA QUE NO DISPONEMOS DE NINGÚN ÍNDICE COMPUESTO, MySQL NOS PERMITE CREAR
            ÍNDICES COMPUESTOS DE HASTA 16 COLUMNAS, EL DATO ALMACENADO EN EL ÍNDICE 
            ES LA CONCATENACIÓN DE LOS VALORES DE LAS COLUMNAS INDEXADAS,
            PARA OBTENER BENEFICIOS DE LA EXISTENCIA DEK ÍNDICE RECORDAD QUE EN EXPRESIONES 
            EN LAS QUERYS MANTENED EL ORDEN DE INDEXACIÓN DEFINIDO AL CREAR EL ÍNDICE DE IZQUIERDA A DERECHA, 
            SINO EL GESTOR NO EMPLEADRÁ EL ÍNDICE
            VAMOS A CREAR UNO  PARA VER SU INFORME;
            CREAR UN ÍNDICE CON COLUMNAS  NOMBRE DE EMPLEADO, FECHA DE NACIMIENTO Y SEXO
            Y LUEGO EJECUTAR DE NUEVO LA SENTENCIA QUE NOS INFORMA DE LA EXISTENCIA DE LOS ÍNDICES


 
 
 
 
 
 
/***  SOLUCIÓN    1º   EJERCICIO   --- EN UN SCRIPT DEFINIMOS ESTAS OPERACIONES *******/
     
  /** ANALIZAMOS, SE TRATA DE INCORPORAR AL MODELO UNA NUEVA RELACIÓN
     PROYECTO TIENE UN EMPLEADO QUE ES SU TUTOR DE PROYECTODESDE UNA FECHA.
     ANALIZAMOS LA PARTICIPACIÓN DE PROYECTO EN LA RELACIÓN (1,1)
              Y LA PARTICIPACIÓN DE EMPLEADO EN LA RELACIÓN (0,N)
              **********/

      ALTER TABLE PROYECTOS       
           ADD COLUMN  TUTOR INT  UNSIGNED  NOT NULL,
           ADD COLUMN FECHA_TUTOR DATE NOT NULL,    
           ADD INDEX FK_TUTOR_PROYECTO (TUTOR); 
           
           
  /** NO PUEDO CONTAR, POR AHORA, ,  NO PUEDO DEFINIR  AÚN , LA COLUMNA TUTOR_PROYECTO,
         COMO UNA FOREIGN KEY QUE APUNTA A EMPLEADOS,
         PORQUE LOS DATOS QUE AHORA  TENGO EN LA TABLA  NO SON ÍNTEGROS
         TENGO  TUTOR_PROYECTO = CERO EN CADA PROYECTO EXISTENTE
         Y VALOR CERO NO EXISTE EN ID_EMPLEADO
      **/         


     UPDATE  PROYECTOS AS P

       SET P.TUTOR=(
                                      SELECT DIRECTOR
                                       FROM DEPARTAMENTOS 
                                       WHERE NUMERO=P.DEPARTAMENTO
                                  ),  /*DATO EN UPDATE CON SUBCONSULTA CORRELACIONADA*/
           P.FECHA_TUTOR= CURRENT_DATE();
           
           
   /** TAMBIÉN ESTE UPDATE SE PUEDE OBTENER ASÍ  **/
   
   UPDATE PROYECTOS AS P INNER JOIN DEPARTAMENTOS AS D
                           ON P.DEPARTAMENTO=D.NUMERO
     SET P.TUTOR=D.DIRECTOR,
         P.FECHA_TUTOR=CURRENT_DATE();

/**  POR FIN , TERMINO DE DEFINIR BIEN  LA COLUMNA  TUTOR, LE IMPONGO LA RESTRICCIÓN QUE FALTA
    POR DEFINIR **/ 
     ALTER TABLE PROYECTOS
         ADD FOREIGN KEY (TUTOR) REFERENCES EMPLEADOS(ID_EMPLEADO)
                  ON DELETE RESTRICT
                  ON UPDATE CASCADE;



  COMMIT;

/******* 2º    EJERCICIO ****/

CREATE VIEW VISTA_PROYECTOS

          AS  
      SELECT   
             P.ID_PROYECTO AS CLAVE_PROYECTO,
             P.NOMBRE AS NOMBRE_PROYECTO,
             (SELECT NOMBRE
               FROM EMPLEADOS
               WHERE ID_EMPLEADO=P.TUTOR
             )     AS NOMBRE_TUTOR, /*POR CADA PROYECTO EJECUTAS UNA VEZ ESTA SUBCONSULTA*/
              COUNT( DISTINCT EP.EMPLEADO)  AS CANTIDAD_EMPLEADOS_TRABAJAN,
              MIN(EP.FECHA_INICIO) AS PRIMERA_FECHA_INICIO_TRABAJO, 
              P.DEPARTAMENTO AS CLAVE_DEPARTAMENTO_CREA,
             (
               SELECT  NOMBRE
                 FROM DEPARTAMENTOS
                 WHERE NUMERO=P.DEPARTAMENTO 
             ) AS NOMBRE_DEPARTAMENTO_CREA,/*POR CADA PROYECTO EJECUTAS UNA VEZ ESTA SUBCONSULTA*/
             COUNT(DISTINCT EP2.EMPLEADO) AS  CANTIDAD_EMPLEADOS_DEl_DEP_TRABAJAN
             

       FROM PROYECTOS AS P  LEFT JOIN   EMPLEADOS_PROYECTOS AS EP
                             ON P.ID_PROYECTO=EP.PROYECTO  /* PROYECTO PARTICIPA (0,N)*/
                               LEFT JOIN EMPLEADOS_PROYECTOS AS EP2
                                     ON P.ID_PROYECTO=EP2.PROYECTO  /* PROYECTO PARTICIPA (0,N)*/
                                          AND
                                          EP2.EMPLEADO IN (SELECT ID_EMPLEADO
                                                             FROM EMPLEADOS
                                                             WHERE DEPARTAMENTO=P.DEPARTAMENTO
                                                           )
   GROUP BY P.ID_PROYECTO;
		
		
	


/** OTRA FORMA ,  PARA LA CONSULTA */


SELECT  
            P.ID_PROYECTO  AS CLAVE_PROYECTO,
            P.NOMBRE AS NOMBRE_PROYECTO,
            ET.NOMBRE AS NOMBRE_TUTOR,
            COUNT(DISTINCT EP.EMPLEADO)  AS CANTIDAD_EMPLEADOS_TRABAJAN,
             MIN(EP.FECHA_INICIO) AS PRIMERA_FECHA_INICIO_TRABAJO, 
            P.DEPARTAMENTO AS CLAVE_DEPARTAMENTO_CREA,
            D.NOMBRE AS NOMBRE_DEPARTAMENTO_CREA,
            COUNT(DISTINCT EP2.EMPLEADO) AS  CANTIDAD_EMPLEADOS_DEl_DEP_TRABAJAN 
    FROM PROYECTOS  AS P INNER JOIN EMPLEADOS AS ET
                                   ON P.TUTOR=ET.ID_EMPLEADO
                                         LEFT JOIN   EMPLEADOS_PROYECTOS AS EP
                                             ON P.ID_PROYECTO=EP.PROYECTO  /** PRIMERA RELACIÓN A MUCHOS**/
                                                   INNER JOIN  DEPARTAMENTOS AS D
                                                        ON P.DEPARTAMENTO=D.NUMERO
                                                           LEFT JOIN EMPLEADOS_PROYECTOS AS EP2
                                                               ON P.ID_PROYECTO=EP2.PROYECTO   /* SEGUNDA RELACIÓN A MUCHOS*/    
                                                                  AND
                                                                  EP2.EMPLEADO IN (SELECT ID_EMPLEADO   
                                                                                    FROM EMPLEADOS
                                                                                    WHERE DEPARTAMENTO=P.DEPARTAMENTO
                                                                                    )   
                                           
     GROUP BY P.ID_PROYECTO; 
     
     
    /*** OTRA FORMA MÁS PARA LA CONSULTA**/ 
	 SELECT   
             P.ID_PROYECTO AS CLAVE_PROYECTO,
             P.NOMBRE AS NOMBRE_PROYECTO,
             (SELECT NOMBRE
               FROM EMPLEADOS
               WHERE ID_EMPLEADO=P.TUTOR
             )     AS NOMBRE_TUTOR,
              COUNT( DISTINCT EP.EMPLEADO)  AS CANTIDAD_EMPLEADOS_TRABAJAN,
              MIN(EP.FECHA_INICIO) AS PRIMERA_FECHA_INICIO_TRABAJO, 
              P.DEPARTAMENTO AS CLAVE_DEPARTAMENTO_CREA,
              D.NOMBRE AS NOMBRE_DEPARTAMENTO,             
             COUNT(DISTINCT EP2.EMPLEADO) AS  CANTIDAD_EMPLEADOS_DEL_DEP_TRABAJAN
             

       FROM PROYECTOS AS P  LEFT JOIN   EMPLEADOS_PROYECTOS AS EP
                             ON P.ID_PROYECTO=EP.PROYECTO
                                INNER JOIN DEPARTAMENTOS AS D
                                    ON P.DEPARTAMENTO=D.NUMERO
                                  LEFT JOIN EMPLEADOS_PROYECTOS AS EP2
                                       ON P.ID_PROYECTO=EP2.PROYECTO
                                          AND
                                          EP2.EMPLEADO IN (SELECT ID_EMPLEADO
                                                             FROM EMPLEADOS
                                                             WHERE DEPARTAMENTO=P.DEPARTAMENTO
                                                           )
   GROUP BY P.ID_PROYECTO;
   
   
   /** OTRA FORMA MÁS EN LA CONSULTA*/
   
   SELECT   
             P.ID_PROYECTO AS CLAVE_PROYECTO,
             P.NOMBRE AS NOMBRE_PROYECTO,
             (SELECT NOMBRE
               FROM EMPLEADOS
               WHERE ID_EMPLEADO=P.TUTOR
             )     AS NOMBRE_TUTOR,
              COUNT( EP.EMPLEADO)  AS CANTIDAD_EMPLEADOS_TRABAJAN,
              MIN(EP.FECHA_INICIO) AS PRIMERA_FECHA_INICIO_TRABAJO, 
              P.DEPARTAMENTO AS CLAVE_DEPARTAMENTO_CREA,
              D.NOMBRE AS NOMBRE_DEPARTAMENTO,             
             (
                SELECT COUNT(*)
                   FROM EMPLEADOS AS E
                   WHERE E.DEPARTAMENTO=P.DEPARTAMENTO
                          AND
                         E.ID_EMPLEADO IN (
                                           SELECT  EMPLEADO
                                             FROM EMPLEADOS_PROYECTOS
                                             WHERE PROYECTO=P.ID_PROYECTO
                                            
                                        )
             
             
             ) AS CANTIDAD_EMPLEADOS_DEL_DEP_TRABAJAN
             

       FROM PROYECTOS AS P  LEFT JOIN   EMPLEADOS_PROYECTOS AS EP
                             ON P.ID_PROYECTO=EP.PROYECTO /* (0,N)*/
                                INNER JOIN DEPARTAMENTOS AS D
                                    ON P.DEPARTAMENTO=D.NUMERO
                                  
   GROUP BY P.ID_PROYECTO;
   
		
		
	

		
	/*REFLEXIONA DIFERENCIA  ENTRE  CONSULTA Y VISTA
                 DIFERENCIA ENTRE VISTA Y TABLA***********/




/********  3º   EJERCICIO   ************************************/

CREATE TABLE DATOS_FAMILIARES
    AS 
SELECT  
        F.NIF AS NIF_FAMILIAR,
        F.NOMBRE AS FAMILIAR,
        F.FECHA_NAC AS FECHA_NAC,
        E.NIF AS NIF_EMPLEADO,
        E.NOMBRE AS EMPLEADO,
        F.PARENTESCO AS PARENTESCO 
    FROM FAMILIARES AS F INNER JOIN EMPLEADOS AS E
                                  ON    F.EMPLEADO=E.ID_EMPLEADO
    ORDER BY E.DEPARTAMENTO, E.NIF ;


ALTER TABLE DATOS_FAMILIARES
    ADD UNIQUE INDEX I_NIF_FAM(NIF_FAMILIAR),
    ADD INDEX I_NIF_EMPL (NIF_EMPLEADO),
    ADD INDEX I_NOMBRES_F_E (FAMILIAR (10), EMPLEADO(10)); 

/*** HEMOS CREADO UNA TABLA CON LOS DATOS RESULTANTES DE LA EJECUCIÓN DE UNA CONSULTA,
     ESTA TABLA ES UN VOLCADO DE DATOS, ES UN FICHERO DE DATOS  AL QUE ACCEDEMOS COMO OBJETO TABLA
     ESTA TABLA NO TIENE DEFINICIONES DE RESTIRCCIÓN (OBLIGATORIEDAD, UNICIDAD, INTEGRIDAD REFERENCIAL)
     NO RESPONDE A ENTIDAD/RELACIÓN DEL MODELO ENTIDAD-RELACIÓN**/
/******** TAMBIÉN DE ESTA FORMA PODEMOS DEFINIR LOS ÍNDICES *************


  CREATE UNIQUE INDEX I_NIF_FAM ON FAMILIARES(NIF_FAMILIAR);
  CREATE INDEX I_NIF_EMPL ON FAMILIARES(NIF_EMPLEADO);
  CREATE INDEX I_NOMBRES_F_E ON FAMILIARES (FAMILIAR (10), EMPLEADO(10));

************************/


/**********   4º   ******/


SHOW INDEX FROM EMPLEADOS IN EMPRESA; 
/** O TAMBIÉN ESTAS SINTAXIS **/

SHOW INDEXES FROM EMPLEADOS;
SHOW KEYS FROM EMPLEADOS;
/** REFLEXIONA: QUÉ ES LA CARDINALIDAD DE UN ÍNDICE**/

/*** ANALIZA EL SIGNIFICADO DEL INFORME MOSTRADO  POR LA SENTENCIA******/

/*** EN EL MOTOR INNODB,
 LA ESTRUCTURA INTERNA O TIPO DE ÍNDICE ES SIEMPRE BTREE, 
 NO ADMITE EMPAQUETAMIENTO DE LOS ÍNDICES**/
 
/*****
            MySQL NOS PERMITE CREAR
            ÍNDICES COMPUESTOS DE HASTA 16 COLUMNAS, EL DATO ALMACENADO EN EL ÍNDICE
            ES LA CONCATENACIÓN DE LOS VALORES DE LAS COLUMNAS INDEXADAS,
            PARA OBTENER BENEFICIOS DE LA EXISTENCIA DEL ÍNDICE RECORDAD QUE EN  LAS EXPRESIONES 
            EN LAS QUERYS MANTENED EL ORDEN DE INDEXACIÓN  DEFINIDO AL CREAR EL ÍNDICE DE IZQUIERDA A DERECHA, 
            SINO EL GESTOR NO EMPLEARÁ  EL ÍNDICE EN LA OPERACIÓN.
     *************************************************************/
     
     /***
            VAMOS A CREAR UNO EN FAMILIARES  PARA VER SU INFORME;
            CREAR UN ÍNDICE CON COLUMNAS  NOMBRE DE EMPLEADO, FECHA DE NACIMIENTO Y SEXO
            Y LUEGO EJECUTAR DE NUEVO LA SENTENCIA QUE NOS INFORMA DE LA EXISTENCIA DE LOS ÍNDICES
   ********************************************/         
 
 CREATE INDEX I_DATOS ON FAMILIARES (NOMBRE (20),FECHA_NAC,SEXO);
 
 
 SHOW INDEX FROM FAMILIARES;
 