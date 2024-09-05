
DELIMITER $$

USE empresa $$

DROP PROCEDURE IF EXISTS ACTUALIZA_SALARIO$$

CREATE PROCEDURE ACTUALIZA_SALARIO ( IN CANTIDAD_HIJOS INTEGER, 
                                     IN CANTIDAD_SUBIDA FLOAT, 
                                     OUT OK INTEGER) 

MODIFIES SQL DATA


BEGIN
 /******************  DECLARACIÓN VARIABLES LOCALES DE RUTINA***************/

   DECLARE FINAL_DATOS BOOLEAN DEFAULT FALSE;  /**IMPORTANTE INICILIZAR SU VALOR  FALSE*/

/********** VAR PARA CURSOR ****/
   DECLARE CLAVE_EMPLEADO  INTEGER;
   DECLARE NUMERO_HIJOS INTEGER;


/***************************  DECLARACIÓN CURSORES*******/
   DECLARE  CURSOR_EMPLEADOS CURSOR FOR
            SELECT   NUMEM, NUMHIJOS
                   FROM EMPLEADOS
                   WHERE  NUMHIJOS>=CANTIDAD_HIJOS
                           AND
                          COMISION IS NULL
                   FOR UPDATE;

/**************************** DEFINICIÓN DE HANDLERS***************/
    DECLARE CONTINUE HANDLER FOR NOT FOUND  SET FINAL_DATOS=TRUE;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
       BEGIN
         ROLLBACK; /**  LAS OPERACIONES  YA REALIZADAS SE DESACEN, NO SE CONFIRMAN**/
         SET OK=0;
         SELECT concat('clave empleado con error,',clave_empleado, 'OPERACIÓN NO REALIZADA');
       END;

                
 
/********************************** PROCESO *******************************/
    DROP TABLE IF EXISTS DATOS_SUBIDA_SALARIO;
    CREATE TABLE DATOS_SUBIDA_SALARIO
    ( LINEA_INFORME  VARCHAR(200) )
    ENGINE MYISAM;
    
    
    
    START TRANSACTION; 
    SET OK=1;
    OPEN CURSOR_EMPLEADOS;  /* se ejecuta el cursor-->bloque de información en memoria para procesar*/
    /** LECTURA DE DATOS CICLO**/
    FETCH CURSOR_EMPLEADOS INTO CLAVE_EMPLEADO, NUMERO_HIJOS;/*INTENTO LEER PRIMERA TUPLA*/
    WHILE   NOT FINAL_DATOS    DO
            
          UPDATE EMPLEADOS
            SET SALARIO= SALARIO + CANTIDAD_SUBIDA*NUMERO_HIJOS
            WHERE NUMEM= CLAVE_EMPLEADO;
            
          INSERT INTO DATOS_SUBIDA_SALARIO
            VALUES ( CONCAT( 'EMPLEADO:    ', CLAVE_EMPLEADO,'    CANTIDAD SUBIDA :  ',CANTIDAD_SUBIDA*NUMERO_HIJOS));
          /**INTENTO LEER LA SIGUIENTE TUPLA*/  
          FETCH CURSOR_EMPLEADOS INTO CLAVE_EMPLEADO, NUMERO_HIJOS;
    END  WHILE;  
    
    CLOSE CURSOR_EMPLEADOS; /**LIBERO BLOQUE DE MEMORIA DEL CURSOR*/
     IF OK THEN COMMIT; 
           ELSE ROLLBACK;
     END IF;      

END$$