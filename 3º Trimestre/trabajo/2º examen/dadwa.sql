DELIMITER $$

use empresa$$

DROP PROCEDURE IF EXISTS EMPLEADOS_EDAD $$

CREATE PROCEDURE EMPLEADOS_EDAD ( IN EDAD INTEGER)
  MODIFIES SQL DATA
  BEGIN
  
  Drop table if exists datos_edad;
  Create table if not exists datos_edad
  (
  Clave_empleado integer unsigned,
  Nombre varchar(50),
  Departamento varchar(25),
  Dia_nac integer,
  Mes_nac varchar(15),
  unique index busca_empleado (clave_empleado),
  index departamento (departamento),
  Fulltext buscar_empleado (nombre)
  
  )ENGINE MYISAM;
  
      INSERT INTO DATOS_EDAD
      (CLAVE_EMPLEADO,NOMBRE,DEPARTAMENTO,DIA_NAC,MES_NAC)
      SELECT
             E.ID_EMPLEADO,
             E.NOMBRE,
             (SELECT NOMBRE
                FROM DEPARTAMENTOS
                WHERE NUMERO=E.DEPARTAMENTO
             ),
             DAY(E.FECHA_NAC),
             CADENAMES(MONTH(E.FECHA_NAC))  /*LLAMADA A NUESTRA FUNCIÓN CADENAMES*/
       FROM EMPLEADOS AS E
       WHERE CALCULAEDAD(E.FECHA_NAC) = EDAD;  /*LLAMADA A NUESTRA FUNCIÓN*/



  END$$ 