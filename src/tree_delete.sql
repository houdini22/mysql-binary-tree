DELIMITER $$

DROP FUNCTION IF EXISTS `tree_delete`$$
CREATE FUNCTION `tree_delete`(
		remove_id INT
)
		RETURNS TINYINT(1)
READS SQL DATA
		BEGIN

				DECLARE _left INT;
				DECLARE _right INT;
				DECLARE _scope INT;
				DECLARE _size INT;

				SELECT
						tree_left,
						tree_right,
						tree_scope,
						_tree_size(tree_left, tree_right)
				INTO _left, _right, _scope, _size
				FROM tree
				WHERE tree_id = remove_id;

				IF _left IS NULL
				THEN
						RETURN (0);
				END IF;

				DELETE FROM tree
				WHERE
						tree_left >= _left AND
						tree_right <= _right AND
						tree_scope = _scope;

				RETURN _tree_delete_space(_left, _size, _scope);

		END$$

DELIMITER ;