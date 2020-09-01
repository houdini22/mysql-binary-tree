DELIMITER $$

DROP FUNCTION IF EXISTS `_tree_create_space`$$
CREATE FUNCTION `_tree_create_space`(
		space_start INT,
		space_size  INT,
		scope       INT
)
		RETURNS TINYINT(1)
READS SQL DATA
		BEGIN

				UPDATE tree t2
				SET t2.tree_left = t2.tree_left + space_size
				WHERE t2.tree_left >= space_start AND t2.tree_scope = scope;

				UPDATE tree t3
				SET t3.tree_right = t3.tree_right + space_size
				WHERE t3.tree_right >= space_start AND t3.tree_scope = scope;

				RETURN (1);

		END$$

DELIMITER ;