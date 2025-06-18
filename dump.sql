-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: personal_records
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `notes`
--

DROP TABLE IF EXISTS `notes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `notes` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `content` text NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `notes_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notes`
--

LOCK TABLES `notes` WRITE;
/*!40000 ALTER TABLE `notes` DISABLE KEYS */;
INSERT INTO `notes` VALUES (6,1,'Kalyan','2025-06-14 10:31:34'),(7,1,' placeat database','2025-06-14 10:32:54'),(19,3,'Lorem ipsum dolor sit amet consectetur, adipisicing elit. Et magnam cum sunt praesentium in, nam iste officia vel suscipit fugit.','2025-06-14 14:01:54'),(20,3,'Lorem ipsum dolor sit amet consectetur, adipisicing elit. Et magnam cum sunt praesentium in, nam iste officia vel suscipit fugit.','2025-06-14 14:02:02'),(21,3,'Lorem ipsum dolor sit amet consectetur, adipisicing elit. Et magnam cum sunt praesentium in, nam iste officia vel suscipit fugit.','2025-06-14 14:02:07'),(22,3,'Lorem ipsum dolor sit amet consectetur, adipisicing elit. Et magnam cum sunt praesentium in, nam iste officia vel suscipit fugit.','2025-06-14 14:02:11'),(23,3,'Lorem ipsum dolor sit amet consectetur, adipisicing elit. Et magnam cum sunt praesentium in, nam iste officia vel suscipit fugit.','2025-06-14 14:02:15'),(24,3,'Lorem ipsum dolor sit amet consectetur, adipisicing elit. Et magnam cum sunt praesentium in, nam iste officia vel suscipit fugit.','2025-06-14 14:02:37'),(25,3,'Lorem ipsum dolor sit amet consectetur, adipisicing elit. Et magnam cum sunt praesentium in, nam iste officia vel suscipit fugit.','2025-06-14 14:02:43'),(26,3,'Lorem ipsum dolor sit amet consectetur, adipisicing elit. Et magnam cum sunt praesentium in, nam iste officia vel suscipit fugit.','2025-06-14 14:02:49'),(31,1,'Nothing to edit','2025-06-17 08:13:57'),(32,1,'eeedd','2025-06-17 10:06:38'),(33,1,'wewe332','2025-06-17 10:17:23'),(34,1,'Hi i developed this using Flask,html,css,Js,Python....','2025-06-17 13:36:05'),(36,6,'6j45h65hy','2025-06-18 04:50:20');
/*!40000 ALTER TABLE `notes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'Sai Teja','esaiteja2358@gmail.com','$2b$12$I1CF/WSLLQmlUpZ/0ZdmKOPWYLhhcJqWx409XNZ4680SNnnFaohS2'),(2,'Dinesh','badavathdhora@gmail.com','12345'),(3,'Akash','goudakash363@gmail.com','$2b$12$ICy10QUsNo0QSR42DqScKeooJRQybYAALvbf46QVrNXBQq4vpLqMu'),(4,'Sai','saiteju777@gmail.com','$2b$12$JPP4qjgo5FIzbWeaqGeGCe9FuD/8s51rWA0SwK2RmEaAJ0c1XdbxG'),(5,'Vishnu','vishnuvarreddy2003@gmail.com','$2b$12$/wuh9GvSvCueLl8Ur0//8uR6NQoTutoTdUP1m9CecUJc3JaNE2Kru'),(6,'Kranthi','ramavathkranthi316@gmail.com','$2b$12$VHG.Q7dV49H0m4fjYAzgyueYaacMMjQS9a2u.4BKjsHOGwATZeb3K');
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-18 11:14:53
