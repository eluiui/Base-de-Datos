/** diseña una función 
         que cantidad de horas de trabajo  en los distintos proyectos
         de un determinado empleado   **/
         
   DELIMITER $$
   
   USE EMPRESA $$
   DROP FUNCTION TOTAL_HORAS_TRABAJO_EMP$$
   CREATE FUNCTION TOTAL_HORAS_TRABAJO_EMP(CLAVE_EMPLEADO INTEGER UNSIGNED)
   RETURNS DOUBLE
   READS SQL DATA
   BEGIN
      DECLARE DATO DOUBLE;
      SELECT  SUM(NUM_HORAS) INTO DATO
          FROM EMPLEADOS_PROYECTOS
          WHERE EMPLEADO=CLAVE_EMPLEADO;
      IF DATO IS NULL THEN RETURN 0;
                      ELSE RETURN DATO;
      END IF;                
  END $$                    
   
   

   
   
         