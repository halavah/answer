-- MySQL dump 10.13  Distrib 5.7.25, for Win64 (x86_64)
--
-- Host: 192.168.2.128    Database: answer
-- ------------------------------------------------------
-- Server version	8.0.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES UTF8MB4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `account_emailaddress`
--

DROP TABLE IF EXISTS `account_emailaddress`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_emailaddress` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(254) NOT NULL,
  `verified` tinyint(1) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `account_emailaddress_user_id_2c513194_fk_users_user_id` (`user_id`),
  CONSTRAINT `account_emailaddress_user_id_2c513194_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_emailaddress`
--

LOCK TABLES `account_emailaddress` WRITE;
/*!40000 ALTER TABLE `account_emailaddress` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_emailaddress` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `account_emailconfirmation`
--

DROP TABLE IF EXISTS `account_emailconfirmation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `account_emailconfirmation` (
  `id` int NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `sent` datetime(6) DEFAULT NULL,
  `key` varchar(64) NOT NULL,
  `email_address_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`),
  KEY `account_emailconfirm_email_address_id_5b7f8c58_fk_account_e` (`email_address_id`),
  CONSTRAINT `account_emailconfirm_email_address_id_5b7f8c58_fk_account_e` FOREIGN KEY (`email_address_id`) REFERENCES `account_emailaddress` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `account_emailconfirmation`
--

LOCK TABLES `account_emailconfirmation` WRITE;
/*!40000 ALTER TABLE `account_emailconfirmation` DISABLE KEYS */;
/*!40000 ALTER TABLE `account_emailconfirmation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(80) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_group_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES (1,'Can add permission',1,'add_permission'),(2,'Can change permission',1,'change_permission'),(3,'Can delete permission',1,'delete_permission'),(4,'Can view permission',1,'view_permission'),(5,'Can add group',2,'add_group'),(6,'Can change group',2,'change_group'),(7,'Can delete group',2,'delete_group'),(8,'Can view group',2,'view_group'),(9,'Can add content type',3,'add_contenttype'),(10,'Can change content type',3,'change_contenttype'),(11,'Can delete content type',3,'delete_contenttype'),(12,'Can view content type',3,'view_contenttype'),(13,'Can add session',4,'add_session'),(14,'Can change session',4,'change_session'),(15,'Can delete session',4,'delete_session'),(16,'Can view session',4,'view_session'),(17,'Can add site',5,'add_site'),(18,'Can change site',5,'change_site'),(19,'Can delete site',5,'delete_site'),(20,'Can view site',5,'view_site'),(21,'Can add email address',6,'add_emailaddress'),(22,'Can change email address',6,'change_emailaddress'),(23,'Can delete email address',6,'delete_emailaddress'),(24,'Can view email address',6,'view_emailaddress'),(25,'Can add email confirmation',7,'add_emailconfirmation'),(26,'Can change email confirmation',7,'change_emailconfirmation'),(27,'Can delete email confirmation',7,'delete_emailconfirmation'),(28,'Can view email confirmation',7,'view_emailconfirmation'),(29,'Can add social account',8,'add_socialaccount'),(30,'Can change social account',8,'change_socialaccount'),(31,'Can delete social account',8,'delete_socialaccount'),(32,'Can view social account',8,'view_socialaccount'),(33,'Can add social application',9,'add_socialapp'),(34,'Can change social application',9,'change_socialapp'),(35,'Can delete social application',9,'delete_socialapp'),(36,'Can view social application',9,'view_socialapp'),(37,'Can add social application token',10,'add_socialtoken'),(38,'Can change social application token',10,'change_socialtoken'),(39,'Can delete social application token',10,'delete_socialtoken'),(40,'Can view social application token',10,'view_socialtoken'),(41,'Can add 用户',11,'add_user'),(42,'Can change 用户',11,'change_user'),(43,'Can delete 用户',11,'delete_user'),(44,'Can view 用户',11,'view_user'),(45,'Can add kv store',12,'add_kvstore'),(46,'Can change kv store',12,'change_kvstore'),(47,'Can delete kv store',12,'delete_kvstore'),(48,'Can view kv store',12,'view_kvstore');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES (6,'account','emailaddress'),(7,'account','emailconfirmation'),(2,'auth','group'),(1,'auth','permission'),(3,'contenttypes','contenttype'),(4,'sessions','session'),(5,'sites','site'),(8,'socialaccount','socialaccount'),(9,'socialaccount','socialapp'),(10,'socialaccount','socialtoken'),(12,'thumbnail','kvstore'),(11,'users','user');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_migrations` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES (1,'contenttypes','0001_initial','2021-03-23 15:43:00.456456'),(2,'contenttypes','0002_remove_content_type_name','2021-03-23 15:43:00.492095'),(3,'auth','0001_initial','2021-03-23 15:43:00.605774'),(4,'auth','0002_alter_permission_name_max_length','2021-03-23 15:43:00.635813'),(5,'auth','0003_alter_user_email_max_length','2021-03-23 15:43:00.643096'),(6,'auth','0004_alter_user_username_opts','2021-03-23 15:43:00.650655'),(7,'auth','0005_alter_user_last_login_null','2021-03-23 15:43:00.658110'),(8,'auth','0006_require_contenttypes_0002','2021-03-23 15:43:00.662109'),(9,'auth','0007_alter_validators_add_error_messages','2021-03-23 15:43:00.668154'),(10,'auth','0008_alter_user_username_max_length','2021-03-23 15:43:00.674889'),(11,'users','0001_initial','2021-03-23 15:43:00.832674'),(12,'account','0001_initial','2021-03-23 15:43:00.933362'),(13,'account','0002_email_max_length','2021-03-23 15:43:00.966139'),(14,'auth','0009_alter_user_last_name_max_length','2021-03-23 15:43:00.973933'),(15,'sessions','0001_initial','2021-03-23 15:43:01.000101'),(16,'sites','0001_initial','2021-03-23 15:43:01.016726'),(17,'sites','0002_alter_domain_unique','2021-03-23 15:43:01.030164'),(18,'sites','0003_set_site_domain_and_name','2021-03-23 15:43:01.046526'),(19,'socialaccount','0001_initial','2021-03-23 15:43:01.252821'),(20,'socialaccount','0002_token_max_lengths','2021-03-23 15:43:01.303699'),(21,'socialaccount','0003_extra_data_default_dict','2021-03-23 15:43:01.314225'),(22,'users','0002_auto_20210323_0745','2021-03-23 15:43:01.713624'),(23,'thumbnail','0001_initial','2021-03-23 16:58:48.713341');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES ('1uuqtav8a14cjpb3dsj9yyfowtgdusdb','NWI2ZDYyYmUwZjgxZTAwYzI1MjUxZGJhMmQyNzdhMDNkZDkzNGY0Mjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxMDA1Y2Q5ZWI4YzI1YTEzMjk2NTAwMWU1ODc5YWZmMjU0NjNiNzUwIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2021-04-07 08:50:47.057358'),('260on9yux4r8ag7yptogmwh16habm4jx','NWI2ZDYyYmUwZjgxZTAwYzI1MjUxZGJhMmQyNzdhMDNkZDkzNGY0Mjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxMDA1Y2Q5ZWI4YzI1YTEzMjk2NTAwMWU1ODc5YWZmMjU0NjNiNzUwIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2021-04-07 10:53:46.752185'),('36lz8coq18gv7i8r890spno25c0pcv0m','NWI2ZDYyYmUwZjgxZTAwYzI1MjUxZGJhMmQyNzdhMDNkZDkzNGY0Mjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxMDA1Y2Q5ZWI4YzI1YTEzMjk2NTAwMWU1ODc5YWZmMjU0NjNiNzUwIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2021-04-07 12:02:19.506792'),('3ygciufi98fo9d1wt9eiidyx331h0qcm','NDUzMzhjOTdjMWZjZjgxNmVkY2VjMzQxZjhkYWI1MzI3NGJmOTI1YTp7InNvY2lhbGFjY291bnRfc3RhdGUiOlt7InByb2Nlc3MiOiJsb2dpbiIsInNjb3BlIjoiIiwiYXV0aF9wYXJhbXMiOiIifSwiaEhuZHo0aE0xUTMxIl19','2021-04-07 14:18:04.303755'),('7mduozdmyzwzokm72969c04l0623qh8k','NWI2ZDYyYmUwZjgxZTAwYzI1MjUxZGJhMmQyNzdhMDNkZDkzNGY0Mjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxMDA1Y2Q5ZWI4YzI1YTEzMjk2NTAwMWU1ODc5YWZmMjU0NjNiNzUwIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2021-04-07 08:42:00.538772'),('7mqazyr6savq8ajtiad4s2ovy69ut2oe','NWI2ZDYyYmUwZjgxZTAwYzI1MjUxZGJhMmQyNzdhMDNkZDkzNGY0Mjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxMDA1Y2Q5ZWI4YzI1YTEzMjk2NTAwMWU1ODc5YWZmMjU0NjNiNzUwIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2021-04-07 09:13:02.344583'),('ah6wh91v1p5yd78jqusc4m2b9duzdv6n','NWI2ZDYyYmUwZjgxZTAwYzI1MjUxZGJhMmQyNzdhMDNkZDkzNGY0Mjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxMDA1Y2Q5ZWI4YzI1YTEzMjk2NTAwMWU1ODc5YWZmMjU0NjNiNzUwIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2021-04-07 08:19:57.917507'),('js82wr4dk21ueu9gjg6grx14730tsarh','NWI2ZDYyYmUwZjgxZTAwYzI1MjUxZGJhMmQyNzdhMDNkZDkzNGY0Mjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxMDA1Y2Q5ZWI4YzI1YTEzMjk2NTAwMWU1ODc5YWZmMjU0NjNiNzUwIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2021-04-07 08:47:51.688641'),('libd2i3sho7xmfu4bj0kahwssv9dq330','NWI2ZDYyYmUwZjgxZTAwYzI1MjUxZGJhMmQyNzdhMDNkZDkzNGY0Mjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxMDA1Y2Q5ZWI4YzI1YTEzMjk2NTAwMWU1ODc5YWZmMjU0NjNiNzUwIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2021-04-07 08:19:01.914881'),('nfzfonfxxlj464shvptcn6142ttmu8dc','NWI2ZDYyYmUwZjgxZTAwYzI1MjUxZGJhMmQyNzdhMDNkZDkzNGY0Mjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxMDA1Y2Q5ZWI4YzI1YTEzMjk2NTAwMWU1ODc5YWZmMjU0NjNiNzUwIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2021-04-06 16:13:59.682602'),('ofgp3g93gn3oe4jlwuppkxz5tj6hi0av','NWI2ZDYyYmUwZjgxZTAwYzI1MjUxZGJhMmQyNzdhMDNkZDkzNGY0Mjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxMDA1Y2Q5ZWI4YzI1YTEzMjk2NTAwMWU1ODc5YWZmMjU0NjNiNzUwIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2021-04-07 10:25:46.328940'),('qal2y2v0e7f95hlcz03w86om9dqdnzzp','NWI2ZDYyYmUwZjgxZTAwYzI1MjUxZGJhMmQyNzdhMDNkZDkzNGY0Mjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxMDA1Y2Q5ZWI4YzI1YTEzMjk2NTAwMWU1ODc5YWZmMjU0NjNiNzUwIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2021-04-07 12:30:11.959636'),('uf21nbsgpw1aov30wo873tf89jedqa78','NWI2ZDYyYmUwZjgxZTAwYzI1MjUxZGJhMmQyNzdhMDNkZDkzNGY0Mjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxMDA1Y2Q5ZWI4YzI1YTEzMjk2NTAwMWU1ODc5YWZmMjU0NjNiNzUwIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2021-04-07 10:29:30.954792'),('ug1suvqwsdie3p7unvy4a1mzjkh5ose6','N2JlYWQzNzU3N2E1ZmM3NTkwYWUzODExZTEzYTdkZDk1YzVmZTgxZTp7InNvY2lhbGFjY291bnRfc3RhdGUiOlt7InByb2Nlc3MiOiJsb2dpbiIsInNjb3BlIjoiIiwiYXV0aF9wYXJhbXMiOiIifSwidU5CME5kSjdJbThqIl19','2021-04-07 13:57:39.987391'),('vxjmk1dylo92ey4rlhfjykcx84wt5cwz','NWI2ZDYyYmUwZjgxZTAwYzI1MjUxZGJhMmQyNzdhMDNkZDkzNGY0Mjp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxMDA1Y2Q5ZWI4YzI1YTEzMjk2NTAwMWU1ODc5YWZmMjU0NjNiNzUwIiwiX3Nlc3Npb25fZXhwaXJ5IjowfQ==','2021-04-07 09:04:06.662719'),('ws64xetkt68l97l5i2o0fr1hlbi4qzu8','Yjg5YThjMGZjMzk0Y2E4MDE3YzBhYzAxNzc1MDM5NDcyY2UxODkzODp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIxMDA1Y2Q5ZWI4YzI1YTEzMjk2NTAwMWU1ODc5YWZmMjU0NjNiNzUwIiwiX3Nlc3Npb25fZXhwaXJ5IjoxMjA5NjAwfQ==','2021-04-06 20:05:59.848507');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_site`
--

DROP TABLE IF EXISTS `django_site`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `django_site` (
  `id` int NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) NOT NULL,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_site_domain_a2e37b91_uniq` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_site`
--

LOCK TABLES `django_site` WRITE;
/*!40000 ALTER TABLE `django_site` DISABLE KEYS */;
INSERT INTO `django_site` (`id`, `domain`, `name`) VALUES (1,'halavah.buzz','answer');
/*!40000 ALTER TABLE `django_site` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialaccount_socialaccount`
--

DROP TABLE IF EXISTS `socialaccount_socialaccount`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `socialaccount_socialaccount` (
  `id` int NOT NULL AUTO_INCREMENT,
  `provider` varchar(30) NOT NULL,
  `uid` varchar(191) NOT NULL,
  `last_login` datetime(6) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `extra_data` longtext NOT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialaccount_provider_uid_fc810c6e_uniq` (`provider`,`uid`),
  KEY `socialaccount_socialaccount_user_id_8146e70c_fk_users_user_id` (`user_id`),
  CONSTRAINT `socialaccount_socialaccount_user_id_8146e70c_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialaccount`
--

LOCK TABLES `socialaccount_socialaccount` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialaccount` DISABLE KEYS */;
/*!40000 ALTER TABLE `socialaccount_socialaccount` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialaccount_socialapp`
--

DROP TABLE IF EXISTS `socialaccount_socialapp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `socialaccount_socialapp` (
  `id` int NOT NULL AUTO_INCREMENT,
  `provider` varchar(30) NOT NULL,
  `name` varchar(40) NOT NULL,
  `client_id` varchar(191) NOT NULL,
  `secret` varchar(191) NOT NULL,
  `key` varchar(191) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialapp`
--

LOCK TABLES `socialaccount_socialapp` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialapp` DISABLE KEYS */;
INSERT INTO `socialaccount_socialapp` (`id`, `provider`, `name`, `client_id`, `secret`, `key`) VALUES (1,'GitHub','GitHub','89186fcbd8c3af3edaca','08c09e17d0fcfa396b303d70e55c29b1a8b94894',' ');
/*!40000 ALTER TABLE `socialaccount_socialapp` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialaccount_socialapp_sites`
--

DROP TABLE IF EXISTS `socialaccount_socialapp_sites`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `socialaccount_socialapp_sites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `socialapp_id` int NOT NULL,
  `site_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialapp_sites_socialapp_id_site_id_71a9a768_uniq` (`socialapp_id`,`site_id`),
  KEY `socialaccount_socialapp_sites_site_id_2579dee5_fk_django_site_id` (`site_id`),
  CONSTRAINT `socialaccount_social_socialapp_id_97fb6e7d_fk_socialacc` FOREIGN KEY (`socialapp_id`) REFERENCES `socialaccount_socialapp` (`id`),
  CONSTRAINT `socialaccount_socialapp_sites_site_id_2579dee5_fk_django_site_id` FOREIGN KEY (`site_id`) REFERENCES `django_site` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialapp_sites`
--

LOCK TABLES `socialaccount_socialapp_sites` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialapp_sites` DISABLE KEYS */;
INSERT INTO `socialaccount_socialapp_sites` (`id`, `socialapp_id`, `site_id`) VALUES (1,1,1);
/*!40000 ALTER TABLE `socialaccount_socialapp_sites` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `socialaccount_socialtoken`
--

DROP TABLE IF EXISTS `socialaccount_socialtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `socialaccount_socialtoken` (
  `id` int NOT NULL AUTO_INCREMENT,
  `token` longtext NOT NULL,
  `token_secret` longtext NOT NULL,
  `expires_at` datetime(6) DEFAULT NULL,
  `account_id` int NOT NULL,
  `app_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `socialaccount_socialtoken_app_id_account_id_fca4e0ac_uniq` (`app_id`,`account_id`),
  KEY `socialaccount_social_account_id_951f210e_fk_socialacc` (`account_id`),
  CONSTRAINT `socialaccount_social_account_id_951f210e_fk_socialacc` FOREIGN KEY (`account_id`) REFERENCES `socialaccount_socialaccount` (`id`),
  CONSTRAINT `socialaccount_social_app_id_636a42d7_fk_socialacc` FOREIGN KEY (`app_id`) REFERENCES `socialaccount_socialapp` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `socialaccount_socialtoken`
--

LOCK TABLES `socialaccount_socialtoken` WRITE;
/*!40000 ALTER TABLE `socialaccount_socialtoken` DISABLE KEYS */;
/*!40000 ALTER TABLE `socialaccount_socialtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `thumbnail_kvstore`
--

DROP TABLE IF EXISTS `thumbnail_kvstore`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `thumbnail_kvstore` (
  `key` varchar(200) NOT NULL,
  `value` longtext NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `thumbnail_kvstore`
--

LOCK TABLES `thumbnail_kvstore` WRITE;
/*!40000 ALTER TABLE `thumbnail_kvstore` DISABLE KEYS */;
INSERT INTO `thumbnail_kvstore` (`key`, `value`) VALUES ('sorl-thumbnail||image||0de87f50493d68ee072396d598e78c01','{\"name\": \"cache/cd/8a/cd8a564e681401d27a5f0d583e4e0d3f.jpg\", \"storage\": \"django.core.files.storage.FileSystemStorage\", \"size\": [40, 40]}'),('sorl-thumbnail||image||2c926b79a592142b5339e1e8f2586a76','{\"name\": \"profile_pics/02_0039.jpg\", \"storage\": \"django.core.files.storage.FileSystemStorage\", \"size\": [640, 640]}'),('sorl-thumbnail||image||5de4409f0b32ed1004b2a6eeb0d57e77','{\"name\": \"cache/21/3b/213bab79a6f8c02a0c554a597a6fa520.jpg\", \"storage\": \"django.core.files.storage.FileSystemStorage\", \"size\": [180, 180]}'),('sorl-thumbnail||image||9fb17171c78fa997aca061b250a0c098','{\"name\": \"profile_pics/02_0039_njaIe6y.jpg\", \"storage\": \"django.core.files.storage.FileSystemStorage\", \"size\": [640, 640]}'),('sorl-thumbnail||image||e3ff62770853e1c6451cea106633f65d','{\"name\": \"cache/e4/4f/e44f29df7bb415dfc928f08b0dc09ff8.jpg\", \"storage\": \"django.core.files.storage.FileSystemStorage\", \"size\": [40, 40]}'),('sorl-thumbnail||image||fe546ab843cea622c671ee59ee993f64','{\"name\": \"cache/e0/51/e051230c9b18a618590bd04d337fd303.jpg\", \"storage\": \"django.core.files.storage.FileSystemStorage\", \"size\": [180, 180]}'),('sorl-thumbnail||thumbnails||2c926b79a592142b5339e1e8f2586a76','[\"fe546ab843cea622c671ee59ee993f64\", \"e3ff62770853e1c6451cea106633f65d\"]'),('sorl-thumbnail||thumbnails||9fb17171c78fa997aca061b250a0c098','[\"5de4409f0b32ed1004b2a6eeb0d57e77\", \"0de87f50493d68ee072396d598e78c01\"]');
/*!40000 ALTER TABLE `thumbnail_kvstore` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_user`
--

DROP TABLE IF EXISTS `users_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(30) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `github` varchar(255) DEFAULT NULL,
  `introduction` longtext,
  `job_title` varchar(50) DEFAULT NULL,
  `linkedin` varchar(255) DEFAULT NULL,
  `location` varchar(50) DEFAULT NULL,
  `nickname` varchar(255) DEFAULT NULL,
  `personal_url` varchar(555) DEFAULT NULL,
  `picture` varchar(100) DEFAULT NULL,
  `updated_at` datetime(6) NOT NULL,
  `weibo` varchar(255) DEFAULT NULL,
  `zhihu` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_user`
--

LOCK TABLES `users_user` WRITE;
/*!40000 ALTER TABLE `users_user` DISABLE KEYS */;
INSERT INTO `users_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`, `created_at`, `github`, `introduction`, `job_title`, `linkedin`, `location`, `nickname`, `personal_url`, `picture`, `updated_at`, `weibo`, `zhihu`) VALUES (1,'argon2$argon2i$v=19$m=512,t=2,p=2$OTZabjk0Y2hrdTc4$A7nGt4mvfpdW/p7FkHdkjQ','2021-03-24 12:30:11.953209',1,'halavah','xi','yan','halavah@126.com',1,1,'2021-03-23 15:43:49.554320','2021-03-23 15:43:49.568233',NULL,'Don\'t let joy take you down !','job_title',NULL,NULL,'nickname',NULL,'profile_pics/02_0039_njaIe6y.jpg','2021-03-24 12:28:29.489924',NULL,NULL);
/*!40000 ALTER TABLE `users_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_user_groups`
--

DROP TABLE IF EXISTS `users_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_user_groups` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_user_groups_user_id_group_id_b88eab82_uniq` (`user_id`,`group_id`),
  KEY `users_user_groups_group_id_9afc8d0e_fk_auth_group_id` (`group_id`),
  CONSTRAINT `users_user_groups_group_id_9afc8d0e_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `users_user_groups_user_id_5f6f5a90_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_user_groups`
--

LOCK TABLES `users_user_groups` WRITE;
/*!40000 ALTER TABLE `users_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users_user_user_permissions`
--

DROP TABLE IF EXISTS `users_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users_user_user_permissions` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_user_user_permissions_user_id_permission_id_43338c45_uniq` (`user_id`,`permission_id`),
  KEY `users_user_user_perm_permission_id_0b93982e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `users_user_user_perm_permission_id_0b93982e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `users_user_user_permissions_user_id_20aca447_fk_users_user_id` FOREIGN KEY (`user_id`) REFERENCES `users_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users_user_user_permissions`
--

LOCK TABLES `users_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `users_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `users_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-03-24 15:08:11
