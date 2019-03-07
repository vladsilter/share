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
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `assegnazione_commessa_BEFORE_INSERT` BEFORE INSERT ON `assegnazione_commessa` FOR EACH ROW BEGIN
	declare dr INT(11);
    select distinct id_ruolo into dr from sincronodb.dipendente where new.id_dip_pm = id_dipendente and id_ruolo = 1;
	IF dr = 1 THEN
			insert into sincronodb.assegnazione_commessa (id_dip_pm, id_commessa, costo, prezzo) values(new.id_dip_pm, new.id_commessa, new.costo, new.prezzo);
	END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `cespite`
--

DROP TABLE IF EXISTS `cespite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `cespite` (
  `id_cespite` int(11) NOT NULL AUTO_INCREMENT,
  `descrizione` varchar(45) DEFAULT NULL,
  `stato` enum('Assegnato','Non Assegnato','Dismesso','Difettato') DEFAULT NULL,
  `tipologia` enum('Arredamento','Elettronica') DEFAULT NULL,
  PRIMARY KEY (`id_cespite`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cespite`
--

LOCK TABLES `cespite` WRITE;
/*!40000 ALTER TABLE `cespite` DISABLE KEYS */;
INSERT INTO `cespite` VALUES (6,'tavolo','Assegnato','Arredamento'),(7,'computer','Assegnato','Elettronica'),(8,'tv','Dismesso','Elettronica'),(9,'sedia','Non Assegnato','Arredamento');
/*!40000 ALTER TABLE `cespite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `cliente` (
  `id_cliente` int(11) NOT NULL AUTO_INCREMENT,
  `ragione_sociale` varchar(45) DEFAULT NULL,
  `cf_piva` varchar(45) DEFAULT NULL,
  `stato` enum('attivo','in attesa','inattivo','sospeso') DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `telefono` int(10) DEFAULT NULL,
  `indirizzo` varchar(45) DEFAULT NULL,
  `categoria` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE KEY `ragione_sociale_UNIQUE` (`ragione_sociale`),
  UNIQUE KEY `cf_piva_UNIQUE` (`cf_piva`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'NTT Data','d939mi2923im29','attivo','nttdata@gmail.com',34091144,'via s.evaristo 167','informatica'),(2,'Fiat','a129vr29273m29','in attesa','fiat@gmail.com',34064311,'via dei pini 1','automobili'),(3,'DELL','w129cd5921vb26','sospeso','dell@gmail.com',32187311,'via rossi 2','informatica'),(4,'Armani','v721ls5923xc30','inattivo','armani@gmail.com',31237723,'via vlad 4','abbigliamento');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `commesse`
--

DROP TABLE IF EXISTS `commesse`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `commesse` (
  `id_commesse` int(11) NOT NULL AUTO_INCREMENT,
  `id_cliente` int(11) NOT NULL,
  `titolo_progetto` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`id_commesse`),
  KEY `id_cliente_idx` (`id_cliente`),
  CONSTRAINT `id_cliente` FOREIGN KEY (`id_cliente`) REFERENCES `cliente` (`id_cliente`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `commesse`
--

LOCK TABLES `commesse` WRITE;
/*!40000 ALTER TABLE `commesse` DISABLE KEYS */;
INSERT INTO `commesse` VALUES (1,1,'talent camp'),(2,2,'motor train'),(3,3,'pc group'),(4,4,'eShirt');
/*!40000 ALTER TABLE `commesse` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cv`
--

DROP TABLE IF EXISTS `cv`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `cv` (
  `id_cv` int(11) NOT NULL AUTO_INCREMENT,
  `cv_file` blob,
  PRIMARY KEY (`id_cv`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cv`
--

LOCK TABLES `cv` WRITE;
/*!40000 ALTER TABLE `cv` DISABLE KEYS */;
INSERT INTO `cv` VALUES (1,NULL),(2,NULL),(3,NULL),(4,NULL);
/*!40000 ALTER TABLE `cv` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `dipendente`
--

DROP TABLE IF EXISTS `dipendente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `dipendente` (
  `id_dipendente` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(45) DEFAULT NULL,
  `cognome` varchar(45) DEFAULT NULL,
  `cod_fiscale` varchar(45) DEFAULT NULL,
  `indirizzo` varchar(45) DEFAULT NULL,
  `email` varchar(45) DEFAULT NULL,
  `password` varchar(45) DEFAULT NULL,
  `data_inizio` date DEFAULT NULL,
  `data_fine` date DEFAULT NULL,
  `id_cv` int(11) DEFAULT NULL,
  `id_ruolo` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_dipendente`),
  UNIQUE KEY `cod_fiscale_UNIQUE` (`cod_fiscale`),
  KEY `id_ruolo_idx` (`id_ruolo`),
  KEY `id_cv_idx` (`id_cv`),
  CONSTRAINT `id_cv` FOREIGN KEY (`id_cv`) REFERENCES `cv` (`id_cv`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `id_ruolo` FOREIGN KEY (`id_ruolo`) REFERENCES `ruolo` (`id_ruolo`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `dipendente`
--

LOCK TABLES `dipendente` WRITE;
/*!40000 ALTER TABLE `dipendente` DISABLE KEYS */;
INSERT INTO `dipendente` VALUES (1,'alex','rusu','RLURGX7Q0SDJ','via mosca 10','alex.rusu@gmail.com','dxassda','2019-02-04',NULL,1,5),(2,'adriano','tartaglione','TARADR7Q4SSD','via mosca 12','adraino.tartaglione@gmail.com','dxasee4da','2019-02-04',NULL,2,1),(3,'vlad','silter','SILVLD1R4SFA','via mosca 14','vlad.silter@gmail.com','jhasrr8db','2019-02-04',NULL,3,2),(5,'kevin','hernandez','HRNKVN0S1ASC','via mosca 16','kevin.hernandez@gmail.com','dxasgg4da','2019-02-04',NULL,4,3);
/*!40000 ALTER TABLE `dipendente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `note`
--

DROP TABLE IF EXISTS `note`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `note` (
  `id_note` int(11) NOT NULL AUTO_INCREMENT,
  `id_dip_autore` int(11) DEFAULT NULL,
  `id_commessa_nota` int(11) DEFAULT NULL,
  `nota` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_note`),
  KEY `id_dip_autore_idx` (`id_dip_autore`),
  KEY `id_commessa_idx` (`id_commessa_nota`),
  CONSTRAINT `id_commessa_nota` FOREIGN KEY (`id_commessa_nota`) REFERENCES `commesse` (`id_commesse`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `id_dip_autore` FOREIGN KEY (`id_dip_autore`) REFERENCES `dipendente` (`id_dipendente`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `note`
--

LOCK TABLES `note` WRITE;
/*!40000 ALTER TABLE `note` DISABLE KEYS */;
/*!40000 ALTER TABLE `note` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `richiesta_recupero_psw`
--

DROP TABLE IF EXISTS `richiesta_recupero_psw`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `richiesta_recupero_psw` (
  `id_richiesta_recupero_psw` int(11) NOT NULL,
  `id_dipendente_psw` int(11) DEFAULT NULL,
  `stato` enum('da lavorare','respinta','accettata') DEFAULT NULL,
  PRIMARY KEY (`id_richiesta_recupero_psw`),
  KEY `id_dipendente_idx` (`id_dipendente_psw`),
  CONSTRAINT `id_dipendente_psw` FOREIGN KEY (`id_dipendente_psw`) REFERENCES `dipendente` (`id_dipendente`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `richiesta_recupero_psw`
--

LOCK TABLES `richiesta_recupero_psw` WRITE;
/*!40000 ALTER TABLE `richiesta_recupero_psw` DISABLE KEYS */;
/*!40000 ALTER TABLE `richiesta_recupero_psw` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ril`
--

DROP TABLE IF EXISTS `ril`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ril` (
  `id_ril` int(11) NOT NULL AUTO_INCREMENT,
  `id_dipendente` int(11) DEFAULT NULL,
  `id_commessa_ril` int(11) DEFAULT NULL,
  `n_ore` int(11) DEFAULT NULL,
  PRIMARY KEY (`id_ril`),
  KEY `id_commessa_idx` (`id_commessa_ril`),
  KEY `id_dipendente_idx` (`id_dipendente`),
  CONSTRAINT `id_commessa_ril` FOREIGN KEY (`id_commessa_ril`) REFERENCES `commesse` (`id_commesse`) ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `id_dipendente` FOREIGN KEY (`id_dipendente`) REFERENCES `dipendente` (`id_dipendente`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ril`
--

LOCK TABLES `ril` WRITE;
/*!40000 ALTER TABLE `ril` DISABLE KEYS */;
/*!40000 ALTER TABLE `ril` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ruolo`
--

DROP TABLE IF EXISTS `ruolo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `ruolo` (
  `id_ruolo` int(11) NOT NULL AUTO_INCREMENT,
  `titolo` enum('PM','DEV','Amministrativo','Commerciale','Admin') DEFAULT NULL,
  PRIMARY KEY (`id_ruolo`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ruolo`
--

LOCK TABLES `ruolo` WRITE;
/*!40000 ALTER TABLE `ruolo` DISABLE KEYS */;
INSERT INTO `ruolo` VALUES (1,'PM'),(2,'DEV'),(3,'Commerciale'),(4,'Amministrativo'),(5,'Admin');
/*!40000 ALTER TABLE `ruolo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `struttura`
--

DROP TABLE IF EXISTS `struttura`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
 SET character_set_client = utf8mb4 ;
CREATE TABLE `struttura` (
  `id_struttura` int(11) NOT NULL AUTO_INCREMENT,
  `descrizione` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id_struttura`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `struttura`
--

LOCK TABLES `struttura` WRITE;
/*!40000 ALTER TABLE `struttura` DISABLE KEYS */;
INSERT INTO `struttura` VALUES (1,'Sede dell amministrazione generale'),(2,'Sede direzione'),(3,'Sede esecutiva');
/*!40000 ALTER TABLE `struttura` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'sincronodb'
--

--
-- Dumping routines for database 'sincronodb'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2019-03-07 13:38:36
