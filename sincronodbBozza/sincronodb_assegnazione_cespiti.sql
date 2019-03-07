CREATE DATABASE  IF NOT EXISTS `sincronodb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */;
USE `sincronodb`;
-- MySQL dump 10.13  Distrib 8.0.15, for Win64 (x86_64)
--
-- Host: localhost    Database: sincronodb
-- ------------------------------------------------------
-- Server version	8.0.15

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
 SET NAMES utf8 ;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `assegnazione_cespiti`
--

DROP TABLE IF EXISTS `assegnazione_cespiti`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `assegnazione_cespiti` (
  `id_assegnazione_cespiti` int(11) NOT NULL AUTO_INCREMENT,
  `id_dip` int(11) DEFAULT NULL,
  `id_struct` int(11) DEFAULT NULL,
  `data_inizio` date DEFAULT NULL,
  `data_fine` date DEFAULT NULL,
  `id_cespite` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_assegnazione_cespiti`),
  KEY `id_dip_idx` (`id_dip`),
  KEY `id_struct_idx` (`id_struct`),
  CONSTRAINT `id_dip` FOREIGN KEY (`id_dip`) REFERENCES `dipendente` (`id_dipendente`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `id_struct` FOREIGN KEY (`id_struct`) REFERENCES `struttura` (`id_struttura`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assegnazione_cespiti`
--

LOCK TABLES `assegnazione_cespiti` WRITE;
/*!40000 ALTER TABLE `assegnazione_cespiti` DISABLE KEYS */;
INSERT INTO `assegnazione_cespiti` VALUES (1,1,NULL,'2019-02-04','2019-07-02',7),(2,3,NULL,'2019-02-04','2019-07-04',8),(3,NULL,1,'2019-02-04','2019-07-04',6),(4,NULL,3,'2019-02-04','2019-07-04',9);
/*!40000 ALTER TABLE `assegnazione_cespiti` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-03-07 13:37:31
