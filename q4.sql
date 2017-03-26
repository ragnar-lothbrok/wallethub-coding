<!-- Bug tracking Query -->

<!-- CREATE TABLE bugs (id INT,severity INT,open_date DATE,close_date DATE);   -->

DELIMITER $$
 DROP PROCEDURE IF EXISTS search$$
 CREATE PROCEDURE search(IN startDate DATE, IN endDate DATE)
BEGIN
  DECLARE output VARCHAR(1000);
  DECLARE iterDate DATE;
	  
	  SET output = '';
	  SET iterDate = startDate;
	  
	  iterLoop: LOOP
		 IF iterDate = endDate THEN
		   SET output = CONCAT(output, ' SELECT DATE(\'',iterDate,'\'),count(*) FROM bugs WHERE open_date <= DATE(\'',iterDate,'\') AND close_date >= DATE(\'',iterDate,'\') UNION ALL');
		 ELSE
		   SET output = CONCAT(output, ' SELECT DATE(\'',iterDate,'\'),count(*) FROM bugs WHERE open_date <= DATE(\'',iterDate,'\') AND close_date = DATE(\'',iterDate,'\') UNION ALL');
		 END IF;
        SET iterDate = DATE_ADD(iterDate, INTERVAL 1 DAY);
		 IF iterDate <= endDate THEN
			ITERATE iterLoop;
		 END IF;
		 
		 LEAVE iterLoop;
	   
	   END LOOP iterLoop;

	SET @output = LEFT(output, LENGTH(output)-LENGTH('UNION ALL'));
	insert into log values(@output);
	PREPARE  statement FROM @output;
	EXECUTE statement;
	   
END;
$$
DELIMITER ;