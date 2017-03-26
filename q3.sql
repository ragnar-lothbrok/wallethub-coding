DELIMITER $$

DROP PROCEDURE IF EXISTS rowify_columns $$
CREATE PROCEDURE rowify_columns(bound VARCHAR(255))

  BEGIN

    DECLARE id INT DEFAULT 0;
    DECLARE value TEXT;
    DECLARE occurence INT DEFAULT 0;
    DECLARE i INT DEFAULT 0;
    DECLARE split_value TEXT;
    DECLARE done INT DEFAULT 0;
    DECLARE cur1 CURSOR FOR SELECT sometbl.id, sometbl.name FROM sometbl WHERE sometbl.name != '';
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    DROP TEMPORARY TABLE IF EXISTS table2;
    CREATE TEMPORARY TABLE table2(
		`id` INT NOT NULL,
		`value` VARCHAR(255) NOT NULL
    ) ENGINE=Memory;

    OPEN cur1;
    
      read_loop: LOOP
        FETCH cur1 INTO id, value;
        IF done THEN
          LEAVE read_loop;
        END IF;

        SET occurence = (SELECT LENGTH(value) - LENGTH(REPLACE(value, bound, '')) + 1);
        SET i=1;
        WHILE i <= occurence DO
          SET split_value =
          (SELECT REPLACE(SUBSTRING(SUBSTRING_INDEX(value, bound, i),
          LENGTH(SUBSTRING_INDEX(value, bound, i - 1)) + 1), '|', ''));

          INSERT INTO table2 VALUES (id, split_value);
          SET i = i + 1;

        END WHILE;
      END LOOP;

      SELECT * FROM table2;
    CLOSE cur1;
  END; 
$$
DELIMITER ;