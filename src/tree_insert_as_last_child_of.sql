DELIMITER $$

DROP FUNCTION IF EXISTS `tree_insert_as_last_child_of`$$
CREATE FUNCTION `tree_insert_as_last_child_of`(
		target_id INT
)
		RETURNS INT(11)
READS SQL DATA
		BEGIN

				RETURN _tree_insert(target_id, "tree_right", 0, 1);

		END$$

DELIMITER ;