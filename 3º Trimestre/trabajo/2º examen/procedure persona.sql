DELIMITER $$

USE empresa$$

DROP PROCEDURE IF EXISTS INTRODUCE_PERSONA$$

CREATE PROCEDURE INTRODUCE_PERSONA ( IN ED INTEGER, IN NOMB VARCHAR(50), 
								      IN TELF CHAR(9), OUT OK INTEGER 
									)
MODIFIES SQL DATA
BEGIN
   DECLARE MENSAJE VARCHAR(128);
   /*****************************************************************************************/
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION 
           BEGIN
                                  SET MENSAJE= CONCAT( ' ERROR AL  HACER LA INSERRCIÓN   DE: \t',nomb,'\n'); 
                                  SELECT MENSAJE;
                                  SET OK=0; /*FALSO*/
            END;    
    /*********************************  PROCESO *******************************************************/     
    SET OK=-1;  /*CIERTO*/
    IF ED>=18  THEN
                     INSERT INTO ADULTOS
                      (EDAD,NOMBRE,TELEFONO)
                     VALUES
                     (ED,NOMB,TELF);
               ELSE 
                     INSERT INTO MENORES
                      (ID, EDAD, NOMBRE,TELEFONO)
                     VALUES
                     (NULL,ED, NOMB,TELF);

   END IF;    

   

END$$