/* SENTECIA  UPDATE
   UPDATE    TABLA
        SET COL1= VALOR/EXPRESIÓN/SUBCONSULTA(UN VALOR), 
            COL2=VALOR/EXPRESIÓN/SUBCONSULTA(UN VALOR),....
        [WHERE EXPRESIÓN DE SELECCIÓN DE TUPLAS]
        
        
******/
        
        
        /*   1. ENUNCIADO SUBIR  EL SALARIO 
                UN 3% A TODOS LOS EMPLEADOS*/
                
        UPDATE   EMPLEADOS 
            SET SALARIO=SALARIO*1.03;
        
       
    /** 20 row(s) affected Rows matched: 20  Changed: 20  Warnings: 0**/
 
   
   
   /* 2. ENUNCIADO SUBIR 
         SALARIO UN 3% A TODOS LOS EMPLEADOS DEL DEPARTAMENTO DE VENTAS
         AQUÍ POR DEBAJO TENEMOS QUE TENER EN CUENTA
		 QUE NOMBRE DE DEPARTAMENTO ES  UNA AK  EN  LA TABLA DEPARTAMENTOS (OBLIGATORIO Y ÚNICO PARA CADADEPARTAMENTO)
    ***/
  UPDATE empleados  as e
    set  salario=salario*1.03
  where e.departamento = (
                            select   numero
                               from departamentos
                               where nombre='ventas'
                         );    
  /**7 row(s) affected Rows matched: 7  Changed: 7  Warnings: 0*/

  
  /* ESTA ORDEN TAMBIÉN PODEMOS CODIFICARLA
     CON OTRA SINTAXIS, SINTAXIS MULTITABLA(PRODUCTO CARTESIANO DE DOS TABLAS)
	 O SINTAXIS  DE COMBINACIÓN INNER DE TABLAS*/
     
     UPDATE EMPLEADOS AS E INNER JOIN DEPARTAMENTOS AS D
                            ON E.DEPARTAMENTO=D.NUMERO
                               AND
                               D.NOMBRE='VENTAS'
       set salario=salario*1.03;
       
     /*7 row(s) affected Rows matched: 7  Changed: 7  Warnings: 0*/

     
     	
    UPDATE EMPLEADOS AS E INNER JOIN DEPARTAMENTOS AS D
                            ON E.DEPARTAMENTO=D.NUMERO
                                
    SET SALARIO=SALARIO*1.03
    WHERE D.NOMBRE='VENTAS';                           
    
	/*6 row(s) affected Rows matched: 6  Changed: 6  Warnings: 0*/

SELECT SALARIO
    FROM empleados
    WHERE DEPARTAMENTO=(
                            select   numero
                               from departamentos
                               where nombre='ventas'
                         );

/* MISMA ORDEN OTRA SINTAXIS, CON INNER JOIN  **/

/** SUBIR A LOS EMPLEADOS DE VENTAS SU SUELDO UN 3%, Y LA PRIMA_SUELDO DEL DIRECTOR DE VENTAS
   UN 3%**/
UPDATE EMPLEADOS AS E INNER JOIN DEPARTAMENTOS AS D
                            ON E.DEPARTAMENTO=D.NUMERO
                               AND
                               D.NOMBRE='VENTAS'
       set E.salario=E.salario*1.03, D.PRIMA_SUELDO=D.PRIMA_SUELDO*1.03 ;
       
       
/* OTRA FORMA PARA ESTA ORDEN EMPLEAR DOS SENTENCIAS UPDATE
  la primera para la tabla empleados,
  la segunda para modificar una tupla en tabla departamentos**/

UPDATE empleados  as e
    set  salario=salario*1.03
  where e.departamento = (
                            select   numero
                               from departamentos
                               where nombre='ventas'
                         );  
  
  
  /* uso una variable de sesión,  es un espacio de memoria interna
     al que le pongo nombre,(@dato), no declaro el tipo, no la declaro, simplemente la uso,
     tendrá, en cada instante, el tipo de dato de la información que almacenes en ella,*/
  
  select  numero into @dato
      from departamentos
      where  nombre='ventas';
       
  update departamentos
     set prima_sueldo=prima_sueldo*1.03
     where numero= @dato;
     
 /*  OTRO ENUNCIADO 
      subir a los empleados de adminsitración su salario, 
      poner de subida el 2% de el salario medio de la empresa**/
      
      SELECT  AVG(SALARIO) INTO @DATO
        FROM EMPLEADOS;
        
        
      UPDATE EMPLEADOS 
         SET SALARIO= SALARIO + 0.02*@DATO
         WHERE DEPARTAMENTO= (
                             SELECT NUMERO
                                FROM DEPARTAMENTOS
                                WHERE NOMBRE='ADMINISTRACION'
      
                           );
      
      
     
      
      
        
      
  
  
  
  
  /*3. ENUNCIADO  
         SUBIR EL SALARIO  UN 2% A TODOS LOS DIRECTORES  DE DEAPARTAMENTO
        Y MODIFICAR SU PRIMA DE DIRECCIÓN SUBIÉNDOLA EN 1000 EUROS MÁS*/
        
        
		
/** EN ESTE CASO TENEMOS QUE MODIFICAR DOS DATOS
 QUE SE ENCUENTRAN EN DOS TABLAS DISTINTAS (EMPLEADOS Y DEPARTAMENTOS)	*/	
  
 UPDATE EMPLEADOS AS E
     SET E.SALARIO=E.SALARIO*1.02
     WHERE E.ID_EMPLEADO IN (
                             SELECT   DIRECTOR
                                FROM DEPARTAMENTOS
                            );
                            
   UPDATE EMPLEADOS AS E INNER JOIN  DEPARTAMENTOS AS D
                                  ON E.ID_EMPLEADO=D.DIRECTOR
       SET E.SALARIO=E.SALARIO*1.02;                           
                                  
/*5 row(s) affected Rows matched: 5  Changed: 5  Warnings: 0*/

  UPDATE DEPARTAMENTOS AS D
      SET PRIMA_SUELDO=PRIMA_SUELDO+1000;
/*5 row(s) affected Rows matched: 5  Changed: 5  Warnings: 0*/
      


 
 /** ESTAS DOS MISMAS  OPERACIONES LAS PODEMOS CODIFICAR Y EJECUTAR DE ESTA OTRA FORMA**/
 
 
 
 UPDATE EMPLEADOS AS E INNER JOIN DEPARTAMENTOS AS D
                         ON E.ID_EMPLEADO=D.DIRECTOR
     SET E.SALARIO=E.SALARIO*1.03, D.PRIMA_SUELDO=D.PRIMA_SUELDO+1000;   
     
                    
 
	 
	 
 



  
/*  4 ENUNCIADO
       A TODOS LOS PROYECTOS LANZADOS 
       POR EL DEPARTAMENTO DE VENTAS,
       MODIFICAR LA CANTIDAD DE HORAS QUE TRABAJA 
       CADA EMPLEADO EN CADA PROYECTO
       AUMENTANDO LA DEDICACIÓN EN UN 10% DE LAS HORAS
       Y SUBIR EL PRECIO DE LA HORA DE TRABAJO EN UN 3%
	             HACEDLA CON DOS SINTAXIS
     **/
  
/*PRIMERA SOLUCIÓN*/

UPDATE EMPLEADOS_PROYECTOS AS EP
   SET EP.NUM_HORAS=EP.NUM_HORAS*1.1,
       EP.PRECIO_HORA=EP.PRECIO_HORA*1.03
   WHERE PROYECTO IN (
                        SELECT ID_PROYECTO
                            FROM PROYECTOS
                            WHERE DEPARTAMENTO = 
                                               (
                                                  SELECT NUMERO
                                                    FROM DEPARTAMENTOS
                                                    WHERE NOMBRE='VENTAS'  
                                               
                                               )
   
                      );

/*14 row(s) affected Rows matched: 14  Changed: 14  Warnings: 0*/


/* SEGUNDA SOLUCIÓN   ESTA ORDEN PODEMOS DISEÑARLA TAMBIÉN ASÍ... 
3 TABLAS COMBINADAS CON INNER*/


UPDATE EMPLEADOS_PROYECTOS AS EP  INNER JOIN PROYECTOS AS P
                                    ON EP.PROYECTO=P.ID_PROYECTO
                                         INNER JOIN DEPARTAMENTOS AS D
                                             ON  P.DEPARTAMENTO=D.NUMERO
                                                 AND 
                                                 D.NOMBRE='VENTAS'
 SET   EP.NUM_HORAS=EP.NUM_HORAS*1.1,
       EP.PRECIO_HORA=EP.PRECIO_HORA*1.03;                                                
/*14 row(s) affected Rows matched: 14  Changed: 14  Warnings: 0*/

UPDATE PROYECTOS AS P INNER JOIN DEPARTAMENTOS AS D
                                ON P.DEPARTAMENTO=D.NUMERO
                                   AND
                                   D.NOMBRE='VENTAS'
                                     INNER JOIN EMPLEADOS_PROYECTOS AS EP
                                       ON P.ID_PROYECTO=EP.PROYECTO
                                       
     SET EP.NUM_HORAS=NUM_HORAS*1.1, 
         EP.PRECIO_HORA=PRECIO_HORA*1.03;
    /* CON ESTA FORMA, ORDEN DE COMBINACIÓN SELECCIONO ANTES*/     


/* SI EN EL ENUNCIADO NOS DICEN QUE TAMBIÉN  LOS PROYECTOS DE VENTAS 
   AUMENTA SU PRESPUESTO EN UN 3%, Y LA FECHA PREVISTA DE FINALIZACIÓN
   EN 30 DIAS MÁS */
   
   UPDATE EMPLEADOS_PROYECTOS AS EP  INNER JOIN PROYECTOS AS P
                                    ON EP.PROYECTO=P.ID_PROYECTO
                                         INNER JOIN DEPARTAMENTOS AS D
                                             ON  P.DEPARTAMENTO=D.NUMERO
                                                 AND 
                                                 D.NOMBRE='VENTAS'
 SET   EP.NUM_HORAS=EP.NUM_HORAS*1.1,
       EP.PRECIO_HORA=EP.PRECIO_HORA*1.03,
       P.PRESUPUESTO=P.PRESUPUESTO*1.03,
       P.FECHA_PREV_FIN=DATE_ADD(P.FECHA_PREV_FIN, INTERVAL 30 DAY);  
       
/*18 row(s) affected Rows matched: 18  Changed: 18  Warnings: 0*/
       
   /** 4 PROYECTOS DE VENTAS**/
   
   
  /* IMPORTANTE USO DE VISTAS ACTUALIZABLES ******/  
	
    /* VAMOS A CREAR UNA VISTA PARA EL USUARIO JEFE DE VENTAS, HABRÍA UNA VISTA PARA CADA JEFE..*/
    
    CREATE VIEW TRABAJO_PROYECTOS_VENTAS
    AS
      SELECT   *
         FROM EMPLEADOS_PROYECTOS 
         WHERE PROYECTO IN (
                              SELECT ID_PROYECTO
                                FROM PROYECTOS
                                WHERE DEPARTAMENTO=(
                                                       SELECT NUMERO
                                                         FROM DEPARTAMENTOS
                                                         WHERE NOMBRE='VENTAS'
                                                   )
         
                            );
                            
                            
SELECT * FROM TRABAJO_PROYECTOS_VENTAS; 
/*IMPORTANTE: ESE USUARIO QUE TIENE ACCESO A ESTA VISTA, PUEDE HACER ESTA OPERACIÓN**/

UPDATE TRABAJO_PROYECTOS_VENTAS
SET NUM_HORAS=NUM_HORAS*1.1, 
    PRECIO_HORA=PRECIO_HORA*1.03;				  
					  
 /**LA MISMA ORDEN DESDE LA VISTA 
   TRABAJO_PROYECTOS_VENTAS**/
   
   
   
	    
 
          
          
        /* 4. ENUNCIADO 
		     AL EMPLEADO DE CLAVE 7
             ASIGNARLE COMO SU SUPERVISOR EL EMPLEADO DE CLAVE 100
             **/
             
             
             
          UPDATE empleados 
             SET SUPERVISOR=100  /*DATO 100 NO ES INTEGRO*/
          WHERE ID_EMPLEADO=7;
             
     /*Error Code: 1452. 
     Cannot add or update a child row: 
     a foreign key constraint fails 
     (`empresa`.`empleados`, CONSTRAINT `empleados_ibfk_2`
     FOREIGN KEY (`SUPERVISOR`) REFERENCES `empleados` (`ID_EMPLEADO`) 
     ON DELETE SET NULL ON UPDATE CASCADE)
     ***/
        
             
             /** EL VALOR DE LA CLAVE DE EMPLEADO SUPERVISOR TIENE QUE SER ÍNTEGRO
                 LA COLUMNA SUPERVISOR TIENE IMPUESTA LA RESTRICCIÓN DE INTEGRIDAD REFERENCIAL
				 DIME, QUÉ SIGNIFICA LO QUE ESTOY INDICANDO??   
				   A EL VALOR DE 100 QUÉ LE PASA? QUE NO ES INTEGRO=NO EXISTE EN ESTE INSTANTE UN EMPLEADO DE CLAVE 100
             **/
                 
                
				
   /*  5 ENUNCIADO 
         A TODOS LOS EMPLEADOS CUYO SUPERVISOR ES EL  EMPLEADO DE CLAVE 9
         DEJARLES SIN SUPERVISOR ASIGNADO**/
      
      /* ESTA OPERACIÓN SE PUEDE REALIZAR PORQUE LA COLUMNA SUPERVISOR ES UNA COLUMNA OPTATIVA*/
      
          /**  CONSULTA PREVIA, OPTATIVA CLAVES DE EMPLEADO 20  Y 21,PARA LUEGO DEJARLO IGUAL*/
		 SELECT ID_EMPLEADO
              FROM EMPLEADOS
              WHERE SUPERVISOR=9;     
  
        /** SOLUCIÓN :**/
		
		UPDATE EMPLEADOS
		    SET SUPERVISOR=NULL
			  WHERE SUPERVISOR=9;
			  
		/*** PARA DEJARLO COMO ESTABA**/

UPDATE EMPLEADOS
    SET SUPERVISOR=9
    WHERE ID_EMPLEADO IN (20,21);	
			  
/**  AHORAN SELECCIONA  A LOS EMPLEADOS CUYO SUPERVISOR ES EL EMPLEADO DE CLAVE 9
    Y DÉJALOS SIN DEPARTAMNETO ASINGNADO*/
    
   /*LA ORDEN SERÍA :**/
   /* SIEMPRE DARÁ ERROR, PORQUE LA COLUMNA ES OBLIGATORIA*/
    UPDATE EMPLEADOS
      SET DEPARTAMENTO=NULL
    WHERE SUPERVISOR=9;
 /* Error Code: 1048. Column 'DEPARTAMENTO' cannot be null*/
 
   UPDATE EMPLEADOS
      SET DEPARTAMENTO=12
    WHERE SUPERVISOR=9;
    
 /* ESTA ORDEN DA ERROR, ERROR DE INTEGRIDAD REFERENCIAL,
    PORQUE NO TENEMOS EN ESTE INSTANTE DEPARTAMENTO CUYA CLAVE (NUMERO ) SEA 12
    */
 /* Error Code: 1452.
 Cannot add or update a child row: a foreign key constraint fails
 (`empresa`.`empleados`, CONSTRAINT `empleados_ibfk_1`
 FOREIGN KEY (`DEPARTAMENTO`) REFERENCES `departamentos` (`NUMERO`) 
 ON DELETE RESTRICT ON UPDATE CASCADE)
 */
                 
      /* 6. ENUNCIADO 
	        REGISTRAR COMO DIRECTOR DEL DEPARTAMENTO DE CLAVE 3, 
            AL EMPLEADO DE CLAVE 100*/
             UPDATE DEPARTAMENTOS 
                  SET  DIRECTOR=100
                 WHERE NUMERO=3;
                 
   /** Error Code: 1452. 
       Cannot add or update a child row: 
       a foreign key constraint fails (`empresa`.`departamentos`, CONSTRAINT `departamentos_ibfk_1`
       FOREIGN KEY (`DIRECTOR`) REFERENCES `empleados` (`ID_EMPLEADO`) 
       ON DELETE RESTRICT ON UPDATE CASCADE)
     **/
     /*** 100 NO ES UN DATO ÍNTEGRO---> NO CUMPLE LA RESTRICCIÓN DE INTEGRIDAD REFEERNCIAL
     --- NO EXISTE UN EMPLEADO DE CLAVE 100 EN LA TABLA EMPLEADOS
     **/
             

      /* 7. ENUNCIADO: 
	        REGISTRAR COMO DIRECTOR DEL  DEPARTAMENTODE CLAVE 3,
            AL EMPLEADO DE CLAVE 1*/
      SELECT NUMERO, DIRECTOR FROM DEPARTAMENTOS; 
      /* LA ORDEN ES CORRECTA Y TAMBIEN ÍNTEGRA*/
      
      
      UPDATE DEPARTAMENTOS 
             SET DIRECTOR=1
          WHERE NUMERO =3;
 
 
 /***Error Code: 1062. Duplicate entry '1'
    for key 'departamentos.FK_DIRECTOR'**/
 
 /*** 1 SI ES INTEGRO, CUMPLE RESTRICCIÓN DE INTEGRIDAD REFERENCIAL
        NO CUMPLE LA RESTRICCIÓN DE UNICIDAD , 1 YA ES DIRECTOR DE OTRO DEPARTAMENTO
        LA COLUMNA DIRECTOR TIENE IMPUESTA LA RESTRICCIÓN DE UNICIDAD
        **/
 

      /** DEJAR SIN REFERENCIA AL DIRECTOR PARA EL  DEPARTAMENTO DE CLAVE 2*/ 
      
      UPDATE departamentos
          SET DIRECTOR=NULL
         WHERE NUMERO=2;

  /*Error Code: 1048. Column 'DIRECTOR' cannot be null**/
  /**   NO CUMPLE LA RESTRICCIÓN DE OBLIGATORIEDAD**/

        
 /***  8 ENUNCIADO
       MODIFICAR LA PRIMA DE SUELDO QUE COBRA CADA DIRECTOR
        TIENE QUE SER IGUAL AL 20% DEL SALARIO DE LA EMPRESA      
      **/
	  
     UPDATE DEPARTAMENTOS 
        SET PRIMA_SUELDO=0.20*(
                                 SELECT   AVG(SALARIO)
                                    FROM EMPLEADOS
        
                               );
      /* UNA SUBCONSULTA----  SE EJECUTA UNA VEZ Y DESPUES
         COMO SIEMPRE, PARA CADA DEPARTAMENTO SE EJECUTA UNA VEZ SET
		 LE HEMOS DEJADO EL MISMO IMPORTE A TODOS LAS TUPLAS
         **/
  /*  5 row(s) affected Rows matched: 5  Changed: 5  Warnings: 0*/
  
  SELECT * FROM DEPARTAMENTOS;



/***   9 ENUNCIADO
        MODIFICAR LA PRIMA DE SUELDO QUE COBRA CADA DIRECTOR
       TIENE QUE SER EL  20 POR CIENTO SALARIO MEDIO DE SU DEPARTAMENTO
     **/
     
   UPDATE DEPARTAMENTOS  AS D
     SET D.PRIMA_SUELDO= 0.20* (
                                  SELECT  AVG(SALARIO)
                                     FROM EMPLEADOS
                                     WHERE DEPARTAMENTO=D.NUMERO
     
                               ); 
 /* COMO NO TENGO IMPLEMENTADO UNAS RUTINAS QUE IMPIDAN DEJAR O TENER UN DEPARTAMENTO
    SIN EMPLEADOS, ESTA ORDEN ANTERIOR, UPDATE, DA ERROR 
    SI HAY UN DEPARTAMNETO SIN EMPLEADOS, PORQUE SU SALARIO MEDIO ES NULL*/
    
/** SUBCONSULTA CORRELACIONADA, SE EJECUTA UNA VEZ POR CADA TUPLA SELECCIONADA
     4 TUPLAS O 5 TUPLAS**/
  /*5 row(s) affected Rows matched: 5  Changed: 5  Warnings: 0*/
   SELECT * FROM DEPARTAMENTOS;
   SELECT * FROM EMPLEADOS WHERE DEPARTAMENTO;
   DELETE  FROM departamentos
      WHERE NUMERO=5;