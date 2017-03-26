<!-- Write a function to capitalize the first letter of a word in a given string; Example: initcap(UNITED states Of AmERIca ) = United States Of America -->


DROP FUNCTION IF EXISTS initcap;

DELIMITER $$

CREATE FUNCTION initcap(input VARCHAR(250))
  RETURNS VARCHAR(250) deterministic

BEGIN

  DECLARE output VARCHAR(250);
  DECLARE prevChar VARCHAR(1);
  DECLARE curChar VARCHAR(1); 
  DECLARE ctr INT;				
  
  SET output = UCASE(LEFT(input, 1));
  SET ctr=1;
  SET prevChar = SUBSTRING(input, ctr, 1);
  SET curChar = "";
  
  elementLoop: LOOP
	SET ctr = ctr + 1;
    SET curChar = SUBSTRING(input, ctr, 1);
    
    IF prevChar = " " THEN
      SET output = CONCAT(output,UCASE(curChar));
    ELSE
      SET output = CONCAT(output,LCASE(curChar));
    END IF;
    
    SET prevChar = curChar;

    IF (ctr < LENGTH(input)) THEN
      ITERATE elementLoop;
    END IF;

    LEAVE elementLoop;
    
  END LOOP elementLoop;
  
  RETURN output;
END;
$$
DELIMITER ;
