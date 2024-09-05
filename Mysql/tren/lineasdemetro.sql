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
-- Table `BD_LINEAS_METRO_2`.`Empleados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_LINEAS_METRO_2`.`Empleados` (
  `dni` CHAR(9) NOT NULL,
  `nss` CHAR(15) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `estado_civil` VARCHAR(45) NOT NULL,
  `fecha_alta` DATE NOT NULL,
  `salario` FLOAT UNSIGNED NOT NULL,
  `Estaciones_id_estacion` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`dni`),
  UNIQUE INDEX `AK_DNI` (`dni` ASC) VISIBLE,
  UNIQUE INDEX `AK_NSS` (`nss` ASC) VISIBLE,
  INDEX `fk_Empleados_Estaciones1_idx` (`Estaciones_id_estacion` ASC) VISIBLE,
  CONSTRAINT `fk_Empleados_Estaciones1`
    FOREIGN KEY (`Estaciones_id_estacion`)
    REFERENCES `BD_LINEAS_METRO_2`.`Estaciones` (`id_estacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_LINEAS_METRO_2`.`JEFES`
-- -----------------------------------------------------
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
-- Table `BD_LINEAS_METRO_2`.`Estaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_LINEAS_METRO_2`.`Estaciones` (
  `id_estacion` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `superficie` FLOAT UNSIGNED NOT NULL,
  `num_andenes` INT UNSIGNED NOT NULL,
  `JEFES_DNI` CHAR(9) NOT NULL,
  PRIMARY KEY (`id_estacion`),
  INDEX `fk_Estaciones_JEFES1_idx` (`JEFES_DNI` ASC) VISIBLE,
  CONSTRAINT `fk_Estaciones_JEFES1`
    FOREIGN KEY (`JEFES_DNI`)
    REFERENCES `BD_LINEAS_METRO_2`.`JEFES` (`DNI`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_LINEAS_METRO_2`.`Lineas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_LINEAS_METRO_2`.`Lineas` (
  `id_linea` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `color` VARCHAR(10) NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `distancia_recorrido` INT UNSIGNED NOT NULL,
  `fecha_inaguracion` VARCHAR(45) NULL,
  `Estaciones_id_estacion` INT UNSIGNED NOT NULL,
  UNIQUE INDEX `Ak_Color` (`color` ASC) VISIBLE,
  PRIMARY KEY (`id_linea`),
  UNIQUE INDEX `ak_nombre` (`nombre` ASC) VISIBLE,
  INDEX `fk_Lineas_Estaciones1_idx` (`Estaciones_id_estacion` ASC) VISIBLE,
  CONSTRAINT `fk_Lineas_Estaciones1`
    FOREIGN KEY (`Estaciones_id_estacion`)
    REFERENCES `BD_LINEAS_METRO_2`.`Estaciones` (`id_estacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_LINEAS_METRO_2`.`Trenes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_LINEAS_METRO_2`.`Trenes` (
  `numero` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `modelo` VARCHAR(45) NOT NULL,
  `fecha_servicio` DATE NOT NULL,
  `estado` ENUM("activo", "en reparacion") NOT NULL DEFAULT 'activo',
  `num_vagones` INT UNSIGNED NOT NULL,
  `num_pasajeros` INT UNSIGNED NOT NULL,
  `Trenes_numero` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`numero`),
  INDEX `fk_Trenes_Trenes1_idx` (`Trenes_numero` ASC) VISIBLE,
  CONSTRAINT `fk_Trenes_Trenes1`
    FOREIGN KEY (`Trenes_numero`)
    REFERENCES `BD_LINEAS_METRO_2`.`Trenes` (`numero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_LINEAS_METRO_2`.`Puertas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_LINEAS_METRO_2`.`Puertas` (
  `numero_puerta` INT UNSIGNED NOT NULL,
  `calle` VARCHAR(20) NOT NULL,
  `superficie` FLOAT NOT NULL DEFAULT 100.0,
  `Estaciones_id_estacion` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`numero_puerta`, `Estaciones_id_estacion`),
  INDEX `fk_Puertas_Estaciones1_idx` (`Estaciones_id_estacion` ASC) VISIBLE,
  CONSTRAINT `fk_Puertas_Estaciones1`
    FOREIGN KEY (`Estaciones_id_estacion`)
    REFERENCES `BD_LINEAS_METRO_2`.`Estaciones` (`id_estacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_LINEAS_METRO_2`.`Maquinistas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_LINEAS_METRO_2`.`Maquinistas` (
  `dni` CHAR(9) NOT NULL,
  `turno` ENUM('mañana', 'tarde', 'noche') NOT NULL DEFAULT 'mañana',
  `Trenes_numero` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`dni`),
  INDEX `fk_Maquinistas_Trenes1_idx` (`Trenes_numero` ASC) VISIBLE,
  CONSTRAINT `fk_table1_Empleados1`
    FOREIGN KEY (`dni`)
    REFERENCES `BD_LINEAS_METRO_2`.`Empleados` (`dni`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Maquinistas_Trenes1`
    FOREIGN KEY (`Trenes_numero`)
    REFERENCES `BD_LINEAS_METRO_2`.`Trenes` (`numero`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `BD_LINEAS_METRO_2`.`Estaciones_has_Lineas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `BD_LINEAS_METRO_2`.`Estaciones_has_Lineas` (
  `Estaciones_id_estacion` INT UNSIGNED NOT NULL,
  `Lineas_id_linea` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`Estaciones_id_estacion`, `Lineas_id_linea`),
  INDEX `fk_Estaciones_has_Lineas_Lineas1_idx` (`Lineas_id_linea` ASC) VISIBLE,
  INDEX `fk_Estaciones_has_Lineas_Estaciones1_idx` (`Estaciones_id_estacion` ASC) VISIBLE,
  CONSTRAINT `fk_Estaciones_has_Lineas_Estaciones1`
    FOREIGN KEY (`Estaciones_id_estacion`)
    REFERENCES `BD_LINEAS_METRO_2`.`Estaciones` (`id_estacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Estaciones_has_Lineas_Lineas1`
    FOREIGN KEY (`Lineas_id_linea`)
    REFERENCES `BD_LINEAS_METRO_2`.`Lineas` (`id_linea`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
