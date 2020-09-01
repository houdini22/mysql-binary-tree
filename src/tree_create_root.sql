DELIMITER $$

DROP FUNCTION IF EXISTS `tree_create_root`$$
CREATE FUNCTION `tree_create_root`()
		RETURNS INT(11)
READS SQL DATA
		BEGIN

				DECLARE _scope INT(11);
				DECLARE _id INT(11);

				SELECT (MAX(tree_scope) + 1)
				INTO _scope
				FROM tree;

				IF _scope IS NULL
				THEN
						SET _scope = 1;
				END IF;

				INSERT INTO tree
				SET
						tree_scope     = _scope,
						tree_left      = 1,
						tree_right     = 2,
						tree_parent_id = NULL,
						tree_level     = 1;

				SELECT LAST_INSERT_ID()
				INTO _id;

				RETURN (_id);

		END$$

DELIMITER ;