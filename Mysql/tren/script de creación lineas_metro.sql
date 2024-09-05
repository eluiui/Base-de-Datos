-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`LINEAS`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`LINEAS` ;

CREATE TABLE IF NOT EXISTS `mydb`.`LINEAS` (
  `ID_LINEA` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `NOMBRE` VARCHAR(50) NOT NULL,
  `TAMNHO` INT NOT NULL DEFAULT 1200,
  `COLOR` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID_LINEA`),
  UNIQUE INDEX `AK_NOMBRE` (`NOMBRE` ASC) VISIBLE,
  UNIQUE INDEX `AK_COLOR` (`COLOR` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TRENES`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydb`.`TRENES` ;

CREATE TABLE IF NOT EXISTS `mydb`.`TRENES` (
  `ID_TREN` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `FECHA_ENTRADA` DATE NOT NULL,
  `ESTADO` ENUM('ACTIVO', 'REPARACIÓN') NOT NULL,
  `NUM_VAGONESl` INT NOT NULL DEFAULT 10,
  `CAPACIDAD` INT NULL,
  `LINEA` INT UNSIGNED NULL,
  PRIMARY KEY (`ID_TREN`),
  INDEX `fk_TRENES_LINEAS_idx` (`LINEA` ASC) INVISIBLE,
  CONSTRAINT `fk_TRENES_LINEAS`
    FOREIGN KEY (`LINEA`)
    REFERENCES `mydb`.`LINEAS` (`ID_LINEA`)
    ON DELETE SET NULL
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
