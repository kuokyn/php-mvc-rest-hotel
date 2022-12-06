CREATE DATABASE  IF NOT EXISTS `hotel_db` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `hotel_db`;
-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: hotel_db
-- ------------------------------------------------------
-- Server version	8.0.28

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
-- Table structure for table `authority`
--
CREATE USER IF NOT EXISTS 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'root';
GRANT ALL PRIVILEGES ON hotel_db.* TO 'root'@'%';
FLUSH PRIVILEGES;
DROP TABLE IF EXISTS `authority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `authority` (
  `title` varchar(128) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `authority`
--

LOCK TABLES `authority` WRITE;
/*!40000 ALTER TABLE `authority` DISABLE KEYS */;
INSERT INTO `authority` VALUES ('ROLE_ADMIN','Admin has an access to the admin panel'),('ROLE_USER','Authorized user has an accsess to certain web-pages');
/*!40000 ALTER TABLE `authority` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `booking`
--

DROP TABLE IF EXISTS `booking`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `room_id` int NOT NULL,
  `check_in_date` datetime NOT NULL,
  `check_out_date` datetime NOT NULL,
  `people` smallint NOT NULL,
  PRIMARY KEY (`id`,`user_id`,`room_id`),
  KEY `fk_booking_room1_idx` (`room_id`),
  KEY `fk_booking_user1_idx` (`user_id`),
  CONSTRAINT `fk_booking_room1` FOREIGN KEY (`room_id`) REFERENCES `room` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_booking_user1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking`
--

LOCK TABLES `booking` WRITE;
/*!40000 ALTER TABLE `booking` DISABLE KEYS */;
INSERT INTO `booking` VALUES (2,3,4,'2022-02-19 00:00:00','2022-02-27 00:00:00',2),(3,4,3,'2022-03-01 00:00:00','2022-03-10 00:00:00',2),(4,7,10,'2022-05-15 00:00:00','2022-05-20 00:00:00',1),(5,5,9,'2022-06-27 00:00:00','2022-07-01 00:00:00',2),(6,8,10,'2022-07-13 00:00:00','2022-07-17 00:00:00',1),(7,6,8,'2022-07-14 00:00:00','2022-07-16 00:00:00',1),(8,9,5,'2022-08-01 00:00:00','2022-08-31 00:00:00',3),(9,10,6,'2022-08-02 00:00:00','2022-08-07 00:00:00',1),(10,2,5,'2022-08-13 00:00:00','2022-08-20 00:00:00',4),(11,7,7,'2022-09-07 00:00:00','2022-09-12 00:00:00',2),(13,8,8,'2022-06-17 00:00:00','2022-06-25 00:00:00',2),(14,8,8,'2022-05-19 00:00:00','2022-05-23 00:00:00',2),(15,12,8,'2022-11-20 00:00:00','2022-11-26 00:00:00',2),(16,12,5,'2022-11-13 00:00:00','2022-11-20 00:00:00',2),(17,2,2,'2022-11-01 00:00:00','2022-11-03 00:00:00',1),(18,15,7,'2022-11-01 00:00:00','2022-11-09 00:00:00',1);
/*!40000 ALTER TABLE `booking` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `people_trigger` BEFORE INSERT ON `booking` FOR EACH ROW BEGIN
IF NEW.people>(select people from room where id=NEW.room_id)
THEN
insert into booking values (1,"","");
END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `booking_dates_trigger` BEFORE INSERT ON `booking` FOR EACH ROW BEGIN
IF (SELECT EXISTS(SELECT * FROM booking WHERE room_id=NEW.room_id AND (NEW.check_in_date BETWEEN check_in_date AND check_out_date))) = 1
THEN
insert into booking values (1,"","");
END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `booking_service`
--

DROP TABLE IF EXISTS `booking_service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `booking_service` (
  `id` int NOT NULL AUTO_INCREMENT,
  `booking_id` int NOT NULL,
  `service_title` varchar(128) NOT NULL,
  `worker_id` int NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_booking_has_worker_idx` (`worker_id`),
  KEY `fk_booking_has_service_booking1_idx` (`booking_id`),
  KEY `fk_booking_has_service_idx_idx` (`service_title`),
  CONSTRAINT `fk_booking_has_booking_idx` FOREIGN KEY (`booking_id`) REFERENCES `booking` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_booking_has_service_idx` FOREIGN KEY (`service_title`) REFERENCES `service` (`title`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_booking_has_worker_idx` FOREIGN KEY (`worker_id`) REFERENCES `worker` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `booking_service`
--

LOCK TABLES `booking_service` WRITE;
/*!40000 ALTER TABLE `booking_service` DISABLE KEYS */;
INSERT INTO `booking_service` VALUES (2,2,'Parking',3,'2022-02-20'),(3,2,'Sauna',4,'2022-02-21'),(4,3,'Meal in room',8,'2022-03-07'),(5,3,'Sauna',3,'2022-03-08'),(6,3,'Laundry',9,'2022-03-09'),(7,11,'Car Rent',2,'2022-09-10'),(8,10,'Parking',4,'2022-08-06'),(9,4,'Extra towels changing',9,'2022-05-16'),(10,5,'Special room cleaning',10,'2022-06-28'),(12,3,'Meal in room',8,'2022-03-08');
/*!40000 ALTER TABLE `booking_service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `booking_service_with_names`
--

DROP TABLE IF EXISTS `booking_service_with_names`;
/*!50001 DROP VIEW IF EXISTS `booking_service_with_names`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `booking_service_with_names` AS SELECT 
 1 AS `id`,
 1 AS `user_surname`,
 1 AS `user_name`,
 1 AS `room_id`,
 1 AS `service_title`,
 1 AS `worker_surname`,
 1 AS `worker_name`,
 1 AS `date`*/;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `job`
--

DROP TABLE IF EXISTS `job`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `job` (
  `title` varchar(128) NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job`
--

LOCK TABLES `job` WRITE;
/*!40000 ALTER TABLE `job` DISABLE KEYS */;
INSERT INTO `job` VALUES ('Administrator','Coordinating the work of staff, giving instructions to hotel employees, communicating with customers, familiarizing arriving visitors with the basic rules of accommodation and internal regulations of the hotel, resettling guests, issuing and receiving keys of the hotel rooms, filling out the necessary documentation, communicating with  potential customers on the phone, booking rooms and providing consulting services.'),('Maid','Scheduled everyday room cleaning, linen and sanitary items changing, completion if mini-bars located in rooms, cleaning of corridors and common areas on the way to the elevator stairs, checking the integrity of the property and the completeness of the room equipment, execution of intstructions and orders of the administrator and manager of the hotel, extra services.'),('Manager','Management of financial and economic activities of the organization, staff management, conclusion of contracts with employees, control over compliance with internal regulations and requirements of job descriptions.');
/*!40000 ALTER TABLE `job` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room`
--

DROP TABLE IF EXISTS `room`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room` (
  `id` int NOT NULL AUTO_INCREMENT,
  `chambers` smallint NOT NULL,
  `people` smallint NOT NULL,
  `room_type_title` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_room_room_type1_idx` (`room_type_title`),
  CONSTRAINT `fk_room_room_type1` FOREIGN KEY (`room_type_title`) REFERENCES `room_type` (`title`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room`
--

LOCK TABLES `room` WRITE;
/*!40000 ALTER TABLE `room` DISABLE KEYS */;
INSERT INTO `room` VALUES (1,1,2,'Standart'),(2,2,4,'Family'),(3,2,2,'Luxury'),(4,1,1,'Economy'),(5,2,4,'Family'),(6,1,1,'Economy'),(7,1,2,'Standart'),(8,1,2,'Economy'),(9,2,2,'Luxury'),(10,1,1,'Luxury');
/*!40000 ALTER TABLE `room` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_type`
--

DROP TABLE IF EXISTS `room_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room_type` (
  `title` varchar(20) NOT NULL,
  `single_beds` smallint NOT NULL,
  `double_beds` smallint NOT NULL,
  `price` double NOT NULL,
  PRIMARY KEY (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_type`
--

LOCK TABLES `room_type` WRITE;
/*!40000 ALTER TABLE `room_type` DISABLE KEYS */;
INSERT INTO `room_type` VALUES ('Economy',1,0,25),('Family',2,2,106.65),('Luxury',1,2,205.5),('Standart',2,0,50);
/*!40000 ALTER TABLE `room_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `service`
--

DROP TABLE IF EXISTS `service`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `service` (
  `title` varchar(128) NOT NULL,
  `price` double NOT NULL,
  `description` text NOT NULL,
  PRIMARY KEY (`title`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `service`
--

LOCK TABLES `service` WRITE;
/*!40000 ALTER TABLE `service` DISABLE KEYS */;
INSERT INTO `service` VALUES ('Additional room cleaning',20.99,'Extra cleaning'),('Car Rent',9.99,'Hourly payment'),('Dry cleaning',10,'The price varies depending on dirtiness level'),('Extra bed sheets changing',4.99,''),('Extra towels changing',4.99,''),('Game hall',5.99,'Hourly payment'),('Gym',9.59,'Hourly payment'),('Hall Rent',9.39,'Hourly payment'),('Laundry',10,'Clothes/fabrics with total weight under 5 kg'),('Meal in room',25.99,'Breakfast, lunch, dinner'),('Parking',5.9,'Hourly payment'),('Sauna',49.99,'Hourly payment'),('Special room cleaning',39.99,'The price is set in individual order');
/*!40000 ALTER TABLE `service` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `name` varchar(128) NOT NULL,
  `surname` varchar(128) DEFAULT NULL,
  `phone` varchar(128) NOT NULL,
  `email` varchar(128) NOT NULL,
  `authority_title` varchar(128) NOT NULL DEFAULT 'ROLE_USER',
  PRIMARY KEY (`id`,`phone`),
  UNIQUE KEY `UK_589idila9li6a4arw1t8ht1gx` (`phone`),
  KEY `fk_user_authority1_idx` (`authority_title`),
  KEY `fk_user_phone_idx` (`phone`) /*!80000 INVISIBLE */,
  CONSTRAINT `fk_user_authority1` FOREIGN KEY (`authority_title`) REFERENCES `authority` (`title`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'superencryptedpasswordadmin','admin','admin','88003003030','admin@outlook.com','ROLE_ADMIN'),(2,'myencryptedpassword','Susan','Smith','88009345656','susan260999@gmail.com','ROLE_USER'),(3,'myencryptedpassword2','Homer','Simpson','88005673232','homersimpson@outlook.com','ROLE_USER'),(4,'passpasspass123123','Harry','Potter','88007778899','harrypotter@yandex.ru','ROLE_USER'),(5,'myencryptedpassword','Henry','Oldman','88004715323','iamsirius@gmail.com','ROLE_USER'),(6,'vhuoevoph480r4043hr','Jane','Doe','88005553535','janedoe@outlook.com','ROLE_USER'),(7,'e?w0fi4bf3r904ut5h','Billieeee','Eilish','88005467645','billieee@yandex.ru','ROLE_USER'),(8,'12909ffnsLDjoD9f.?','Daiki','Tsuneta','88008889797','milleniumparade@gmail.com','ROLE_USER'),(9,'f0ewfjev30f.fef9?3','Justin','Tim','88904534231','youamiottd@yandex.ru','ROLE_USER'),(10,'$2a$10$aiWjjV3mEBH6TQPYOGuURupyrHaRV3qLLewQaq.4eFY6g.1toynBa','Sae','Kim','88007045221','kimsaebok@gmail.com','ROLE_USER'),(12,'$2a$10$Fq.QFkdEITAy1SeGJLvR5.HHTUuHXuma.QQHQH0kifRechxkcTA8O','admin','admin','1234567890','admin@mail.ru','ROLE_ADMIN'),(14,'$2a$10$4N2.0o/JO.HHvyFPgZoLUOIb8TOChFJoUWqplLKECrgok4ILtRAVi','USER','USER','0987654321','user1@mail.ru','ROLE_USER'),(15,'$2a$10$TR8c3se8gmlgtl/WMGCBpO.v8rqN/4ufOcVs2UytLYHa/GU6/pCYe','user','user111','12','user@mail.ru','ROLE_USER');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_authority`
--

DROP TABLE IF EXISTS `user_authority`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user_authority` (
  `user_phone` varchar(128) NOT NULL,
  `authority_title` varchar(128) NOT NULL,
  KEY `user_authority_authority_title_fk` (`authority_title`),
  KEY `user_authority_user_phone_fk` (`user_phone`),
  CONSTRAINT `user_authority_authority_title_fk` FOREIGN KEY (`authority_title`) REFERENCES `authority` (`title`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_authority_user_phone_fk` FOREIGN KEY (`user_phone`) REFERENCES `user` (`phone`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_authority`
--

LOCK TABLES `user_authority` WRITE;
/*!40000 ALTER TABLE `user_authority` DISABLE KEYS */;
INSERT INTO `user_authority` VALUES ('12','ROLE_USER'),('1234567890','ROLE_ADMIN'),('88007045221','ROLE_USER');
/*!40000 ALTER TABLE `user_authority` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `worker`
--

DROP TABLE IF EXISTS `worker`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `worker` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(128) NOT NULL,
  `surname` varchar(128) NOT NULL,
  `phone` varchar(11) NOT NULL,
  `email` varchar(128) NOT NULL,
  `job_title` varchar(128) NOT NULL,
  `fired` smallint DEFAULT '0',
  PRIMARY KEY (`id`,`job_title`),
  KEY `fk_worker_job1_idx` (`job_title`),
  CONSTRAINT `fk_worker_job1` FOREIGN KEY (`job_title`) REFERENCES `job` (`title`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb3;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `worker`
--

LOCK TABLES `worker` WRITE;
/*!40000 ALTER TABLE `worker` DISABLE KEYS */;
INSERT INTO `worker` VALUES (1,'Nansyy','Dru','88004443232','manager_dru@yandex.ru','Manager',NULL),(2,'Dannie','Rainolds','88006668080','manager_rainolds@yandex.ru','Manager',NULL),(3,'Dominiko','Verdi','88007665445','admin_verdi@yandex.ru','Administrator',NULL),(4,'Nicolo','Paganini','88076512214','admin_paganini@yandex.ru','Administrator',NULL),(5,'Yu','Lee','88006557777','yulee1@yandex.ru','Maid',NULL),(6,'Yena','Go','88003331901','yulee1@yandex.ru','Maid',NULL),(7,'Hisako','Kobayashi','88006770098','kobayashiki@yandex.ru','Maid',NULL),(8,'Jane','Dinn','88009806565','janedinn@yandex.ru','Maid',NULL),(9,'Jessikaaa','Simon','88009325250','jessikasimon@yandex.ru','Maid',NULL),(10,'Kou','Joshi','88005609832','joshikou@yandex.ru','Maid',NULL);
/*!40000 ALTER TABLE `worker` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'hotel_db'
--

--
-- Dumping routines for database 'hotel_db'
--
/*!50003 DROP PROCEDURE IF EXISTS `get_room_services` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_room_services`()
BEGIN 
	select room_id, service_title, count(*) as amount_of_services, 
    service.price*count(*) as total_price 
	from booking_service_with_names
	join service on service.title=service_title
	group by room_id, service_title
	order by room_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_room_services_by_id` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_room_services_by_id`( IN room_number INT(11) )
BEGIN 
	select room_id, service_title, count(*) as amount_of_services, 
    service.price*count(*) as total_price 
	from booking_service_with_names
	join service on service.title=service_title
    where room_id=room_number
	group by room_id, service_title
	order by room_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Final view structure for view `booking_service_with_names`
--

/*!50001 DROP VIEW IF EXISTS `booking_service_with_names`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8mb4 */;
/*!50001 SET character_set_results     = utf8mb4 */;
/*!50001 SET collation_connection      = utf8mb4_0900_ai_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `booking_service_with_names` AS select `booking_service`.`id` AS `id`,`user`.`surname` AS `user_surname`,`user`.`name` AS `user_name`,`booking`.`room_id` AS `room_id`,`booking_service`.`service_title` AS `service_title`,`worker`.`surname` AS `worker_surname`,`worker`.`name` AS `worker_name`,`booking_service`.`date` AS `date` from (((`booking_service` join `booking` on((`booking`.`id` = `booking_service`.`booking_id`))) join `user` on((`user`.`id` = `booking`.`user_id`))) join `worker` on((`worker`.`id` = `booking_service`.`worker_id`))) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-12-03 13:40:59
