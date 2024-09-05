/********** SCRIPT DE CREACIÓN DE LA BASE DE DATOS
                                  BBDD_CURSOS_INTERNET_V2   *****************/
                                  
                                  
  DROP DATABASE if exists BBDD_CURSOS_INTERNET_V2;
  CREATE DATABASE IF NOT EXISTS  BBDD_CURSOS_INTERNET_V2;
  
  USE BBDD_CURSOS_INTERNET_V2;
  
   /*****************************  TABLA AULAS PARA GUARDAR ENTIDAD AULA 
                                   Y NO ALMACENA NINGÚNA RELACIÓN
                                   por eso no tiene ninguna linea foreign key,
                                   TABLA TELEFONOS_AULAS PARA SU ATRIBUTO
                                                  MULTIVALUADO****************************/
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
  
  
  /********esta tabla sirve para guardar un atributo multivalado de la entidad aula**/
  
  DROP TABLE IF EXISTS TELEFONOS_AULAS;
  CREATE TABLE IF NOT EXISTS TELEFONOS_AULAS
  ( 
       AULA  INT  UNSIGNED  NOT NULL,
       TELEFONO VARCHAR(10) NOT NULL,
       PRIMARY KEY (AULA, TELEFONO),
       FOREIGN KEY (AULA) REFERENCES AULAS(ID_AULA)
              ON DELETE CASCADE
              ON UPDATE CASCADE,
       INDEX FK_AULA_TLF (AULA)       
              
  
  
  
  )ENGINE INNODB;
  
  
  
  
  
  
  /************  TABLA ALUMNOS    PARA GUARDAR ENTIDAD ALUMNO
                    y guardar relación alumno está asignado a un aula
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
      aula   integer unsigned not null,
      PRIMARY KEY (DNI),
      /** RESTRICCIÓN DE UNICIDAD PARA COLUMNA E_MAIL, NOS SERVIRÁ DE CLAVE ALTERNATIVA**/
      UNIQUE INDEX AK_E_MAIL_ALUMNO (E_MAIL),
      foreign key (aula) references aulas (id_aula)
                           on delete restrict /*solo se podrá borrar una aula si o hay nadie referenciandola*/
                           on update cascade, 
      index fk_aula_asignada (aula) /** es una relacio (1:n)**/                   
  
  ) ENGINE INNODB;
  
  
  
  
  
  /*******************************TABLA  CURSOS  
                 PARA GUARDAR ENTIDAD CURSO 
                 y guarda la relación curso tiene un alumno delegado
                   y la relación curso tiene evaluador
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
    /******* para registrar  curso tiene una alumno delegado**/
    delegado CHAR(9) not null,/* curso tiene un alumno delegado*/
    /******** PARA REGISTRAR LA RELACIÓN TENER PROFESOR EVALUADOR***/
    EVALUADOR  CHAR(9) NOT NULL, /*  FK PARA EL DNI DE UN PROFESOR QUE ES SU EVALUADOR*/
    FECHA_EVALUACIÓN DATE NULL, 
    HORA_EVALUACIÓN TIME NULL,   
    /******************************************/
    PRIMARY KEY (ID_CURSO),
    UNIQUE INDEX AK_NOMBRE_CURSO (NOMBRE),
    UNIQUE INDEX AK_URL_CURSO(URL_CURSO),
    foreign key (delegado) references alumnos(dni)
                             on delete restrict
                             on update cascade,
    unique index fk_alumno_delegado (delegado),/*la reclación es de tipo (1:1)*/
    
    
    INDEX FK_PROF_EVALUADOR (EVALUADOR) /*la relación es de tipo (1:n)*/                           
  
  
  )ENGINE INNODB;
  
  
  
  /******************************* TABLA   PROFESORES 
              PARA GUARDAR ENTIDAD PROFESOR
              Y TRES REALACIONES, PERTENECER A DEPARTAMENTO OBLIGATORIA
                                 ADMINSTRAR AULA (OPTATIVA)
                                 TENER SUPERVISOR  OBLIGATORIA***********/
  
  
  DROP TABLE IF EXISTS PROFESORES;
  CREATE TABLE IF NOT EXISTS PROFESORES
  (
      DNI  CHAR(9) NOT NULL,
      NOMBRE VARCHAR(50) NOT NULL,
      FECHA_NAC DATE NOT NULL,
      E_MAIL VARCHAR (45) NOT NULL,
      FECHA_ALTA  DATE NOT NULL,
      SALARIO  FLOAT NOT NULL DEFAULT 1500.0,
      /****** para guardar relación profesor pertenece a departamento**/
      departamento  INT UNSIGNED not null,/* CADA TUPLA , CADA PROFESOR, APUNTA AL DEPARTAMENTO
                                            AL QUE PERTENECE*/
     /**************************************/                                       
      AULA_ADMINISTRADA  INT  UNSIGNED  NULL, /*PROFEOSR PARTICIPA DE FORMA OPTATIVA**/                                    
      NUM_HORAS INTEGER NULL,
      DIA_SEMANA ENUM ('LUNES','MARTES','MIERCOLES','JUEVES','VIERNES') NULL,
      PRECIO_HORA FLOAT NULL,
      /******* PARA GUARDAR LA RELACIÓN PROFESOR TIENE OTRO PROFESOR QUE LO SUPERVISA**/
      SUPERVISOR CHAR(9) NOT NULL,
      /*******************/
      PRIMARY KEY (DNI),
      UNIQUE INDEX AK_E_MAIL_PROF (E_MAIL),
      
      index   fk_departamento_pertenece (departamento),
      
      FOREIGN KEY(AULA_ADMINISTRADA) REFERENCES AULAS(ID_AULA)
                                    ON DELETE SET NULL
                                    ON UPDATE CASCADE,
      INDEX FK_AULA_ADMINISTRADA (AULA_ADMINISTRADA),
      FOREIGN KEY (SUPERVISOR) REFERENCES PROFESORES(DNI)
            ON DELETE RESTRICT
            ON UPDATE CASCADE,
      INDEX FK_SUPRVISOR(SUPERVISOR)      
                                    
          
  
  ) ENGINE INNODB;
  
  /***** AHORA EL COMPILAOR YA CONOCE EL IDENTIFICADOR TABLA PROFESORES
       ENTONCES PUEDO HACER ESTA DEFINICIÓN QUE FALTABA EN LA TABLA CURSOS**/
  ALTER TABLE CURSOS
      ADD FOREIGN KEY (EVALUADOR) REFERENCES PROFESORES(DNI)
                                 ON DELETE RESTRICT
                                 ON UPDATE CASCADE;
  
 
  
  
    /*****************************  TABLA DEPARTAMENTOS 
    PARA GUARDAR  ENTIDAD DEPARTAMENTO  Y GUARDA LA RELACIÓN TENER DIRECTOR*******/
  
  DROP TABLE IF EXISTS DEPARTAMENTOS;
  CREATE TABLE IF NOT EXISTS DEPARTAMENTOS
  (
    ID_DEPARTAMENTO INT UNSIGNED NOT NULL AUTO_INCREMENT,
    NOMBRE VARCHAR (20)  NOT NULL,
    E_MAIL     VARCHAR(45) NOT NULL,
    director  CHAR(9) not null, /* para guardar la relación dep tiene director**/
    FECHA_DIRECTOR  DATE NOT NULL,
    PRIMA_DIRECTOR  FLOAT NOT NULL DEFAULT 350.0,
    PRIMARY KEY(ID_DEPARTAMENTO),
    UNIQUE INDEX AK_E_MAIL_DEP (E_MAIL),
    foreign key(director) references profesores (dni)
                           on delete restrict /*mientras un profesor esté refenciado como director no se puede borrar**/
                           on update cascade,
    unique index fk_director (director)              
                     
   
  
  ) ENGINE INNODB;
  
  /*** AQUÍ EN ESTE PUNTO DEL CODIGO FUENTE YA PODEMOS USAR EL IDENTIFICADOR 
  DE TABLA  DEPARTAMENTOS**/
  
  ALTER TABLE PROFESORES
     ADD foreign key (departamento) references departamentos(id_departamento)
                               on delete restrict
                               on update cascade;
                               
                               
  /*** tabla para registrar la relación alumno se matricula en curso
        relación de tipo (N:M)   ****/
        
  drop table if exists matriculas;
  create table if not exists matriculas
  (
    alumno  CHAR(9)  NOT NULL,
    curso   INT UNSIGNED  NOT NULL,
    FECHA DATE NOT NULL,
    NOTA FLOAT NULL,
    PRIMARY KEY (ALUMNO, CURSO),
    FOREIGN KEY (ALUMNO) REFERENCES ALUMNOS(DNI)
                         ON DELETE CASCADE
                         ON UPDATE CASCADE,
    INDEX FK_ALUMNO (ALUMNO) ,
    FOREIGN KEY (CURSO) REFERENCES CURSOS(ID_CURSO)
                          ON DELETE RESTRICT
                          ON UPDATE CASCADE,
    INDEX FK_CURSO(CURSO)                  
   
  ) engine innodb;
  
  
  /*** TABLA PARA GUARDAR LA RELACIÓN DE TIPO (N:M)
        CURSO ES IMPARTIDO POR PROFESOR / PROFESOR IMPARTE CURSO
        ****/
        
        
 DROP TABLE IF EXISTS CURSOS_PROFESORES;
 CREATE TABLE IF NOT EXISTS CURSOS_PROFESORES
 (
    CURSO INTEGER UNSIGNED NOT NULL,
    PROFESOR CHAR(9) NOT NULL,
    NUM_HORAS INTEGER NOT NULL,
    PRECIO_HORA FLOAT NOT NULL DEFAULT 160.5,
    PRIMARY KEY (CURSO,PROFESOR),
    FOREIGN KEY (CURSO) REFERENCES CURSOS(ID_CURSO)
                         ON DELETE CASCADE
                         ON UPDATE CASCADE,
    INDEX FK_CURSO_IMPARTIDO (CURSO),/**SIEMPRE DE TIPO INDEX**/
    FOREIGN KEY(PROFESOR) REFERENCES PROFESORES (DNI)
                          ON DELETE CASCADE
                          ON UPDATE CASCADE,
    INDEX FK_PROFESOR_IMPARTE (PROFESOR)                       
                    
    
 ) ENGINE INNODB;
 /************************ fin diseño de la base de datos***********************/
  
  /**** ESTAS OPERACIONES LAS HACEMOS PARA PODER ALMACENAR LOS DEPARTAMENTOS
      SIN SUS CORRESPONDIENTES DIRECTORES**/
      
      ALTER TABLE DEPARTAMENTOS
         MODIFY COLUMN DIRECTOR CHAR(9) NULL;
         /** temporalmente dejamos esta columna como optativa, 
         para poder almacenar los departamentos sin su director*/
         
    INSERT INTO departamentos 
       (NOMBRE, E_MAIL, DIRECTOR,FECHA_DIRECTOR, PRIMA_DIRECTOR)
   VALUES ('MATEMÁTICAS', 'mate@gmail.com',NULL, '000-00-00', '0'); 
   
     INSERT INTO departamentos 
       (NOMBRE, E_MAIL, DIRECTOR, FECHA_DIRECTOR, PRIMA_DIRECTOR)
        VALUES ('LENGUA', 'lengua@gmail.com',NULL, '000-00-00', 0);
        
      INSERT INTO departamentos 
       (NOMBRE, E_MAIL, DIRECTOR,FECHA_DIRECTOR, PRIMA_DIRECTOR)
          VALUES ('INFORMÁTICA', 'info@gmail.com', NULL,'0000-00-00', '0');
          
     INSERT INTO departamentos 
       (NOMBRE, E_MAIL, DIRECTOR,FECHA_DIRECTOR, PRIMA_DIRECTOR)
         VALUES ('HISTORIA ', 'historia@gmail.com',NULL,'0000-00-00', '0'); 
  
  
  /****** más adelante nombramos a los  directores y definimos de nuevo la columna
      como obligatoria**/
  
  
  
  
  