CREATE TABLE IF NOT EXISTS `tree` (
		`tree_id`        INT(11) NOT NULL AUTO_INCREMENT,
		`tree_parent_id` INT(11) DEFAULT NULL,
		`tree_left`      INT(11) NOT NULL,
		`tree_right`     INT(11) NOT NULL,
		`tree_scope`     INT(11) NOT NULL,
		`tree_level`     INT(11) NOT NULL,
		PRIMARY KEY (`tree_id`),
		KEY `tree_parent_id` (`tree_parent_id`),
		KEY `tree_left` (`tree_left`),
		KEY `tree_right` (`tree_right`),
		KEY `tree_scope` (`tree_scope`),
		KEY `tree_level` (`tree_level`)
)
		ENGINE =MyISAM
		DEFAULT CHARSET =utf8;