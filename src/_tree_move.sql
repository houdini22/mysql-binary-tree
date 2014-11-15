DELIMITER $$

DROP FUNCTION IF EXISTS `_tree_move`$$
CREATE FUNCTION `_tree_move`(
		move_id      INT,
		target_id    INT,
		left_column  INT,
		left_offset  INT,
		level_offset INT
)
		RETURNS TINYINT(1)
READS SQL DATA
		BEGIN

				DECLARE _parent_left INT;
				DECLARE _parent_right INT;
				DECLARE _parent_level INT;
				DECLARE _parent_id INT;
				DECLARE _parent_scope INT;

				DECLARE _tree_left INT;
				DECLARE _tree_right INT;
				DECLARE _tree_level INT;
				DECLARE _tree_scope INT;
				DECLARE _tree_size INT;

				DECLARE _offset INT;

				DECLARE _null TINYINT;

				SELECT
						tree_left,
						tree_right,
						tree_level,
						tree_parent_id,
						tree_scope
				INTO _parent_left, _parent_right, _parent_level, _parent_id, _parent_scope
				FROM tree
				WHERE tree_id = target_id;

				SELECT
						tree_left,
						tree_right,
						tree_level,
						tree_scope
				INTO _tree_left, _tree_right, _tree_level, _tree_scope
				FROM tree
				WHERE tree_id = move_id;

				IF level_offset > 0
				THEN

						IF left_column > 0
						THEN
								SET left_offset = _parent_left + 1;
						ELSE
								SET left_offset = _parent_right + left_offset;
						END IF;

						SET _parent_id = target_id;

				ELSE

						IF left_column > 0
						THEN
								SET left_offset = _parent_left;
						ELSE
								SET left_offset = _parent_right + left_offset;
						END IF;

				END IF;

				SET level_offset = _parent_level - _tree_level + level_offset;
				SET _tree_size = _tree_right - _tree_left + 1;

				SELECT _tree_create_space(left_offset, _tree_size, _parent_scope)
				INTO _null;

				SET _offset = left_offset - _tree_left;

				UPDATE tree
				SET
						tree_left  = tree_left + _offset,
						tree_right = tree_right + _offset,
						tree_level = tree_level + level_offset,
						tree_scope = _parent_scope
				WHERE
						tree_left >= _tree_left AND
						tree_right <= _tree_right AND
						tree_scope = _tree_scope;

				SELECT _tree_delete_space(_tree_left, _tree_size, _tree_scope)
				INTO _null;

				UPDATE tree
				SET
						tree_parent_id = _parent_id
				WHERE
						tree_id = move_id;

				RETURN (1);

		END$$

DELIMITER ;