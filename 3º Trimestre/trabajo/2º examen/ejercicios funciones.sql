DELIMITER $$
USE EMPRESA $$

/*1 ejercicio*/
dROP FUNCTION IF EXISTS NUM_SUPERVISADOs$$
CREATE FUNCTION NUM_SUPERVISADOS(CLAVE_EMPLEADO INTEGER UNSIGNED)
RETURNS INTEGER
READS SQL DATA
BEGIN
	DECLARE CANTIDAD INTEGER;
SELECT COUNT(*) INTO CANTIDAD
	FROM EMPLEADOS 
    WHERE SUPERVISOR=CLAVE_EMPLEADO;
	RETURN CANTIDAD;

END$$

/*2(a) ejercicio*/
DROP FUNCTION IF EXISTS SALARIO_MEDIO$$
CREATE FUNCTION SALARIO_MEDIO()
RETURNS Double
READS SQL DATA
BEGIN
	RETURN (
            select avg(salario)
				from empleados
            );
    
END$$

/*2(b) ejercicio*/
DROP FUNCTION IF EXISTS SALARIO_MEDIO_dep$$
CREATE FUNCTION SALARIO_MEDIO_DEP(Clave_dep INTeger unsigned)
RETURNS double
READS SQL DATA
BEGIN
	DECLARE SALARIO_MEDIO double;
	SELECT AVG(SALARIO) INTO SALARIO_MEDIO
		FROM EMPLEADOS
		Where DEPARTAMENTO=clave_dep;
	if salario_medio is null
		then return 0;
	end if;
	RETURN SALARIO_MEDIO;
    
END$$
/*3 ejercicio*/
DROP FUNCTION IF EXISTS clave_departamento$$
CREATE FUNCTION clave_departamento(nombre_dep varchar(25))
RETURNS INTEGER
READS SQL DATA
BEGIN
RETURN (	
        SELECT numero 
			FROM departamentos
			where nombre=nombre_dep
		);
    
END$$

/*4 ejercicio*/

DROP FUNCTION IF EXISTS num_proyectos_dep$$
CREATE FUNCTION num_proyectos_dep(clave_departamento INTeger unsigned)
RETURNS INTEGER
READS SQL DATA
BEGIN
	DECLARE num_proyectos INTEGER;
SELECT count(*) INTO num_proyectos
	FROM proyectos
	where DEPARTAMENTO=clave_departamento;
	RETURN num_proyectos;
    
END$$

/*5 ejercicio*/

DROP FUNCTION IF EXISTS SI_supervisor$$
CREATE FUNCTION SI_supervisor(CLAVE_EMPLEADO INTEGER UNSIGNED)
RETURNS BOOLEAN
READS SQL DATA
BEGIN
    
  IF CLAVE_EMPLEADO IN (
                        SELECT distinct supervisor
                          FROM empleados
                          where supervisor
                       )
             THEN RETURN TRUE;
             ELSE RETURN FALSE;
  END IF;
  
END$$

/*6 ejercicio*/

DROP FUNCTION IF EXISTS HORAS_TRABAJO_DEP$$
 CREATE FUNCTION HORAS_TRABAJO_DEP ( CLAVE_DEP INTEGER UNSIGNED )
 RETURNS DOUBLE
 READS SQL DATA
 BEGIN
     DECLARE TOTAL_HORAS DOUBLE ;
     SELECT    SUM(NUM_HORAS) INTO TOTAL_HORAS
         FROM EMPLEADOS_PROYECTOS
         WHERE EMPLEADO IN (
                                  SELECT ID_EMPLEADO
                                    FROM EMPLEADOS
                                    WHERE DEPARTAMENTO=CLAVE_DEP
                           );
      IF TOTAL_HORAS THEN   RETURN TOTAL_HORAS;
                     ELSE   RETURN 0.0 ;
      END IF;               
 
 
 END$$
 
 /** OTRO CÓDIGO POSIBLE, EJECUTAMOS UNO U OTRO **********/ 
 
 
 DROP FUNCTION IF EXISTS NUM_HORAS_DEP$$
 CREATE FUNCTION NUM_HORAS_DEP( CLAVE_DEP INTEGER UNSIGNED)
 RETURNS DOUBLE
 READS SQL DATA
 BEGIN
     DECLARE TOTAL_HORAS DOUBLE ;
     SELECT   SUM(EP.NUM_HORAS)  INTO TOTAL_HORAS
        FROM EMPLEADOS_PROYECTOS AS EP INNER  JOIN EMPLEADOS AS E
                                       ON EP.EMPLEADO=E.ID_EMPLEADO
                                           AND
                                          E.DEPARTAMENTO=CLAVE_DEP; 
     IF  TOTAL_HORAS THEN RETURN TOTAL_HORAS;
                     ELSE RETURN 0.0;
     END IF;
     
 
 END$$
