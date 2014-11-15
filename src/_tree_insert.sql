DELIMITER $$

DROP FUNCTION IF EXISTS `_tree_insert`$$
CREATE FUNCTION `_tree_insert`(
		parent_id    INT,
		column_name  ENUM("tree_left", "tree_right"),
		left_offset  INT,
		level_offset INT
)
		RETURNS INT(11)
READS SQL DATA
		BEGIN

				DECLARE _new_left INT;
				DECLARE _new_right INT;
				DECLARE _new_level INT;
				DECLARE _new_scope INT;

				DECLARE _id INT;

				DECLARE _null INT;

				SELECT
						IF(column_name = "tree_left", tree_left, tree_right) + left_offset,
						tree_level + level_offset,
						tree_scope
				INTO _new_left, _new_level, _new_scope
				FROM tree t
				WHERE tree_id = parent_id;

				SET _new_right = _new_left + 1;

				SELECT _tree_create_space(_new_left, 2, _new_scope)
				INTO _null;

				INSERT INTO tree
				SET
						tree_left      = _new_left,
						tree_right     = _new_right,
						tree_level     = _new_level,
						tree_scope     = _new_scope,
						tree_parent_id = parent_id;

				SELECT LAST_INSERT_ID()
				INTO _id;

				RETURN _id;

		END$$

DELIMITER ;