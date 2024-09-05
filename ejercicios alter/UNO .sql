SELECT ID_EMPLEADO, NOMBRE
    FROM EMPLEADOS;
    
    
 /**LISTA DE NOMBRES DE MIS EMPLEADOS, EN ORDEN ALFABÉTICO**/   
 
 /** CRITERIO DE CLASIFICACIÓN ---> DATO NOMBRE
         VARIOS CRITERIOS DE CLASIFICACIÓN
               2º, 3º--**/
               
       
      
  /*** LISTA DE NOMBRES DE LOS EMPLEADOS 
       DEL DEPARTAMENTO DE CLAVE 3**/
      
      
         
    /****NOMBRES Y SALARIOS DE LOS EMPLEADOS
         QUE PERTENEZCAN A LOS DEPARTAMENTOS DE CLAVE
         2 Y 3 Y 4****/
         
         
     
               
               
    
         
       
       /**NOMBRE DE LOS EMPLEADOS QUE NO PERTENEZCAN
          A LOS DEPARTAMENTOS UNO Y DOS**/
          
    
   
   
   /**NOMBRE Y SALARIO DE LOS EMPLEADOS QUE NO PERTENEZCAN
          A LOS DEPARTAMENTOS UNO Y DOS
          Y CUYO SALARIO SEA MAYOR QUE 2000**/
          
          
   
                
                
    
                
  /**NOMBRE Y SALARIO DE LOS EMPLEADOS QUE NO PERTENEZCAN
          A LOS DEPARTAMENTOS UNO Y DOS
          O SU SALARIO SEA MAYOR QUE 2000**/
          
          
     
                
  /*** DAME LOS NOMBRES DE LOS EMPLEADOS
       QUE SU SALARIO SEA MAYOR QUE 1000 Y MENOR QUE
       2000**/
	   
	   /*** operador between*/
       
  
                
         
  
      /**[1000,2000]**/
      
   /*** NOMBRES DE EMPLEADOS CUYO SALARIO
        NO ESTÁ COMPRENDIDO ENTRE 1000 Y 1500**/
        
   
      
    /*** EXCLUIR SALARIOS DENTRO DE [1000,1500]**/
    
    
    
    /*** DAME NOMBRE Y APELLIDOS , Y SALARIO
         DE LOS EMPLEADOS QUE SE LLAMEN FERNANDO**/
         
         
         /**** LIKE PATRÓN DE BÚSQUEDA EN UNA CADENA**/
         
       
          
          /*** QUE CONTENGA LA CADENA FERNANDO**/
          
    
          
         /*** QUE EMPIECE POR  LA CADENA FERNANDO Y SIGA CUALQUIER CADENA**/ 
          
          
          
  /******* funciones de agregado, son rutinas...
         RETORNAN UN DATO, NUNCA UNA LISTA DE DATOS***/
         
    /*** COUNT(*)  CUENTA LAS TUPLAS SELECCIONADAS
         COUNT(COLUMNA)  CUENTA LAS TUPLAS SELECCIONADAS
                         QUE TENGA VALOR EL LA COLUMNA
         COUNT(DISTINCT COLUMNA)
                          CUENTA LAS TUPLAS SELECCIONADAS
                          QUE TENGA VALOR EN LA COLUMNA PERO VALOR DISTINTO
    ****************************************/
    
    
    /*** CUÁNTOS EMPLEADOS TENGO EN LA EMPRESA?**/
    
   
    
     /*** CUANTOS EMPLEADOS ESTÁN ASIGNADOS AL DEPARTAMENTO 
          DE CLAVE 3**/
          
         
        /****** CUANTOS EMPLEADOS TIENEN SUPERVISOR***/
        
        
       /*** IS NOT NULL  , SI TIENE VALOR**/   
         
        
         
         
         /** CUANTOS EMPLEADOS NO TIENEN SUPERVISOR,
             CUANTOS  EMPLEADOS NO ESTÁN SUPERVISADOS**/
             
             
             
         
         /**** IS NULL--- NO TIENEN VALOR**/
         
        /***  CUANTOS EMPLEADOS ESTÁN SUPERVISADOS POR EL EMPLEADO
              DE CLAVE 5**/
              
            
                  
                  
          /*******  CUÁNTOS EMPLEADOS SON SUPERVISORES***/
          
         
         
         /** CUANTOS DEPARTAMENTOS HAY EN LA EMPRESA?***/
         
         /** DE FORMA EFICIENTE**/
            
         
         /** SUPONGO NO TENGO ACCESO A TABLA DEPARTAMENTOS
             Y TODOS LOS DEPARTAMENTOS TIENEN EMPLEADOS**/
             
          
             
          /****  EN CUANTOS PROYECTOS ESTÁ TRABAJANDO EL EMPLEADO DE CLAVE 5**/
          
          S
             
         /** EN CUANTOS PROYECTOS ESTÁN TRABAJANDO
             LOS EMPLEADOS DE CLAVES 5,3, Y 1 ?
             ***/
             
             
             
                
          /** CUANTOS SALARIOS HAY EN LA EMPRESA**/
          
          
         
              
              
          /**** DIME EL SALARIO MEDIO DE LA EMPRESA*/
          
          /*** AVG(COLUMNA)  MEDIA ARITMÉTICA DE LOS VALORES DE UNA COLUMNA
                ------> DOUBLE**/
                
                
              
                    
             /*** CÚAL ES EL VALOR DEL SALARIO MÁS ALTO
                  EN LA EMPRESA?***/
                  
                /*** MAX(COLUMNA) ---- VALOR MAYOR**/  
                
             
                 
             /** DIME :
                CANTIDAD DE EMPLEADOS, SALARIO MAYOR, SALARIO MENOR
                  SALARIO MEDIO DE LA EMPRESA**/
                  
            
                 
           /** SALARIO MEDIO DE LOS SUPERVISADOS*/  
                
           /**** MAYOR SALARIO DE LOS EMPLEADOS DEL DEPARTAMENTO
                DE CLAVE 3**/
                
              
                
            /*** CUANTOS EMPLEADOS TIENEN UN SALARIO
                  MAYOR QUE EL SALARIO MEDIO DE  LA EMPRESA**/
       /*     SELECT   COUNT(*)
                FROM EMPLEADOS
                WHERE SALARIO>(
                               SELECT   AVG(SALARIO) 
                               FROM EMPLEADOS  
                              )    */        
            
            /*** NOMBRES Y DEPARTAMENTO
                 DE LOS EMPLEADOS
                 QUE TIENEN UN SALARIO
                 MAYOR QUE EL SALARIO MEDIO DE  LA EMPRESA***/
                 
   /**   SELECT   NOMBRE, DEPARTAMENTO
                FROM EMPLEADOS
                WHERE SALARIO>(
                               SELECT   AVG(SALARIO) 
                               FROM EMPLEADOS  
                              ) ;    **/ 
                              
                              
     /***** CRITERIO DE CLASIFICACIÓN**
             POR DEFECTO  ESTÁN ORDENADOS POR CLAVE PRIMARIA
             UN CRITERIO DE CLASIFICACIÓN DISTINTO
                ----> ORDER BY COL1
             PUEDO TENER VARIOS CRITERIOS DE CLASIFICACIÓN
             ----> SON ANIDADOS ***/
             
       /**LISTA DE NOMBRES Y SALARIOS
          DE LOS EMPLEADOS
          DE LOS DEPARTAMENTOS 3, 4 Y 2
          QUE ESTÁN SUPERVISADOS
          ORDENADOS DE MAYOR A MENOR SALARIO
          Y EN ORDEN ALFABÉTICO
       **/
       
       
       
        
       
       
           
           
    /**** DAME LA FECHA DE NACIMIENTO
          DEL EMPLEADO MÁS JOVEN**/
          
     
        
         
         
    /**** NOMBRES DE LOS EMPLEADOS
         ORDENADOS POR SU EDAD**/
         
         
        
            
     /*** EJEMPLO DE EXPRESIÓN O DATO CALCULADO**/
     
     /** DAME LOS DIAS QUE SE LLEVA TRABAJANDO
         EN CADA ASIGNACIÓN DE TRABAJO**/
         
     
                   
            
     /** para el proyecto de clave 1,
         obtener
         clave de cada empleado trabajando en él
         y cantidad de días que lleva trabajando**/
         
     
         
         
             