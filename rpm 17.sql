/*M!999999\- enable the sandbox mode */ 
-- MariaDB dump 10.19  Distrib 10.11.14-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: rpm
-- ------------------------------------------------------
-- Server version	10.11.14-MariaDB-0+deb12u2

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `cache`
--

DROP TABLE IF EXISTS `cache`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache` (
  `key` varchar(255) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache`
--

LOCK TABLES `cache` WRITE;
/*!40000 ALTER TABLE `cache` DISABLE KEYS */;
INSERT INTO `cache` VALUES
('regtix_rpm_cache_356a192b7913b04c54574d18c28d46e6395428ab','i:1;',1763104976),
('regtix_rpm_cache_356a192b7913b04c54574d18c28d46e6395428ab:timer','i:1763104976;',1763104976),
('regtix_rpm_cache_livewire-rate-limiter:0b9e1fb439b2b1a8e8426f8b415ee1999f619a09','i:1;',1763340644),
('regtix_rpm_cache_livewire-rate-limiter:0b9e1fb439b2b1a8e8426f8b415ee1999f619a09:timer','i:1763340644;',1763340644),
('regtix_rpm_cache_livewire-rate-limiter:3fbefb176867056f89ba2ea39d5b970b0f01965d','i:1;',1762948188),
('regtix_rpm_cache_livewire-rate-limiter:3fbefb176867056f89ba2ea39d5b970b0f01965d:timer','i:1762948188;',1762948188),
('regtix_rpm_cache_livewire-rate-limiter:45cfc46dca088b3114b50dbcee582896f8f48c4e','i:1;',1763352246),
('regtix_rpm_cache_livewire-rate-limiter:45cfc46dca088b3114b50dbcee582896f8f48c4e:timer','i:1763352246;',1763352246),
('regtix_rpm_cache_livewire-rate-limiter:7b7aa18b78d311f7caea1c859d0ed148c2055be8','i:1;',1763103653),
('regtix_rpm_cache_livewire-rate-limiter:7b7aa18b78d311f7caea1c859d0ed148c2055be8:timer','i:1763103653;',1763103653),
('regtix_rpm_cache_livewire-rate-limiter:8854f3c7faf6ce2bdfce5128599b28c3e2c0f4d3','i:1;',1763256308),
('regtix_rpm_cache_livewire-rate-limiter:8854f3c7faf6ce2bdfce5128599b28c3e2c0f4d3:timer','i:1763256308;',1763256308),
('regtix_rpm_cache_livewire-rate-limiter:cb74c36150fc115f7c6bdf8460cad442699d0e34','i:1;',1763097284),
('regtix_rpm_cache_livewire-rate-limiter:cb74c36150fc115f7c6bdf8460cad442699d0e34:timer','i:1763097284;',1763097284),
('regtix_rpm_cache_livewire-rate-limiter:dfccdaa2ad72e501cea62004d5c5e57f9ffe516a','i:1;',1763351171),
('regtix_rpm_cache_livewire-rate-limiter:dfccdaa2ad72e501cea62004d5c5e57f9ffe516a:timer','i:1763351171;',1763351171),
('regtix_rpm_cache_livewire-rate-limiter:e3988f7f0fd04c859e4043bfc00f5990eb790a64','i:1;',1763353513),
('regtix_rpm_cache_livewire-rate-limiter:e3988f7f0fd04c859e4043bfc00f5990eb790a64:timer','i:1763353513;',1763353513),
('regtix_rpm_cache_livewire-rate-limiter:ec602a7bed7ab8fe07f5200d7d220514a359b80b','i:1;',1763076030),
('regtix_rpm_cache_livewire-rate-limiter:ec602a7bed7ab8fe07f5200d7d220514a359b80b:timer','i:1763076030;',1763076030),
('regtix_rpm_cache_livewire-rate-limiter:f2f61b837868e480e9aa1b3af6345eea52cea17b','i:1;',1763005289),
('regtix_rpm_cache_livewire-rate-limiter:f2f61b837868e480e9aa1b3af6345eea52cea17b:timer','i:1763005289;',1763005289),
('regtix_rpm_cache_livewire-rate-limiter:f45fa96567ea32b304f2fdd43a065493ba227648','i:2;',1763085150),
('regtix_rpm_cache_livewire-rate-limiter:f45fa96567ea32b304f2fdd43a065493ba227648:timer','i:1763085150;',1763085150),
('regtix_rpm_cache_livewire-rate-limiter:f7f466f4b0cd51c2e4d55c3cbb6c82277d6d0132','i:1;',1763340629),
('regtix_rpm_cache_livewire-rate-limiter:f7f466f4b0cd51c2e4d55c3cbb6c82277d6d0132:timer','i:1763340629;',1763340629);
/*!40000 ALTER TABLE `cache` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cache_locks`
--

DROP TABLE IF EXISTS `cache_locks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `cache_locks` (
  `key` varchar(255) NOT NULL,
  `owner` varchar(255) NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cache_locks`
--

LOCK TABLES `cache_locks` WRITE;
/*!40000 ALTER TABLE `cache_locks` DISABLE KEYS */;
/*!40000 ALTER TABLE `cache_locks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campaign_registration`
--

DROP TABLE IF EXISTS `campaign_registration`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `campaign_registration` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `campaign_id` bigint(20) unsigned NOT NULL,
  `registration_id` bigint(20) unsigned NOT NULL,
  `status` enum('pending','sent','bounced') NOT NULL DEFAULT 'pending',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `campaign_registration_campaign_id_registration_id_unique` (`campaign_id`,`registration_id`),
  KEY `campaign_registration_registration_id_foreign` (`registration_id`),
  CONSTRAINT `campaign_registration_campaign_id_foreign` FOREIGN KEY (`campaign_id`) REFERENCES `campaigns` (`id`) ON DELETE CASCADE,
  CONSTRAINT `campaign_registration_registration_id_foreign` FOREIGN KEY (`registration_id`) REFERENCES `registrations` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaign_registration`
--

LOCK TABLES `campaign_registration` WRITE;
/*!40000 ALTER TABLE `campaign_registration` DISABLE KEYS */;
/*!40000 ALTER TABLE `campaign_registration` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `campaigns`
--

DROP TABLE IF EXISTS `campaigns`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `campaigns` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) NOT NULL,
  `event_id` bigint(20) unsigned NOT NULL,
  `subject` varchar(255) NOT NULL,
  `html_template` longtext NOT NULL,
  `status` enum('active','inactive') NOT NULL DEFAULT 'inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `campaigns_event_id_foreign` (`event_id`),
  CONSTRAINT `campaigns_event_id_foreign` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `campaigns`
--

LOCK TABLES `campaigns` WRITE;
/*!40000 ALTER TABLE `campaigns` DISABLE KEYS */;
INSERT INTO `campaigns` VALUES
(1,'SANGA SANGA RUN 7K RACE PACK COLLECTION',1,'[REMINDER] SANGA SANGA RUN 7K RACE PACK COLLECTION','<!DOCTYPE html>\n<html lang=\"id\">\n<head>\n    <meta charset=\"UTF-8\">\n    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n    <title>Informasi Race Pack - SANGA SANGA RUN 2025</title>\n    <style>\n        body {\n            font-family: Arial, sans-serif;\n            background-color: #f8f9fa;\n            margin: 0;\n            padding: 0;\n            color: #333;\n        }\n\n        h1, h2, p {\n            margin: 0;\n            padding: 0;\n        }\n\n        a {\n            color: #007BFF;\n            text-decoration: none;\n        }\n\n        a:hover {\n            text-decoration: underline;\n        }\n\n        .container {\n            background-color: #ffffff;\n            color: #333;\n            max-width: 800px;\n            margin: 40px auto;\n            padding: 30px;\n            border-radius: 12px;\n            box-shadow: 0 4px 10px rgba(0, 0, 0, 0.1);\n        }\n\n        .header {\n            text-align: center;\n            margin-bottom: 30px;\n        }\n\n        .header h1 {\n            font-size: 2.5em;\n            margin-bottom: 10px;\n            color: #333;\n        }\n\n        .header p {\n            font-size: 1.2em;\n            color: #6c757d;\n        }\n\n        .highlight {\n            color: #007BFF;\n            font-weight: bold;\n        }\n\n        .address, .important {\n            font-style: italic;\n            font-size: 1.1em;\n        }\n\n        .address a {\n            font-weight: bold;\n        }\n\n        .content {\n            margin-top: 30px;\n            padding-left: 20px;\n            padding-right: 20px;\n        }\n\n        .content h2 {\n            font-size: 1.5em;\n            margin-bottom: 15px;\n        }\n\n        .content ul {\n            padding-left: 20px;\n            list-style-type: square;\n        }\n\n        .content ul li {\n            margin: 10px 0;\n        }\n\n        .footer {\n            margin-top: 30px;\n            text-align: center;\n            font-size: 1.2em;\n            font-weight: bold;\n        }\n\n        .footer p {\n            color: #007BFF;\n        }\n\n        .footer .date-time {\n            font-size: 1.1em;\n            color: #6c757d;\n        }\n\n        .highlight-date {\n            font-weight: bold;\n            font-size: 1.3em;\n        }\n\n        .spacer {\n            margin-top: 20px;\n        }\n\n        /* Mobile Responsive Styles */\n        @media (max-width: 600px) {\n            .container {\n                margin: 20px 10px;\n                padding: 20px;\n            }\n\n            .header h1 {\n                font-size: 1.8em;\n            }\n\n            .header p,\n            .footer,\n            .content h2,\n            .highlight-date {\n                font-size: 1em;\n            }\n\n            .content ul {\n                padding-left: 15px;\n            }\n        }\n    </style>\n</head>\n<body>\n\n    <div class=\"container\">\n        <div class=\"header\">\n            <h1>Dear Runners,</h1>\n        </div>\n\n        <div class=\"content\">\n            <p>Terima kasih telah membeli tiket <span class=\"highlight\">SANGA SANGA RUN 2025</span>. Untuk seluruh peserta yang sudah mendaftarkan diri, dihimbau untuk mengambil <span class=\"highlight\">race pack</span> di:</p>\n            \n            <div class=\"spacer\"></div>\n            <h2>Lokasi Pengambilan Race Pack:</h2>\n            <p class=\"address\">\n                <strong>MANGO LANGO LAKE</strong><br>\n                Jl. Sawo Babakan Bitera, Gianyar, Bali<br>\n                <a href=\"https://maps.app.goo.gl/r5Wy75gYNE41Etws7\" target=\"_blank\">Klik disini untuk lokasi Google Maps</a>\n            </p>\n\n            <div class=\"spacer\"></div>\n            <h2>Pada Tanggal:</h2>\n            <p class=\"highlight-date\">10-11 Mei 2025</p>\n            <p class=\"highlight-date\">11.00-19.00 WITA</p>\n\n            <div class=\"spacer\"></div>\n            <h2>Mohon membaca syarat pengambilan race pack yang tertera dibawah ini:</h2>\n            <ul>\n                <li>Identitas Diri: KTP/SIM/Kartu Pelajar asli atau fotokopi.</li>\n                <li>Konfirmasi Keikutsertaan: Cetakan atau digital bukti konfirmasi pendaftaran.</li>\n                <li>Surat Persetujuan Orang Tua/Wali (Parental Consent): Untuk peserta di bawah 17 tahun.</li>\n                <li>Surat Kuasa (jika diwakilkan): Surat kuasa yang ditandatangani peserta dan disertai fotokopi KTP peserta.</li>\n                <li>Identitas Perwakilan (jika diwakilkan): KTP/SIM/Kartu Pelajar asli perwakilan.</li>\n                <li>Race pack tidak dapat dititipkan/diambil saat race day/setelah race day.</li>\n                <li>Race pack yang tidak diambil pada jadwal yang ditentukan akan menjadi hak Panitia.</li>\n            </ul>\n        </div>\n\n        <div class=\"footer\">\n            <p>Sampai bertemu, Runners!</p>\n            <p class=\"highlight\">SANGA SANGA RUN 2025!</p>\n            <p class=\"date-time\">12.5.2025 | 06.00 WITA</p>\n        </div>\n    </div>\n\n</body>\n</html>\n','active','2025-05-16 00:59:18','2025-05-16 00:59:18');
/*!40000 ALTER TABLE `campaigns` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `categories`
--

DROP TABLE IF EXISTS `categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `event_id` bigint(20) unsigned NOT NULL,
  `distance` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `categories_event_id_foreign` (`event_id`),
  CONSTRAINT `categories_event_id_foreign` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categories`
--

LOCK TABLES `categories` WRITE;
/*!40000 ALTER TABLE `categories` DISABLE KEYS */;
INSERT INTO `categories` VALUES
(1,'7K',1,7,'2025-05-16 22:09:59','2025-05-27 21:55:05'),
(4,'5K',3,5,'2025-11-06 15:34:13','2025-11-06 15:34:13'),
(5,'10K',3,10,'2025-11-06 15:34:13','2025-11-06 15:34:13'),
(6,'Run Kids 200M',3,1,'2025-11-06 15:34:13','2025-11-10 21:44:01'),
(7,'5K',4,5,'2025-11-08 18:43:50','2025-11-08 18:43:50'),
(8,'5K',5,5,'2025-11-08 18:48:48','2025-11-08 18:48:48'),
(9,'5K',6,5,'2025-11-08 19:14:07','2025-11-08 19:14:07'),
(10,'5K',7,2,'2025-11-08 19:21:15','2025-11-08 19:21:15'),
(11,'5k',8,5,'2025-11-08 19:25:02','2025-11-08 19:25:02'),
(12,'5k',9,5,'2025-11-08 19:27:55','2025-11-08 19:27:55'),
(13,'5K',10,5,'2025-11-11 23:34:27','2025-11-11 23:34:27'),
(14,'5K',12,5,'2025-11-12 09:33:51','2025-11-12 09:33:51'),
(15,'10K',12,5,'2025-11-12 09:33:51','2025-11-12 09:33:51');
/*!40000 ALTER TABLE `categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `category_ticket_type`
--

DROP TABLE IF EXISTS `category_ticket_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `category_ticket_type` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `category_id` bigint(20) unsigned NOT NULL,
  `ticket_type_id` bigint(20) unsigned NOT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `quota` int(11) NOT NULL DEFAULT 0,
  `valid_from` date DEFAULT NULL,
  `valid_until` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `category_ticket_type_category_id_ticket_type_id_unique` (`category_id`,`ticket_type_id`),
  KEY `category_ticket_type_ticket_type_id_foreign` (`ticket_type_id`),
  CONSTRAINT `category_ticket_type_category_id_foreign` FOREIGN KEY (`category_id`) REFERENCES `categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `category_ticket_type_ticket_type_id_foreign` FOREIGN KEY (`ticket_type_id`) REFERENCES `ticket_types` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `category_ticket_type`
--

LOCK TABLES `category_ticket_type` WRITE;
/*!40000 ALTER TABLE `category_ticket_type` DISABLE KEYS */;
INSERT INTO `category_ticket_type` VALUES
(1,1,1,99000.00,100,'2025-05-18',NULL,'2025-05-16 22:09:59','2025-05-16 22:09:59'),
(2,1,2,150000.00,100,'2025-05-20',NULL,'2025-05-16 22:09:59','2025-05-16 22:09:59'),
(10,4,2,190000.00,150,'2025-11-16',NULL,'2025-11-06 15:34:13','2025-11-16 13:51:11'),
(11,4,4,220000.00,100,'2025-11-16',NULL,'2025-11-06 15:34:13','2025-11-16 13:51:11'),
(13,5,2,225000.00,200,'2025-11-12',NULL,'2025-11-06 15:34:13','2025-11-16 13:51:11'),
(16,6,4,185000.00,50,'2025-11-16',NULL,'2025-11-06 15:34:13','2025-11-16 13:51:11'),
(20,5,4,260000.00,150,'2025-11-16',NULL,'2025-11-07 17:39:31','2025-11-16 13:51:11'),
(23,7,4,100000.00,1,'2024-06-01',NULL,'2025-11-08 18:43:50','2025-11-08 18:43:50'),
(24,8,4,100000.00,1,'2024-03-01',NULL,'2025-11-08 18:48:48','2025-11-08 18:48:48'),
(25,9,4,100.00,1,'2023-04-01',NULL,'2025-11-08 19:14:07','2025-11-08 19:14:07'),
(26,10,4,50000.00,0,'2025-10-29',NULL,'2025-11-08 19:21:15','2025-11-11 23:48:21'),
(27,11,4,100000.00,1,'2025-08-08',NULL,'2025-11-08 19:25:02','2025-11-08 19:25:02'),
(28,12,4,100000.00,1,'2025-08-09',NULL,'2025-11-08 19:27:55','2025-11-08 19:27:55'),
(29,13,4,100000.00,10,'2023-11-05',NULL,'2025-11-11 23:34:27','2025-11-11 23:34:27'),
(30,14,2,199000.00,300,NULL,NULL,'2025-11-12 09:33:51','2025-11-12 09:33:51'),
(31,15,2,245000.00,300,NULL,NULL,'2025-11-12 09:33:51','2025-11-12 09:33:51');
/*!40000 ALTER TABLE `category_ticket_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_slides`
--

DROP TABLE IF EXISTS `event_slides`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_slides` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `event_id` bigint(20) unsigned NOT NULL,
  `image_path` varchar(255) NOT NULL,
  `caption` varchar(255) DEFAULT NULL,
  `order` int(11) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `event_slides_event_id_foreign` (`event_id`),
  CONSTRAINT `event_slides_event_id_foreign` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_slides`
--

LOCK TABLES `event_slides` WRITE;
/*!40000 ALTER TABLE `event_slides` DISABLE KEYS */;
INSERT INTO `event_slides` VALUES
(2,3,'image/event/slides/01K9SMFNVTEYZG3C38HGRT2P1E.jpg','Lari 1',1,'2025-11-11 22:17:59','2025-11-12 09:06:13'),
(3,3,'image/event/slides/01K9SMFNVWNJ3PGM0YYY9FNRP5.jpg','lari 2',2,'2025-11-11 22:17:59','2025-11-12 09:14:12'),
(4,3,'image/event/slides/01K9SMFNVX8YT99EVPS298WXVS.jpg','lari 3',3,'2025-11-11 22:17:59','2025-11-12 09:14:12'),
(5,12,'image/event/slides/01K9TV578430CVSE23WH3BMZ4K.jpg','K1',1,'2025-11-12 09:33:51','2025-11-12 09:33:51');
/*!40000 ALTER TABLE `event_slides` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `event_user`
--

DROP TABLE IF EXISTS `event_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `event_user` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `event_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `event_user_user_id_foreign` (`user_id`),
  KEY `event_user_event_id_foreign` (`event_id`),
  CONSTRAINT `event_user_event_id_foreign` FOREIGN KEY (`event_id`) REFERENCES `events` (`id`) ON DELETE CASCADE,
  CONSTRAINT `event_user_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `event_user`
--

LOCK TABLES `event_user` WRITE;
/*!40000 ALTER TABLE `event_user` DISABLE KEYS */;
INSERT INTO `event_user` VALUES
(1,2,1,NULL,NULL),
(2,3,1,NULL,NULL),
(9,1,4,NULL,NULL),
(10,1,5,NULL,NULL),
(11,1,6,NULL,NULL),
(12,1,7,NULL,NULL),
(13,1,8,NULL,NULL),
(14,1,9,NULL,NULL),
(15,1,12,NULL,NULL),
(16,11,3,NULL,NULL);
/*!40000 ALTER TABLE `event_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `events` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `slug` varchar(255) DEFAULT NULL,
  `status` enum('OPEN','CLOSED','TBA','TC') NOT NULL DEFAULT 'TBA',
  `size` enum('Large','Medium','Small') DEFAULT NULL,
  `code_prefix` varchar(10) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `start_date` datetime DEFAULT NULL,
  `end_date` datetime DEFAULT NULL,
  `location` varchar(255) DEFAULT NULL,
  `location_gmaps_url` text DEFAULT NULL,
  `registration_start_date` date DEFAULT NULL,
  `registration_end_date` date DEFAULT NULL,
  `description` text DEFAULT NULL,
  `rpc_start_date` datetime DEFAULT NULL,
  `rpc_end_date` datetime DEFAULT NULL,
  `rpc_collection_times` varchar(255) DEFAULT NULL,
  `rpc_collection_location` varchar(255) DEFAULT NULL,
  `rpc_collection_gmaps_url` text DEFAULT NULL,
  `event_url` varchar(255) DEFAULT NULL,
  `ig_url` varchar(255) DEFAULT NULL,
  `fb_url` varchar(255) DEFAULT NULL,
  `contact_email` varchar(255) DEFAULT NULL,
  `contact_phone` varchar(255) DEFAULT NULL,
  `event_owner` varchar(255) DEFAULT NULL,
  `event_organizer` varchar(255) DEFAULT NULL,
  `event_logo` varchar(255) DEFAULT NULL,
  `event_banner` varchar(255) DEFAULT NULL,
  `jersey_size_image` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `events_slug_unique` (`slug`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES
(1,'sanga-sanga-run-2025','CLOSED','Large','SS99','Sanga Sanga Run 2025','2025-05-12 06:00:00','2025-05-12 06:00:00','Mango Lango Lake, Jl. Sawo Bakbakan, Bitera, Gianyar, Bali',NULL,NULL,NULL,NULL,'2025-10-05 00:00:00','2025-12-05 00:00:00','07.00 - 18.00',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'image/event/logo/1/01JVW61QVHSR3Z6G0E5FSY9Z61.png','image/event/banner/1/01JVW61QVK5W4HGVB3T69MB15S.png',NULL,'2025-05-16 00:59:17','2025-11-11 02:42:01'),
(3,'keramas-run-2026','OPEN','Small','KR26','KERAMAS RUN 2026','2026-01-04 06:00:00','2026-01-04 10:00:00','Keramas Water Park, Desa Keramas, Gianyar, Bali','https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3945.251407209282!2d115.32458347501341!3d-8.571808091472413!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x2dd215cd8eb338a3%3A0xdc8292375b0aebff!2sKeramas%20Water%20Park!5e0!3m2!1sen!2sid!4v1762828730666!5m2!1sen!2sid','2025-11-16','2025-12-03','Keramas Run 2026 – Run for Pertiwi\n\nNestled in Gianyar Bali, Desa Keramas is a place where time slows down and nature speaks softly. Famous for its green rice terraces, ocean breeze, and sacred temples, Desa Keramas has long been the route for big running events in Bali — a path that connects runners not only to the land, but to Pertiwi — the Mother Earth who gives us strength beneath our feet. Here, every step crosses paths with culture, every breath connects with nature, and every heartbeat echoes devotion to the land.\n\nKeramas Run 2026 celebrate the spirit of earth, culture, and unity.\nEvery step you take supports sustainability, local heritage, and the timeless beauty of Bali’s natural landscape. Let your footsteps honor the land. Let your breath carry the song of Pertiwi.\n\n“Run for Pertiwi” is more than a theme. It’s a call to run with gratitude, to honor the soil that sustains us, to carry the essence of Bali’s living tradition forward with each stride. As dawn breaks over the fields and temples of Keramas, you don’t just run — you become part of the island’s heartbeat.\n\nKeindahan suasana alam Desa Keramas, Gianyar Bali selalu menjadi daya tarik untuk rute event lari besar di Bali. Beberapa situs budaya desa dengan icon seni Tari Arja ini menghiasi background foto pelari dari seluruh dunia. Saatnya semua kalangan bisa menikmati keindahan rute lari di Desa Keramas, di event lari Keramas Run 2026.\n\nEvent Lari yang diawali pada tahun 2024 oleh Pemerintah Desa Keramas & Kawara Sports ini dikenal menyuguhkan rute pemandangan alam, situs agama dan budaya yang sangat iconic. Tahun ini, dengan dukungan STT Abdi Pertiwi Mandala, Keramas Run 2026 hadir dengan tiga kategori menarik: 5K, 10K, Kids Run. Selama berlari, peserta akan disuguhi pemandangan pedesaan Bali yang asri, hamparan sawah hijau, udara pagi yang segar, serta kehidupan lokal yang masih kental dengan budaya dan kehangatan masyarakatnya. \n\nKERAMAS RUN 2026\n📍 Lokasi: Keramas Water Park, Desa Keramas, Gianyar, Bali\n📅 RACE DAY: Minggu, 4 Januari 2026\n🏁 Kategori: 5K | 10K | Kids Run\n🎽 Fasilitas: Jersey, Medali Finisher, Goodie Bag, Refreshment, Podium & Doorprize, Zumba, DJ Entertainment, Swimming Pool & Water Playground Access','2026-01-02 00:00:00','2026-01-03 00:00:00','10.00 - 18.00','Keramas Water Park, Jl. Maruti, Keramas, Kec. Blahbatuh, Kabupaten Gianyar, Bali','https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3945.251407209282!2d115.32458347501341!3d-8.571808091472413!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x2dd215cd8eb338a3%3A0xdc8292375b0aebff!2sKeramas%20Water%20Park!5e0!3m2!1sen!2sid!4v1762828730666!5m2!1sen!2sid',NULL,'https://www.instagram.com/keramasrun',NULL,'keramasrun@gmail.com','087794250227','Pemerintah Desa Keramas & Kawara Sports','Kawara Sports & STT Abdi Pertiwi Mandala','image/event/logo/3/01K9PYXGEQBAZVQQHBHJ46A446.jpg','image/event/banner/3/01K9PF0FD7K92ZHS2VKNC32DZN.jpg','image/event/jersey-size/3/01KA0KW55V5KCYYNGY2HEG3DRF.jpg','2025-11-06 15:34:13','2025-11-17 08:42:54'),
(4,'keramas-run-2024','CLOSED',NULL,NULL,'KERAMAS RUN 2024','2024-06-29 06:00:00','2024-06-29 00:00:00','Keramas Water Park',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'image/event/banner/4/01K9HJ275QFZWAV2AY3XHM8SBE.jpg',NULL,'2025-11-08 18:43:50','2025-11-08 19:01:45'),
(5,'hotr-runniversary-2024','CLOSED',NULL,NULL,'HOTR RUNNIVERSARY 2024','2024-05-31 00:00:00','2024-05-31 00:00:00','Gianyar',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'image/event/banner/5/01K9HKWK25KRW3CF697RB5P9E3.jpg',NULL,'2025-11-08 18:48:48','2025-11-08 19:33:38'),
(6,'end-year-run-2024','CLOSED',NULL,NULL,'END YEAR RUN 2024','2024-12-29 00:00:53','2024-12-29 00:00:00','Gianyar',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'image/event/banner/6/01K9HJRV8J2AAD85675RGH20KR.jpg',NULL,'2025-11-08 19:14:07','2025-11-08 19:14:07'),
(7,'healing-fun-run','CLOSED','Small',NULL,'HEALING FUN RUN ','2025-09-28 00:00:00','2025-09-28 00:00:00','Aura Plus Fitness Studio',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'image/event/banner/7/01K9HKQDTT4TE2X0XYCPX164FW.jpg',NULL,'2025-11-08 19:21:15','2025-11-11 23:48:21'),
(8,'coffee-run','CLOSED','Small',NULL,'Coffee Run ','2025-08-18 00:00:00','2025-08-18 00:00:00','Jl. Manik, Kota Gianyar ',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'image/event/banner/8/01K9HKT0HV9ZF7B3HC8XCW11YQ.jpg',NULL,'2025-11-08 19:25:02','2025-11-11 23:49:20'),
(9,'msglow-for-men-jejak-merdeka','CLOSED','Large',NULL,'MSGLOW FOR MEN JEJAK MERDEKA','2025-08-16 00:00:00','2025-08-16 00:00:00','Gianyar',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'image/event/banner/9/01K9HKNCDBC04MVKPHYQRHV3C4.jpg',NULL,'2025-11-08 19:27:55','2025-11-11 02:42:24'),
(10,'krisna-x-klari-fun-run','CLOSED','Medium',NULL,'KRISNA X KLARI FUN RUN','2023-12-03 00:00:00','2023-12-03 00:00:00','Krisna Bali Souvenir Center',NULL,'2023-11-01','2023-11-01',NULL,'2023-10-11 00:00:00','2023-11-11 00:00:00',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'image/event/banner/10/01K9SSAEWAT59330N0CNRATEVX.jpg',NULL,'2025-11-11 23:32:24','2025-11-11 23:45:58'),
(12,'klungkung-run','TBA','Medium',NULL,'KLUNGKUNG RUN','2026-01-25 06:00:00','2026-01-25 06:00:00','Klungkung Bali',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,'image/event/logo/12/01K9TV5781ZWPTB0GQ0GT9KB4S.jpg','image/event/banner/12/01K9TV6450T6D6PRXMM14YP90K.jpg',NULL,'2025-11-12 09:33:51','2025-11-12 09:34:59');
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `exports`
--

DROP TABLE IF EXISTS `exports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `exports` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `completed_at` timestamp NULL DEFAULT NULL,
  `file_disk` varchar(255) NOT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `exporter` varchar(255) NOT NULL,
  `processed_rows` int(10) unsigned NOT NULL DEFAULT 0,
  `total_rows` int(10) unsigned NOT NULL,
  `successful_rows` int(10) unsigned NOT NULL DEFAULT 0,
  `user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `exports_user_id_foreign` (`user_id`),
  CONSTRAINT `exports_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `exports`
--

LOCK TABLES `exports` WRITE;
/*!40000 ALTER TABLE `exports` DISABLE KEYS */;
INSERT INTO `exports` VALUES
(1,NULL,'local','registrations-2025-11-07-110959','App\\Filament\\Exports\\RegistrationExporter',0,761,0,1,'2025-11-07 23:10:00','2025-11-07 23:10:00'),
(2,NULL,'local','registration-2025-11-07-111024','App\\Filament\\Exports\\RegistrationExporter',0,761,0,1,'2025-11-07 23:10:24','2025-11-07 23:10:24');
/*!40000 ALTER TABLE `exports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_import_rows`
--

DROP TABLE IF EXISTS `failed_import_rows`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_import_rows` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`data`)),
  `import_id` bigint(20) unsigned NOT NULL,
  `validation_error` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `failed_import_rows_import_id_foreign` (`import_id`),
  CONSTRAINT `failed_import_rows_import_id_foreign` FOREIGN KEY (`import_id`) REFERENCES `imports` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_import_rows`
--

LOCK TABLES `failed_import_rows` WRITE;
/*!40000 ALTER TABLE `failed_import_rows` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_import_rows` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `failed_jobs`
--

DROP TABLE IF EXISTS `failed_jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `failed_jobs`
--

LOCK TABLES `failed_jobs` WRITE;
/*!40000 ALTER TABLE `failed_jobs` DISABLE KEYS */;
/*!40000 ALTER TABLE `failed_jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `imports`
--

DROP TABLE IF EXISTS `imports`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `imports` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `completed_at` timestamp NULL DEFAULT NULL,
  `file_name` varchar(255) NOT NULL,
  `file_path` varchar(255) NOT NULL,
  `importer` varchar(255) NOT NULL,
  `processed_rows` int(10) unsigned NOT NULL DEFAULT 0,
  `total_rows` int(10) unsigned NOT NULL,
  `successful_rows` int(10) unsigned NOT NULL DEFAULT 0,
  `user_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `imports_user_id_foreign` (`user_id`),
  CONSTRAINT `imports_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `imports`
--

LOCK TABLES `imports` WRITE;
/*!40000 ALTER TABLE `imports` DISABLE KEYS */;
/*!40000 ALTER TABLE `imports` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `job_batches`
--

DROP TABLE IF EXISTS `job_batches`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `job_batches` (
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `job_batches`
--

LOCK TABLES `job_batches` WRITE;
/*!40000 ALTER TABLE `job_batches` DISABLE KEYS */;
/*!40000 ALTER TABLE `job_batches` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `jobs`
--

DROP TABLE IF EXISTS `jobs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(255) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `jobs`
--

LOCK TABLES `jobs` WRITE;
/*!40000 ALTER TABLE `jobs` DISABLE KEYS */;
INSERT INTO `jobs` VALUES
(1,'default','{\"uuid\":\"0dedaf65-3382-45f6-a275-4c11762c7333\",\"displayName\":\"Illuminate\\\\Bus\\\\ChainedBatch\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Bus\\\\ChainedBatch\",\"command\":\"O:27:\\\"Illuminate\\\\Bus\\\\ChainedBatch\\\":15:{s:4:\\\"jobs\\\";O:29:\\\"Illuminate\\\\Support\\\\Collection\\\":2:{s:8:\\\"\\u0000*\\u0000items\\\";a:1:{i:0;O:46:\\\"Filament\\\\Actions\\\\Exports\\\\Jobs\\\\PrepareCsvExport\\\":7:{s:11:\\\"\\u0000*\\u0000exporter\\\";O:41:\\\"App\\\\Filament\\\\Exports\\\\RegistrationExporter\\\":3:{s:9:\\\"\\u0000*\\u0000export\\\";O:38:\\\"Filament\\\\Actions\\\\Exports\\\\Models\\\\Export\\\":31:{s:13:\\\"\\u0000*\\u0000connection\\\";s:5:\\\"mysql\\\";s:8:\\\"\\u0000*\\u0000table\\\";N;s:13:\\\"\\u0000*\\u0000primaryKey\\\";s:2:\\\"id\\\";s:10:\\\"\\u0000*\\u0000keyType\\\";s:3:\\\"int\\\";s:12:\\\"incrementing\\\";b:1;s:7:\\\"\\u0000*\\u0000with\\\";a:0:{}s:12:\\\"\\u0000*\\u0000withCount\\\";a:0:{}s:19:\\\"preventsLazyLoading\\\";b:0;s:10:\\\"\\u0000*\\u0000perPage\\\";i:15;s:6:\\\"exists\\\";b:1;s:18:\\\"wasRecentlyCreated\\\";b:1;s:28:\\\"\\u0000*\\u0000escapeWhenCastingToString\\\";b:0;s:13:\\\"\\u0000*\\u0000attributes\\\";a:8:{s:7:\\\"user_id\\\";i:1;s:8:\\\"exporter\\\";s:41:\\\"App\\\\Filament\\\\Exports\\\\RegistrationExporter\\\";s:10:\\\"total_rows\\\";i:761;s:9:\\\"file_disk\\\";s:5:\\\"local\\\";s:10:\\\"updated_at\\\";s:19:\\\"2025-11-07 23:10:00\\\";s:10:\\\"created_at\\\";s:19:\\\"2025-11-07 23:10:00\\\";s:2:\\\"id\\\";i:1;s:9:\\\"file_name\\\";s:31:\\\"registrations-2025-11-07-110959\\\";}s:11:\\\"\\u0000*\\u0000original\\\";a:8:{s:7:\\\"user_id\\\";i:1;s:8:\\\"exporter\\\";s:41:\\\"App\\\\Filament\\\\Exports\\\\RegistrationExporter\\\";s:10:\\\"total_rows\\\";i:761;s:9:\\\"file_disk\\\";s:5:\\\"local\\\";s:10:\\\"updated_at\\\";s:19:\\\"2025-11-07 23:10:00\\\";s:10:\\\"created_at\\\";s:19:\\\"2025-11-07 23:10:00\\\";s:2:\\\"id\\\";i:1;s:9:\\\"file_name\\\";s:31:\\\"registrations-2025-11-07-110959\\\";}s:10:\\\"\\u0000*\\u0000changes\\\";a:1:{s:9:\\\"file_name\\\";s:31:\\\"registrations-2025-11-07-110959\\\";}s:8:\\\"\\u0000*\\u0000casts\\\";a:4:{s:12:\\\"completed_at\\\";s:9:\\\"timestamp\\\";s:14:\\\"processed_rows\\\";s:7:\\\"integer\\\";s:10:\\\"total_rows\\\";s:7:\\\"integer\\\";s:15:\\\"successful_rows\\\";s:7:\\\"integer\\\";}s:17:\\\"\\u0000*\\u0000classCastCache\\\";a:0:{}s:21:\\\"\\u0000*\\u0000attributeCastCache\\\";a:0:{}s:13:\\\"\\u0000*\\u0000dateFormat\\\";N;s:10:\\\"\\u0000*\\u0000appends\\\";a:0:{}s:19:\\\"\\u0000*\\u0000dispatchesEvents\\\";a:0:{}s:14:\\\"\\u0000*\\u0000observables\\\";a:0:{}s:12:\\\"\\u0000*\\u0000relations\\\";a:0:{}s:10:\\\"\\u0000*\\u0000touches\\\";a:0:{}s:27:\\\"\\u0000*\\u0000relationAutoloadCallback\\\";N;s:10:\\\"timestamps\\\";b:1;s:13:\\\"usesUniqueIds\\\";b:0;s:9:\\\"\\u0000*\\u0000hidden\\\";a:0:{}s:10:\\\"\\u0000*\\u0000visible\\\";a:0:{}s:11:\\\"\\u0000*\\u0000fillable\\\";a:0:{}s:10:\\\"\\u0000*\\u0000guarded\\\";a:0:{}}s:12:\\\"\\u0000*\\u0000columnMap\\\";a:24:{s:2:\\\"id\\\";s:2:\\\"ID\\\";s:15:\\\"ticketType.name\\\";s:5:\\\"Tiket\\\";s:9:\\\"full_name\\\";s:4:\\\"Nama\\\";s:5:\\\"email\\\";s:5:\\\"Email\\\";s:5:\\\"phone\\\";s:8:\\\"Nomor HP\\\";s:6:\\\"gender\\\";s:13:\\\"Jenis Kelamin\\\";s:14:\\\"place_of_birth\\\";s:12:\\\"Tempat Lahir\\\";s:3:\\\"dob\\\";s:13:\\\"Tanggal Lahir\\\";s:7:\\\"address\\\";s:6:\\\"Alamat\\\";s:8:\\\"district\\\";s:9:\\\"Kecamatan\\\";s:8:\\\"province\\\";s:8:\\\"Provinsi\\\";s:7:\\\"country\\\";s:6:\\\"Negara\\\";s:12:\\\"id_card_type\\\";s:20:\\\"Tipe Kartu Identitas\\\";s:14:\\\"id_card_number\\\";s:21:\\\"Nomor Kartu Identitas\\\";s:22:\\\"emergency_contact_name\\\";s:19:\\\"Nama Kontak Darurat\\\";s:23:\\\"emergency_contact_phone\\\";s:20:\\\"Nomor Kontak Darurat\\\";s:10:\\\"blood_type\\\";s:14:\\\"Golongan Darah\\\";s:11:\\\"nationality\\\";s:15:\\\"Kewarganegaraan\\\";s:11:\\\"jersey_size\\\";s:11:\\\"Size Jersey\\\";s:14:\\\"community_name\\\";s:9:\\\"Komunitas\\\";s:8:\\\"bib_name\\\";s:9:\\\"Nomer BIB\\\";s:6:\\\"reg_id\\\";s:16:\\\"Nomer Registrasi\\\";s:17:\\\"registration_date\\\";s:18:\\\"Tanggal Registrasi\\\";s:15:\\\"invitation_code\\\";s:13:\\\"Kode Undangan\\\";}s:10:\\\"\\u0000*\\u0000options\\\";a:0:{}}s:9:\\\"\\u0000*\\u0000export\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:38:\\\"Filament\\\\Actions\\\\Exports\\\\Models\\\\Export\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:8:\\\"\\u0000*\\u0000query\\\";s:637:\\\"O:36:\\\"AnourValar\\\\EloquentSerialize\\\\Package\\\":1:{s:42:\\\"\\u0000AnourValar\\\\EloquentSerialize\\\\Package\\u0000data\\\";a:4:{s:5:\\\"model\\\";s:23:\\\"App\\\\Models\\\\Registration\\\";s:10:\\\"connection\\\";N;s:8:\\\"eloquent\\\";a:3:{s:4:\\\"with\\\";a:0:{}s:14:\\\"removed_scopes\\\";a:0:{}s:5:\\\"casts\\\";a:1:{s:2:\\\"id\\\";s:3:\\\"int\\\";}}s:5:\\\"query\\\";a:5:{s:8:\\\"bindings\\\";a:9:{s:6:\\\"select\\\";a:0:{}s:4:\\\"from\\\";a:0:{}s:4:\\\"join\\\";a:0:{}s:5:\\\"where\\\";a:0:{}s:7:\\\"groupBy\\\";a:0:{}s:6:\\\"having\\\";a:0:{}s:5:\\\"order\\\";a:0:{}s:5:\\\"union\\\";a:0:{}s:10:\\\"unionOrder\\\";a:0:{}}s:8:\\\"distinct\\\";b:0;s:4:\\\"from\\\";s:13:\\\"registrations\\\";s:6:\\\"wheres\\\";a:0:{}s:6:\\\"orders\\\";a:1:{i:0;a:2:{s:6:\\\"column\\\";s:12:\\\"is_validated\\\";s:9:\\\"direction\\\";s:3:\\\"asc\\\";}}}}}\\\";s:12:\\\"\\u0000*\\u0000columnMap\\\";a:24:{s:2:\\\"id\\\";s:2:\\\"ID\\\";s:15:\\\"ticketType.name\\\";s:5:\\\"Tiket\\\";s:9:\\\"full_name\\\";s:4:\\\"Nama\\\";s:5:\\\"email\\\";s:5:\\\"Email\\\";s:5:\\\"phone\\\";s:8:\\\"Nomor HP\\\";s:6:\\\"gender\\\";s:13:\\\"Jenis Kelamin\\\";s:14:\\\"place_of_birth\\\";s:12:\\\"Tempat Lahir\\\";s:3:\\\"dob\\\";s:13:\\\"Tanggal Lahir\\\";s:7:\\\"address\\\";s:6:\\\"Alamat\\\";s:8:\\\"district\\\";s:9:\\\"Kecamatan\\\";s:8:\\\"province\\\";s:8:\\\"Provinsi\\\";s:7:\\\"country\\\";s:6:\\\"Negara\\\";s:12:\\\"id_card_type\\\";s:20:\\\"Tipe Kartu Identitas\\\";s:14:\\\"id_card_number\\\";s:21:\\\"Nomor Kartu Identitas\\\";s:22:\\\"emergency_contact_name\\\";s:19:\\\"Nama Kontak Darurat\\\";s:23:\\\"emergency_contact_phone\\\";s:20:\\\"Nomor Kontak Darurat\\\";s:10:\\\"blood_type\\\";s:14:\\\"Golongan Darah\\\";s:11:\\\"nationality\\\";s:15:\\\"Kewarganegaraan\\\";s:11:\\\"jersey_size\\\";s:11:\\\"Size Jersey\\\";s:14:\\\"community_name\\\";s:9:\\\"Komunitas\\\";s:8:\\\"bib_name\\\";s:9:\\\"Nomer BIB\\\";s:6:\\\"reg_id\\\";s:16:\\\"Nomer Registrasi\\\";s:17:\\\"registration_date\\\";s:18:\\\"Tanggal Registrasi\\\";s:15:\\\"invitation_code\\\";s:13:\\\"Kode Undangan\\\";}s:10:\\\"\\u0000*\\u0000options\\\";a:0:{}s:12:\\\"\\u0000*\\u0000chunkSize\\\";i:100;s:10:\\\"\\u0000*\\u0000records\\\";a:761:{i:0;i:32;i:1;i:156;i:2;i:153;i:3;i:231;i:4;i:187;i:5;i:64;i:6;i:362;i:7;i:274;i:8;i:426;i:9;i:427;i:10;i:391;i:11;i:429;i:12;i:434;i:13;i:827;i:14;i:836;i:15;i:835;i:16;i:834;i:17;i:833;i:18;i:832;i:19;i:831;i:20;i:830;i:21;i:829;i:22;i:828;i:23;i:647;i:24;i:622;i:25;i:699;i:26;i:543;i:27;i:687;i:28;i:670;i:29;i:669;i:30;i:668;i:31;i:667;i:32;i:666;i:33;i:665;i:34;i:664;i:35;i:663;i:36;i:662;i:37;i:661;i:38;i:660;i:39;i:671;i:40;i:672;i:41;i:673;i:42;i:686;i:43;i:685;i:44;i:684;i:45;i:683;i:46;i:682;i:47;i:681;i:48;i:680;i:49;i:679;i:50;i:678;i:51;i:677;i:52;i:676;i:53;i:675;i:54;i:674;i:55;i:659;i:56;i:658;i:57;i:640;i:58;i:639;i:59;i:638;i:60;i:637;i:61;i:636;i:62;i:635;i:63;i:634;i:64;i:633;i:65;i:632;i:66;i:631;i:67;i:630;i:68;i:629;i:69;i:628;i:70;i:641;i:71;i:642;i:72;i:643;i:73;i:657;i:74;i:656;i:75;i:655;i:76;i:654;i:77;i:653;i:78;i:652;i:79;i:651;i:80;i:650;i:81;i:649;i:82;i:648;i:83;i:646;i:84;i:645;i:85;i:644;i:86;i:627;i:87;i:750;i:88;i:733;i:89;i:732;i:90;i:731;i:91;i:730;i:92;i:729;i:93;i:728;i:94;i:727;i:95;i:726;i:96;i:725;i:97;i:724;i:98;i:723;i:99;i:722;i:100;i:721;i:101;i:734;i:102;i:735;i:103;i:736;i:104;i:749;i:105;i:748;i:106;i:747;i:107;i:746;i:108;i:745;i:109;i:744;i:110;i:743;i:111;i:742;i:112;i:741;i:113;i:740;i:114;i:739;i:115;i:738;i:116;i:737;i:117;i:720;i:118;i:719;i:119;i:702;i:120;i:701;i:121;i:700;i:122;i:698;i:123;i:697;i:124;i:696;i:125;i:695;i:126;i:694;i:127;i:693;i:128;i:692;i:129;i:691;i:130;i:690;i:131;i:689;i:132;i:703;i:133;i:704;i:134;i:705;i:135;i:718;i:136;i:717;i:137;i:716;i:138;i:715;i:139;i:714;i:140;i:713;i:141;i:712;i:142;i:711;i:143;i:710;i:144;i:709;i:145;i:708;i:146;i:707;i:147;i:706;i:148;i:688;i:149;i:563;i:150;i:546;i:151;i:545;i:152;i:544;i:153;i:542;i:154;i:541;i:155;i:540;i:156;i:539;i:157;i:538;i:158;i:537;i:159;i:536;i:160;i:535;i:161;i:534;i:162;i:533;i:163;i:547;i:164;i:548;i:165;i:549;i:166;i:562;i:167;i:561;i:168;i:560;i:169;i:559;i:170;i:558;i:171;i:557;i:172;i:556;i:173;i:555;i:174;i:554;i:175;i:553;i:176;i:552;i:177;i:551;i:178;i:550;i:179;i:532;i:180;i:531;i:181;i:514;i:182;i:513;i:183;i:512;i:184;i:511;i:185;i:510;i:186;i:509;i:187;i:508;i:188;i:507;i:189;i:506;i:190;i:505;i:191;i:504;i:192;i:503;i:193;i:502;i:194;i:515;i:195;i:516;i:196;i:517;i:197;i:530;i:198;i:529;i:199;i:528;i:200;i:527;i:201;i:526;i:202;i:525;i:203;i:524;i:204;i:523;i:205;i:522;i:206;i:521;i:207;i:520;i:208;i:519;i:209;i:518;i:210;i:501;i:211;i:626;i:212;i:608;i:213;i:607;i:214;i:606;i:215;i:605;i:216;i:604;i:217;i:603;i:218;i:602;i:219;i:601;i:220;i:600;i:221;i:599;i:222;i:598;i:223;i:597;i:224;i:596;i:225;i:609;i:226;i:610;i:227;i:611;i:228;i:625;i:229;i:624;i:230;i:623;i:231;i:621;i:232;i:620;i:233;i:619;i:234;i:618;i:235;i:617;i:236;i:616;i:237;i:615;i:238;i:614;i:239;i:613;i:240;i:612;i:241;i:595;i:242;i:594;i:243;i:577;i:244;i:576;i:245;i:575;i:246;i:574;i:247;i:573;i:248;i:572;i:249;i:571;i:250;i:570;i:251;i:569;i:252;i:568;i:253;i:567;i:254;i:566;i:255;i:565;i:256;i:578;i:257;i:579;i:258;i:580;i:259;i:593;i:260;i:592;i:261;i:591;i:262;i:590;i:263;i:589;i:264;i:588;i:265;i:587;i:266;i:586;i:267;i:585;i:268;i:584;i:269;i:583;i:270;i:582;i:271;i:581;i:272;i:564;i:273;i:182;i:274;i:169;i:275;i:168;i:276;i:167;i:277;i:166;i:278;i:165;i:279;i:164;i:280;i:163;i:281;i:186;i:282;i:162;i:283;i:161;i:284;i:172;i:285;i:160;i:286;i:185;i:287;i:170;i:288;i:181;i:289;i:180;i:290;i:179;i:291;i:178;i:292;i:177;i:293;i:176;i:294;i:175;i:295;i:174;i:296;i:173;i:297;i:183;i:298;i:184;i:299;i:171;i:300;i:159;i:301;i:158;i:302;i:140;i:303;i:139;i:304;i:138;i:305;i:137;i:306;i:136;i:307;i:135;i:308;i:134;i:309;i:133;i:310;i:132;i:311;i:131;i:312;i:130;i:313;i:129;i:314;i:128;i:315;i:141;i:316;i:142;i:317;i:157;i:318;i:155;i:319;i:154;i:320;i:152;i:321;i:151;i:322;i:150;i:323;i:149;i:324;i:148;i:325;i:147;i:326;i:146;i:327;i:145;i:328;i:144;i:329;i:143;i:330;i:127;i:331;i:188;i:332;i:250;i:333;i:234;i:334;i:233;i:335;i:232;i:336;i:230;i:337;i:229;i:338;i:228;i:339;i:227;i:340;i:226;i:341;i:225;i:342;i:224;i:343;i:223;i:344;i:222;i:345;i:221;i:346;i:235;i:347;i:236;i:348;i:249;i:349;i:248;i:350;i:247;i:351;i:246;i:352;i:245;i:353;i:244;i:354;i:243;i:355;i:242;i:356;i:241;i:357;i:240;i:358;i:239;i:359;i:238;i:360;i:237;i:361;i:220;i:362;i:219;i:363;i:218;i:364;i:201;i:365;i:200;i:366;i:199;i:367;i:198;i:368;i:197;i:369;i:196;i:370;i:195;i:371;i:194;i:372;i:193;i:373;i:192;i:374;i:191;i:375;i:190;i:376;i:189;i:377;i:202;i:378;i:204;i:379;i:217;i:380;i:216;i:381;i:215;i:382;i:214;i:383;i:213;i:384;i:212;i:385;i:211;i:386;i:210;i:387;i:209;i:388;i:208;i:389;i:207;i:390;i:206;i:391;i:205;i:392;i:203;i:393;i:63;i:394;i:46;i:395;i:45;i:396;i:44;i:397;i:43;i:398;i:42;i:399;i:41;i:400;i:40;i:401;i:39;i:402;i:38;i:403;i:37;i:404;i:36;i:405;i:35;i:406;i:34;i:407;i:47;i:408;i:48;i:409;i:49;i:410;i:62;i:411;i:61;i:412;i:60;i:413;i:59;i:414;i:58;i:415;i:57;i:416;i:56;i:417;i:55;i:418;i:54;i:419;i:53;i:420;i:52;i:421;i:51;i:422;i:50;i:423;i:33;i:424;i:1;i:425;i:15;i:426;i:14;i:427;i:13;i:428;i:12;i:429;i:11;i:430;i:10;i:431;i:9;i:432;i:8;i:433;i:7;i:434;i:6;i:435;i:5;i:436;i:4;i:437;i:3;i:438;i:16;i:439;i:17;i:440;i:18;i:441;i:31;i:442;i:30;i:443;i:29;i:444;i:28;i:445;i:27;i:446;i:26;i:447;i:25;i:448;i:24;i:449;i:23;i:450;i:22;i:451;i:21;i:452;i:20;i:453;i:19;i:454;i:2;i:455;i:126;i:456;i:109;i:457;i:108;i:458;i:107;i:459;i:106;i:460;i:105;i:461;i:104;i:462;i:103;i:463;i:102;i:464;i:101;i:465;i:100;i:466;i:99;i:467;i:98;i:468;i:97;i:469;i:110;i:470;i:111;i:471;i:112;i:472;i:125;i:473;i:124;i:474;i:123;i:475;i:122;i:476;i:121;i:477;i:120;i:478;i:119;i:479;i:118;i:480;i:117;i:481;i:116;i:482;i:115;i:483;i:114;i:484;i:113;i:485;i:96;i:486;i:95;i:487;i:78;i:488;i:77;i:489;i:76;i:490;i:75;i:491;i:74;i:492;i:73;i:493;i:72;i:494;i:71;i:495;i:70;i:496;i:69;i:497;i:68;i:498;i:67;i:499;i:66;i:500;i:79;i:501;i:80;i:502;i:81;i:503;i:94;i:504;i:93;i:505;i:92;i:506;i:91;i:507;i:90;i:508;i:89;i:509;i:88;i:510;i:87;i:511;i:86;i:512;i:85;i:513;i:84;i:514;i:83;i:515;i:82;i:516;i:65;i:517;i:837;i:518;i:413;i:519;i:418;i:520;i:417;i:521;i:416;i:522;i:409;i:523;i:410;i:524;i:411;i:525;i:412;i:526;i:415;i:527;i:414;i:528;i:419;i:529;i:420;i:530;i:421;i:531;i:437;i:532;i:436;i:533;i:435;i:534;i:433;i:535;i:432;i:536;i:431;i:537;i:430;i:538;i:428;i:539;i:425;i:540;i:424;i:541;i:423;i:542;i:422;i:543;i:408;i:544;i:407;i:545;i:377;i:546;i:390;i:547;i:389;i:548;i:388;i:549;i:387;i:550;i:386;i:551;i:385;i:552;i:384;i:553;i:383;i:554;i:382;i:555;i:381;i:556;i:380;i:557;i:379;i:558;i:406;i:559;i:392;i:560;i:399;i:561;i:405;i:562;i:404;i:563;i:403;i:564;i:402;i:565;i:401;i:566;i:400;i:567;i:398;i:568;i:397;i:569;i:396;i:570;i:395;i:571;i:394;i:572;i:393;i:573;i:378;i:574;i:438;i:575;i:500;i:576;i:483;i:577;i:482;i:578;i:481;i:579;i:480;i:580;i:479;i:581;i:478;i:582;i:477;i:583;i:476;i:584;i:475;i:585;i:474;i:586;i:473;i:587;i:472;i:588;i:471;i:589;i:484;i:590;i:485;i:591;i:486;i:592;i:499;i:593;i:498;i:594;i:497;i:595;i:496;i:596;i:495;i:597;i:494;i:598;i:493;i:599;i:492;i:600;i:491;i:601;i:490;i:602;i:489;i:603;i:488;i:604;i:487;i:605;i:470;i:606;i:469;i:607;i:452;i:608;i:451;i:609;i:450;i:610;i:449;i:611;i:448;i:612;i:447;i:613;i:446;i:614;i:445;i:615;i:444;i:616;i:443;i:617;i:442;i:618;i:441;i:619;i:440;i:620;i:453;i:621;i:454;i:622;i:455;i:623;i:468;i:624;i:467;i:625;i:466;i:626;i:465;i:627;i:464;i:628;i:463;i:629;i:462;i:630;i:461;i:631;i:460;i:632;i:459;i:633;i:458;i:634;i:457;i:635;i:456;i:636;i:439;i:637;i:313;i:638;i:296;i:639;i:295;i:640;i:294;i:641;i:293;i:642;i:292;i:643;i:291;i:644;i:290;i:645;i:289;i:646;i:288;i:647;i:287;i:648;i:286;i:649;i:285;i:650;i:284;i:651;i:297;i:652;i:298;i:653;i:299;i:654;i:312;i:655;i:311;i:656;i:310;i:657;i:309;i:658;i:308;i:659;i:307;i:660;i:306;i:661;i:305;i:662;i:304;i:663;i:303;i:664;i:302;i:665;i:301;i:666;i:300;i:667;i:283;i:668;i:282;i:669;i:264;i:670;i:263;i:671;i:262;i:672;i:261;i:673;i:260;i:674;i:259;i:675;i:258;i:676;i:257;i:677;i:256;i:678;i:255;i:679;i:254;i:680;i:253;i:681;i:252;i:682;i:265;i:683;i:266;i:684;i:267;i:685;i:281;i:686;i:280;i:687;i:279;i:688;i:278;i:689;i:277;i:690;i:276;i:691;i:275;i:692;i:273;i:693;i:272;i:694;i:271;i:695;i:270;i:696;i:269;i:697;i:268;i:698;i:251;i:699;i:376;i:700;i:358;i:701;i:357;i:702;i:356;i:703;i:355;i:704;i:354;i:705;i:353;i:706;i:352;i:707;i:351;i:708;i:350;i:709;i:349;i:710;i:348;i:711;i:347;i:712;i:346;i:713;i:359;i:714;i:360;i:715;i:361;i:716;i:375;i:717;i:374;i:718;i:373;i:719;i:372;i:720;i:371;i:721;i:370;i:722;i:369;i:723;i:368;i:724;i:367;i:725;i:366;i:726;i:365;i:727;i:364;i:728;i:363;i:729;i:345;i:730;i:344;i:731;i:327;i:732;i:326;i:733;i:325;i:734;i:324;i:735;i:323;i:736;i:322;i:737;i:321;i:738;i:320;i:739;i:319;i:740;i:318;i:741;i:317;i:742;i:316;i:743;i:315;i:744;i:328;i:745;i:329;i:746;i:330;i:747;i:343;i:748;i:342;i:749;i:341;i:750;i:340;i:751;i:339;i:752;i:338;i:753;i:337;i:754;i:336;i:755;i:335;i:756;i:334;i:757;i:333;i:758;i:332;i:759;i:331;i:760;i:314;}}}s:28:\\\"\\u0000*\\u0000escapeWhenCastingToString\\\";b:0;}s:4:\\\"name\\\";s:0:\\\"\\\";s:7:\\\"options\\\";a:1:{s:13:\\\"allowFailures\\\";b:1;}s:7:\\\"batchId\\\";N;s:38:\\\"\\u0000Illuminate\\\\Bus\\\\ChainedBatch\\u0000fakeBatch\\\";N;s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:2:{i:0;s:4040:\\\"O:46:\\\"Filament\\\\Actions\\\\Exports\\\\Jobs\\\\ExportCompletion\\\":5:{s:11:\\\"\\u0000*\\u0000exporter\\\";O:41:\\\"App\\\\Filament\\\\Exports\\\\RegistrationExporter\\\":3:{s:9:\\\"\\u0000*\\u0000export\\\";O:38:\\\"Filament\\\\Actions\\\\Exports\\\\Models\\\\Export\\\":31:{s:13:\\\"\\u0000*\\u0000connection\\\";s:5:\\\"mysql\\\";s:8:\\\"\\u0000*\\u0000table\\\";N;s:13:\\\"\\u0000*\\u0000primaryKey\\\";s:2:\\\"id\\\";s:10:\\\"\\u0000*\\u0000keyType\\\";s:3:\\\"int\\\";s:12:\\\"incrementing\\\";b:1;s:7:\\\"\\u0000*\\u0000with\\\";a:0:{}s:12:\\\"\\u0000*\\u0000withCount\\\";a:0:{}s:19:\\\"preventsLazyLoading\\\";b:0;s:10:\\\"\\u0000*\\u0000perPage\\\";i:15;s:6:\\\"exists\\\";b:1;s:18:\\\"wasRecentlyCreated\\\";b:1;s:28:\\\"\\u0000*\\u0000escapeWhenCastingToString\\\";b:0;s:13:\\\"\\u0000*\\u0000attributes\\\";a:8:{s:7:\\\"user_id\\\";i:1;s:8:\\\"exporter\\\";s:41:\\\"App\\\\Filament\\\\Exports\\\\RegistrationExporter\\\";s:10:\\\"total_rows\\\";i:761;s:9:\\\"file_disk\\\";s:5:\\\"local\\\";s:10:\\\"updated_at\\\";s:19:\\\"2025-11-07 23:10:00\\\";s:10:\\\"created_at\\\";s:19:\\\"2025-11-07 23:10:00\\\";s:2:\\\"id\\\";i:1;s:9:\\\"file_name\\\";s:31:\\\"registrations-2025-11-07-110959\\\";}s:11:\\\"\\u0000*\\u0000original\\\";a:8:{s:7:\\\"user_id\\\";i:1;s:8:\\\"exporter\\\";s:41:\\\"App\\\\Filament\\\\Exports\\\\RegistrationExporter\\\";s:10:\\\"total_rows\\\";i:761;s:9:\\\"file_disk\\\";s:5:\\\"local\\\";s:10:\\\"updated_at\\\";s:19:\\\"2025-11-07 23:10:00\\\";s:10:\\\"created_at\\\";s:19:\\\"2025-11-07 23:10:00\\\";s:2:\\\"id\\\";i:1;s:9:\\\"file_name\\\";s:31:\\\"registrations-2025-11-07-110959\\\";}s:10:\\\"\\u0000*\\u0000changes\\\";a:1:{s:9:\\\"file_name\\\";s:31:\\\"registrations-2025-11-07-110959\\\";}s:8:\\\"\\u0000*\\u0000casts\\\";a:4:{s:12:\\\"completed_at\\\";s:9:\\\"timestamp\\\";s:14:\\\"processed_rows\\\";s:7:\\\"integer\\\";s:10:\\\"total_rows\\\";s:7:\\\"integer\\\";s:15:\\\"successful_rows\\\";s:7:\\\"integer\\\";}s:17:\\\"\\u0000*\\u0000classCastCache\\\";a:0:{}s:21:\\\"\\u0000*\\u0000attributeCastCache\\\";a:0:{}s:13:\\\"\\u0000*\\u0000dateFormat\\\";N;s:10:\\\"\\u0000*\\u0000appends\\\";a:0:{}s:19:\\\"\\u0000*\\u0000dispatchesEvents\\\";a:0:{}s:14:\\\"\\u0000*\\u0000observables\\\";a:0:{}s:12:\\\"\\u0000*\\u0000relations\\\";a:0:{}s:10:\\\"\\u0000*\\u0000touches\\\";a:0:{}s:27:\\\"\\u0000*\\u0000relationAutoloadCallback\\\";N;s:10:\\\"timestamps\\\";b:1;s:13:\\\"usesUniqueIds\\\";b:0;s:9:\\\"\\u0000*\\u0000hidden\\\";a:0:{}s:10:\\\"\\u0000*\\u0000visible\\\";a:0:{}s:11:\\\"\\u0000*\\u0000fillable\\\";a:0:{}s:10:\\\"\\u0000*\\u0000guarded\\\";a:0:{}}s:12:\\\"\\u0000*\\u0000columnMap\\\";a:24:{s:2:\\\"id\\\";s:2:\\\"ID\\\";s:15:\\\"ticketType.name\\\";s:5:\\\"Tiket\\\";s:9:\\\"full_name\\\";s:4:\\\"Nama\\\";s:5:\\\"email\\\";s:5:\\\"Email\\\";s:5:\\\"phone\\\";s:8:\\\"Nomor HP\\\";s:6:\\\"gender\\\";s:13:\\\"Jenis Kelamin\\\";s:14:\\\"place_of_birth\\\";s:12:\\\"Tempat Lahir\\\";s:3:\\\"dob\\\";s:13:\\\"Tanggal Lahir\\\";s:7:\\\"address\\\";s:6:\\\"Alamat\\\";s:8:\\\"district\\\";s:9:\\\"Kecamatan\\\";s:8:\\\"province\\\";s:8:\\\"Provinsi\\\";s:7:\\\"country\\\";s:6:\\\"Negara\\\";s:12:\\\"id_card_type\\\";s:20:\\\"Tipe Kartu Identitas\\\";s:14:\\\"id_card_number\\\";s:21:\\\"Nomor Kartu Identitas\\\";s:22:\\\"emergency_contact_name\\\";s:19:\\\"Nama Kontak Darurat\\\";s:23:\\\"emergency_contact_phone\\\";s:20:\\\"Nomor Kontak Darurat\\\";s:10:\\\"blood_type\\\";s:14:\\\"Golongan Darah\\\";s:11:\\\"nationality\\\";s:15:\\\"Kewarganegaraan\\\";s:11:\\\"jersey_size\\\";s:11:\\\"Size Jersey\\\";s:14:\\\"community_name\\\";s:9:\\\"Komunitas\\\";s:8:\\\"bib_name\\\";s:9:\\\"Nomer BIB\\\";s:6:\\\"reg_id\\\";s:16:\\\"Nomer Registrasi\\\";s:17:\\\"registration_date\\\";s:18:\\\"Tanggal Registrasi\\\";s:15:\\\"invitation_code\\\";s:13:\\\"Kode Undangan\\\";}s:10:\\\"\\u0000*\\u0000options\\\";a:0:{}}s:9:\\\"\\u0000*\\u0000export\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:38:\\\"Filament\\\\Actions\\\\Exports\\\\Models\\\\Export\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"\\u0000*\\u0000columnMap\\\";a:24:{s:2:\\\"id\\\";s:2:\\\"ID\\\";s:15:\\\"ticketType.name\\\";s:5:\\\"Tiket\\\";s:9:\\\"full_name\\\";s:4:\\\"Nama\\\";s:5:\\\"email\\\";s:5:\\\"Email\\\";s:5:\\\"phone\\\";s:8:\\\"Nomor HP\\\";s:6:\\\"gender\\\";s:13:\\\"Jenis Kelamin\\\";s:14:\\\"place_of_birth\\\";s:12:\\\"Tempat Lahir\\\";s:3:\\\"dob\\\";s:13:\\\"Tanggal Lahir\\\";s:7:\\\"address\\\";s:6:\\\"Alamat\\\";s:8:\\\"district\\\";s:9:\\\"Kecamatan\\\";s:8:\\\"province\\\";s:8:\\\"Provinsi\\\";s:7:\\\"country\\\";s:6:\\\"Negara\\\";s:12:\\\"id_card_type\\\";s:20:\\\"Tipe Kartu Identitas\\\";s:14:\\\"id_card_number\\\";s:21:\\\"Nomor Kartu Identitas\\\";s:22:\\\"emergency_contact_name\\\";s:19:\\\"Nama Kontak Darurat\\\";s:23:\\\"emergency_contact_phone\\\";s:20:\\\"Nomor Kontak Darurat\\\";s:10:\\\"blood_type\\\";s:14:\\\"Golongan Darah\\\";s:11:\\\"nationality\\\";s:15:\\\"Kewarganegaraan\\\";s:11:\\\"jersey_size\\\";s:11:\\\"Size Jersey\\\";s:14:\\\"community_name\\\";s:9:\\\"Komunitas\\\";s:8:\\\"bib_name\\\";s:9:\\\"Nomer BIB\\\";s:6:\\\"reg_id\\\";s:16:\\\"Nomer Registrasi\\\";s:17:\\\"registration_date\\\";s:18:\\\"Tanggal Registrasi\\\";s:15:\\\"invitation_code\\\";s:13:\\\"Kode Undangan\\\";}s:10:\\\"\\u0000*\\u0000formats\\\";a:2:{i:0;E:47:\\\"Filament\\\\Actions\\\\Exports\\\\Enums\\\\ExportFormat:Csv\\\";i:1;E:48:\\\"Filament\\\\Actions\\\\Exports\\\\Enums\\\\ExportFormat:Xlsx\\\";}s:10:\\\"\\u0000*\\u0000options\\\";a:0:{}}\\\";i:1;s:3895:\\\"O:44:\\\"Filament\\\\Actions\\\\Exports\\\\Jobs\\\\CreateXlsxFile\\\":4:{s:11:\\\"\\u0000*\\u0000exporter\\\";O:41:\\\"App\\\\Filament\\\\Exports\\\\RegistrationExporter\\\":3:{s:9:\\\"\\u0000*\\u0000export\\\";O:38:\\\"Filament\\\\Actions\\\\Exports\\\\Models\\\\Export\\\":31:{s:13:\\\"\\u0000*\\u0000connection\\\";s:5:\\\"mysql\\\";s:8:\\\"\\u0000*\\u0000table\\\";N;s:13:\\\"\\u0000*\\u0000primaryKey\\\";s:2:\\\"id\\\";s:10:\\\"\\u0000*\\u0000keyType\\\";s:3:\\\"int\\\";s:12:\\\"incrementing\\\";b:1;s:7:\\\"\\u0000*\\u0000with\\\";a:0:{}s:12:\\\"\\u0000*\\u0000withCount\\\";a:0:{}s:19:\\\"preventsLazyLoading\\\";b:0;s:10:\\\"\\u0000*\\u0000perPage\\\";i:15;s:6:\\\"exists\\\";b:1;s:18:\\\"wasRecentlyCreated\\\";b:1;s:28:\\\"\\u0000*\\u0000escapeWhenCastingToString\\\";b:0;s:13:\\\"\\u0000*\\u0000attributes\\\";a:8:{s:7:\\\"user_id\\\";i:1;s:8:\\\"exporter\\\";s:41:\\\"App\\\\Filament\\\\Exports\\\\RegistrationExporter\\\";s:10:\\\"total_rows\\\";i:761;s:9:\\\"file_disk\\\";s:5:\\\"local\\\";s:10:\\\"updated_at\\\";s:19:\\\"2025-11-07 23:10:00\\\";s:10:\\\"created_at\\\";s:19:\\\"2025-11-07 23:10:00\\\";s:2:\\\"id\\\";i:1;s:9:\\\"file_name\\\";s:31:\\\"registrations-2025-11-07-110959\\\";}s:11:\\\"\\u0000*\\u0000original\\\";a:8:{s:7:\\\"user_id\\\";i:1;s:8:\\\"exporter\\\";s:41:\\\"App\\\\Filament\\\\Exports\\\\RegistrationExporter\\\";s:10:\\\"total_rows\\\";i:761;s:9:\\\"file_disk\\\";s:5:\\\"local\\\";s:10:\\\"updated_at\\\";s:19:\\\"2025-11-07 23:10:00\\\";s:10:\\\"created_at\\\";s:19:\\\"2025-11-07 23:10:00\\\";s:2:\\\"id\\\";i:1;s:9:\\\"file_name\\\";s:31:\\\"registrations-2025-11-07-110959\\\";}s:10:\\\"\\u0000*\\u0000changes\\\";a:1:{s:9:\\\"file_name\\\";s:31:\\\"registrations-2025-11-07-110959\\\";}s:8:\\\"\\u0000*\\u0000casts\\\";a:4:{s:12:\\\"completed_at\\\";s:9:\\\"timestamp\\\";s:14:\\\"processed_rows\\\";s:7:\\\"integer\\\";s:10:\\\"total_rows\\\";s:7:\\\"integer\\\";s:15:\\\"successful_rows\\\";s:7:\\\"integer\\\";}s:17:\\\"\\u0000*\\u0000classCastCache\\\";a:0:{}s:21:\\\"\\u0000*\\u0000attributeCastCache\\\";a:0:{}s:13:\\\"\\u0000*\\u0000dateFormat\\\";N;s:10:\\\"\\u0000*\\u0000appends\\\";a:0:{}s:19:\\\"\\u0000*\\u0000dispatchesEvents\\\";a:0:{}s:14:\\\"\\u0000*\\u0000observables\\\";a:0:{}s:12:\\\"\\u0000*\\u0000relations\\\";a:0:{}s:10:\\\"\\u0000*\\u0000touches\\\";a:0:{}s:27:\\\"\\u0000*\\u0000relationAutoloadCallback\\\";N;s:10:\\\"timestamps\\\";b:1;s:13:\\\"usesUniqueIds\\\";b:0;s:9:\\\"\\u0000*\\u0000hidden\\\";a:0:{}s:10:\\\"\\u0000*\\u0000visible\\\";a:0:{}s:11:\\\"\\u0000*\\u0000fillable\\\";a:0:{}s:10:\\\"\\u0000*\\u0000guarded\\\";a:0:{}}s:12:\\\"\\u0000*\\u0000columnMap\\\";a:24:{s:2:\\\"id\\\";s:2:\\\"ID\\\";s:15:\\\"ticketType.name\\\";s:5:\\\"Tiket\\\";s:9:\\\"full_name\\\";s:4:\\\"Nama\\\";s:5:\\\"email\\\";s:5:\\\"Email\\\";s:5:\\\"phone\\\";s:8:\\\"Nomor HP\\\";s:6:\\\"gender\\\";s:13:\\\"Jenis Kelamin\\\";s:14:\\\"place_of_birth\\\";s:12:\\\"Tempat Lahir\\\";s:3:\\\"dob\\\";s:13:\\\"Tanggal Lahir\\\";s:7:\\\"address\\\";s:6:\\\"Alamat\\\";s:8:\\\"district\\\";s:9:\\\"Kecamatan\\\";s:8:\\\"province\\\";s:8:\\\"Provinsi\\\";s:7:\\\"country\\\";s:6:\\\"Negara\\\";s:12:\\\"id_card_type\\\";s:20:\\\"Tipe Kartu Identitas\\\";s:14:\\\"id_card_number\\\";s:21:\\\"Nomor Kartu Identitas\\\";s:22:\\\"emergency_contact_name\\\";s:19:\\\"Nama Kontak Darurat\\\";s:23:\\\"emergency_contact_phone\\\";s:20:\\\"Nomor Kontak Darurat\\\";s:10:\\\"blood_type\\\";s:14:\\\"Golongan Darah\\\";s:11:\\\"nationality\\\";s:15:\\\"Kewarganegaraan\\\";s:11:\\\"jersey_size\\\";s:11:\\\"Size Jersey\\\";s:14:\\\"community_name\\\";s:9:\\\"Komunitas\\\";s:8:\\\"bib_name\\\";s:9:\\\"Nomer BIB\\\";s:6:\\\"reg_id\\\";s:16:\\\"Nomer Registrasi\\\";s:17:\\\"registration_date\\\";s:18:\\\"Tanggal Registrasi\\\";s:15:\\\"invitation_code\\\";s:13:\\\"Kode Undangan\\\";}s:10:\\\"\\u0000*\\u0000options\\\";a:0:{}}s:9:\\\"\\u0000*\\u0000export\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:38:\\\"Filament\\\\Actions\\\\Exports\\\\Models\\\\Export\\\";s:2:\\\"id\\\";i:1;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"\\u0000*\\u0000columnMap\\\";a:24:{s:2:\\\"id\\\";s:2:\\\"ID\\\";s:15:\\\"ticketType.name\\\";s:5:\\\"Tiket\\\";s:9:\\\"full_name\\\";s:4:\\\"Nama\\\";s:5:\\\"email\\\";s:5:\\\"Email\\\";s:5:\\\"phone\\\";s:8:\\\"Nomor HP\\\";s:6:\\\"gender\\\";s:13:\\\"Jenis Kelamin\\\";s:14:\\\"place_of_birth\\\";s:12:\\\"Tempat Lahir\\\";s:3:\\\"dob\\\";s:13:\\\"Tanggal Lahir\\\";s:7:\\\"address\\\";s:6:\\\"Alamat\\\";s:8:\\\"district\\\";s:9:\\\"Kecamatan\\\";s:8:\\\"province\\\";s:8:\\\"Provinsi\\\";s:7:\\\"country\\\";s:6:\\\"Negara\\\";s:12:\\\"id_card_type\\\";s:20:\\\"Tipe Kartu Identitas\\\";s:14:\\\"id_card_number\\\";s:21:\\\"Nomor Kartu Identitas\\\";s:22:\\\"emergency_contact_name\\\";s:19:\\\"Nama Kontak Darurat\\\";s:23:\\\"emergency_contact_phone\\\";s:20:\\\"Nomor Kontak Darurat\\\";s:10:\\\"blood_type\\\";s:14:\\\"Golongan Darah\\\";s:11:\\\"nationality\\\";s:15:\\\"Kewarganegaraan\\\";s:11:\\\"jersey_size\\\";s:11:\\\"Size Jersey\\\";s:14:\\\"community_name\\\";s:9:\\\"Komunitas\\\";s:8:\\\"bib_name\\\";s:9:\\\"Nomer BIB\\\";s:6:\\\"reg_id\\\";s:16:\\\"Nomer Registrasi\\\";s:17:\\\"registration_date\\\";s:18:\\\"Tanggal Registrasi\\\";s:15:\\\"invitation_code\\\";s:13:\\\"Kode Undangan\\\";}s:10:\\\"\\u0000*\\u0000options\\\";a:0:{}}\\\";}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";a:0:{}}\"}}',0,NULL,1762528200,1762528200),
(2,'default','{\"uuid\":\"cc348c92-9985-4449-a590-eb547cdd0f3c\",\"displayName\":\"Illuminate\\\\Bus\\\\ChainedBatch\",\"job\":\"Illuminate\\\\Queue\\\\CallQueuedHandler@call\",\"maxTries\":null,\"maxExceptions\":null,\"failOnTimeout\":false,\"backoff\":null,\"timeout\":null,\"retryUntil\":null,\"data\":{\"commandName\":\"Illuminate\\\\Bus\\\\ChainedBatch\",\"command\":\"O:27:\\\"Illuminate\\\\Bus\\\\ChainedBatch\\\":15:{s:4:\\\"jobs\\\";O:29:\\\"Illuminate\\\\Support\\\\Collection\\\":2:{s:8:\\\"\\u0000*\\u0000items\\\";a:1:{i:0;O:46:\\\"Filament\\\\Actions\\\\Exports\\\\Jobs\\\\PrepareCsvExport\\\":7:{s:11:\\\"\\u0000*\\u0000exporter\\\";O:41:\\\"App\\\\Filament\\\\Exports\\\\RegistrationExporter\\\":3:{s:9:\\\"\\u0000*\\u0000export\\\";O:38:\\\"Filament\\\\Actions\\\\Exports\\\\Models\\\\Export\\\":31:{s:13:\\\"\\u0000*\\u0000connection\\\";s:5:\\\"mysql\\\";s:8:\\\"\\u0000*\\u0000table\\\";N;s:13:\\\"\\u0000*\\u0000primaryKey\\\";s:2:\\\"id\\\";s:10:\\\"\\u0000*\\u0000keyType\\\";s:3:\\\"int\\\";s:12:\\\"incrementing\\\";b:1;s:7:\\\"\\u0000*\\u0000with\\\";a:0:{}s:12:\\\"\\u0000*\\u0000withCount\\\";a:0:{}s:19:\\\"preventsLazyLoading\\\";b:0;s:10:\\\"\\u0000*\\u0000perPage\\\";i:15;s:6:\\\"exists\\\";b:1;s:18:\\\"wasRecentlyCreated\\\";b:1;s:28:\\\"\\u0000*\\u0000escapeWhenCastingToString\\\";b:0;s:13:\\\"\\u0000*\\u0000attributes\\\";a:8:{s:7:\\\"user_id\\\";i:1;s:8:\\\"exporter\\\";s:41:\\\"App\\\\Filament\\\\Exports\\\\RegistrationExporter\\\";s:10:\\\"total_rows\\\";i:761;s:9:\\\"file_disk\\\";s:5:\\\"local\\\";s:10:\\\"updated_at\\\";s:19:\\\"2025-11-07 23:10:24\\\";s:10:\\\"created_at\\\";s:19:\\\"2025-11-07 23:10:24\\\";s:2:\\\"id\\\";i:2;s:9:\\\"file_name\\\";s:30:\\\"registration-2025-11-07-111024\\\";}s:11:\\\"\\u0000*\\u0000original\\\";a:8:{s:7:\\\"user_id\\\";i:1;s:8:\\\"exporter\\\";s:41:\\\"App\\\\Filament\\\\Exports\\\\RegistrationExporter\\\";s:10:\\\"total_rows\\\";i:761;s:9:\\\"file_disk\\\";s:5:\\\"local\\\";s:10:\\\"updated_at\\\";s:19:\\\"2025-11-07 23:10:24\\\";s:10:\\\"created_at\\\";s:19:\\\"2025-11-07 23:10:24\\\";s:2:\\\"id\\\";i:2;s:9:\\\"file_name\\\";s:30:\\\"registration-2025-11-07-111024\\\";}s:10:\\\"\\u0000*\\u0000changes\\\";a:1:{s:9:\\\"file_name\\\";s:30:\\\"registration-2025-11-07-111024\\\";}s:8:\\\"\\u0000*\\u0000casts\\\";a:4:{s:12:\\\"completed_at\\\";s:9:\\\"timestamp\\\";s:14:\\\"processed_rows\\\";s:7:\\\"integer\\\";s:10:\\\"total_rows\\\";s:7:\\\"integer\\\";s:15:\\\"successful_rows\\\";s:7:\\\"integer\\\";}s:17:\\\"\\u0000*\\u0000classCastCache\\\";a:0:{}s:21:\\\"\\u0000*\\u0000attributeCastCache\\\";a:0:{}s:13:\\\"\\u0000*\\u0000dateFormat\\\";N;s:10:\\\"\\u0000*\\u0000appends\\\";a:0:{}s:19:\\\"\\u0000*\\u0000dispatchesEvents\\\";a:0:{}s:14:\\\"\\u0000*\\u0000observables\\\";a:0:{}s:12:\\\"\\u0000*\\u0000relations\\\";a:0:{}s:10:\\\"\\u0000*\\u0000touches\\\";a:0:{}s:27:\\\"\\u0000*\\u0000relationAutoloadCallback\\\";N;s:10:\\\"timestamps\\\";b:1;s:13:\\\"usesUniqueIds\\\";b:0;s:9:\\\"\\u0000*\\u0000hidden\\\";a:0:{}s:10:\\\"\\u0000*\\u0000visible\\\";a:0:{}s:11:\\\"\\u0000*\\u0000fillable\\\";a:0:{}s:10:\\\"\\u0000*\\u0000guarded\\\";a:0:{}}s:12:\\\"\\u0000*\\u0000columnMap\\\";a:24:{s:2:\\\"id\\\";s:2:\\\"ID\\\";s:15:\\\"ticketType.name\\\";s:5:\\\"Tiket\\\";s:9:\\\"full_name\\\";s:4:\\\"Nama\\\";s:5:\\\"email\\\";s:5:\\\"Email\\\";s:5:\\\"phone\\\";s:8:\\\"Nomor HP\\\";s:6:\\\"gender\\\";s:13:\\\"Jenis Kelamin\\\";s:14:\\\"place_of_birth\\\";s:12:\\\"Tempat Lahir\\\";s:3:\\\"dob\\\";s:13:\\\"Tanggal Lahir\\\";s:7:\\\"address\\\";s:6:\\\"Alamat\\\";s:8:\\\"district\\\";s:9:\\\"Kecamatan\\\";s:8:\\\"province\\\";s:8:\\\"Provinsi\\\";s:7:\\\"country\\\";s:6:\\\"Negara\\\";s:12:\\\"id_card_type\\\";s:20:\\\"Tipe Kartu Identitas\\\";s:14:\\\"id_card_number\\\";s:21:\\\"Nomor Kartu Identitas\\\";s:22:\\\"emergency_contact_name\\\";s:19:\\\"Nama Kontak Darurat\\\";s:23:\\\"emergency_contact_phone\\\";s:20:\\\"Nomor Kontak Darurat\\\";s:10:\\\"blood_type\\\";s:14:\\\"Golongan Darah\\\";s:11:\\\"nationality\\\";s:15:\\\"Kewarganegaraan\\\";s:11:\\\"jersey_size\\\";s:11:\\\"Size Jersey\\\";s:14:\\\"community_name\\\";s:9:\\\"Komunitas\\\";s:8:\\\"bib_name\\\";s:9:\\\"Nomer BIB\\\";s:6:\\\"reg_id\\\";s:16:\\\"Nomer Registrasi\\\";s:17:\\\"registration_date\\\";s:18:\\\"Tanggal Registrasi\\\";s:15:\\\"invitation_code\\\";s:13:\\\"Kode Undangan\\\";}s:10:\\\"\\u0000*\\u0000options\\\";a:0:{}}s:9:\\\"\\u0000*\\u0000export\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:38:\\\"Filament\\\\Actions\\\\Exports\\\\Models\\\\Export\\\";s:2:\\\"id\\\";i:2;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:8:\\\"\\u0000*\\u0000query\\\";s:637:\\\"O:36:\\\"AnourValar\\\\EloquentSerialize\\\\Package\\\":1:{s:42:\\\"\\u0000AnourValar\\\\EloquentSerialize\\\\Package\\u0000data\\\";a:4:{s:5:\\\"model\\\";s:23:\\\"App\\\\Models\\\\Registration\\\";s:10:\\\"connection\\\";N;s:8:\\\"eloquent\\\";a:3:{s:4:\\\"with\\\";a:0:{}s:14:\\\"removed_scopes\\\";a:0:{}s:5:\\\"casts\\\";a:1:{s:2:\\\"id\\\";s:3:\\\"int\\\";}}s:5:\\\"query\\\";a:5:{s:8:\\\"bindings\\\";a:9:{s:6:\\\"select\\\";a:0:{}s:4:\\\"from\\\";a:0:{}s:4:\\\"join\\\";a:0:{}s:5:\\\"where\\\";a:0:{}s:7:\\\"groupBy\\\";a:0:{}s:6:\\\"having\\\";a:0:{}s:5:\\\"order\\\";a:0:{}s:5:\\\"union\\\";a:0:{}s:10:\\\"unionOrder\\\";a:0:{}}s:8:\\\"distinct\\\";b:0;s:4:\\\"from\\\";s:13:\\\"registrations\\\";s:6:\\\"wheres\\\";a:0:{}s:6:\\\"orders\\\";a:1:{i:0;a:2:{s:6:\\\"column\\\";s:12:\\\"is_validated\\\";s:9:\\\"direction\\\";s:3:\\\"asc\\\";}}}}}\\\";s:12:\\\"\\u0000*\\u0000columnMap\\\";a:24:{s:2:\\\"id\\\";s:2:\\\"ID\\\";s:15:\\\"ticketType.name\\\";s:5:\\\"Tiket\\\";s:9:\\\"full_name\\\";s:4:\\\"Nama\\\";s:5:\\\"email\\\";s:5:\\\"Email\\\";s:5:\\\"phone\\\";s:8:\\\"Nomor HP\\\";s:6:\\\"gender\\\";s:13:\\\"Jenis Kelamin\\\";s:14:\\\"place_of_birth\\\";s:12:\\\"Tempat Lahir\\\";s:3:\\\"dob\\\";s:13:\\\"Tanggal Lahir\\\";s:7:\\\"address\\\";s:6:\\\"Alamat\\\";s:8:\\\"district\\\";s:9:\\\"Kecamatan\\\";s:8:\\\"province\\\";s:8:\\\"Provinsi\\\";s:7:\\\"country\\\";s:6:\\\"Negara\\\";s:12:\\\"id_card_type\\\";s:20:\\\"Tipe Kartu Identitas\\\";s:14:\\\"id_card_number\\\";s:21:\\\"Nomor Kartu Identitas\\\";s:22:\\\"emergency_contact_name\\\";s:19:\\\"Nama Kontak Darurat\\\";s:23:\\\"emergency_contact_phone\\\";s:20:\\\"Nomor Kontak Darurat\\\";s:10:\\\"blood_type\\\";s:14:\\\"Golongan Darah\\\";s:11:\\\"nationality\\\";s:15:\\\"Kewarganegaraan\\\";s:11:\\\"jersey_size\\\";s:11:\\\"Size Jersey\\\";s:14:\\\"community_name\\\";s:9:\\\"Komunitas\\\";s:8:\\\"bib_name\\\";s:9:\\\"Nomer BIB\\\";s:6:\\\"reg_id\\\";s:16:\\\"Nomer Registrasi\\\";s:17:\\\"registration_date\\\";s:18:\\\"Tanggal Registrasi\\\";s:15:\\\"invitation_code\\\";s:13:\\\"Kode Undangan\\\";}s:10:\\\"\\u0000*\\u0000options\\\";a:0:{}s:12:\\\"\\u0000*\\u0000chunkSize\\\";i:100;s:10:\\\"\\u0000*\\u0000records\\\";N;}}s:28:\\\"\\u0000*\\u0000escapeWhenCastingToString\\\";b:0;}s:4:\\\"name\\\";s:0:\\\"\\\";s:7:\\\"options\\\";a:1:{s:13:\\\"allowFailures\\\";b:1;}s:7:\\\"batchId\\\";N;s:38:\\\"\\u0000Illuminate\\\\Bus\\\\ChainedBatch\\u0000fakeBatch\\\";N;s:3:\\\"job\\\";N;s:10:\\\"connection\\\";N;s:5:\\\"queue\\\";N;s:5:\\\"delay\\\";N;s:11:\\\"afterCommit\\\";N;s:10:\\\"middleware\\\";a:0:{}s:7:\\\"chained\\\";a:2:{i:0;s:4037:\\\"O:46:\\\"Filament\\\\Actions\\\\Exports\\\\Jobs\\\\ExportCompletion\\\":5:{s:11:\\\"\\u0000*\\u0000exporter\\\";O:41:\\\"App\\\\Filament\\\\Exports\\\\RegistrationExporter\\\":3:{s:9:\\\"\\u0000*\\u0000export\\\";O:38:\\\"Filament\\\\Actions\\\\Exports\\\\Models\\\\Export\\\":31:{s:13:\\\"\\u0000*\\u0000connection\\\";s:5:\\\"mysql\\\";s:8:\\\"\\u0000*\\u0000table\\\";N;s:13:\\\"\\u0000*\\u0000primaryKey\\\";s:2:\\\"id\\\";s:10:\\\"\\u0000*\\u0000keyType\\\";s:3:\\\"int\\\";s:12:\\\"incrementing\\\";b:1;s:7:\\\"\\u0000*\\u0000with\\\";a:0:{}s:12:\\\"\\u0000*\\u0000withCount\\\";a:0:{}s:19:\\\"preventsLazyLoading\\\";b:0;s:10:\\\"\\u0000*\\u0000perPage\\\";i:15;s:6:\\\"exists\\\";b:1;s:18:\\\"wasRecentlyCreated\\\";b:1;s:28:\\\"\\u0000*\\u0000escapeWhenCastingToString\\\";b:0;s:13:\\\"\\u0000*\\u0000attributes\\\";a:8:{s:7:\\\"user_id\\\";i:1;s:8:\\\"exporter\\\";s:41:\\\"App\\\\Filament\\\\Exports\\\\RegistrationExporter\\\";s:10:\\\"total_rows\\\";i:761;s:9:\\\"file_disk\\\";s:5:\\\"local\\\";s:10:\\\"updated_at\\\";s:19:\\\"2025-11-07 23:10:24\\\";s:10:\\\"created_at\\\";s:19:\\\"2025-11-07 23:10:24\\\";s:2:\\\"id\\\";i:2;s:9:\\\"file_name\\\";s:30:\\\"registration-2025-11-07-111024\\\";}s:11:\\\"\\u0000*\\u0000original\\\";a:8:{s:7:\\\"user_id\\\";i:1;s:8:\\\"exporter\\\";s:41:\\\"App\\\\Filament\\\\Exports\\\\RegistrationExporter\\\";s:10:\\\"total_rows\\\";i:761;s:9:\\\"file_disk\\\";s:5:\\\"local\\\";s:10:\\\"updated_at\\\";s:19:\\\"2025-11-07 23:10:24\\\";s:10:\\\"created_at\\\";s:19:\\\"2025-11-07 23:10:24\\\";s:2:\\\"id\\\";i:2;s:9:\\\"file_name\\\";s:30:\\\"registration-2025-11-07-111024\\\";}s:10:\\\"\\u0000*\\u0000changes\\\";a:1:{s:9:\\\"file_name\\\";s:30:\\\"registration-2025-11-07-111024\\\";}s:8:\\\"\\u0000*\\u0000casts\\\";a:4:{s:12:\\\"completed_at\\\";s:9:\\\"timestamp\\\";s:14:\\\"processed_rows\\\";s:7:\\\"integer\\\";s:10:\\\"total_rows\\\";s:7:\\\"integer\\\";s:15:\\\"successful_rows\\\";s:7:\\\"integer\\\";}s:17:\\\"\\u0000*\\u0000classCastCache\\\";a:0:{}s:21:\\\"\\u0000*\\u0000attributeCastCache\\\";a:0:{}s:13:\\\"\\u0000*\\u0000dateFormat\\\";N;s:10:\\\"\\u0000*\\u0000appends\\\";a:0:{}s:19:\\\"\\u0000*\\u0000dispatchesEvents\\\";a:0:{}s:14:\\\"\\u0000*\\u0000observables\\\";a:0:{}s:12:\\\"\\u0000*\\u0000relations\\\";a:0:{}s:10:\\\"\\u0000*\\u0000touches\\\";a:0:{}s:27:\\\"\\u0000*\\u0000relationAutoloadCallback\\\";N;s:10:\\\"timestamps\\\";b:1;s:13:\\\"usesUniqueIds\\\";b:0;s:9:\\\"\\u0000*\\u0000hidden\\\";a:0:{}s:10:\\\"\\u0000*\\u0000visible\\\";a:0:{}s:11:\\\"\\u0000*\\u0000fillable\\\";a:0:{}s:10:\\\"\\u0000*\\u0000guarded\\\";a:0:{}}s:12:\\\"\\u0000*\\u0000columnMap\\\";a:24:{s:2:\\\"id\\\";s:2:\\\"ID\\\";s:15:\\\"ticketType.name\\\";s:5:\\\"Tiket\\\";s:9:\\\"full_name\\\";s:4:\\\"Nama\\\";s:5:\\\"email\\\";s:5:\\\"Email\\\";s:5:\\\"phone\\\";s:8:\\\"Nomor HP\\\";s:6:\\\"gender\\\";s:13:\\\"Jenis Kelamin\\\";s:14:\\\"place_of_birth\\\";s:12:\\\"Tempat Lahir\\\";s:3:\\\"dob\\\";s:13:\\\"Tanggal Lahir\\\";s:7:\\\"address\\\";s:6:\\\"Alamat\\\";s:8:\\\"district\\\";s:9:\\\"Kecamatan\\\";s:8:\\\"province\\\";s:8:\\\"Provinsi\\\";s:7:\\\"country\\\";s:6:\\\"Negara\\\";s:12:\\\"id_card_type\\\";s:20:\\\"Tipe Kartu Identitas\\\";s:14:\\\"id_card_number\\\";s:21:\\\"Nomor Kartu Identitas\\\";s:22:\\\"emergency_contact_name\\\";s:19:\\\"Nama Kontak Darurat\\\";s:23:\\\"emergency_contact_phone\\\";s:20:\\\"Nomor Kontak Darurat\\\";s:10:\\\"blood_type\\\";s:14:\\\"Golongan Darah\\\";s:11:\\\"nationality\\\";s:15:\\\"Kewarganegaraan\\\";s:11:\\\"jersey_size\\\";s:11:\\\"Size Jersey\\\";s:14:\\\"community_name\\\";s:9:\\\"Komunitas\\\";s:8:\\\"bib_name\\\";s:9:\\\"Nomer BIB\\\";s:6:\\\"reg_id\\\";s:16:\\\"Nomer Registrasi\\\";s:17:\\\"registration_date\\\";s:18:\\\"Tanggal Registrasi\\\";s:15:\\\"invitation_code\\\";s:13:\\\"Kode Undangan\\\";}s:10:\\\"\\u0000*\\u0000options\\\";a:0:{}}s:9:\\\"\\u0000*\\u0000export\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:38:\\\"Filament\\\\Actions\\\\Exports\\\\Models\\\\Export\\\";s:2:\\\"id\\\";i:2;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"\\u0000*\\u0000columnMap\\\";a:24:{s:2:\\\"id\\\";s:2:\\\"ID\\\";s:15:\\\"ticketType.name\\\";s:5:\\\"Tiket\\\";s:9:\\\"full_name\\\";s:4:\\\"Nama\\\";s:5:\\\"email\\\";s:5:\\\"Email\\\";s:5:\\\"phone\\\";s:8:\\\"Nomor HP\\\";s:6:\\\"gender\\\";s:13:\\\"Jenis Kelamin\\\";s:14:\\\"place_of_birth\\\";s:12:\\\"Tempat Lahir\\\";s:3:\\\"dob\\\";s:13:\\\"Tanggal Lahir\\\";s:7:\\\"address\\\";s:6:\\\"Alamat\\\";s:8:\\\"district\\\";s:9:\\\"Kecamatan\\\";s:8:\\\"province\\\";s:8:\\\"Provinsi\\\";s:7:\\\"country\\\";s:6:\\\"Negara\\\";s:12:\\\"id_card_type\\\";s:20:\\\"Tipe Kartu Identitas\\\";s:14:\\\"id_card_number\\\";s:21:\\\"Nomor Kartu Identitas\\\";s:22:\\\"emergency_contact_name\\\";s:19:\\\"Nama Kontak Darurat\\\";s:23:\\\"emergency_contact_phone\\\";s:20:\\\"Nomor Kontak Darurat\\\";s:10:\\\"blood_type\\\";s:14:\\\"Golongan Darah\\\";s:11:\\\"nationality\\\";s:15:\\\"Kewarganegaraan\\\";s:11:\\\"jersey_size\\\";s:11:\\\"Size Jersey\\\";s:14:\\\"community_name\\\";s:9:\\\"Komunitas\\\";s:8:\\\"bib_name\\\";s:9:\\\"Nomer BIB\\\";s:6:\\\"reg_id\\\";s:16:\\\"Nomer Registrasi\\\";s:17:\\\"registration_date\\\";s:18:\\\"Tanggal Registrasi\\\";s:15:\\\"invitation_code\\\";s:13:\\\"Kode Undangan\\\";}s:10:\\\"\\u0000*\\u0000formats\\\";a:2:{i:0;E:47:\\\"Filament\\\\Actions\\\\Exports\\\\Enums\\\\ExportFormat:Csv\\\";i:1;E:48:\\\"Filament\\\\Actions\\\\Exports\\\\Enums\\\\ExportFormat:Xlsx\\\";}s:10:\\\"\\u0000*\\u0000options\\\";a:0:{}}\\\";i:1;s:3892:\\\"O:44:\\\"Filament\\\\Actions\\\\Exports\\\\Jobs\\\\CreateXlsxFile\\\":4:{s:11:\\\"\\u0000*\\u0000exporter\\\";O:41:\\\"App\\\\Filament\\\\Exports\\\\RegistrationExporter\\\":3:{s:9:\\\"\\u0000*\\u0000export\\\";O:38:\\\"Filament\\\\Actions\\\\Exports\\\\Models\\\\Export\\\":31:{s:13:\\\"\\u0000*\\u0000connection\\\";s:5:\\\"mysql\\\";s:8:\\\"\\u0000*\\u0000table\\\";N;s:13:\\\"\\u0000*\\u0000primaryKey\\\";s:2:\\\"id\\\";s:10:\\\"\\u0000*\\u0000keyType\\\";s:3:\\\"int\\\";s:12:\\\"incrementing\\\";b:1;s:7:\\\"\\u0000*\\u0000with\\\";a:0:{}s:12:\\\"\\u0000*\\u0000withCount\\\";a:0:{}s:19:\\\"preventsLazyLoading\\\";b:0;s:10:\\\"\\u0000*\\u0000perPage\\\";i:15;s:6:\\\"exists\\\";b:1;s:18:\\\"wasRecentlyCreated\\\";b:1;s:28:\\\"\\u0000*\\u0000escapeWhenCastingToString\\\";b:0;s:13:\\\"\\u0000*\\u0000attributes\\\";a:8:{s:7:\\\"user_id\\\";i:1;s:8:\\\"exporter\\\";s:41:\\\"App\\\\Filament\\\\Exports\\\\RegistrationExporter\\\";s:10:\\\"total_rows\\\";i:761;s:9:\\\"file_disk\\\";s:5:\\\"local\\\";s:10:\\\"updated_at\\\";s:19:\\\"2025-11-07 23:10:24\\\";s:10:\\\"created_at\\\";s:19:\\\"2025-11-07 23:10:24\\\";s:2:\\\"id\\\";i:2;s:9:\\\"file_name\\\";s:30:\\\"registration-2025-11-07-111024\\\";}s:11:\\\"\\u0000*\\u0000original\\\";a:8:{s:7:\\\"user_id\\\";i:1;s:8:\\\"exporter\\\";s:41:\\\"App\\\\Filament\\\\Exports\\\\RegistrationExporter\\\";s:10:\\\"total_rows\\\";i:761;s:9:\\\"file_disk\\\";s:5:\\\"local\\\";s:10:\\\"updated_at\\\";s:19:\\\"2025-11-07 23:10:24\\\";s:10:\\\"created_at\\\";s:19:\\\"2025-11-07 23:10:24\\\";s:2:\\\"id\\\";i:2;s:9:\\\"file_name\\\";s:30:\\\"registration-2025-11-07-111024\\\";}s:10:\\\"\\u0000*\\u0000changes\\\";a:1:{s:9:\\\"file_name\\\";s:30:\\\"registration-2025-11-07-111024\\\";}s:8:\\\"\\u0000*\\u0000casts\\\";a:4:{s:12:\\\"completed_at\\\";s:9:\\\"timestamp\\\";s:14:\\\"processed_rows\\\";s:7:\\\"integer\\\";s:10:\\\"total_rows\\\";s:7:\\\"integer\\\";s:15:\\\"successful_rows\\\";s:7:\\\"integer\\\";}s:17:\\\"\\u0000*\\u0000classCastCache\\\";a:0:{}s:21:\\\"\\u0000*\\u0000attributeCastCache\\\";a:0:{}s:13:\\\"\\u0000*\\u0000dateFormat\\\";N;s:10:\\\"\\u0000*\\u0000appends\\\";a:0:{}s:19:\\\"\\u0000*\\u0000dispatchesEvents\\\";a:0:{}s:14:\\\"\\u0000*\\u0000observables\\\";a:0:{}s:12:\\\"\\u0000*\\u0000relations\\\";a:0:{}s:10:\\\"\\u0000*\\u0000touches\\\";a:0:{}s:27:\\\"\\u0000*\\u0000relationAutoloadCallback\\\";N;s:10:\\\"timestamps\\\";b:1;s:13:\\\"usesUniqueIds\\\";b:0;s:9:\\\"\\u0000*\\u0000hidden\\\";a:0:{}s:10:\\\"\\u0000*\\u0000visible\\\";a:0:{}s:11:\\\"\\u0000*\\u0000fillable\\\";a:0:{}s:10:\\\"\\u0000*\\u0000guarded\\\";a:0:{}}s:12:\\\"\\u0000*\\u0000columnMap\\\";a:24:{s:2:\\\"id\\\";s:2:\\\"ID\\\";s:15:\\\"ticketType.name\\\";s:5:\\\"Tiket\\\";s:9:\\\"full_name\\\";s:4:\\\"Nama\\\";s:5:\\\"email\\\";s:5:\\\"Email\\\";s:5:\\\"phone\\\";s:8:\\\"Nomor HP\\\";s:6:\\\"gender\\\";s:13:\\\"Jenis Kelamin\\\";s:14:\\\"place_of_birth\\\";s:12:\\\"Tempat Lahir\\\";s:3:\\\"dob\\\";s:13:\\\"Tanggal Lahir\\\";s:7:\\\"address\\\";s:6:\\\"Alamat\\\";s:8:\\\"district\\\";s:9:\\\"Kecamatan\\\";s:8:\\\"province\\\";s:8:\\\"Provinsi\\\";s:7:\\\"country\\\";s:6:\\\"Negara\\\";s:12:\\\"id_card_type\\\";s:20:\\\"Tipe Kartu Identitas\\\";s:14:\\\"id_card_number\\\";s:21:\\\"Nomor Kartu Identitas\\\";s:22:\\\"emergency_contact_name\\\";s:19:\\\"Nama Kontak Darurat\\\";s:23:\\\"emergency_contact_phone\\\";s:20:\\\"Nomor Kontak Darurat\\\";s:10:\\\"blood_type\\\";s:14:\\\"Golongan Darah\\\";s:11:\\\"nationality\\\";s:15:\\\"Kewarganegaraan\\\";s:11:\\\"jersey_size\\\";s:11:\\\"Size Jersey\\\";s:14:\\\"community_name\\\";s:9:\\\"Komunitas\\\";s:8:\\\"bib_name\\\";s:9:\\\"Nomer BIB\\\";s:6:\\\"reg_id\\\";s:16:\\\"Nomer Registrasi\\\";s:17:\\\"registration_date\\\";s:18:\\\"Tanggal Registrasi\\\";s:15:\\\"invitation_code\\\";s:13:\\\"Kode Undangan\\\";}s:10:\\\"\\u0000*\\u0000options\\\";a:0:{}}s:9:\\\"\\u0000*\\u0000export\\\";O:45:\\\"Illuminate\\\\Contracts\\\\Database\\\\ModelIdentifier\\\":5:{s:5:\\\"class\\\";s:38:\\\"Filament\\\\Actions\\\\Exports\\\\Models\\\\Export\\\";s:2:\\\"id\\\";i:2;s:9:\\\"relations\\\";a:0:{}s:10:\\\"connection\\\";s:5:\\\"mysql\\\";s:15:\\\"collectionClass\\\";N;}s:12:\\\"\\u0000*\\u0000columnMap\\\";a:24:{s:2:\\\"id\\\";s:2:\\\"ID\\\";s:15:\\\"ticketType.name\\\";s:5:\\\"Tiket\\\";s:9:\\\"full_name\\\";s:4:\\\"Nama\\\";s:5:\\\"email\\\";s:5:\\\"Email\\\";s:5:\\\"phone\\\";s:8:\\\"Nomor HP\\\";s:6:\\\"gender\\\";s:13:\\\"Jenis Kelamin\\\";s:14:\\\"place_of_birth\\\";s:12:\\\"Tempat Lahir\\\";s:3:\\\"dob\\\";s:13:\\\"Tanggal Lahir\\\";s:7:\\\"address\\\";s:6:\\\"Alamat\\\";s:8:\\\"district\\\";s:9:\\\"Kecamatan\\\";s:8:\\\"province\\\";s:8:\\\"Provinsi\\\";s:7:\\\"country\\\";s:6:\\\"Negara\\\";s:12:\\\"id_card_type\\\";s:20:\\\"Tipe Kartu Identitas\\\";s:14:\\\"id_card_number\\\";s:21:\\\"Nomor Kartu Identitas\\\";s:22:\\\"emergency_contact_name\\\";s:19:\\\"Nama Kontak Darurat\\\";s:23:\\\"emergency_contact_phone\\\";s:20:\\\"Nomor Kontak Darurat\\\";s:10:\\\"blood_type\\\";s:14:\\\"Golongan Darah\\\";s:11:\\\"nationality\\\";s:15:\\\"Kewarganegaraan\\\";s:11:\\\"jersey_size\\\";s:11:\\\"Size Jersey\\\";s:14:\\\"community_name\\\";s:9:\\\"Komunitas\\\";s:8:\\\"bib_name\\\";s:9:\\\"Nomer BIB\\\";s:6:\\\"reg_id\\\";s:16:\\\"Nomer Registrasi\\\";s:17:\\\"registration_date\\\";s:18:\\\"Tanggal Registrasi\\\";s:15:\\\"invitation_code\\\";s:13:\\\"Kode Undangan\\\";}s:10:\\\"\\u0000*\\u0000options\\\";a:0:{}}\\\";}s:15:\\\"chainConnection\\\";N;s:10:\\\"chainQueue\\\";N;s:19:\\\"chainCatchCallbacks\\\";a:0:{}}\"}}',0,NULL,1762528224,1762528224);
/*!40000 ALTER TABLE `jobs` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `migrations`
--

DROP TABLE IF EXISTS `migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `migrations`
--

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;
INSERT INTO `migrations` VALUES
(19,'0001_01_01_000000_create_users_table',1),
(20,'0001_01_01_000001_create_cache_table',1),
(21,'0001_01_01_000002_create_jobs_table',1),
(22,'2025_04_15_143132_create_roles_table',1),
(23,'2025_04_15_152110_add_role_id_to_users_table',1),
(24,'2025_04_16_071527_create_events_table',1),
(25,'2025_04_16_071554_create_ticket_types_table',1),
(26,'2025_04_16_071804_create_registrations_table',1),
(27,'2025_04_16_114347_add_invitation_code_to_registrations_table',1),
(28,'2025_04_16_151338_add_registration_date_to_registrations_table',1),
(29,'2025_04_17_081356_add_validated_by_to_registrations_table',1),
(30,'2025_04_17_100922_add_code_prefix_to_events_table',1),
(31,'2025_05_06_192128_create_campaigns_table',1),
(32,'2025_05_06_192605_create_campaign_registration_table',1),
(33,'2025_05_07_131720_create_imports_table',1),
(34,'2025_05_07_131721_create_exports_table',1),
(35,'2025_05_07_131722_create_failed_import_rows_table',1),
(36,'2025_05_07_211710_create_notifications_table',1),
(37,'2025_05_12_230859_add_description_to_events_table',2),
(38,'2025_05_13_003338_create_categories_table',2),
(39,'2025_05_13_200949_remove_event_id_from_ticket_types_table',2),
(40,'2025_05_13_201358_create_category_ticket_type_table',2),
(41,'2025_05_13_203730_create_vouchers_table',2),
(42,'2025_05_13_204118_create_voucher_codes_table',2),
(43,'2025_05_15_185632_create_personal_access_tokens_table',2),
(44,'2025_05_15_210650_add_registration_code_to_registrations_table',2),
(45,'2025_05_15_210810_add_valid_from_to_category_ticket_type_table',2),
(46,'2025_05_16_201647_add_category_ticket_type_id_to_registrations_table',3),
(47,'2025_05_16_225149_add_status_and_transaction_code_to_registrations_table',4),
(48,'2025_05_18_092408_add_payment_fields_to_registrations_table',5),
(49,'2025_05_18_092618_add_valid_until_to_category_ticket_type_table',5),
(50,'2025_05_19_193351_modify_reg_id_on_registration_table',6),
(51,'2025_05_23_193456_add_slug_to_events_table',7),
(52,'2025_05_23_224754_add_qr_code_path_to_registrations_table',8),
(53,'2025_05_28_223319_create_event_user_table',9),
(54,'2025_05_29_000843_add_event_id_to_users_table',9),
(55,'2025_05_29_215005_update_events_table',10),
(56,'2025_06_02_213855_create_event_user_table',11),
(57,'2025_11_08_095819_add_multiple_use_column_to_vouchers_table',12),
(58,'2025_11_08_144532_update_voucher_and_registration_relation',13),
(59,'2025_11_10_233926_update_gmaps_columns_in_events_table',14),
(60,'2025_11_11_021222_add_size_to_events_table',14),
(61,'2025_11_11_202123_add_jersey_size_image_to_events_table',15),
(62,'2025_11_11_203442_create_event_slides_table',15),
(64,'2025_11_14_092943_add_jersey_size_option_to_registrations_table',16);
/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `notifications`
--

DROP TABLE IF EXISTS `notifications`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `notifications` (
  `id` char(36) NOT NULL,
  `type` varchar(255) NOT NULL,
  `notifiable_type` varchar(255) NOT NULL,
  `notifiable_id` bigint(20) unsigned NOT NULL,
  `data` text NOT NULL,
  `read_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notifications_notifiable_type_notifiable_id_index` (`notifiable_type`,`notifiable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `notifications`
--

LOCK TABLES `notifications` WRITE;
/*!40000 ALTER TABLE `notifications` DISABLE KEYS */;
/*!40000 ALTER TABLE `notifications` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password_reset_tokens`
--

DROP TABLE IF EXISTS `password_reset_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(255) NOT NULL,
  `token` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password_reset_tokens`
--

LOCK TABLES `password_reset_tokens` WRITE;
/*!40000 ALTER TABLE `password_reset_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `password_reset_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `personal_access_tokens`
--

DROP TABLE IF EXISTS `personal_access_tokens`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tokenable_type` varchar(255) NOT NULL,
  `tokenable_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `token` varchar(64) NOT NULL,
  `abilities` text DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `personal_access_tokens`
--

LOCK TABLES `personal_access_tokens` WRITE;
/*!40000 ALTER TABLE `personal_access_tokens` DISABLE KEYS */;
/*!40000 ALTER TABLE `personal_access_tokens` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registrations`
--

DROP TABLE IF EXISTS `registrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `registrations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `category_ticket_type_id` bigint(20) unsigned DEFAULT NULL,
  `voucher_code_id` bigint(20) unsigned DEFAULT NULL,
  `validated_by` bigint(20) unsigned DEFAULT NULL,
  `full_name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone` varchar(255) NOT NULL,
  `gender` enum('Male','Female') DEFAULT NULL,
  `place_of_birth` varchar(255) DEFAULT NULL,
  `dob` date DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `district` varchar(255) DEFAULT NULL,
  `province` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `id_card_type` enum('KTP','SIM','PASSPORT','KARTU PELAJAR','KITAS','KITAP','OTHER') DEFAULT NULL,
  `id_card_number` varchar(255) DEFAULT NULL,
  `emergency_contact_name` varchar(255) DEFAULT NULL,
  `emergency_contact_phone` varchar(255) DEFAULT NULL,
  `blood_type` enum('A','B','AB','O') DEFAULT NULL,
  `nationality` varchar(255) DEFAULT NULL,
  `jersey_size` varchar(20) DEFAULT NULL,
  `community_name` varchar(255) DEFAULT NULL,
  `bib_name` varchar(255) DEFAULT NULL,
  `reg_id` varchar(255) DEFAULT NULL,
  `registration_code` varchar(255) DEFAULT NULL,
  `registration_date` datetime DEFAULT NULL,
  `invitation_code` varchar(255) DEFAULT NULL,
  `is_validated` tinyint(1) NOT NULL DEFAULT 0,
  `status` enum('pending','confirmed') NOT NULL DEFAULT 'pending',
  `transaction_code` varchar(255) DEFAULT NULL,
  `payment_status` enum('pending','paid','settlement','cancel','deny','expire','failure','refund') NOT NULL DEFAULT 'pending',
  `payment_type` varchar(255) DEFAULT NULL,
  `payment_method` varchar(255) DEFAULT NULL,
  `gross_amount` decimal(12,2) DEFAULT NULL,
  `paid_at` datetime DEFAULT NULL,
  `payment_token` varchar(255) DEFAULT NULL,
  `payment_url` text DEFAULT NULL,
  `qr_code_path` varchar(255) DEFAULT NULL,
  `last_printed_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `registrations_validated_by_foreign` (`validated_by`),
  KEY `registrations_category_ticket_type_id_foreign` (`category_ticket_type_id`),
  KEY `registrations_voucher_code_id_foreign` (`voucher_code_id`),
  CONSTRAINT `registrations_category_ticket_type_id_foreign` FOREIGN KEY (`category_ticket_type_id`) REFERENCES `category_ticket_type` (`id`) ON DELETE SET NULL,
  CONSTRAINT `registrations_validated_by_foreign` FOREIGN KEY (`validated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `registrations_voucher_code_id_foreign` FOREIGN KEY (`voucher_code_id`) REFERENCES `voucher_codes` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=875 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registrations`
--

LOCK TABLES `registrations` WRITE;
/*!40000 ALTER TABLE `registrations` DISABLE KEYS */;
INSERT INTO `registrations` VALUES
(873,13,NULL,NULL,'anak agung gede yoga saputra','gungdey132@gmail.com','+6288987053956','Male','Gianyar','2007-09-09','Br. Lodpeken , Desa Keramas','KAB. GIANYAR','BALI','Indonesia','KTP','5104020909070003','Agung Anom','+6281916343383','O','Indonesia','M','HOTR','JungDee','0002','RTIX-KR26-XPVXY7','2025-11-17 10:17:07',NULL,0,'confirmed','ceafcc3f-892e-487c-9823-e9921ebc99fd','paid','qris',NULL,226587.00,'2025-11-17 10:23:22',NULL,'https://app.midtrans.com/payment-links/67c17c8a-4bf8-4f9c-8bb1-a7a4368642fd','https://rpm.regtix.id/storage/qrcodes/873/RTIX-KR26-XPVXY7.png',NULL,'2025-11-17 10:17:07','2025-11-17 10:37:25'),
(874,13,NULL,NULL,'Gusti Agung Gede Satria Diningrat','Satriadiningratjungsatria@gmail.com','+6289643071231','Male','13/01/2000','2000-01-13','Br. Gel-gel keramas','KAB. GIANYAR','BALI','Indonesia','KTP','5104020801000003','Wina cahyani','+6281947859166','O','Indonesia','XL',NULL,'Jungsatria','0003','RTIX-KR26-8HXQII','2025-11-17 10:44:22',NULL,0,'confirmed','a2d32e0d-7a3f-4952-8925-48d765ab81be','paid','bank_transfer',NULL,229440.00,'2025-11-17 10:44:52',NULL,'https://app.midtrans.com/payment-links/46405f8b-66eb-4660-9d85-7ee0bcdcf033','https://rpm.regtix.id/storage/qrcodes/874/RTIX-KR26-8HXQII.png',NULL,'2025-11-17 10:44:22','2025-11-17 10:54:16');
/*!40000 ALTER TABLE `registrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `label` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_unique` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES
(1,'admin','Administrator','2025-05-16 00:59:16','2025-05-16 00:59:16'),
(2,'operator','Operator','2025-05-16 00:59:16','2025-05-16 00:59:16'),
(3,'superadmin','Super Admin','2025-06-03 01:49:24','2025-06-03 01:49:24');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `sessions` (
  `id` varchar(255) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
INSERT INTO `sessions` VALUES
('1msXyASmOWH3LB1pMjU8CNaLWB6OoHI3LCMUU12z',NULL,'103.157.49.11','Mozilla/5.0 (Linux; Android 10; K) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Mobile Safari/537.36','YTozOntzOjY6Il90b2tlbiI7czo0MDoiNXpaejEyV2JTZ1VnbXJwZk1QNmhQelBPVTJMVUp6STY1VU8weXlFeCI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vcnBtLnJlZ3RpeC5pZC9hZG1pbi9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=',1763351404),
('7UWpnA2xYPy2D2ufrYXDwEx2TcCp53IrbFk5G23h',NULL,'2a02:4780:3:1::3','Go-http-client/1.1','YToyOntzOjY6Il90b2tlbiI7czo0MDoiR1dvTHJiWTd6aFBGeHg3c0E1MTZkbldIdHA5VWU4OGdHbkhXbW1oUSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1763351071),
('7Xfn04ZLfGsCTH0MEq6vhrSG2iVqJr00SYDNEBsr',NULL,'182.253.51.103','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1','YTo0OntzOjY6Il90b2tlbiI7czo0MDoiNWZzY3BlOENnbnI5c1Q3d2wwOWJiSkdKS3ZKd2FnUUpZN0tlaDJZMiI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo0MToiaHR0cHM6Ly9ycG0ucmVndGl4LmlkL2FkbWluL3JlZ2lzdHJhdGlvbnMiO31zOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czozMzoiaHR0cHM6Ly9ycG0ucmVndGl4LmlkL2FkbWluL2xvZ2luIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1763354793),
('9G9mpN7kNAKI16GHUvDT24KQlEvyG8ARKg9xwiif',1,'182.253.51.103','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36','YTo4OntzOjY6Il90b2tlbiI7czo0MDoiZjBKdGU5anVaV081ZFlwZzNYZXFZeWN0Y081WkladWxRTE5YV3dCdiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHBzOi8vcnBtLnJlZ3RpeC5pZC9hZG1pbi9yZXBvcnQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjM6InVybCI7YTowOnt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTtzOjE3OiJwYXNzd29yZF9oYXNoX3dlYiI7czo2MDoiJDJ5JDEyJFNJaTdKRGJhbDZRSy9GOS5TYTE2bi5CRVg5YjJ1ZGhEZmE2SWhYZ2pvMjNJb0U5S3B6MHVxIjtzOjg6ImZpbGFtZW50IjthOjA6e31zOjY6InRhYmxlcyI7YToxOntzOjI1OiJMaXN0UmVnaXN0cmF0aW9uc19maWx0ZXJzIjthOjY6e3M6MTc6InJlZ2lzdHJhdGlvbl9jb2RlIjthOjE6e3M6MTc6InJlZ2lzdHJhdGlvbl9jb2RlIjtOO31zOjg6ImV2ZW50X2lkIjthOjE6e3M6NToidmFsdWUiO047fXM6MjM6ImNhdGVnb3J5X3RpY2tldF90eXBlX2lkIjthOjE6e3M6NToidmFsdWUiO047fXM6MTI6ImlzX3ZhbGlkYXRlZCI7YToxOntzOjU6InZhbHVlIjtOO31zOjEwOiJzdGFydF9kYXRlIjthOjE6e3M6MTA6InN0YXJ0X2RhdGUiO047fXM6ODoiZW5kX2RhdGUiO2E6MTp7czo4OiJlbmRfZGF0ZSI7Tjt9fX19',1763357079),
('blGAuVLCKxTer8QdAot1HharRliHctJWjsd1N3U8',1,'182.253.51.103','Mozilla/5.0 (iPhone; CPU iPhone OS 18_6 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/18.6 Mobile/15E148 Safari/604.1','YTo3OntzOjY6Il90b2tlbiI7czo0MDoiRGdhdG1JTEJ5eUs5UTdnTWxFZWdHUVNPQlMyYkVtZG5CVVpxUklrMiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDE6Imh0dHBzOi8vcnBtLnJlZ3RpeC5pZC9hZG1pbi9yZWdpc3RyYXRpb25zIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czozOiJ1cmwiO2E6MDp7fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7czoxNzoicGFzc3dvcmRfaGFzaF93ZWIiO3M6NjA6IiQyeSQxMiRTSWk3SkRiYWw2UUsvRjkuU2ExNm4uQkVYOWIydWRoRGZhNkloWGdqbzIzSW9FOUtwejB1cSI7czo2OiJ0YWJsZXMiO2E6MTp7czoyNToiTGlzdFJlZ2lzdHJhdGlvbnNfZmlsdGVycyI7YTo2OntzOjE3OiJyZWdpc3RyYXRpb25fY29kZSI7YToxOntzOjE3OiJyZWdpc3RyYXRpb25fY29kZSI7Tjt9czo4OiJldmVudF9pZCI7YToxOntzOjU6InZhbHVlIjtOO31zOjIzOiJjYXRlZ29yeV90aWNrZXRfdHlwZV9pZCI7YToxOntzOjU6InZhbHVlIjtOO31zOjEyOiJpc192YWxpZGF0ZWQiO2E6MTp7czo1OiJ2YWx1ZSI7Tjt9czoxMDoic3RhcnRfZGF0ZSI7YToxOntzOjEwOiJzdGFydF9kYXRlIjtOO31zOjg6ImVuZF9kYXRlIjthOjE6e3M6ODoiZW5kX2RhdGUiO047fX19fQ==',1763353483),
('gNPRLPXUJMXQnhquI1WmedHXVt2x8WZCyrO1J4Ui',NULL,'2a02:4780:3:1::3','Go-http-client/1.1','YTozOntzOjY6Il90b2tlbiI7czo0MDoiNzdpUlBtSlZiNU4xS1lXTWtRV1FoUGcwTjZQS1E5YzMxd0F4cmV4eCI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czoyNzoiaHR0cHM6Ly9ycG0ucmVndGl4LmlkLjo0NDMvIjt9czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1763351071),
('KroDBfZheMkRG6kfbXUzkkhh2ldIbNe4UO9wyd7r',1,'110.139.183.5','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36','YTo2OntzOjY6Il90b2tlbiI7czo0MDoidjZqUDkzWHhEZTRidDVLMG5Hdmc3VGhZaEhvdVYxVHFUODdDTVFzZiI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6Mjc6Imh0dHBzOi8vcnBtLnJlZ3RpeC5pZC9hZG1pbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7czoxNzoicGFzc3dvcmRfaGFzaF93ZWIiO3M6NjA6IiQyeSQxMiRTSWk3SkRiYWw2UUsvRjkuU2ExNm4uQkVYOWIydWRoRGZhNkloWGdqbzIzSW9FOUtwejB1cSI7czo2OiJ0YWJsZXMiO2E6MTp7czoyNToiTGlzdFJlZ2lzdHJhdGlvbnNfZmlsdGVycyI7YTo2OntzOjE3OiJyZWdpc3RyYXRpb25fY29kZSI7YToxOntzOjE3OiJyZWdpc3RyYXRpb25fY29kZSI7Tjt9czo4OiJldmVudF9pZCI7YToxOntzOjU6InZhbHVlIjtOO31zOjIzOiJjYXRlZ29yeV90aWNrZXRfdHlwZV9pZCI7YToxOntzOjU6InZhbHVlIjtOO31zOjEyOiJpc192YWxpZGF0ZWQiO2E6MTp7czo1OiJ2YWx1ZSI7Tjt9czoxMDoic3RhcnRfZGF0ZSI7YToxOntzOjEwOiJzdGFydF9kYXRlIjtOO31zOjg6ImVuZF9kYXRlIjthOjE6e3M6ODoiZW5kX2RhdGUiO047fX19fQ==',1763352320),
('sajhdHbKqBDy1nznYsBYf8V4BeI5kR48BWrzDmtk',1,'202.146.235.171','Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/142.0.0.0 Safari/537.36','YTo3OntzOjY6Il90b2tlbiI7czo0MDoiRzVJcThFV2tKQkxQRjZSME1DR1RHZmJ1NWszMnlxaHRZY054NWR5TSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzQ6Imh0dHBzOi8vcnBtLnJlZ3RpeC5pZC9hZG1pbi9yZXBvcnQiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjM6InVybCI7YTowOnt9czo1MDoibG9naW5fd2ViXzU5YmEzNmFkZGMyYjJmOTQwMTU4MGYwMTRjN2Y1OGVhNGUzMDk4OWQiO2k6MTtzOjE3OiJwYXNzd29yZF9oYXNoX3dlYiI7czo2MDoiJDJ5JDEyJFNJaTdKRGJhbDZRSy9GOS5TYTE2bi5CRVg5YjJ1ZGhEZmE2SWhYZ2pvMjNJb0U5S3B6MHVxIjtzOjY6InRhYmxlcyI7YToxOntzOjI1OiJMaXN0UmVnaXN0cmF0aW9uc19maWx0ZXJzIjthOjY6e3M6MTc6InJlZ2lzdHJhdGlvbl9jb2RlIjthOjE6e3M6MTc6InJlZ2lzdHJhdGlvbl9jb2RlIjtOO31zOjg6ImV2ZW50X2lkIjthOjE6e3M6NToidmFsdWUiO047fXM6MjM6ImNhdGVnb3J5X3RpY2tldF90eXBlX2lkIjthOjE6e3M6NToidmFsdWUiO047fXM6MTI6ImlzX3ZhbGlkYXRlZCI7YToxOntzOjU6InZhbHVlIjtOO31zOjEwOiJzdGFydF9kYXRlIjthOjE6e3M6MTA6InN0YXJ0X2RhdGUiO047fXM6ODoiZW5kX2RhdGUiO2E6MTp7czo4OiJlbmRfZGF0ZSI7Tjt9fX19',1763351147),
('sPxdl2LVvhV07IzayOaXtLR5AuJri433iKoOfJoR',NULL,'182.253.51.103','WhatsApp/2.23.20.0','YTozOntzOjY6Il90b2tlbiI7czo0MDoiNlhxUlkxTlM5cU8xR1hma1dWVllNS0RKQXdLYVA4emUwSEVkQ0dBZSI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzM6Imh0dHBzOi8vcnBtLnJlZ3RpeC5pZC9hZG1pbi9sb2dpbiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=',1763352802),
('TPnfBeKvYfUGeL4HgxiWdDOJhhhm4lpL4vSdHbe6',NULL,'2a02:4780:3:1::3','Go-http-client/1.1','YToyOntzOjY6Il90b2tlbiI7czo0MDoia1VBTGY4aVA2SFVYNnBYT2pIeUZlbXp1UEVsdmMxRFB4RDVWQ2tiYiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==',1763351071);
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ticket_types`
--

DROP TABLE IF EXISTS `ticket_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `ticket_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ticket_types`
--

LOCK TABLES `ticket_types` WRITE;
/*!40000 ALTER TABLE `ticket_types` DISABLE KEYS */;
INSERT INTO `ticket_types` VALUES
(1,'Flash Sale','2025-05-16 00:59:17','2025-05-16 00:59:17'),
(2,'Early Bird','2025-05-16 00:59:17','2025-05-16 00:59:17'),
(3,'Special Price','2025-05-16 00:59:17','2025-05-16 00:59:17'),
(4,'Regular','2025-05-16 00:59:17','2025-05-16 00:59:17'),
(5,'Invitation','2025-05-16 00:59:17','2025-05-16 00:59:17'),
(6,'Community Price','2025-05-16 00:59:17','2025-05-16 00:59:17'),
(7,'Sangasian','2025-05-16 00:59:17','2025-05-16 00:59:17');
/*!40000 ALTER TABLE `ticket_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) NOT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `role_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_email_unique` (`email`),
  KEY `users_role_id_foreign` (`role_id`),
  CONSTRAINT `users_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES
(1,'Administrator','administrator@regtix.id',NULL,'$2y$12$SIi7JDbal6QK/F9.Sa16n.BEX9b2udhDfa6IhXgjo23IoE9Kpz0uq','G9aopEK5HXzgbSLmqfz4Rn7nIvycfgspqQN520DJUnCP8SCOhJaTBHBPwWnw','2025-06-03 01:49:24','2025-11-14 00:38:40',3),
(2,'Admin Event','admin@regtix.id',NULL,'$2y$12$Xw3iYFYK6zhhgIOENZ4vW.dOOi5JXPOCfwK49Iry4VKHjDmVpvhrS',NULL,'2025-06-03 01:49:25','2025-06-03 01:49:25',1),
(3,'Operator 1','operator1@regtix.id',NULL,'$2y$12$gO8BYrh1lgbVLo4dg4hzUeSD0f0ZXX2bBuQnk.BVQqLpesf0dvOiG',NULL,'2025-06-03 01:49:26','2025-06-03 01:49:26',2),
(11,'Admin Keramas Run 2026','priyakepakisan2@gmail.com',NULL,'$2y$12$3ZV4JV9fGQPlKC6uG5E3fe29ag/DycE3pYyKitTihE4edmmcHNLry','3fhV41M3OfKQHzOpNzcSyV40EFLsJlvM5eZL2VYdmRM19h4a4DovgYk2KanH','2025-11-16 08:44:23','2025-11-16 08:46:46',1);
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `voucher_codes`
--

DROP TABLE IF EXISTS `voucher_codes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `voucher_codes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `voucher_id` bigint(20) unsigned NOT NULL,
  `code` varchar(255) NOT NULL,
  `used` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `voucher_codes_voucher_id_foreign` (`voucher_id`),
  CONSTRAINT `voucher_codes_voucher_id_foreign` FOREIGN KEY (`voucher_id`) REFERENCES `vouchers` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=121 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `voucher_codes`
--

LOCK TABLES `voucher_codes` WRITE;
/*!40000 ALTER TABLE `voucher_codes` DISABLE KEYS */;
INSERT INTO `voucher_codes` VALUES
(1,1,'HLFLVWFPLM',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(2,1,'GQQ2WBGTMV',0,'2025-05-16 22:11:18','2025-05-20 01:13:09'),
(3,1,'FB6WPC6RIM',0,'2025-05-16 22:11:18','2025-05-20 01:20:28'),
(4,1,'XNESZIEJK7',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(5,1,'HN3GKNVZM0',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(6,1,'WGV9NCITBT',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(7,1,'ZD5QJPWOT7',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(8,1,'7U48FNCXKX',0,'2025-05-16 22:11:18','2025-05-27 00:38:27'),
(9,1,'RTVJ2GI9UA',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(10,1,'98QQ0WCXC3',1,'2025-05-16 22:11:18','2025-05-27 20:55:32'),
(11,1,'NAPN2O1YYF',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(12,1,'CJRJXVNJME',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(13,1,'PODHRR1ZFQ',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(14,1,'KIFY15FHWV',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(15,1,'CPJEXN2BPN',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(16,1,'3HS9RHSPX1',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(17,1,'GISLHZJTHI',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(18,1,'KTVKLJGJYO',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(19,1,'73459WNQDF',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(20,1,'UY54O7LN06',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(21,1,'MQYVRABI8A',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(22,1,'PRGTXXXWLW',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(23,1,'IDUUMCSKPT',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(24,1,'Q3NWLXCTO7',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(25,1,'CIO96YTFMM',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(26,1,'NJPFX0ICSJ',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(27,1,'TJYSJVTTTJ',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(28,1,'GKE1SJB1XR',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(29,1,'NFCXRTQWXV',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(30,1,'CNGEHBRWFS',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(31,1,'46MRAYXQB1',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(32,1,'CNPNIWKJ5B',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(33,1,'0GLCQK5BQH',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(34,1,'HOZNDTSUB5',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(35,1,'NBFW70TLCP',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(36,1,'PYWLAIGKG6',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(37,1,'38HXAXEHJE',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(38,1,'QE7HVW2IEL',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(39,1,'B3QVQIFGYI',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(40,1,'D027Y11DOC',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(41,1,'ZGYPUBTNXL',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(42,1,'SNURIA3QHK',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(43,1,'8I7KAEZTRK',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(44,1,'YQ6SYDDJKL',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(45,1,'OF8382BSUI',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(46,1,'6XE809APZD',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(47,1,'DVARDFZEJ9',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(48,1,'2ZQX1HQ03M',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(49,1,'SUGEFRYUL1',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(50,1,'FXN4KBS132',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(51,1,'OHITUGK6TA',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(52,1,'QILC5PGUQI',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(53,1,'KPQ16CUXGS',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(54,1,'HIG7YDNPMU',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(55,1,'C4USUVQPWO',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(56,1,'SVBCDP7T63',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(57,1,'6TCICCJ94D',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(58,1,'COH74QJPXO',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(59,1,'SRIBSYZRSE',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(60,1,'AKOSIANMMW',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(61,1,'BIBPVAEQYX',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(62,1,'PRKJG7DE4N',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(63,1,'U8OPB885IK',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(64,1,'0TGPAGYSWJ',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(65,1,'OEUBQMXVJJ',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(66,1,'UTFVWSWTP7',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(67,1,'LONBE3EMDY',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(68,1,'L1TEPK3LPN',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(69,1,'Z2RSGT90FE',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(70,1,'YTYIXFHYFU',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(71,1,'ETVCGLEEWC',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(72,1,'YHEBEWLZAH',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(73,1,'SJX93HLCJF',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(74,1,'4TL4NOZVOH',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(75,1,'51XSXOWUAE',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(76,1,'ZT8FNSQOLJ',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(77,1,'JU06AUEKXQ',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(78,1,'SCNY6GCCNU',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(79,1,'2TMHWVIRZV',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(80,1,'6TQWVTXJAW',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(81,1,'4P8XZE6ZII',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(82,1,'1LMM7YEDTJ',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(83,1,'NGYXC0VGV8',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(84,1,'RSLZWSBUBK',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(85,1,'436SQPVSCP',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(86,1,'NYXC72ICGE',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(87,1,'3SP8XLQLHI',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(88,1,'KBFM5UFUYC',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(89,1,'MB0X3FUSWX',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(90,1,'FN8M6ZYIT8',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(91,1,'SXE0WIP5DJ',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(92,1,'VLDJNFMRAF',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(93,1,'H1XC4ZXDLP',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(94,1,'Z0WLNY1UBX',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(95,1,'Y9VAEHN6RT',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(96,1,'DVAPOLPSPI',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(97,1,'TVR5SV22DE',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(98,1,'AUUNFQ2KGH',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(99,1,'BYFAH6BJ9V',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(100,1,'MSJCMLBXBH',0,'2025-05-16 22:11:18','2025-05-16 22:11:18'),
(119,6,'HOTRXKR26',0,'2025-11-11 11:54:13','2025-11-11 11:54:13'),
(120,7,'HOTRXKR26',0,'2025-11-11 11:56:58','2025-11-11 11:56:58');
/*!40000 ALTER TABLE `voucher_codes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vouchers`
--

DROP TABLE IF EXISTS `vouchers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8mb4 */;
CREATE TABLE `vouchers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `category_ticket_type_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `final_price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `is_multiple_use` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `vouchers_category_ticket_type_id_foreign` (`category_ticket_type_id`),
  CONSTRAINT `vouchers_category_ticket_type_id_foreign` FOREIGN KEY (`category_ticket_type_id`) REFERENCES `category_ticket_type` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vouchers`
--

LOCK TABLES `vouchers` WRITE;
/*!40000 ALTER TABLE `vouchers` DISABLE KEYS */;
INSERT INTO `vouchers` VALUES
(1,2,'Invitation - 50% ',75000.00,0,'2025-05-16 22:10:44','2025-11-08 11:21:01'),
(6,20,'HOTRXKR26',250000.00,0,'2025-11-11 11:54:00','2025-11-11 11:56:28'),
(7,11,'HOTRXKR26',200000.00,0,'2025-11-11 11:56:51','2025-11-11 11:56:51');
/*!40000 ALTER TABLE `vouchers` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-17  5:28:58
