 DROP DATABASE IF EXISTS BDTENISTAS;
 CREATE DATABASE IF NOT EXISTS BDTENISTAS;
 USE BDTENISTAS;
 
 /** TABLA PARA LA ENTIDAD TENISTA Y
     DOS RELACIONES OPTATIVAS
        ESTAR FICHADO EN EQUIPO
        TENER UN TENISTA ENTRENADOR**/
 
 DROP TABLE IF EXISTS TENISTAS;
 CREATE TABLE IF NOT EXISTS TENISTAS
 (
   NUM_AFILIADO INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
   DNI CHAR(9) NOT NULL,
   NOMBRE_APE  VARCHAR(60) NOT NULL,
   FECHA_NAC DATE NOT NULL,
   PESO  FLOAT NULL, /*COLUMNA OPTATIVA*/
   PRIMARY KEY (NUM_AFILIADO),
   UNIQUE INDEX AK_DNI_TENISTA(DNI),
   /** RELACIÓN TENISTA PUEDE FORMAR PARTE DE UN EQUIPO**/
   EQUIPO INTEGER UNSIGNED  NULL, /**COLUMNA OPTATIVA!! RELACIÓN OPTATIVA*/
   
   INDEX FK_EQUIPO(EQUIPO),
   /** INDEX PARA PARTICIPACIÓN DE EQUIPO max n, REL (1:N)*/
   /** RELACIÓN TENISTA PUEDE ESTAR ENTRENADO POR OTRO TENISTA
       DE ESTA TABLA**/
    TENISTA_ENTRENADOR INTEGER UNSIGNED NULL, /** REL OPTATIVA*/ 
    FOREIGN KEY(TENISTA_ENTRENADOR) REFERENCES TENISTAS(NUM_AFILIADO)
                        ON DELETE SET NULL
                        ON UPDATE CASCADE,
    INDEX FK_ENTRENADOR (TENISTA_ENTRENADOR)
    /* INDEX PORQUE PARTICIPACIÓN DE ENTREANDOR ES max n, RELA(1:N)*/
 
 
 
 ) ENGINE INNODB
   AUTO_INCREMENT 100;
   
/*** TABLA PARA LA ENTIDAD TORNEO
 */

DROP TABLE IF EXISTS TORNEOS;
CREATE TABLE IF NOT EXISTS TORNEOS
(
  ID_TORNEO INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  NOMBRE VARCHAR(60) NOT NULL,
  PAIS ENUM('INGLATERRA','FRANCIA','ESPAÑA','EEUU', 'SUIZA','ARGENTINA') NOT NULL DEFAULT'ESPAÑA', 
  FECHA_INICIO DATE NOT NULL,
  NUM_JORNADAS INTEGER UNSIGNED NOT NULL DEFAULT 20,
  PRIMARY KEY(ID_TORNEO),
  UNIQUE INDEX AK_NOMBRE_TORNEO(NOMBRE)
  
  
) ENGINE INNODB
  AUTO_INCREMENT 10;   

/*** TABLA PARA LA ENTIDAD EQUIPO NACIONAL
  Y UNA RELACIÓN OBLIGATORIA
  TENER UN TENISTA COMO CAPITAN*/

DROP TABLE IF  EXISTS EQUIPOS;
CREATE TABLE IF NOT EXISTS EQUIPOS
(
  ID_EQUIPO INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  NOMBRE_PAIS VARCHAR(50) NOT NULL,
  NOMB_SELECCIONADOR VARCHAR(60) NULL, /* COLUMNA OPTATIVA*/
  PRIMARY KEY (ID_EQUIPO),
  UNIQUE INDEX AK_NOMBRE_PAIS(NOMBRE_PAIS),
  /**** RELACIÓN EQUIPO TIENE TENISTA CAPITAN**/
  CAPITAN INTEGER UNSIGNED NOT NULL, /*REL OBLIGATORIA*/
  FECHA_CAPITAN DATE NOT NULL,
  FOREIGN KEY(CAPITAN) REFERENCES TENISTAS(NUM_AFILIADO)
                         ON DELETE RESTRICT
                         ON UPDATE CASCADE,
  UNIQUE INDEX FK_CAPITAN(CAPITAN) 
  /** UNIQUE TRADUCE PARTICIPACIÓN DE TENISTA max 1, es REL (1:1)**/
  
  
)ENGINE INNODB;

ALTER TABLE TENISTAS
 ADD  FOREIGN KEY(EQUIPO) REFERENCES EQUIPOS(ID_EQUIPO)
                        ON DELETE SET NULL
                        ON UPDATE CASCADE;
                        /** TABLA PARA ENTIDAD PARTIDO, SERÁ ENTIDAD DEBIL DEPENDE EN EXISTENCIA  
   Y EN IDENTIFICACIÓN DE LA ENTIDAD TORNEO
   GUARDA UNA RELACIÓN OBLIGATORIA
     PARTIDO ES DE UN TORNEO**/
   
DROP TABLE IF EXISTS PARTIDOS;
CREATE TABLE IF NOT EXISTS PARTIDOS
(
  NUMERO INTEGER UNSIGNED NOT NULL,
  FECHA DATE NOT NULL,
  HORA_COMIENZO  TIME NOT NULL DEFAULT '17:00:00',
  DURACION  TIME NULL, /* PARA ALMACENAR UNA CANTIDAD DE TIEMPO EN HORAS, MINUTOS Y SEGUNDOS*/ 
  /* RELACIÓN PARTIDO ES DE UN TORNEO**/
  TORNEO INTEGER UNSIGNED NOT NULL,
  FOREIGN KEY(TORNEO) REFERENCES TORNEOS(ID_TORNEO)
                 ON DELETE CASCADE /*DEP EN EXISTENCIA*/
                 ON UPDATE CASCADE,
  INDEX FK_TORNEO(TORNEO),
  /** INDEX PARA PARTICIPACIÓN DE TORNEO max n, REL (1:N)*/
  PRIMARY KEY(TORNEO, NUMERO)  
 /*DEPENDENCIA EN IDENTIFICACIÓN, LA FK FORMA PARTE DE LA PK*/
) ENGINE INNODB;   

/*** TABLA PARA ALMACENAR LA RELACIÓN TENISTA PARTICIPA O SE INSCRIBE
    EN TORNEO, REL DE TIPO (N:M) 
    ESTA TABLA ALMACENA CADA UNA DE LAS INSCRIPCIONES
*******/
    
DROP TABLE IF EXISTS TENISTAS_TORNEOS;
CREATE TABLE IF NOT EXISTS TENISTAS_TORNEOS
(
   TENISTA INTEGER UNSIGNED NOT NULL,
   TORNEO  INTEGER UNSIGNED NOT NULL,
   FECHA_INSCRIPCION DATE NOT NULL,
   PUESTO   INTEGER UNSIGNED NOT NULL DEFAULT 0,
   PRIMARY KEY(TENISTA, TORNEO),
   FOREIGN KEY (TENISTA) REFERENCES TENISTAS(NUM_AFILIADO)
                ON DELETE CASCADE
                ON UPDATE CASCADE,
   INDEX FK_TENISTA_INSCRITO(TENISTA),
   FOREIGN KEY(TORNEO) REFERENCES TORNEOS(ID_TORNEO)
                      ON DELETE RESTRICT
                      ON UPDATE CASCADE,
   INDEX FK_TORNEO_CON_INSCRIPCION (TORNEO)
  
) ENGINE INNODB
  MAX_ROWS 2000 ;
    
    
   