/*******A PARTIR DE AHORA
 NECESITAMOS PODER ALMACENAR MÁS 
 DE UNA DIRECCIÓN PARA NUESTROS 
 EMPLEADOS
 
 ***/
 /** ANALIZAMOS EL PROBLEMA
     ---> ERA UN ATRIBUTO PARA LA ENTIDAD EMPLEADO ---> OCUPA UNA COLUMNA EN LA TABLA EMPLEADOS
          SE HA CONVERTIDO
          EN UN ATRIBUTO MULTIVALUADO---> NECESITAMOS UNA NUEVA TABLA**/
          
   CREATE TABLE  IF NOT EXISTS EMPLEADOS_DIRECCIONES
   (
      EMPLEADO INTEGER UNSIGNED NOT NULL,
      DIRECCION  VARCHAR(50) NOT NULL,
      PRIMARY KEY (EMPLEADO,DIRECCION),
      FOREIGN KEY (EMPLEADO)REFERENCES EMPLEADOS(ID_EMPLEADO)
                           ON DELETE CASCADE
                           ON UPDATE CASCADE,
      INDEX FK_EMPLEADO_DIRECCION(EMPLEADO)                     
     
   
   )ENGINE INNODB;
   
   /** YA TENEMOS EL ESPACIO PREPARADO PARA ALMACENAR LA NUEVA INFORMACIÓN...*/
   /** COPIAMOS LAS DIRECCIONES QUE TENEMOS HASTA AHORA, UNA TUPLA POR CADA  EMPLEADO..*/
   INSERT INTO EMPLEADOS_DIRECCIONES
    (EMPLEADO,DIRECCION) 
    SELECT  ID_EMPLEADO,DIRECCION
        FROM EMPLEADOS;
     /** COMO   LA COLUMNA DIRECCION EN EMPLEADOS ES OBLIGATORIA
          POR ESO ESTA CONSULTA NO LLEVA WHERE, ES IMPORTANTE VERIFICAR SI COLUMNA ES NOT NULL/NULL*/
  /** POR FIN,  AHORA ELIMINAMOS COLUMNA DIRECCION EN TABLA EMPLEADOS**/
  ALTER TABLE empleados 
      DROP COLUMN DIRECCION;
      
      
      
      