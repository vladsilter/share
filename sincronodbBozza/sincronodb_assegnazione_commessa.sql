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
-- Table structure for table `assegnazione_commessa`
--

DROP TABLE IF EXISTS `assegnazione_commessa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `assegnazione_commessa` (
  `id_assegnazione_commessa` int(11) NOT NULL AUTO_INCREMENT,
  `id_dip_pm` int(11) DEFAULT NULL,
  `id_commessa` int(11) DEFAULT NULL,
  `costo` float DEFAULT NULL,
  `prezzo` float DEFAULT NULL,
  PRIMARY KEY (`id_assegnazione_commessa`),
  KEY `id_commessa_idx` (`id_commessa`),
  KEY `id_dip_pm_idx` (`id_dip_pm`),
  CONSTRAINT `id_commessa` FOREIGN KEY (`id_commessa`) REFERENCES `commesse` (`id_commesse`),
  CONSTRAINT `id_dip_pm` FOREIGN KEY (`id_dip_pm`) REFERENCES `dipendente` (`id_dipendente`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `assegnazione_commessa`
--

LOCK TABLES `assegnazione_commessa` WRITE;
/*!40000 ALTER TABLE `assegnazione_commessa` DISABLE KEYS */;
INSERT INTO `assegnazione_commessa` VALUES (1,1,1,100,140),(2,1,2,110,180),(3,1,3,80,240),(4,1,4,150,240);
/*!40000 ALTER TABLE `assegnazione_commessa` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-03-07 13:37:32
