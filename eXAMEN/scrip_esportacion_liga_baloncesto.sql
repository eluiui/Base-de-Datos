-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: liga_baloncesto
-- ------------------------------------------------------
-- Server version	8.0.31

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `equipo`
--

DROP TABLE IF EXISTS `equipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipo` (
  `ID_EQUIPO` int unsigned NOT NULL AUTO_INCREMENT,
  `NOMBRE_EQUIPO` varchar(15) NOT NULL,
  `NOMBRE_ENTRENADOR` varchar(55) DEFAULT NULL,
  `NOMBRE_CANCHA` varchar(30) NOT NULL,
  `POBLACION` varchar(25) NOT NULL,
  `AÑO_FUNDACION` year DEFAULT NULL,
  `CAPITAN` int unsigned NOT NULL,
  PRIMARY KEY (`ID_EQUIPO`),
  UNIQUE KEY `NOMBRE_EQUIPO_UNIQUE` (`NOMBRE_EQUIPO`),
  UNIQUE KEY `NOMBRE_CANCHA_UNIQUE` (`NOMBRE_CANCHA`),
  KEY `FK_CAPITAN` (`CAPITAN`),
  CONSTRAINT `FK_CAPITAN` FOREIGN KEY (`CAPITAN`) REFERENCES `jugador` (`ID_JUGADOR`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipo`
--

LOCK TABLES `equipo` WRITE;
/*!40000 ALTER TABLE `equipo` DISABLE KEYS */;
INSERT INTO `equipo` VALUES (1,'Madrid','anxo mar mar','bernaveu','madrid',1999,1),(2,'Barsa','diego mar mar','camp nou','barcelona',1999,2),(3,'Celta','jesus mar mar','balaidos','vigo',1999,3);
/*!40000 ALTER TABLE `equipo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jugador`
--

DROP TABLE IF EXISTS `jugador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `jugador` (
  `ID_JUGADOR` int unsigned NOT NULL AUTO_INCREMENT,
  `DNI` varchar(9) NOT NULL,
  `NOMBRE_APELLIDOS` varchar(30) NOT NULL,
  `NACIONALIDAD` enum('ESPAÑOLA','INGLESA','YUGOSLAVA','AMERICANA','JAMAICANA') DEFAULT NULL,
  `DORSAL` int DEFAULT NULL,
  `EQUIPO` int unsigned DEFAULT NULL,
  PRIMARY KEY (`ID_JUGADOR`),
  UNIQUE KEY `DNI_UNIQUE` (`DNI`),
  UNIQUE KEY `DORSAL` (`DORSAL`,`ID_JUGADOR`),
  KEY `FK_EQUIPO_FICHADO` (`EQUIPO`),
  CONSTRAINT `FK_EQUIPO_FICHADO` FOREIGN KEY (`EQUIPO`) REFERENCES `equipo` (`ID_EQUIPO`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jugador`
--

LOCK TABLES `jugador` WRITE;
/*!40000 ALTER TABLE `jugador` DISABLE KEYS */;
INSERT INTO `jugador` VALUES (1,'0000000a1','jose perez perez','ESPAÑOLA',1,1),(2,'0000000a2','anxo perez perez','ESPAÑOLA',2,2),(3,'0000000a3','diego perez perez','INGLESA',3,3),(4,'0000000a4','jesus perez perez','INGLESA',4,1),(5,'0000000a5','Brais perez perez','ESPAÑOLA',5,2),(6,'0000000a6','javier perez perez','INGLESA',6,3);
/*!40000 ALTER TABLE `jugador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `partidos`
--

DROP TABLE IF EXISTS `partidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `partidos` (
  `ID_PARTIDO` int unsigned NOT NULL AUTO_INCREMENT,
  `EQUIPO_LOCAL` int unsigned NOT NULL,
  `EQUIPO_VISITANTE` int unsigned NOT NULL,
  `FECHA_PARTIDO` date DEFAULT NULL,
  `PUNTOS_LOCAL` int unsigned NOT NULL DEFAULT '0',
  `PUNTOS_VISITANTE` int unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID_PARTIDO`),
  UNIQUE KEY `PARTIDO_UNICO` (`EQUIPO_LOCAL`,`EQUIPO_VISITANTE`),
  KEY `FK_EQUIPO_VISITANTE` (`EQUIPO_VISITANTE`),
  KEY `FK_EQUIPO_LOCAL` (`EQUIPO_LOCAL`),
  CONSTRAINT `FK_EQUIPO_LOCAL` FOREIGN KEY (`EQUIPO_LOCAL`) REFERENCES `equipo` (`ID_EQUIPO`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `FK_EQUIPO_VISITANTE` FOREIGN KEY (`EQUIPO_VISITANTE`) REFERENCES `equipo` (`ID_EQUIPO`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `partidos`
--

LOCK TABLES `partidos` WRITE;
/*!40000 ALTER TABLE `partidos` DISABLE KEYS */;
/*!40000 ALTER TABLE `partidos` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-01-17 11:29:54
