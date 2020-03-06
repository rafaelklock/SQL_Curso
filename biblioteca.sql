-- MySQL dump 10.13  Distrib 8.0.19, for Linux (x86_64)
--
-- Host: localhost    Database: Biblioteca
-- ------------------------------------------------------
-- Server version	8.0.19

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `tb_aluno`
--

DROP TABLE IF EXISTS `tb_aluno`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_aluno` (
  `id_aluno` int NOT NULL AUTO_INCREMENT,
  `nome` varchar(100) NOT NULL,
  `sobre_nome` varchar(100) DEFAULT NULL,
  `rg` varchar(100) DEFAULT NULL,
  `pk_serie` int DEFAULT NULL,
  PRIMARY KEY (`id_aluno`),
  KEY `tb_aluno_FK` (`pk_serie`),
  CONSTRAINT `tb_aluno_FK` FOREIGN KEY (`pk_serie`) REFERENCES `tb_serie` (`id_serie`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_aluno`
--

LOCK TABLES `tb_aluno` WRITE;
/*!40000 ALTER TABLE `tb_aluno` DISABLE KEYS */;
INSERT INTO `tb_aluno` VALUES (2,'Rafael','Klock','5555123',2),(3,'Alana','Klock','887733233',3);
/*!40000 ALTER TABLE `tb_aluno` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_emprestimo`
--

DROP TABLE IF EXISTS `tb_emprestimo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_emprestimo` (
  `id_emprestimo` int NOT NULL AUTO_INCREMENT,
  `pk_livro` int DEFAULT NULL,
  `pk_aluno` int DEFAULT NULL,
  `data_emprestimo` datetime DEFAULT NULL,
  `quantidade` int NOT NULL DEFAULT '1',
  `acao` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id_emprestimo`),
  KEY `tb_emprestimo_FK` (`pk_livro`),
  KEY `tb_emprestimo_FK_1` (`pk_aluno`),
  CONSTRAINT `tb_emprestimo_FK` FOREIGN KEY (`pk_livro`) REFERENCES `tb_livro` (`id_livro`),
  CONSTRAINT `tb_emprestimo_FK_1` FOREIGN KEY (`pk_aluno`) REFERENCES `tb_aluno` (`id_aluno`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_emprestimo`
--

LOCK TABLES `tb_emprestimo` WRITE;
/*!40000 ALTER TABLE `tb_emprestimo` DISABLE KEYS */;
INSERT INTO `tb_emprestimo` VALUES (16,1,2,NULL,1,'emprestimo'),(17,1,2,NULL,1,'devolucao');
/*!40000 ALTER TABLE `tb_emprestimo` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`%`*/ /*!50003 TRIGGER `emprestimo` AFTER INSERT ON `tb_emprestimo` FOR EACH ROW BEGIN
	
	IF quantidade_livro >= 1 THEN
	
		IF NEW.acao = 'emprestimo' THEN
			UPDATE tb_livro SET quantidade_livro = quantidade_livro - NEW.quantidade 
			WHERE id_livro = NEW.pk_livro;
		END IF;
	
		IF NEW.acao = 'devolucao' THEN
			UPDATE tb_livro SET quantidade_livro = quantidade_livro + NEW.quantidade 
			WHERE id_livro = NEW.pk_livro;
		END IF;

	END IF;
	
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `tb_livro`
--

DROP TABLE IF EXISTS `tb_livro`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_livro` (
  `id_livro` int NOT NULL AUTO_INCREMENT,
  `nome_livro` varchar(100) DEFAULT NULL,
  `autor_livro` varchar(100) DEFAULT NULL,
  `quantidade_livro` int DEFAULT NULL,
  PRIMARY KEY (`id_livro`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_livro`
--

LOCK TABLES `tb_livro` WRITE;
/*!40000 ALTER TABLE `tb_livro` DISABLE KEYS */;
INSERT INTO `tb_livro` VALUES (1,'Dom Quixote','Miguel de Cervantes',1),(2,'Guerra e Paz','Liev Tolstói',20),(3,'A Montanha Mágica','Thomas Man',30);
/*!40000 ALTER TABLE `tb_livro` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `tb_serie`
--

DROP TABLE IF EXISTS `tb_serie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `tb_serie` (
  `id_serie` int NOT NULL AUTO_INCREMENT,
  `nome_serie` varchar(100) NOT NULL,
  PRIMARY KEY (`id_serie`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `tb_serie`
--

LOCK TABLES `tb_serie` WRITE;
/*!40000 ALTER TABLE `tb_serie` DISABLE KEYS */;
INSERT INTO `tb_serie` VALUES (1,'primeira'),(2,'terceira'),(3,'nona');
/*!40000 ALTER TABLE `tb_serie` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-03-06 12:34:10
