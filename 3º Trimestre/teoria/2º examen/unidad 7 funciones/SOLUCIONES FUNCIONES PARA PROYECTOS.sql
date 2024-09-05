delimiter $$

use empresa $$

ALTER TABLE PROYECTOS
  CHANGE COLUMN FECHA_INICIO FECHA_LANZAMIENTO DATE NOT NULL;
  

/*4º-Realiza una función que reciba la clave de un departamento
 y retorne la cantidad de
 proyectos lanzados por ese departamento. 
 num_proyectos_dep **/

drop function if exists num_proyectos_dep$$
create function num_proyectos_dep (clave_departamento  integer unsigned)
returns integer
reads sql data
begin

return (
          select  count(*)
             from proyectos
             where departamento=clave_departamento

       );
end$$

/*** FUNCIÓN QUE RECIBE LA CLAVE DE UN PROYECTO
    Y RETORNA LA CANTIDAD DE DÍAS QUE HACE QUE ESTÁ LANZADO O CREADO
    NUM_DIAS_CREADO
    ***/
  /**** fecha de inicio de tabla proyectos
        es la fecha de creación o de lanzamiento del proyecto**/
        
 DROP FUNCTION IF EXISTS NUM_DIAS_CREADO $$
  CREATE FUNCTION NUM_DIAS_CREADO (CLAVE_PROYECTO INTEGER UNSIGNED )
  RETURNS INTEGER
  READS SQL DATA
  BEGIN
      DECLARE CANTIDAD_DIAS INTEGER;
      DECLARE FECHA DATE;
      SELECT  FECHA_LANZAMIENTO INTO FECHA
          FROM PROYECTOS
          WHERE ID_PROYECTO=CLAVE_PROYECTO;
      
      IF FECHA  IS NOT NULL THEN 
                             SET CANTIDAD_DIAS=DATEDIFF(CURRENT_DATE(),FECHA);
                             /*
                                SELECT DATEDIFF(CURRENT_DATE(), FECHA) INTO CANTIDAD_DIAS;
                             */
                             RETURN CANTIDAD_DIAS;
      END IF;
      RETURN 0;
  END$$

/** FUNCIÓN QUE RECIBE LA CLAVE DE UN PROYECTO
    Y RETORNA LA FECHA DEL PRIMER DIA DE TRABAJO EN ÉL**/
 /** fecha de inicio de la tabla empleados_proyectos
     es la fecha de comienzo de trabajo de un empleado en un proyecto**/
     
    DROP FUNCTION IF EXISTS PRIMER_DIA_TRABAJO $$
    CREATE FUNCTION PRIMER_DIA_TRABAJO ( CLAVE_PROYECTO INTEGER UNSIGNED)
    RETURNS DATE 
    READS SQL DATA
    BEGIN
        DECLARE PRIMER_DIA DATE;
        
        SELECT    MIN(FECHA_INICIO) INTO PRIMER_DIA
           FROM EMPLEADOS_PROYECTOS 
           WHERE PROYECTO=CLAVE_PROYECTO;
       IF PRIMER_DIA IS NOT NULL THEN 
                                 RETURN PRIMER_DIA;
                                 ELSE RETURN '0000-00-00'; 
       END IF;               
    
    END$$
    
/** FUNCIÓN QUE RECIBE LA CLAVE DE UN PROYECTO
    Y RETORNA EL TOTAL DE HORAS DE TRABAJO QUE SE HACEN EN ESE PROYECTO
    TOTAL_HORAS_TRABAJO  **/

   DROP FUNCTION IF EXISTS TOTAL_HORAS_TRABAJO$$
   CREATE FUNCTION TOTAL_HORAS_TRABAJO (CLAVE_PROYECTO INTEGER UNSIGNED)
   RETURNS DOUBLE
   READS SQL DATA
   BEGIN
       DECLARE TOTAL DOUBLE; /* VAR PARA HACER RETURN**/
       SELECT   SUM(NUM_HORAS) INTO TOTAL
          FROM EMPLEADOS_PROYECTOS
          WHERE PROYECTO=CLAVE_PROYECTO;
      IF TOTAL IS NULL THEN SET TOTAL= O.O;
      END IF;
      RETURN TOTAL;
      
   END$$
   

/** FUNCIÓN QUE RECIBE LA CLAVE DE UN PROYECTO Y RETORNA CANTIDAD DE EMPLEADOS
    DEL MISMO DEPARTAMENTO QUE EL PROYECTO QUE ESTÁN TRABAJANDO EN ÉL**/
    
    DROP FUNCTION  IF EXISTS CANTIDAD_EMPL_TRABAJAN_DEP$$
    CREATE FUNCTION  CANTIDAD_EMPL_TRABAJAN_DEP (CLAVE_PROYECTO INTEGER UNSIGNED)
    RETURNS INTEGER
    READS SQL DATA
    BEGIN
         DECLARE CANTIDAD INTEGER; /*VAR A RETORNAR*/
         DECLARE CLAVE_DEP INTEGER UNSIGNED;
         /* para la clave del departamento al que pertenece el proyecto*/
         
         /**** PROCESO**/
         SELECT   DEPARTAMENTO INTO CLAVE_DEP
            FROM PROYECTOS
            WHERE ID_PROYECTO=CLAVE_PROYECTO;
            
         IF CLAVE_DEP IS NULL
                     THEN RETURN 0;
         END IF;          
         SELECT   COUNT(*) INTO CANTIDAD
           FROM EMPLEADOS_PROYECTOS
           WHERE PROYECTO=CLAVE_PROYECTO
                 AND
                 EMPLEADO IN (
                                SELECT   ID_EMPLEADO
                                   FROM EMPLEADOS
                                   WHERE DEPARTAMENTO=CLAVE_DEP
                 
                              );
         RETURN CANTIDAD;
    END$$
    

    
    
/* FUNCIÓN QUE RECIBE LA CLAVE DE UN PROYECTO 
    Y RETORNA LA CANTIDAD DE DIRECTORES
    DE DEPARTAMENTO QUE ESTÁN TRABAJANDO EN EL PROYECTO**/ 
    
    /*** HACERLA DE DOS FROMAS
         UNA DE ELLAS USANDO FUNCIÓN  SI_DIRECTOR
         ****/
   DROP FUNCTION IF EXISTS  CANTIDAD_DIRECTORES_TRABAJAN $$
   
   CREATE FUNCTION CANTIDAD_DIRECTORES_TRABAJAN ( CLAVE_PROYECTO INTEGER UNSIGNED)
   RETURNS INTEGER
   READS SQL DATA
   BEGIN
      
    RETURN (  SELECT COUNT(*)
                FROM EMPLEADOS_PROYECTOS 
                  WHERE  PROYECTO=CLAVE_PROYECTO
                           AND
                         EMPLEADO IN(
                                  SELECT DIRECTOR
                                     FROM DEPARTAMENTOS
                                    )
            );                        
   
   
   END$$
 /*** FUNCIÓN SI_DIRECTOR***/
  DROP FUNCTION IF EXISTS SI_DIRECTOR $$
  CREATE FUNCTION SI_DIRECTOR (CLAVE_EMPLEADO INTEGER UNSIGNED )
  RETURNS BOOLEAN
  READS SQL DATA
  BEGIN
      IF  CLAVE_EMPLEADO IN (
                                SELECT DIRECTOR
                                  FROM DEPARTAMENTOS
      
                             )
         THEN RETURN TRUE;
         ELSE RETURN FALSE;
      END IF;   
  END$$
   
 /*****  LA MISMA FUNCIÓN DE OTRA FORMA , USANDO EN EL CUERPO
      DE LA FUNCIÓN UNA LLAMADA A OTRA FUNCIÓN
      SI_DIRECTOR ***/
     
 DROP FUNCTION IF EXISTS  CANTIDAD_DIRECTORES_TRABAJAN $$
 CREATE FUNCTION CANTIDAD_DIRECTORES_TRABAJAN ( CLAVE_PROYECTO INTEGER UNSIGNED)
   RETURNS INTEGER
   READS SQL DATA
   BEGIN
    RETURN 
        (   SELECT  COUNT(*)  
            FROM EMPLEADOS_PROYECTOS
            WHERE PROYECTO=CLAVE_PROYECTO
                  AND
                 SI_DIRECTOR(EMPLEADO) /**LA FUNCIÓN TIENE QUE EXISTIR, TIENE
                                        QUE ESTAR IMPLEMENTADA**/
         );
   
   
   END$$
/*
Error Code: 1305. 
   FUNCTION empresa.SI_DIRECTOR does not exist **/


     

/*** FUNCIÓN QUE RECIBE LA CLAVE DE UN DEPARTAMENTO
    Y RETORNA EL TOTAL DEL IMPORTE DE LOS PRESUPUESTOS
    EN   TODOS SUS PROYECTOS
    *****/
    
   drop function if exists   total_presupuestos_proyectos $$
   
   create function total_presupuestos_proyectos (CLAVE_DEPARTAMENTO integer unsigned)
   returns double
   reads sql data
   begin
       declare total double; /*var para retornar*/
       
       select     sum(PRESUPUESTO) into total
          from PROYECTOS
          where DEPARTAMENTO=CLAVE_DEPARTAMENTO;
    
        if total is null then return 0.0;
        end if;
        return total;
   end$$
    
    
    
    