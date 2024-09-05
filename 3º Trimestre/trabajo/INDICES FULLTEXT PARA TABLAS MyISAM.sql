/*******SCRIPT DE EXPLICACIÓN DE ÍNDICES FULLTEXT ( ÍNDICES DE TEXTO COMPLETO EN EL MOTOR  DE TABLA MyISAN******/

create database if not exists prueba_indices_full_text;
use prueba_indices_full_text;

CREATE TABLE LIBROS (
             nombre VARCHAR (255) ,
             FULLTEXT indice_nombre (nombre)
   )engine=Myisam;

INSERT INTO LIBROS VALUES 
 ('Waiting for the Barbarians'),
 ('In the Heart of the Country'),
 ('The Master of Petersburg'), 
('Writing and Being'),
('Master Master'), 
('A Barbarian at my Door'), 
('The Beginning and the End');

/***   1º ACCEDE A LA NUEVA TABLA Y USA EL INSPECTOR DE TABLA PARA INFORMARTE DE SUS DEFINICIONES  **/

select * from libros;


select * from libros where nombre='master';
/*** RESULTADO ES UNA CONSULTA VACÍA**/

select * from libros where nombre='Master Master';

/** RESULTADO ES UNA TUPLA**/

/*** consultas " de siempre", DESDE EXPRESIÓN WHERE 
    no están usando el  índice fulltext definido en la tabla
      recordad, ya hemos visto que para investigar la ejecución de una sentencia podemos usar la sentencia  explain*/

explain select * from libros where nombre='master';

SHOW INDEX FROM LIBROS;

/*  2º Buscar ocurrencias de la palabra Master:*/

/*** Buscamos tuplas QUE CONTENGAN la subcadena master**/

/** AHORA APRENDEMOS QUE CON ESTA SINTAXIS, FORZAMOS USO DE ÍNDICE FULLTEXT**/

SELECT * 
  FROM LIBROS
  WHERE MATCH (nombre) AGAINST ('Master'); 
 /** empleo del índice fulltext creado**/
 
/* LO DEMOSTRAMOS**/ 
 EXPLAIN
  SELECT * 
   FROM LIBROS
   WHERE MATCH (nombre) AGAINST ('Master'); 

select * from libros
   where nombre like'%Master%';
/** ESTA SERÍA LAS OLUCCIÓN SI NO DISPONEMOS DE UN ÍNDICE FULLTEXT PARA COLUMNA NOMBRE**/ 
/** muy lenta, no se usa índice, EXPESIÓN LIKE PATRÓN DE BÚDQUEDA  ***/
  EXPLAIN select * from libros
   where nombre like'%Master%';

 SELECT COUNT(*) 
  FROM LIBROS 
 WHERE MATCH(NOMBRE) AGAINST ('MASTER');
 
 
/*************** CONCEPTO DE  PALABRAS RUÍDO EN UN ÍNDICE FULLTEXT*********************/
/*** palabras ruído ( the )**
?	MySQL tiene lo que se conoce como umbral del 50 por ciento.
   Todas las palabras que aparecen en más de un 50 por ciento
   de los datos (cadenas a indexar), se consideran como ruído y se ignoran.
   Es decir, se excluyen del índice.

?	Todas las palabras que tengan un número igual o inferior
    a TRES letras se excluyen del índice.

?	Existe una lista predefinida de palabras ruido,
    entre las que se incluye the.

*/


/** ruído es una subcadena que no se incorpora en el índice**/
select * from libros
where match(nombre) against ('the'); 

/** consulta vacía**/ 

SELECT * 
  FROM LIBROS 
  WHERE MATCH (nombre) AGAINST ('The Master');
/** la palabra ruído the es eliminada de la búsqueda***/
SELECT * FROM LIBROS WHERE MATCH (nombre) AGAINST ('The');
/*retorna cero ocurrencias, the es eliminada de la búsqueda**/




/** *****************************BÚSQUEDA BOOLEANA  EN UN ÍNDICE FULLTEXT
  IN BOOLEAN MODE                                                              ***************************** ***/

/** BUSCAMOS AHORA, TUPLAS QUE TIENEN QUE TENER LA PALABRA MASTER
  Y NO TIENEN LA PALABRA PETERSBURG
  USO DE + /-
  
  **/

SELECT *
 FROM libros 
 WHERE MATCH (nombre)  AGAINST( '+Master -PETERSBURG' IN BOOLEAN MODE);


SELECT * FROM libros 
 WHERE MATCH (nombre) AGAINST( '+PETERSBURG' IN BOOLEAN MODE);

SELECT * FROM libros 
 WHERE MATCH (nombre) AGAINST('PETERSBURG');



SELECT * FROM libros 
 
 WHERE MATCH (nombre) AGAINST( '+Master*' IN BOOLEAN MODE);

/***  EN ESTA CONSULTA USO * ;  TUPLAS QUE CONTIENEN PALABRA MASTER O PALABRAS
     QUE COMIENZAN POR MASTER**/ 
/********************************** ÍNDICES MÚLTIPLES, COMPUESTOS POR VARIAS COLUMNAS
   RECORDAD UTILIDAD O EFICIENCIA MANTENER ORDEN DE DEFINICIÓN EN EXPRESIONES DE BÚSQUEDA
   ***********************************************************************************************************/
   
CREATE TABLE IF NOT EXISTS CLIENTES
(
   ID INT UNSIGNED ,
  NOMBRE VARCHAR(15)  NOT NULL,
  PRIMER_APELLIDO VARCHAR (20) NOT NULL,
  SEGUNDO_APELLIDO VARCHAR(20) NULL,
  COMENTARIO TEXT NULL,
  PRIMARY KEY (ID),
  INDEX I_NOMBRE_COMPLETO(NOMBRE,PRIMER_APELLIDO, SEGUNDO_APELLIDO),
 FULLTEXT (COMENTARIO)
 )
ENGINE MYISAM;

INSERT INTO CLIENTES
(ID,NOMBRE, PRIMER_APELLIDO, SEGUNDO_APELLIDO,COMENTARIO)
VALUES
(1,'MARIA TERESA','FERNANDEZ','PEREZ',DEFAULT),
(2,'PEPE', 'GOMEZ', 'CASTRO',DEFAULT),
(3, 'MARIA LUISA','CASTRO','CASTRO','VIVE EN VIGO PERO CONSULTA DESDE PONTEVEDRA'),
(4, 'LOLA','GOMEZ','GARCIA','VIVE EN VIGO USA MUY FRECUENTEMENTE CIENCIAS');

SELECT * FROM CLIENTES WHERE NOMBRE='PEPE';    /*USA EL ÍNDICE? SI*/

EXPLAIN SELECT * FROM CLIENTES WHERE NOMBRE='PEPE';

SELECT * 
FROM CLIENTES 
WHERE NOMBRE='PEPE' AND PRIMER_APELLIDO='GOMEZ';/*USA EL ÍNDICE?   SI*/

EXPLAIN SELECT * 
FROM CLIENTES 
WHERE NOMBRE='PEPE' AND PRIMER_APELLIDO='GOMEZ';
/** EN AMBAS CONSULTAS APROVECHAMOS BIEN EL ,INDICE*/

SELECT * 
   FROM CLIENTES WHERE PRIMER_APELLIDO='GOMEZ';
   
 /*   EN ESTA CONSULTA ROMPEMOS LA SECUENCIA CON LA QUE ESTÁ CREADO EL ÍNDICE -->NO USA EL ìNDICE*/
/** no se aprovecha la existencia de índice**/
EXPLAIN SELECT * 
   FROM CLIENTES WHERE PRIMER_APELLIDO='GOMEZ';
EXPLAIN SELECT * FROM CLIENTES WHERE Segundo_APELLIDO='GOMEZ';

EXPLAIN SELECT * FROM CLIENTE