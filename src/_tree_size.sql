DELIMITER $$

DROP FUNCTION IF EXISTS `_tree_size`$$
CREATE FUNCTION `_tree_size`(
		_left  INT,
		_right INT
)
		RETURNS INT(11)
DETERMINISTIC
		BEGIN
				RETURN _right - _left + 1;
		END$$

DELIMITER ;