
      DELIMITER $$
      USE EMPRESA$$
 
      DROP TRIGGER IF EXISTS CONTROL_TUTOR_PROYECTO_1$$
      CREATE TRIGGER CONTROL_TUTOR_PROYECTO_1
         BEFORE INSERT ON PROYECTOS
         FOR EACH ROW
         BEGIN
           IF (
                      SELECT  DEPARTAMENTO
                          FROM EMPLEADOS
                          WHERE ID_EMPLEADO =NEW.TUTOR) <> NEW.DEPARTAMENTO
                    THEN  SIGNAL SQLSTATE '45010' SET MESSAGE_TEXT='FATAL ERROR. EL TUTOR NO ESTA EN EL MISMO DEPARTAMENTO';
         END IF;
         IF (    SELECT   COUNT(*)
                  FROM PROYECTOS
                 WHERE TUTOR=NEW.TUTOR  )= 3
                       THEN SIGNAL SQLSTATE '45011' SET MESSAGE_TEXT='FATAL ERROR. EL TUTOR  ALCANZO EL LIMITE DE PROYECTOS';
     END IF;                   
  END$$
  

  DROP TRIGGER IF EXISTS  CONTROL_TUTOR_PROYECTO_2 $$
  CREATE TRIGGER CONTROL_TUTOR_PROYECTO_2
           BEFORE UPDATE ON PROYECTOS
    FOR EACH ROW
    BEGIN
      IF OLD.TUTOR <>NEW.TUTOR
          THEN
                         IF (   SELECT  DEPARTAMENTO
                                      FROM EMPLEADOS
                                      WHERE ID_EMPLEADO =NEW.TUTOR)     <>    NEW.DEPARTAMENTO
                               THEN  SIGNAL SQLSTATE '45010' SET MESSAGE_TEXT='FATAL ERROR. EL TUTOR NO ESTAEN EL MISMO DEPARTAMENTO';
                          END IF;
                           IF (    SELECT   COUNT(*)
                                       FROM PROYECTOS
                                       WHERE TUTOR=NEW.TUTOR  )= 3
                                       THEN SIGNAL SQLSTATE '45011'SET MESSAGE_TEXT='FATAL ERROR. EL TUTOR  ALCANZO EL LIMITE DE PROYECTOS'; 
                           END IF;            
    END IF;
    END$$
                                    