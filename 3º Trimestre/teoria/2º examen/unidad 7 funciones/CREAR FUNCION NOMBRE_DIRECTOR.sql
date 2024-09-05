/** DEFINIR E IMPLEMENTAR
   UNA FUNCIÓN
   QUE RECIBE LA CLAVE DE UN DEPARTAMENTO
   Y RETORNA EL NOMBRE DE SU DIRECTOR**/
   
   
   DELIMITER $$
   
   USE EMPRESA $$
   DROP FUNCTION IF EXISTS NOMBRE_DIRECTOR $$
   CREATE FUNCTION NOMBRE_DIRECTOR (CLAVE_DEP  INTEGER UNSIGNED )
   RETURNS VARCHAR(50)
   READS SQL DATA
   BEGIN
       DECLARE NOMBRE_D VARCHAR(50);
       SELECT  NOMBRE INTO NOMBRE_D
           FROM EMPLEADOS
           WHERE ID_EMPLEADO = (
                                SELECT   DIRECTOR
                                   FROM DEPARTAMENTOS
                                   WHERE NUMERO=CLAVE_DEP
                              );
      IF  NOMBRE_D is not null   
                         THEN  RETURN NOMBRE_D;
	                     ELSE RETURN '\0'; /*cadena nula,falsa, no tiene longitud, pinta blanco*/
	  END IF;					 
   END$$