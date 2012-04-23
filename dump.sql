CREATE TABLE IF NOT EXISTS `anchor` (
  `id` int(10) unsigned NOT NULL,
  `from_page_id` int(10) unsigned NOT NULL,
  `to_page_id` int(10) unsigned NOT NULL,
  `url` varchar(255) NOT NULL,
  `url_params` varchar(255) NOT NULL,
  `is_contents` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `anchor_mem`
--

CREATE TABLE IF NOT EXISTS `anchor_mem` (
  `id` int(10) unsigned NOT NULL,
  `from_page_id` int(10) unsigned NOT NULL,
  `to_page_id` int(10) unsigned DEFAULT NULL,
  `url` varchar(255) NOT NULL,
  `url_params` varchar(255) NOT NULL DEFAULT '',
  `is_contents` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MEMORY DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Структура таблицы `page`
--

CREATE TABLE IF NOT EXISTS `page` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `url` text CHARACTER SET utf8 NOT NULL,
  `content` text CHARACTER SET utf8,
  `date` datetime NOT NULL,
  `completely` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- Структура таблицы `page_mem`
--

CREATE TABLE IF NOT EXISTS `page_mem` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `parent_id` int(10) unsigned DEFAULT NULL,
  `name` varchar(255) CHARACTER SET utf8 NOT NULL,
  `url` varchar(255) CHARACTER SET utf8 NOT NULL,
  `content_hash` char(32) CHARACTER SET ascii COLLATE ascii_bin DEFAULT NULL,
  `date` datetime NOT NULL,
  `completely` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MEMORY  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;
