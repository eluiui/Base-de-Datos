/**********************************************************************************************************************************************
    SOLUCIÓN :      SCRIPT PARA OBTENER LA BASE DE DATOS 
                              BBDD_CURSOS_INTERNET_VER 3 
*************************************************************************************************************************************************
 SCRIPT DE CREACIÓN DE LA BASE DE DATOS
                                  BBDD_CURSOS_INTERNET_VER 3
                                        ESPECIALIZACIÓN DE LA ENTIDAD PROFESOR                                              
     **************************** *****************/
 /****  EN ESTA SOLUCIÓN LA RELACIÓN TENER DIRECTOR ESTÁ ALMACENADA EN  LA TABLA DEPARTAMENTOS,
         PODRÍA ESTAR ALMACENADA EN LA TABLA DIRECTORES
         *****************************************************/
                                  
  DROP DATABASE IF EXISTS BBDD_CURSOS_INTERNET_V3;
  
  CREATE DATABASE IF NOT EXISTS  BBDD_CURSOS_INTERNET_V3;
  
  USE BBDD_CURSOS_INTERNET_V3;
  
  /*****************************  TABLA AULAS PARA GUARDAR ENTIDAD AULA  
                                              Y 
                                              TABLA TELEFONOS_AULAS PARA SU ATRIBUTO 
                                                                       MULTIVALUADO        ****************************/
  DROP TABLE IF  EXISTS AULAS;
  CREATE TABLE IF  NOT EXISTS AULAS
  (
      ID_AULA INT  UNSIGNED NOT NULL  AUTO_INCREMENT,
      NOMBRE   ENUM ('SÓCRATES','ARISTÓTELES', 'PITÁGORAS','SÓFOCLES', 'PLATÓN') NOT NULL,
      LOCALIDAD  VARCHAR(30) NOT NULL,
      DIRECCION VARCHAR (45) NULL,
      PRIMARY KEY (ID_AULA),
      UNIQUE INDEX U_NOM_LOC (NOMBRE,LOCALIDAD)
  ) ENGINE INNODB;
  /** ESTA TABLA GUARDA LA ENTIDAD AULA***/
  /**    ESTA ENTIDAD SE COMPLETA CON ESTA SEGUNDA TABLA PARA 
             PODER REGISTRAR POR CADA TUPLA DE AULA VARIOS TELÉFONOS
             (ESTO CAMBIARÁ CUANDO USEMOS BASES DE DATOS OBJETO_RELACIONALES
             QUE NOS PERMITIRAN DEFINIR TIPOS DE DATOS COMPLEJOS,
             DE MODO QUE, PODREMOS INCORPORAR  ENTRO DEL TIPO DEL  OBJETO PARA LA TUPLA UN ARRAY LIST DE DATOS TELEFONO
             **************/
  
  
  DROP TABLE IF EXISTS TELEFONOS_AULAS;
  CREATE TABLE IF NOT EXISTS TELEFONOS_AULAS
  ( 
       AULA  INT  UNSIGNED  NOT NULL,
       TELEFONO VARCHAR(10) NOT NULL,
       PRIMARY KEY (AULA, TELEFONO),
       FOREIGN KEY (AULA) REFERENCES AULAS(ID_AULA)
              ON DELETE CASCADE  /** SIEMPRE**/
              ON UPDATE CASCADE,
       INDEX FK_AULA_TLF (AULA)                  
   
  
  )ENGINE INNODB;
  
   
 /************  TABLA ALUMNOS    PARA GUARDAR ENTIDAD ALUMNO
                       Y LA RELACIÓN ALUMNO TIENE UN AULA ASIGNADA
                       MIENTRAS UN AULA ESTÉ REFERENCIADA POR UN ALUMNO/A COMO SU AULA ASIGNADA
                        NO SE PODRÁ  SER ELIMINADA DE LA BASE DE DATOS
                                                              ********************/
                                                              
  DROP TABLE IF EXISTS  ALUMNOS;
  CREATE TABLE IF NOT EXISTS ALUMNOS
  (
      DNI CHAR(9) NOT NULL,
      NOMBRE VARCHAR (50) NOT NULL,
      DIRECCION VARCHAR(60) NOT NULL,
      FECHA_NAC  DATE NOT NULL,
      TELEFONO  VARCHAR (10) NULL,
      E_MAIL     VARCHAR(45) NOT NULL,
      FOTO       BLOB NULL,
      DNI_DIG   BLOB NULL,      
      PRIMARY KEY (DNI),
           /** RESTRICCIÓN DE UNICIDAD PARA COLUMNA E_MAIL, NOS SERVIRÁ DE CLAVE ALTERNATIVA**/
      UNIQUE INDEX AK_E_MAIL_ALUMNO (E_MAIL),
      /*** DEFINICIONES PARA REGISTRAR RELACIÓN ALUMNO TIENE UN AULA ASIGNADA**/
       AULA_ASIGNADA INT  UNSIGNED NOT NULL,
      FOREIGN KEY (AULA_ASIGNADA) REFERENCES AULAS(ID_AULA)
            ON DELETE RESTRICT 
            ON UPDATE CASCADE,
      INDEX FK_AULA_ASIGNADA (AULA_ASIGNADA)      
       
  
  ) ENGINE INNODB;
  
  
   /******************************* TABLA   PROFESORES PARA GUARDAR ENTIDAD PROFESOR
                                              QUE EN NUESTRO MODELO HEMOS ESPECIALIZADO EN 4 SUBCLASES
                                              O SUBENTIDADES
                                  Y 
                                     1) LA RELACIÓN PROFESOR PUEDE TENER UN  PROFESOR_SUPERVISOR
                                     2) LA RELACIÓN PROFESOR PERTENENECE A UN DEPARTAMENTO***********/
  
          /********* TABLA PROFESORES ES UNA SUPERCLASE**/
  DROP TABLE IF EXISTS PROFESORES;
  CREATE TABLE IF NOT EXISTS PROFESORES
  (
      DNI  CHAR(9) NOT NULL,
      NOMBRE VARCHAR(50) NOT NULL,
      FECHA_NAC DATE NOT NULL,
      E_MAIL VARCHAR (45) NOT NULL,
      FECHA_ALTA  DATE NOT NULL,
      SALARIO  FLOAT NOT NULL DEFAULT 1500.0,
       PRIMARY KEY (DNI),
      UNIQUE INDEX AK_E_MAIL_PROF (E_MAIL),
      /*** DEFINICIONES PARA LAS DOS RELACIONES**/
      SUPERVISOR CHAR(9) NULL,   /*PROFESOR PARTICIPA EN RELACIÓN TENER SUPERVISOR OPTATIVA (0,1)**/
      /*RESTRICCIÓN DE FOREIGN KEY PARA COLUMNA SUPERVISOR**/ 
       INDEX FK_PROFESOR_SUPERVISOR(SUPERVISOR),
      DEPARTAMENTO INT UNSIGNED NOT NULL,/*PROFESOR PARTICIPA EN RELACIÓN PERTENECER A DEPARTAMENTO OBLIGATORIA (1,1)**/       
       /*RESTRICCIÓN DE FOREIGN KEY PARA COLUMNA DEPARTAMENTO**/ 
        INDEX FK_DEPARTAMENTO_PERTENECE (DEPARTAMENTO)      
       
   ) ENGINE INNODB;
   
   /****** INSERTAMOS AQUÍ    A LOS 4 PROFESORES QUE SERÁN , VAN A SER,  
         DIRECTORES DE LOS 4 DEPARTAMENTOS QUE TENEMOS**/
  
  INSERT INTO `PROFESORES`
  (`DNI`, `NOMBRE`, `FECHA_NAC`, `E_MAIL`, `FECHA_ALTA`, `SALARIO`, `DEPARTAMENTO`) 
VALUES 
('36000001A', 'FERNANDO PEREZ PÉREZ ', '1988-12-02', 'ferpp@gmail.com', '2000-01-01', '1600', '1');

INSERT INTO `PROFESORES` 
(`DNI`, `NOMBRE`, `FECHA_NAC`, `E_MAIL`, `FECHA_ALTA`, `SALARIO`, `DEPARTAMENTO`) 
VALUES 
('36000002B', 'FRANCISCO LÓPEZ MIRA', '1990-01-23', 'fralm@gmail.com', '2000-02-01', '1600', '2');
INSERT INTO `PROFESORES`
 (`DNI`, `NOMBRE`, `FECHA_NAC`, `E_MAIL`, `FECHA_ALTA`, `SALARIO`, `DEPARTAMENTO`) 
 VALUES ('36000003C', 'PALOMA GARCÍA ACUÑA', '1988-11-26', 'palomagarciaacuña@gmail.com', '2001-01-01', '1700', '3');
 
INSERT INTO `PROFESORES`
 (`DNI`, `NOMBRE`, `FECHA_NAC`, `E_MAIL`, `FECHA_ALTA`, `SALARIO`, `DEPARTAMENTO`) 
 VALUES
 ('37000123G', 'SOLEDAD FERNÁNDEZ PÉREZ', '1991-02-03', 'soleadfp@gmail.com', '2000-03-04', '1600', '4');
  
  
  
  
  
  
  /*************** CUATRO TABLAS UNA PARA CADA SUBCLASE:
                        CADA TABLA ES UNA ESPECIALIZACIÓN DE PROFESOR, ES DECIR,
                        UNA LISTA DE DNI's  DE PROFESORES  **/
                        
   /* PARA LA SUBCLASE SUPERVISOR-----> LA TABLA SUPERVISORES**/
   
   
  DROP TABLE IF EXISTS SUPERVISORES;
  CREATE TABLE IF NOT EXISTS SUPERVISORES
  (
      DNI CHAR(9) NOT NULL,
      PRIMARY KEY (DNI),  
      FOREIGN KEY (DNI) REFERENCES PROFESORES(DNI)
           ON DELETE CASCADE /*SIEMPRE, PORQUE UNA SUBCLASE DEPENDE EN EXISTENCIA DE LA SUPERCLASE**/
           ON UPDATE CASCADE
    
  
  )  ENGINE INNODB; /**MOTOR POR DEFECTO**/
  
 /** DESDE ESTE PUNTO DEL SCRIPT YA PODEMOS COMPILAR ESTA DEFINICIÓN 
      QUE FALTABA PARA LA TABLA PROFESORES**/
      
  ALTER TABLE PROFESORES
     ADD FOREIGN KEY (SUPERVISOR) REFERENCES SUPERVISORES(DNI)
            ON DELETE SET NULL  /** FIJARSE**/
             ON UPDATE CASCADE;
             
   /** CUANDO SE ELIMINA DE LA BASE DE DATOS A UN PROFESOR QUE ES SUPERVISOR
        DE 1 O VARIOS PROFESORES, TODOS SUS SUPERVISADOS PASAN A NO TENER SUPERVISOR ASIGNADO
        Y EN CASCADA SE ELIMINA UNA TUPLA DE LA TABLA SUPERVISORES**/          
            
   /**  PARA LA SUBCLASE ADMINISTRADOR---->  LA TABLA ADMINISTRADORES**/
   
   DROP TABLE IF EXISTS ADMINISTRADORES;
  CREATE TABLE IF NOT EXISTS ADMINISTRADORES
  (
      DNI CHAR(9) NOT NULL,
      PRIMARY KEY (DNI),  
      FOREIGN KEY (DNI) REFERENCES PROFESORES(DNI)
           ON DELETE CASCADE
           ON UPDATE CASCADE,
      /*********************  AÑADIMOS TODAS  ESTAS  DEFINICIONES
                                    PARA REGISTRAR  LA RELACIÓN
                                    ADMINISTRADOR ADMINISTRA UN AULA **********/
      AULA INT  UNSIGNED NOT NULL,   /** ADMINISTRADOR PARTICIPA CON OBLIGATORIEDAD  (1,1)*/
      DIA_SEMANA  SET ('LUNES','MARTES','JUEVES') NOT NULL,
      PRECIO_HORA  FLOAT NOT NULL DEFAULT 120.5,
      NUM_HORAS_SEM INTEGER NOT NULL DEFAULT 5,
            
      FOREIGN KEY (AULA) REFERENCES AULAS (ID_AULA)
             ON DELETE CASCADE  /**FIJARSE**/
             ON UPDATE CASCADE,
      INDEX FK_AULA_ADMINISTRADA (AULA)  
      /****************************************************************************/   
  
  
  )  ENGINE INNODB; /**MOTOR POR DEFECTO**/
  
  /***  PARA LA SUBCLASE  DIRECTOR----> TABLA DIRECTORES**/
DROP TABLE IF EXISTS DIRECTORES;
  CREATE TABLE IF NOT EXISTS DIRECTORES
  (
      DNI CHAR(9) NOT NULL,
      PRIMARY KEY (DNI),  
      FOREIGN KEY (DNI) REFERENCES PROFESORES(DNI)
           ON DELETE CASCADE /*SIEMPRE, PORQUE UNA SUBCLASE DEPENDE EN EXISTENCIA DE LA SUPERCLASE**/
           ON UPDATE CASCADE        
  
  
  )  ENGINE INNODB; /**MOTOR POR DEFECTO**/  
  
  /*** COPIAMOS LOS 4 DNI's DE LA TABLA PROFESORES EN LA DE DIRECTORES**/ 
  INSERT INTO DIRECTORES
       SELECT DNI FROM PROFESORES;



  
  /**  PARA SUBCLASE EVALUADOR----> TABLA   EVALUADORES**/
  
  DROP TABLE IF EXISTS EVALUADORES;
  CREATE TABLE IF NOT EXISTS EVALUADORES
  (
      DNI CHAR(9) NOT NULL,
      PRIMARY KEY (DNI),  
      FOREIGN KEY (DNI) REFERENCES PROFESORES(DNI)
           ON DELETE CASCADE /*SIEMPRE, PORQUE UNA SUBCLASE DEPENDE EN EXISTENCIA DE LA SUPERCLASE**/
           ON UPDATE CASCADE        
  
  
  )  ENGINE INNODB; /**MOTOR POR DEFECTO**/
 
    /*****************************  TABLA DEPARTAMENTOS PARA GUARDAR  LA ENTIDAD DEPARTAMENTO
                               Y  LA RELACIÓN DEPARTAMENTO TIENE UN DIRECTOR
                               *******/
  
  DROP TABLE IF EXISTS DEPARTAMENTOS;
  CREATE TABLE IF NOT EXISTS DEPARTAMENTOS
  (
    ID_DEPARTAMENTO INT UNSIGNED NOT NULL AUTO_INCREMENT,
    NOMBRE VARCHAR (20)  NOT NULL,
    E_MAIL     VARCHAR(45) NOT NULL,    
       
    PRIMARY KEY(ID_DEPARTAMENTO),
    UNIQUE INDEX AK_E_MAIL_DEP (E_MAIL),
    /****LAS SIGUIENTES DEFINICIONES PARA ALMACENAR LA RELACIÓN
          DEPARTAMENTO TIENE UN DIRECTOR******/
    DIRECTOR  CHAR(9) NOT NULL, /*PORQUE DEPARTAMENTO PART OBLIGATORIAMENTE*/
    PRIMA    FLOAT NOT NULL DEFAULT 1200.0,
    FECHA    DATE NOT NULL,
    FOREIGN KEY (DIRECTOR) REFERENCES DIRECTORES(DNI)
            ON DELETE RESTRICT
            ON UPDATE CASCADE,            
     UNIQUE INDEX FK_DIRECTOR(DIRECTOR)    /** RESTRICCIÓN DE UNICIDAD E ÍNDICE PARA FK**/   
     /**** ESTA ÚLTIMA DEFINICIÓN IMPRESCINDIBLE HACERLA PARA PODER
            REGISTRAR LA PARTICIPACIÓN  MÁXIMA DE DIRECTOR  1**/
     
  
  ) ENGINE INNODB;
  
    /**** AHORA POR ÚLTIMO, ALMACENAMOS LOS CUATRO DEPARTAMENTOS*****/
    INSERT INTO DEPARTAMENTOS 
    (`NOMBRE`, `E_MAIL`, `DIRECTOR`, `FECHA`) 
    VALUES 
   ('MATEMÁTICAS', 'empresa.matem@gmail.com', '36000001A', '2000-01-01'),
   ('INFORMÁTICA', 'empresa.inform.@gmail.com', '36000002B', '2001-12-14'),
   ('FILOSOFÍA', 'empresa.filosofia@gmail.com', '36000003C', '2000-03-12'),
   ('IDIOMAS', 'empresa.idiomas@gmail.com', '37000123G', '2001-02-20');
  
    
  
  /** DESDE ESTE PUNTO  DEL SCRIPT YA PODEMOS HACER LA DEFINICIÓN QUE FALTABA
      EN LA TABLA PROFESORES**/
  ALTER TABLE PROFESORES
      ADD FOREIGN KEY(DEPARTAMENTO) REFERENCES DEPARTAMENTOS(ID_DEPARTAMENTO)
           ON DELETE RESTRICT /** FIJARSE**/
           ON UPDATE CASCADE;
  
  /** MIENTRAS UN DEPARTAMENTO ESTÉ REFERENCIADO POR UN PROFESOR, NO SE PODRÁ
       ELIMINAR DE LA BASE DE DATOS, SÓLO PODEMOS BORRAR A UN DEPARTAMENTO
       CUANDO NO HAYA NINGÚN PROFESOR "DICIENDO" QUE PERTENECE A ÉL**/
  

  
  
  /*******************************TABLA  CURSOS   PARA GUARDAR ENTIDAD CURSO
                                  Y  
                                             RELACIÓN CURSO TIENE UN PROFESOR QUE ES SU EVALUADOR
                                             RELACIÓN CURSO TIENE UN ALUMNO QUE ES SU DELEGADO
                                  
                                  ************************************************/
  DROP TABLE IF EXISTS CURSOS;
  CREATE TABLE IF NOT EXISTS CURSOS
  (
    ID_CURSO INT UNSIGNED  AUTO_INCREMENT NOT NULL,
    NOMBRE  VARCHAR(30) NOT NULL,
    DURACION   INT NOT NULL DEFAULT 300 ,
    PRECIO      FLOAT NOT NULL DEFAULT 650.0,
    URL_CURSO VARCHAR(100) NOT NULL,
    LIBRO  VARCHAR(60)  NULL,
    PRIMARY KEY (ID_CURSO),
    UNIQUE INDEX AK_NOMBRE_CURSO (NOMBRE),
    UNIQUE INDEX AK_URL_CURSO(URL_CURSO),
     /*********** DEFINICIONES PARA REGISTRAR
                      RELACIÓN TENER PROFESOR EVALUADOR  ******************************/
    EVALUADOR  CHAR(9) NOT NULL, /** CURSO PARTICIPA (1,1)**/
    FECHA_EVALUACION DATE NULL,
    HORA_EVALUACION  TIME NULL,
     /** LA RELACIÓN ES OBLIGATORIA, PERO ESTA VEZ LOS ATRIBUTOS SON OPTATIVOS**/
    FOREIGN KEY (EVALUADOR) REFERENCES EVALUADORES(DNI)
         ON DELETE RESTRICT /** FIJARSE**/
         ON UPDATE CASCADE,
    INDEX FK_PROF_EVALUADOR(EVALUADOR) ,
    /**ESTA RELACIÓN ES (1:N),INDICE PARA LA FK EVALUADOR DE TIPO INDEX**/
    /** FIJARSE: MIENTRAS UN PROFESOR ESTÉ REFERENCIADO COMO EVALUADOR NO SE PODRÁ ELIMINAR**/
    
    /*************  DEFINICIONES PARA REGISTRAR RELACIÓN TENER  ALUMNO DELEGADO****/
     DELEGADO CHAR(9)  NOT NULL,
    FOREIGN KEY (DELEGADO) REFERENCES ALUMNOS(DNI)
          ON DELETE RESTRICT
          ON UPDATE CASCADE,
    UNIQUE INDEX FK_ALUMNO_DELEGADO(DELEGADO) 
    /***IMPORTANTE ESTA REALCIÓN ES (1:1), IMPRESCINDIBLE ESTE UNIQUE INDEX PARA
         LA FK DELEGADO*****/
   
  
  )ENGINE INNODB;
  
  
    /**************************  TABLA PARA RELACIÓN (N:M) PROFESOR IMPARTE CURSO
    EN ESTA TABLA CADA TUPLA CONTIENE UN REGISTRO DE IMPARTIR
    UNA OCURRENCIA DE LA RELACIÓN IMPARTIR (  UN REGISTRO DE TRABAJO)***/
  
  DROP TABLE IF EXISTS PROFESORES_CURSOS;
  
  CREATE TABLE IF NOT EXISTS PROFESORES_CURSOS
  (
        PROFESOR  CHAR(9) NOT NULL,
        CURSO   INT UNSIGNED  NOT NULL,
        NUM_HORAS INT NOT NULL DEFAULT 7,
        PRECIO_HORA FLOAT NOT NULL  DEFAULT 120.0,
        
        PRIMARY KEY(PROFESOR, CURSO),
        FOREIGN KEY(PROFESOR) REFERENCES PROFESORES(DNI)
                             ON DELETE CASCADE
                             ON UPDATE CASCADE,
         INDEX FK_PROFEOSR_IMPARTE (PROFESOR),
         FOREIGN KEY (CURSO) REFERENCES CURSOS(ID_CURSO)
                             ON DELETE CASCADE
                             ON UPDATE CASCADE,
          INDEX FK_CURSO_IMPARTIDO (CURSO)                   
  
    
  ) ENGINE INNODB;
  
  
   /**************************  TABLA PARA RELACIÓN (N:M) ALUMNO MATRICULADO EN  CURSO
   EN ESTA TABLA CADA TUPLA CONTIENE UN REGISTRO DE ESTAR MATRICULADO,
    UNA OCURRENCIA DE LA RELACIÓN MATRICULARSE (  UN REGISTRO DE MATRÍCULA) ***/
  DROP TABLE IF EXISTS ALUMNOS_CURSOS;
  
  CREATE TABLE IF NOT EXISTS ALUMNOS_CURSOS
  (
     ALUMNO CHAR(9) NOT NULL,
     CURSO   INT UNSIGNED  NOT NULL,
     FECHA_MATRICULA DATE NOT NULL,
     NOTA   ENUM ('APTO', 'NO APTO', 'SIN EVALUAR')  NOT NULL  DEFAULT 'SIN EVALUAR',
     PRIMARY KEY (ALUMNO, CURSO),
     FOREIGN KEY (ALUMNO) REFERENCES ALUMNOS(DNI)
                          ON DELETE CASCADE
                          ON UPDATE CASCADE,
     INDEX FK_ALUMNO_MATRICULADO(ALUMNO),                     
     FOREIGN KEY (CURSO) REFERENCES CURSOS(ID_CURSO)
                             ON DELETE RESTRICT
                             ON UPDATE CASCADE,
     INDEX FK_CURSO_IMPARTIDO (CURSO) 
  
  
  ) ENGINE INNODB;
 
 