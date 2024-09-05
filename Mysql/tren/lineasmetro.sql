-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema BD_LINEAS_METRO_2
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema BD_LINEAS_METRO_2
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `BD_LINEAS_METRO_2` DEFAULT CHARACTER SET utf8 ;
USE `BD_LINEAS_METRO_2` ;

-- -----------------------------------------------------
-- Table `BD_LINEAS_METRO_2`.`Lineas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_LINEAS_METRO_2`.`Lineas`;
CREATE TABLE IF NOT EXISTS `BD_LINEAS_METRO_2`.`Lineas` (
  `id_linea` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `color` VARCHAR(10) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `distancia_recorrido` INT UNSIGNED NOT NULL,
  `fecha_inaguracion` VARCHAR(45) NULL,
  UNIQUE INDEX `Ak_Color` (`color` ASC) VISIBLE,
  PRIMARY KEY (`id_linea`),
  UNIQUE INDEX `ak_nombre` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_LINEAS_METRO_2`.`Trenes`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_LINEAS_METRO_2`.`Trenes`;
CREATE TABLE IF NOT EXISTS `BD_LINEAS_METRO_2`.`Trenes` (
  `numero` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `modelo` VARCHAR(45) NOT NULL,
  `fecha_servicio` DATE NOT NULL,
  `estado` ENUM("activo", "en reparacion") NOT NULL DEFAULT 'activo',
  `num_vagones` INT UNSIGNED NOT NULL,
  `num_pasajeros` INT UNSIGNED NOT NULL,
  `Lineas_id_linea` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`numero`),
  INDEX `fk_Trenes_Lineas1_idx` (`Lineas_id_linea` ASC) VISIBLE,
  CONSTRAINT `fk_Trenes_Lineas1`
    FOREIGN KEY (`Lineas_id_linea`)
    REFERENCES `BD_LINEAS_METRO_2`.`Lineas` (`id_linea`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_LINEAS_METRO_2`.`Estaciones`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_LINEAS_METRO_2`.`Estaciones`;
CREATE TABLE IF NOT EXISTS `BD_LINEAS_METRO_2`.`Estaciones` (
  `id_estacion` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `superficie` FLOAT UNSIGNED NOT NULL,
  `num_andenes` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`id_estacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_LINEAS_METRO_2`.`Empleados`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_LINEAS_METRO_2`.`Empleados` ;
CREATE TABLE IF NOT EXISTS `BD_LINEAS_METRO_2`.`Empleados` (
  `dni` CHAR(9) NOT NULL,
  `nss` CHAR(15) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `estado_civil` VARCHAR(45) NOT NULL,
  `fecha_alta` DATE NOT NULL,
  `salario` FLOAT UNSIGNED NOT NULL,
  PRIMARY KEY (`dni`),
  UNIQUE INDEX `AK_DNI` (`dni` ASC) VISIBLE,
  UNIQUE INDEX `AK_NSS` (`nss` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_LINEAS_METRO_2`.`Puertas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_LINEAS_METRO_2`.`Puertas` ;
CREATE TABLE IF NOT EXISTS `BD_LINEAS_METRO_2`.`Puertas` (
  `numero_puerta` INT UNSIGNED NOT NULL,
  `calle` VARCHAR(20) NOT NULL,
  `superficie` FLOAT NOT NULL DEFAULT 100.0,
  PRIMARY KEY (`numero_puerta`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_LINEAS_METRO_2`.`JEFES`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_LINEAS_METRO_2`.`JEFES` ;
CREATE TABLE IF NOT EXISTS `BD_LINEAS_METRO_2`.`JEFES` (
  `DNI` CHAR(9) NOT NULL,
  `PRIMA` FLOAT NOT NULL,
  `FECHA` DATE NOT NULL,
  PRIMARY KEY (`DNI`),
  CONSTRAINT `fk_JEFES_Empleados`
    FOREIGN KEY (`DNI`)
    REFERENCES `BD_LINEAS_METRO_2`.`Empleados` (`dni`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_LINEAS_METRO_2`.`Maquinistas`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `BD_LINEAS_METRO_2`.`Maquinistas`;
CREATE TABLE IF NOT EXISTS `BD_LINEAS_METRO_2`.`Maquinistas` (
  `dni` CHAR(9) NOT NULL,
  `turno` ENUM('mañana', 'tarde', 'noche') NOT NULL DEFAULT 'mañana',
  PRIMARY KEY (`dni`),
  CONSTRAINT `fk_table1_Empleados1`
    FOREIGN KEY (`dni`)
    REFERENCES `BD_LINEAS_METRO_2`.`Empleados` (`dni`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
