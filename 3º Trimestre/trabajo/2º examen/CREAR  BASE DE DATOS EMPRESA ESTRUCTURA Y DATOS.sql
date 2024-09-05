
--
-- Base de Datos: `empresa`
--
DROP DATABASE IF EXISTS EMPRESA;
CREATE DATABASE IF NOT EXISTS EMPRESA;

USE EMPRESA;

-- --------------------------------------------------------

--
-- Estrutura da tabela `departamentos`
--

DROP TABLE IF EXISTS `departamentos`;
CREATE TABLE IF NOT EXISTS `departamentos` (
  `NUMERO` int unsigned NOT NULL auto_increment,
  `NOMBRE` varchar(25) NOT NULL,
  `DIRECTOR` int unsigned  NOT NULL,
  `PRIMA_SUELDO` float NOT NULL default '1000',
  `FECHA_INICIO` date NOT NULL default '0000-00-00',
  PRIMARY KEY  (`NUMERO`),
  UNIQUE KEY `AK_NOMBRE` (`NOMBRE`),
  UNIQUE KEY `FK_DIRECTOR` (`DIRECTOR`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Extraindo datos da tabela `departamentos`
--

INSERT INTO `departamentos` (`NUMERO`, `NOMBRE`, `DIRECTOR`, `PRIMA_SUELDO`, `FECHA_INICIO`) VALUES
(01, 'ADMINISTRACION', 001, 1000, '2017-12-11'),
(02, 'VENTAS', 002, 1000, '2017-12-05'),
(03, 'MARKETING', 003, 1000, '2017-12-05'),
(04, 'PERSONAL', 004, 1000, '2017-12-25');

-- --------------------------------------------------------

--
-- Estrutura da tabela `departamentos_sedes`
--

DROP TABLE IF EXISTS `departamentos_sedes`;
CREATE TABLE IF NOT EXISTS `departamentos_sedes` (
  `DEPARTAMENTO` int unsigned  NOT NULL,
  `SEDE` int unsigned  NOT NULL,
  PRIMARY KEY  (`DEPARTAMENTO`,`SEDE`),
  KEY `FK1_DEPARTAMENTO` (`DEPARTAMENTO`),
  KEY `FK2_SEDE` (`SEDE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo datos da tabela `departamentos_sedes`
--

INSERT INTO `departamentos_sedes` (`DEPARTAMENTO`, `SEDE`) VALUES
(01, 01),
(01, 04),
(01, 05),
(01, 09),
(02, 01),
(02, 08),
(03, 01),
(03, 08),
(03, 10),
(04, 01),
(04, 02),
(04, 05),
(04, 09);

-- --------------------------------------------------------

--
-- Estrutura da tabela `empleados`
--

DROP TABLE IF EXISTS `empleados`;
CREATE TABLE IF NOT EXISTS `empleados` (
  `ID_EMPLEADO` int unsigned  NOT NULL auto_increment,
  `NIF` char(9) NOT NULL,
  `NSS` char(20) NOT NULL,
  `NOMBRE` varchar(50) NOT NULL,
  `DIRECCION` varchar(50) NOT NULL,
  `SALARIO` float NOT NULL,
  `SEXO` enum('V','H') NOT NULL default 'V',
  `FECHA_NAC` date NOT NULL,
  `DEPARTAMENTO` int unsigned  NOT NULL,
  `SUPERVISOR` int unsigned  default NULL,
  PRIMARY KEY  (`ID_EMPLEADO`),
  UNIQUE KEY `AK_NSS` (`NSS`),
  UNIQUE KEY `AK_NIF` (`NIF`),
  KEY `FK_DEPARTAMENTO_PERTENECE` (`DEPARTAMENTO`),
  KEY `FK_SUPERVISOR` (`SUPERVISOR`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=22 ;

--
-- Extraindo datos da tabela `empleados`
--

INSERT INTO `empleados` (`ID_EMPLEADO`, `NIF`, `NSS`, `NOMBRE`, `DIRECCION`, `SALARIO`, `SEXO`, `FECHA_NAC`, `DEPARTAMENTO`, `SUPERVISOR`) VALUES
(001, '111111111', '123456567891111', 'PEPE FERNANDEZ', 'AVDA DE ARTEIXO 123', 1200, 'V', '2017-12-04', 01, NULL),
(002, '22222222', '22222222256789012', 'FERNANDO GOMEZ', 'CAMELIAS 34', 13450, 'V', '2017-12-04', 02, NULL),
(003, '33333333', '134563333333', 'ELENA PEREZ', 'AVDA DE ARTEIXO 123', 1345, 'H', '2017-12-04', 03, NULL),
(004, '44444444', '34567899999', 'JUANA GOMEZ', 'AVDA DE ARTEIXO 123', 1234, 'H', '2017-12-04', 04, NULL),
(005, '5454515', '545154', 'MARCOS FERNÁNDEZ GONDA', 'RUA DO TEXO 12', 1900, 'V', '2017-12-04', 02, NULL),
(007, '1515415', '1541515151', 'FELIPE FRAGA FRAGA', 'AVDA PEINADOR 32', 1678, 'V', '2017-12-05', 01, 005),
(008, '52525252', '57878', 'JUAN PEREZ PEREZ', 'CAMELIAS 25 ', 1000, 'V', '2017-12-05', 01, 005),
(009, '991234567', '0991234567', 'FERNADO ARBONES GONZALEZ', 'CASTRELOS NUEVO 56', 2000, 'V', '1993-01-09', 01, 005),
(010, '981234567', '0981234567', 'MARIA DOLORES FERNANDEZ PEREZ', 'PRINCIPE 19', 2000, 'H', '1999-03-09', 03, 005),
(011, '971234567', '0971234567', 'JUAN DOMINGO GARCIA LOPEZ', 'CASTRELOS 15', 1500, 'V', '1998-05-04', 04, NULL),
(012, '96456789', '0961234567', 'PABLO DOPICO DOPICO', 'AVDA CASTELAO', 1800, 'V', '1995-03-08', 04, 007),
(013, '951234567', '09512345678', 'ELENA NUÑEZ FERNANDEZ', 'CAMINO DEL COUTO', 2300, 'H', '1999-08-03', 04, 007),
(014, '891234567', '08956789', 'JUANA INES DOVAL', 'CASTELAO 34', 1600, 'H', '1993-02-10', 04, 007),
(015, '871234567', '087324567', 'DAVID LEMA GOMEZ', 'SAMIL 78', 1780, 'V', '1994-07-02', 02, 005),
(016, '861234567', '0865432189', 'ENRIQUE CASTRO GOMEZ', 'PEINCIPE 56', 1800, 'V', '1994-01-05', 03, 007),
(017, '851234567', '0856789522', 'MERCEDES POSE RECAREY', 'INES DE CASTRO 23', 1290, 'H', '1993-01-05', 02, NULL),
(018, '823456789', '0824444444', 'TERESA LOPEZ GAGO', 'CASTRELOS NUEVO 56', 1345, 'H', '1993-01-09', 02, NULL),
(019, '811234567', '081555555', 'DIEGO JUSTO FERNANDEZ', 'PLAZA DE LUGO 19', 2000, 'V', '1994-05-09', 04, NULL),
(020, '781234567', '0786666666', 'FRANCISCO ARUFE REY', 'AVDA DE ARTEIXO 19', 1345, 'V', '1995-03-08', 02, 009),
(021, '771234567', '0771111114', 'JOAQUIN DAVILA PEREZ', 'CAMELIAS 12', 1560, 'V', '1996-10-06', 02, 009);

-- --------------------------------------------------------

--
-- Estrutura da tabela `empleados_proyectos`
--

DROP TABLE IF EXISTS `empleados_proyectos`;
CREATE TABLE IF NOT EXISTS `empleados_proyectos` (
  `EMPLEADO` int unsigned  NOT NULL,
  `PROYECTO` int unsigned  NOT NULL,
  `FECHA_INICIO` date NOT NULL,
  `NUM_HORAS` int(3) NOT NULL,
  PRIMARY KEY  (`EMPLEADO`,`PROYECTO`),
  KEY `FK3_EMPLEADO` (`EMPLEADO`),
  KEY `FK4_PROYECTO` (`PROYECTO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo datos da tabela `empleados_proyectos`
--

INSERT INTO `empleados_proyectos` (`EMPLEADO`, `PROYECTO`, `FECHA_INICIO`, `NUM_HORAS`) VALUES
(003, 001, '2017-01-01', 100),
(003, 002, '2017-12-05', 77),
(003, 005, '2017-01-01', 26),
(003, 008, '2017-05-01', 200),
(004, 002, '2017-12-12', 20),
(004, 003, '2017-07-12', 23),
(004, 006, '2017-11-12', 100),
(004, 007, '2017-12-02', 25),
(005, 001, '2017-12-04', 20),
(005, 002, '2017-12-06', 1),
(008, 001, '2017-12-05', 45),
(009, 008, '2017-12-02', 46),
(011, 003, '2017-07-12', 100),
(011, 005, '2017-05-01', 45),
(012, 008, '2017-01-01', 23),
(013, 003, '2017-07-12', 19),
(014, 005, '2017-01-01', 23),
(015, 007, '2017-12-08', 120),
(016, 004, '2017-07-12', 123),
(016, 007, '2017-12-02', 150),
(017, 006, '2017-07-12', 300),
(017, 008, '2017-12-08', 100),
(018, 001, '2017-01-01', 26),
(018, 003, '2017-01-01', 15),
(018, 005, '2017-07-12', 36),
(020, 001, '2017-01-01', 30),
(020, 003, '2017-01-01', 25),
(020, 007, '2017-12-08', 50),
(021, 004, '2017-07-12', 34);

-- --------------------------------------------------------

--
-- Estrutura da tabela `familiares`
--

DROP TABLE IF EXISTS `familiares`;
CREATE TABLE IF NOT EXISTS `familiares` (
  `ID_FAMILIAR` int NOT NULL,
  `NIF` char(9) NOT NULL,
  `NOMBRE` varchar(50) NOT NULL,
  `SEXO` enum('V','H') NOT NULL,
  `FECHA_NAC` date NOT NULL,
  `PARENTESCO` enum('HIJA','HIJO','PADRE','MADRE') NOT NULL,
  `EMPLEADO` int unsigned  NOT NULL,
  PRIMARY KEY  (`ID_FAMILIAR`),
  KEY `FK_EMPLEADO_CON_FAMILIAR` (`EMPLEADO`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo datos da tabela `familiares`
--

INSERT INTO `familiares` (`ID_FAMILIAR`, `NIF`, `NOMBRE`, `SEXO`, `FECHA_NAC`, `PARENTESCO`, `EMPLEADO`) VALUES
(0, '621234567', 'DAVID LEMAPEREZ', 'V', '2000-02-02', 'HIJO', 021),
(1, '66123456', 'ELENA FRANCO PEREZ', 'H', '2000-02-02', 'HIJA', 018),
(2, '65123456', 'JUAN FRANCO PEREZ', 'V', '2003-06-06', 'HIJO', 018),
(3, '591234567', 'GLORIA DOVAL GOMEZ', 'H', '1999-03-19', 'MADRE', 004),
(4, '581234567', 'DAVID LEMA GONZALEZ', 'V', '2004-08-09', 'HIJO', 003);

-- --------------------------------------------------------

--
-- Estrutura da tabela `proyectos`
--

DROP TABLE IF EXISTS `proyectos`;
CREATE TABLE IF NOT EXISTS `proyectos` (
  `ID_PROYECTO` int unsigned  NOT NULL auto_increment,
  `NOMBRE` varchar(25) NOT NULL,
  `DEPARTAMENTO` int unsigned  NOT NULL,
  PRIMARY KEY  (`ID_PROYECTO`),
  UNIQUE KEY `AK_NOMBRE_PROYECTO` (`NOMBRE`),
  KEY `FK_DEPARTAMENTO_LANZA` (`DEPARTAMENTO`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Extraindo datos da tabela `proyectos`
--

INSERT INTO `proyectos` (`ID_PROYECTO`, `NOMBRE`, `DEPARTAMENTO`) VALUES
(001, 'PROYECTO A', 01),
(002, 'PROYECTO B', 02),
(003, 'PROYECTO C', 02),
(004, 'PROYECTO D', 03),
(005, 'PROYECTO E', 04),
(006, 'PROYECTO AAA-1', 04),
(007, 'PROYECTO XX-2', 03),
(008, 'PROYECTO JJ-3', 02);

-- --------------------------------------------------------

--
-- Estrutura da tabela `sedes`
--

DROP TABLE IF EXISTS `sedes`;
CREATE TABLE IF NOT EXISTS `sedes` (
  `ID_SEDE` int unsigned  NOT NULL auto_increment,
  `DIRECCION` varchar(40) NOT NULL,
  `LOCALIDAD` varchar(40) NOT NULL,
  `PROVINCIA` enum('PONTEVEDRA','CORUÑA','LUGO','OURENSE') NOT NULL default 'PONTEVEDRA',
  `SUPERFICIE` float NOT NULL default '100',
  PRIMARY KEY  (`ID_SEDE`),
  KEY `BUSQ_PROVICIA` (`PROVINCIA`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=11 ;

--
-- Extraindo datos da tabela `sedes`
--

INSERT INTO `sedes` (`ID_SEDE`, `DIRECCION`, `LOCALIDAD`, `PROVINCIA`, `SUPERFICIE`) VALUES
(01, 'GRAN VIA 19', 'VIGO', 'PONTEVEDRA', 500),
(02, 'CASTRELOS 34', 'VIGO', 'PONTEVEDRA', 300),
(03, 'PLAZA DEL PRINCIPE', 'LUGO', 'LUGO', 100),
(04, 'AVDA DE VIGO 102', 'MONFORTE', 'LUGO', 300),
(05, 'AVDA DE ARTEIXO', 'CORUÑA', 'CORUÑA', 400),
(06, 'AVDA DE LUGO 23', 'SANTIAGO DE COMPOSTELA', 'CORUÑA', 100),
(07, 'PLAZA DE COMPOSTELA', 'LUGO', 'LUGO', 450),
(08, 'PLAZA CENTRAL 5 ', 'OURENSE', 'OURENSE', 1000),
(09, 'CASTRELOS NUEVO 56', 'VERIN', 'OURENSE', 300),
(10, 'CAMINO DEL COUTO', 'BETANZOS', 'CORUÑA', 100);

-- --------------------------------------------------------

--
-- Estrutura da tabela `telefonos_sedes`
--

DROP TABLE IF EXISTS `telefonos_sedes`;
CREATE TABLE IF NOT EXISTS `telefonos_sedes` (
  `SEDE` int unsigned  NOT NULL,
  `TELEFONO` varchar(15) NOT NULL,
  PRIMARY KEY  (`SEDE`,`TELEFONO`),
  KEY `FK_SEDE` (`SEDE`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Extraindo datos da tabela `telefonos_sedes`
--

INSERT INTO `telefonos_sedes` (`SEDE`, `TELEFONO`) VALUES
(01, '654123456'),
(01, '986343434'),
(01, '986345678'),
(01, '986777777'),
(02, '661234589'),
(02, '986456789'),
(03, '776542311'),
(03, '981234567'),
(04, '234567890'),
(04, '564123455'),
(04, '988234567'),
(05, '765123400'),
(06, '786123456'),
(07, '666541234'),
(08, '897654321'),
(08, '987563421'),
(09, '345678900'),
(09, '666111111'),
(10, '456789011');

ALTER TABLE `departamentos`
  
    ADD FOREIGN KEY (`DIRECTOR`) REFERENCES `empleados` (`ID_EMPLEADO`) 
                            ON DELETE RESTRICT
                            ON UPDATE CASCADE;
ALTER TABLE `departamentos_sedes`
  ADD 
     FOREIGN KEY (`DEPARTAMENTO`) REFERENCES `departamentos` (`NUMERO`)
           ON DELETE CASCADE ON UPDATE CASCADE,
  ADD 
         FOREIGN KEY (`SEDE`) REFERENCES `sedes` (`ID_SEDE`) 
          ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `empleados`
  ADD 
     FOREIGN KEY (`DEPARTAMENTO`) REFERENCES `departamentos` (`NUMERO`) 
               ON DELETE RESTRICT
               ON UPDATE CASCADE,
  ADD 
      FOREIGN KEY (`SUPERVISOR`) REFERENCES `empleados` (`ID_EMPLEADO`) 
            ON DELETE SET NULL 
            ON UPDATE CASCADE;
ALTER TABLE `empleados_proyectos`
  ADD 
     FOREIGN KEY (`EMPLEADO`) REFERENCES `empleados` (`ID_EMPLEADO`) 
           ON DELETE CASCADE ON UPDATE CASCADE,
  ADD 
     FOREIGN KEY (`PROYECTO`) REFERENCES `proyectos` (ID_PROYECTO ) 
      ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `familiares`
  ADD 
     FOREIGN KEY (`EMPLEADO`) REFERENCES `empleados` (`ID_EMPLEADO`)
          ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE `proyectos`
  ADD  
    FOREIGN KEY (`DEPARTAMENTO`) REFERENCES `departamentos` (`NUMERO`) 
         ON DELETE RESTRICT
         ON UPDATE CASCADE;
ALTER TABLE `telefonos_sedes`
  ADD  
     FOREIGN KEY (`SEDE`) REFERENCES `sedes` (`ID_SEDE`) 
           ON DELETE CASCADE ON UPDATE CASCADE;
           
           
/*********************** CAMBIOS DISEÑADOS POSTERIORMENTE           ************************
**********************************************************************************************************/
ALTER TABLE EMPLEADOS_PROYECTOS
   ADD COLUMN PRECIO_HORA FLOAT NOT NULL DEFAULT 100.0;
   
   /*************************************/
   
  ALTER TABLE PROYECTOS
    ADD COLUMN FECHA_INICIO DATE NOT NULL,
    ADD COLUMN FECHA_PREV_FIN DATE NOT NULL,
    ADD COLUMN PRESUPUESTO INTEGER NOT NULL;
    
    
    /*** VALORES  PARA LAS NUEVAS COLUMNAS DE LA TABLAPROYECTOS *******************/
    
UPDATE `empresa`.`PROYECTOS` SET `FECHA_INICIO` = '2021-01-12', `FECHA_PREV_FIN` = '2021-12-30', `PRESUPUESTO` = '1000000' WHERE (`ID_PROYECTO` = '1');
UPDATE `empresa`.`PROYECTOS` SET `FECHA_INICIO` = '2021-01-12', `FECHA_PREV_FIN` = '2021-12-30', `PRESUPUESTO` = '256000' WHERE (`ID_PROYECTO` = '4');
UPDATE `empresa`.`PROYECTOS` SET `FECHA_INICIO` = '2021-01-12', `FECHA_PREV_FIN` = '2021-12-30', `PRESUPUESTO` = '345000' WHERE (`ID_PROYECTO` = '7');
UPDATE `empresa`.`PROYECTOS` SET `FECHA_INICIO` = '2021-01-12', `FECHA_PREV_FIN` = '2022-11-13', `PRESUPUESTO` = '1000000' WHERE (`ID_PROYECTO` = '8');
UPDATE `empresa`.`PROYECTOS` SET `FECHA_INICIO` = '2021-01-05', `FECHA_PREV_FIN` = '2022-11-13', `PRESUPUESTO` = '650000' WHERE (`ID_PROYECTO` = '2');
UPDATE `empresa`.`PROYECTOS` SET `FECHA_INICIO` = '2021-01-05', `FECHA_PREV_FIN` = '2021-12-30', `PRESUPUESTO` = '1000000' WHERE (`ID_PROYECTO` = '6');
UPDATE `empresa`.`PROYECTOS` SET `FECHA_INICIO` = '2021-01-05', `FECHA_PREV_FIN` = '2022-11-13', `PRESUPUESTO` = '123000' WHERE (`ID_PROYECTO` = '3');
UPDATE `empresa`.`PROYECTOS` SET `FECHA_INICIO` = '2020-12-03', `FECHA_PREV_FIN` = '2022-11-13', `PRESUPUESTO` = '650000' WHERE (`ID_PROYECTO` = '5');
   
   /*** AÑADIMOS POSTERIORMENTE RELACIÓN PROYECTO TIENE TUTOR************************/ 
   
    ALTER TABLE PROYECTOS       
           ADD COLUMN  TUTOR INT  UNSIGNED  NOT NULL,
           ADD COLUMN FECHA_TUTOR DATE NOT NULL,    
           ADD INDEX FK_TUTOR_PROYECTO (TUTOR); 


     UPDATE  PROYECTOS AS P

       SET P.TUTOR=(
                                      SELECT DIRECTOR
                                       FROM DEPARTAMENTOS 
                                       WHERE NUMERO=P.DEPARTAMENTO
                                  ),  /*DATO EN UPDATE CON SUBCONSULTA CORRELACIONADA*/
           P.FECHA_TUTOR= CURRENT_DATE();
           
           
   /** TAMBIÉN ESTE UPDATE SE PUEDE OBTENER ASÍ  **/
   
/*********************   UPDATE PROYECTOS AS P INNER JOIN DEPARTAMENTOS AS D
                                                                                       ON P.DEPARTAMENTO=D.NUMERO
                                      SET P.TUTOR=D.DIRECTOR,
                                       P.FECHA_TUTOR=CURRENT_DATE();
                       ***************************************************************************************************/                

/**  POR FIN , TERMINO DE DEFINIR BIEN  LA COLUMNA  TUTOR, LE IMPONGO LA RESTRICCIÓN QUE FALTA
    POR DEFINIR **/ 
     ALTER TABLE PROYECTOS
         ADD FOREIGN KEY (TUTOR) REFERENCES EMPLEADOS(ID_EMPLEADO)
                  ON DELETE RESTRICT
                  ON UPDATE CASCADE,
          ADD INDEX FK_TUTOR_DE_PROYECTO(TUTOR);


