-- MySQL dump 10.13  Distrib 5.5.38, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: xepanai
-- ------------------------------------------------------
-- Server version	5.5.38-0ubuntu0.14.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `alerts`
--

DROP TABLE IF EXISTS `alerts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alerts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `epan_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `sender_signature` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_epan_id` (`epan_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `alerts`
--

LOCK TABLES `alerts` WRITE;
/*!40000 ALTER TABLE `alerts` DISABLE KEYS */;
/*!40000 ALTER TABLE `alerts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branch`
--

DROP TABLE IF EXISTS `branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `branch` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `points` varchar(255) DEFAULT NULL,
  `owner_name` varchar(255) DEFAULT NULL,
  `mobile_number` varchar(255) DEFAULT NULL,
  `address` text,
  `created_at` date DEFAULT NULL,
  `email_id` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branch`
--

LOCK TABLES `branch` WRITE;
/*!40000 ALTER TABLE `branch` DISABLE KEYS */;
INSERT INTO `branch` VALUES (1,'Default','500000','Xavoc Technocrats','+91 8875191258','18/436 Gayatri Marg, Kanji Ka Hata, Dhabai Ji Ka Wada, udaipur','2011-12-12','info@xavoc.com');
/*!40000 ALTER TABLE `branch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `epan`
--

DROP TABLE IF EXISTS `epan`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `epan` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `staff_id` int(11) DEFAULT NULL,
  `branch_id` int(11) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `fund_alloted` varchar(255) DEFAULT NULL,
  `created_at` varchar(255) DEFAULT NULL,
  `category_id` int(11) DEFAULT NULL,
  `company_name` varchar(255) DEFAULT NULL,
  `contact_person_name` varchar(255) DEFAULT NULL,
  `mobile_no` varchar(255) DEFAULT NULL,
  `address` text,
  `city` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `email_id` varchar(255) DEFAULT NULL,
  `keywords` text,
  `description` text,
  `website` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `is_approved` tinyint(1) DEFAULT NULL,
  `last_email_sent` datetime DEFAULT NULL,
  `allowed_aliases` int(11) DEFAULT NULL,
  `parked_domain` varchar(255) DEFAULT NULL,
  `email_host` varchar(255) DEFAULT NULL,
  `email_port` varchar(255) DEFAULT NULL,
  `email_username` varchar(255) DEFAULT NULL,
  `email_password` varchar(255) DEFAULT NULL,
  `email_reply_to` varchar(255) DEFAULT NULL,
  `email_reply_to_name` varchar(255) DEFAULT NULL,
  `email_from` varchar(255) DEFAULT NULL,
  `email_from_name` varchar(255) DEFAULT NULL,
  `is_frontent_regiatrstion_allowed` tinyint(1) DEFAULT NULL,
  `user_activation` varchar(255) DEFAULT NULL,
  `email_threshold` varchar(255) DEFAULT NULL,
  `user_registration_email_subject` varchar(255) DEFAULT NULL,
  `user_registration_email_message_body` text,
  PRIMARY KEY (`id`),
  KEY `fk_epan_staff1` (`staff_id`),
  KEY `fk_epan_epan_categories1` (`category_id`),
  FULLTEXT KEY `tags_description_full_text` (`keywords`,`description`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `epan`
--

LOCK TABLES `epan` WRITE;
/*!40000 ALTER TABLE `epan` DISABLE KEYS */;
INSERT INTO `epan` VALUES (1,'web',1,1,'admin','5000000','2014-01-26',1,'Xavoc Technocrats Pvt. Ltd.','Xavoc Admin','+91 8875191258','18/436, Gayatri marg, Kanji Ka hata, Udaipur, Rajasthan , India','Udaipur','Rajasthan','India','','xEpan CMS, an innovative approach towards Drag And Drop CMS.','World\'s best and easiest cms :)','http://www.xavoc.com',1,1,NULL,1,NULL,'','','root','winserver','','','','',1,'self_activated','200',NULL,NULL);
/*!40000 ALTER TABLE `epan` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `epan_aliases`
--

DROP TABLE IF EXISTS `epan_aliases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `epan_aliases` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `epan_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_epan_id` (`epan_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `epan_aliases`
--

LOCK TABLES `epan_aliases` WRITE;
/*!40000 ALTER TABLE `epan_aliases` DISABLE KEYS */;
INSERT INTO `epan_aliases` VALUES (1,1,'web');
/*!40000 ALTER TABLE `epan_aliases` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `epan_categories`
--

DROP TABLE IF EXISTS `epan_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `epan_categories` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `parent_category_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cat_id` (`id`),
  KEY `cat_parent` (`parent_category_id`),
  KEY `func_getPathWay` (`id`,`parent_category_id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `epan_categories`
--

LOCK TABLES `epan_categories` WRITE;
/*!40000 ALTER TABLE `epan_categories` DISABLE KEYS */;
INSERT INTO `epan_categories` VALUES (1,'Default','Default',0);
/*!40000 ALTER TABLE `epan_categories` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `epan_components_marketplace`
--

DROP TABLE IF EXISTS `epan_components_marketplace`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `epan_components_marketplace` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `allowed_children` varchar(255) DEFAULT NULL,
  `specific_to` varchar(255) DEFAULT NULL,
  `namespace` varchar(255) DEFAULT NULL,
  `type` varchar(255) DEFAULT NULL,
  `is_system` tinyint(1) DEFAULT NULL,
  `description` text,
  `default_enabled` tinyint(1) DEFAULT NULL,
  `has_toolbar_tools` tinyint(1) DEFAULT NULL,
  `has_owner_modules` tinyint(1) DEFAULT NULL,
  `has_plugins` tinyint(1) DEFAULT NULL,
  `has_live_edit_app_page` tinyint(1) DEFAULT NULL,
  `git_path` varchar(255) DEFAULT NULL,
  `initialize_and_clone_from_git` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=77 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `epan_components_marketplace`
--

LOCK TABLES `epan_components_marketplace` WRITE;
/*!40000 ALTER TABLE `epan_components_marketplace` DISABLE KEYS */;
INSERT INTO `epan_components_marketplace` VALUES (51,'Basic Web Elements And Plugins','0','0','baseElements','element',1,'0',1,1,0,NULL,0,'',0);
/*!40000 ALTER TABLE `epan_components_marketplace` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `epan_components_plugins`
--

DROP TABLE IF EXISTS `epan_components_plugins`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `epan_components_plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `component_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `event` varchar(255) DEFAULT NULL,
  `params` varchar(255) DEFAULT NULL,
  `is_system` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_component_id` (`component_id`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `epan_components_plugins`
--

LOCK TABLES `epan_components_plugins` WRITE;
/*!40000 ALTER TABLE `epan_components_plugins` DISABLE KEYS */;
INSERT INTO `epan_components_plugins` VALUES (13,51,'RunServerSideComponent','content-fetched','$page',1),(12,51,'RemoveContentEditable','content-fetched','$page',1);
/*!40000 ALTER TABLE `epan_components_plugins` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `epan_components_tools`
--

DROP TABLE IF EXISTS `epan_components_tools`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `epan_components_tools` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `component_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `is_serverside` tinyint(1) DEFAULT NULL,
  `is_sortable` tinyint(1) DEFAULT NULL,
  `is_resizable` tinyint(1) DEFAULT NULL,
  `display_name` varchar(255) DEFAULT NULL,
  `order` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_component_id` (`component_id`)
) ENGINE=MyISAM AUTO_INCREMENT=140 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `epan_components_tools`
--

LOCK TABLES `epan_components_tools` WRITE;
/*!40000 ALTER TABLE `epan_components_tools` DISABLE KEYS */;
INSERT INTO `epan_components_tools` VALUES (87,51,'Text',0,0,0,'Simple Text',NULL),(86,51,'Title',0,0,0,'Heading',2),(85,51,'Image',0,0,0,'Simple IMage',10),(84,51,'Container',0,1,0,NULL,NULL),(83,51,'Row',0,1,0,NULL,NULL),(82,51,'Column',0,1,0,NULL,NULL),(81,51,'Template Content Region',0,1,0,NULL,NULL),(88,51,'Html Block',0,0,0,NULL,NULL),(89,51,'User Panel',1,0,0,NULL,NULL);
/*!40000 ALTER TABLE `epan_components_tools` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `epan_installed_components`
--

DROP TABLE IF EXISTS `epan_installed_components`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `epan_installed_components` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `epan_id` int(11) DEFAULT NULL,
  `component_id` int(11) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT NULL,
  `params` varchar(255) DEFAULT NULL,
  `installed_on` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `epan_installed_components`
--

LOCK TABLES `epan_installed_components` WRITE;
/*!40000 ALTER TABLE `epan_installed_components` DISABLE KEYS */;
/*!40000 ALTER TABLE `epan_installed_components` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `epan_page`
--

DROP TABLE IF EXISTS `epan_page`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `epan_page` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_page_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `menu_caption` varchar(255) DEFAULT NULL,
  `epan_id` int(11) DEFAULT NULL,
  `is_template` tinyint(1) DEFAULT NULL,
  `title` text,
  `description` text,
  `keywords` text,
  `content` text,
  `body_attributes` text,
  `created_on` datetime DEFAULT NULL,
  `updated_on` datetime DEFAULT NULL,
  `access_level` varchar(255) DEFAULT NULL,
  `template_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_epan_page_epan1` (`epan_id`),
  KEY `fk_template_id` (`template_id`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `epan_page`
--

LOCK TABLES `epan_page` WRITE;
/*!40000 ALTER TABLE `epan_page` DISABLE KEYS */;
INSERT INTO `epan_page` VALUES (1,0,'home','Home',1,0,'xEpan CMS, an innovative approach towards Drag And Drop CMS.','World\'s best and easiest cms :)','xEpan CMS, an innovative approach towards Drag And Drop CMS.',NULL,NULL,NULL,'2014-10-01 15:37:42','public',1);
/*!40000 ALTER TABLE `epan_page` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `epan_page_snapshots`
--

DROP TABLE IF EXISTS `epan_page_snapshots`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `epan_page_snapshots` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `epan_page_id` int(11) DEFAULT NULL,
  `created_on` datetime DEFAULT NULL,
  `updated_on` datetime DEFAULT NULL,
  `title` varchar(255) DEFAULT NULL,
  `keywords` text,
  `description` text,
  `body_attributes` text,
  `content` text,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `epan_page_snapshots`
--

LOCK TABLES `epan_page_snapshots` WRITE;
/*!40000 ALTER TABLE `epan_page_snapshots` DISABLE KEYS */;
/*!40000 ALTER TABLE `epan_page_snapshots` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `epan_templates`
--

DROP TABLE IF EXISTS `epan_templates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `epan_templates` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `epan_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `body_attributes` text,
  `content` text,
  `is_current` tinyint(1) DEFAULT NULL,
  `css` text,
  PRIMARY KEY (`id`),
  KEY `fk_epan_id` (`epan_id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `epan_templates`
--

LOCK TABLES `epan_templates` WRITE;
/*!40000 ALTER TABLE `epan_templates` DISABLE KEYS */;
INSERT INTO `epan_templates` VALUES (1,1,'default',NULL,'<div id=\"6b9c7e51-526c-41f1-c404-66b136b60a83\" component_namespace=\"baseElements\" component_type=\"TemplateContentRegion\" class=\"epan-sortable-component epan-component  ui-sortable\" style=\"\" contenteditable=\"false\">   {{Content}} </div>',1,NULL);
/*!40000 ALTER TABLE `epan_templates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `messages`
--

DROP TABLE IF EXISTS `messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `messages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `epan_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `message` text,
  `created_at` datetime DEFAULT NULL,
  `is_read` tinyint(1) DEFAULT NULL,
  `sender_signature` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_epan_id` (`epan_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `messages`
--

LOCK TABLES `messages` WRITE;
/*!40000 ALTER TABLE `messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `staff` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `branch_id` int(11) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `access_level` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_staff_branche1` (`branch_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `staff`
--

LOCK TABLES `staff` WRITE;
/*!40000 ALTER TABLE `staff` DISABLE KEYS */;
/*!40000 ALTER TABLE `staff` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `epan_id` int(11) DEFAULT NULL,
  `name` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `created_at` date DEFAULT NULL,
  `type` int(11) DEFAULT NULL,
  `email` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT NULL,
  `activation_code` varchar(255) DEFAULT NULL,
  `last_login_date` date DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_epan_id` (`epan_id`)
) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
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

-- Dump completed on 2014-10-01 15:41:22
