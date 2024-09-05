 /** LA SENTENCIA SELECT ... INTO OUTFILE 'NOMBRE_DE_FICHERO'
      Escribe las filas seleccionadas resultado de la consulta en un archivo.
      
      El archivo se crea en el host del servidor.
      El ususrio debe tener el privilegio FILE para usar esta sintaxis.
      
      Por razones de seguridad el servidor me deja ejecutar esta orden   SELECT .. INTO OUTFILE .. 
      para volcar una tabla/una consulta  en en un fichero texto en el host del servidor, 
      pero  en un directorio concreto y sólo en ese.
      Para enterarme del directorio donde puedo crear el fichero  desde la orden  SELECT .. INTO OUTFILE :
      podemos hacer estas consultas */
      
   /* Por otro lado el fichero no puede ser un archivo existente, no podemos, de nuevo por razones de seguridad, sobreescribir en ese directorio
   **/
 use empresa;
 
 SHOW VARIABLES LIKE "secure_file_priv";
 /* o bienn */
 
 SELECT @@global.secure_file_priv;
 
 /*  resultado :
 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\'  */



  
 /** EJEMPLO :*/ 
select  e.nif, e.nss, e.nombre, e.direccion, e.salario,
        d.nombre,d.prima_sueldo,d.fecha_inicio
             into outfile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\Datos_Directores.txt'
              FIELDS TERMINATED BY '-'
              ESCAPED BY '\\'
              ENCLOSED BY '\"'
              LINES TERMINATED BY '\n'
  from empleados as e inner join departamentos as d
                      on e.id_empleado=d.director;



 /*OTRO EJEMPLO*/        
SELECT   *  
INTO OUTFILE  'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\EMPLEADOS.TXT'                      
      FIELDS TERMINATED BY ','  
      ESCAPED BY '\\'
      OPTIONALLY ENCLOSED BY '"'
      LINES TERMINATED BY '\n'    
      
    FROM EMPLEADOS
       ;    
    
   /** SELECT.. INTO OUTFILE NOMBRE_FICHERO
       es el complemento de la sentencia LOAD DATA*/ 
   /**
   
   sintaxis de LOAD DATA :
   
LOAD DATA [LOW_PRIORITY | CONCURRENT] [LOCAL] INFILE 'file_name.txt'
    [REPLACE | IGNORE]
    INTO TABLE tbl_name
    [FIELDS
        [TERMINATED BY '\t']
        [[OPTIONALLY] ENCLOSED BY '']
        [ESCAPED BY '\\' ]
    ]
    [LINES 
        [STARTING BY '']    
        [TERMINATED BY '\n']
    ]
    [IGNORE number LINES]
    [(col_name,...)]
************************/
 
CREATE  DATABASE  IF NOT EXISTS PRUEBA;
USE PRUEBA;
DROP TABLE IF EXISTS DATOS;
CREATE TABLE  DATOS
(
 NUMERO INTEGER NOT NULL,
 NOMBRE VARCHAR(30) NOT NULL,
 TELEFONO VARCHAR(10) NOT NULL
 

)ENGINE INNODB;
LOAD DATA   INFILE  'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\DATOS.TXT'
   INTO TABLE PRUEBA.DATOS
      FIELDS TERMINATED BY ','  
      ESCAPED BY '\\'
      OPTIONALLY ENCLOSED BY '"'
      LINES TERMINATED BY '\r\n'; 

SELECT * FROM DATOS;
    
/*****************************************************************/

USE EMPRESA;
/*EJEMPLO DE USO DE SENTENCIA 
   SELECT   INTO OUTFILE NOMBRE_FICHERO  */
SELECT   *  
       INTO OUTFILE  'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\DATOS-EMPLEADOS.TXT'                     
           FIELDS TERMINATED BY ','
           ESCAPED BY '\\'
           OPTIONALLY ENCLOSED BY '\"'
           LINES TERMINATED BY '\r\n'
 FROM EMPLEADOS
     ;

CREATE   TABLE  IF NOT EXISTS  EMPLEADOS2 LIKE EMPLEADOS;
 /** LIKE NO CREA O COPIA LAS RESTRICCIONES DE FOREIGN KEY, SI CREA O COPIA LOS ÍNDICES **/    
DESCRIBE EMPLEADOS2;

/** AHORA EJEMPLO ,  CARGAMOS EN UNA TABLA  UN FICHERO DE DATOS */

LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\datos-empleados.txt'
     INTO TABLE EMPLEADOS2  
           charset'latin1' /*comentar esto**/
           FIELDS TERMINATED BY ','
           ESCAPED BY '\\'
           OPTIONALLY ENCLOSED BY '\"'
           LINES TERMINATED BY '\r\n'
    ;  
 

select * from empleados2;

