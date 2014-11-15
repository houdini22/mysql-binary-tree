DELIMITER $$

DROP FUNCTION IF EXISTS `tree_move_to_first_child_of`$$
CREATE FUNCTION `tree_move_to_first_child_of`(
		move_id   INT,
		target_id INT
)
		RETURNS INT(11)
READS SQL DATA
		BEGIN

				RETURN _tree_move(move_id, target_id, 1, 1, 1);

		END$$

DELIMITER ;