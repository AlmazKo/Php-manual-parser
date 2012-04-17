/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `page` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `url` text CHARACTER SET utf8 NOT NULL,
  `date` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;
INSERT INTO `page` (`id`, `parent_id`, `name`, `url`, `date`) VALUES (1,NULL,'PHP: PHP Manual - Manual','http://php.net/manual/en/','2012-04-17 23:11:00'),(2,NULL,'PHP: PHP Manual - Manual','http://php.net/manual/en/','2012-04-17 23:12:26');
