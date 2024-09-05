/******
   combinaciones externas:
          left join
          right join
    *******************************/  
    
    /*** para cada supervisor
          su nombre y la cantidad de supervisados
    **/
    /*NO SIRVE AGRUPAR POR eados.supervisor*/
        
        
    /** obtener para todos los empleados
        de  la empresa:
        su nombre y salario
        y la cantidad de empleados a los que supervisa
      **/  
      
      
     
          
          
     /*** obtener clave de empleado
          y cantidad de proyectos en los que trabaja
          en el informe sólo interesan los empleados
          que trabajan en más de 2 proyectos
       ***/
       
       
       
       /** Obtener para cada empleado: (*TODOS !!*)
           su clave, nombre y salario
           nombre del departamento al que está asignado,
           cantidad de proyectos en los que está trabajando,
           número de días que lleva trabajando en algún proyecto
        ***/   
        
        
       
            
          
            
            
           /** PARA CADA PROYECTO DE LA EMPRESA OBTENER,
               SU CLAVE, NOMBRE Y PRESUPUESTO,
               DIAS QUE HACE QUE HA SIDO LANZADO,
               CANTIDAD DE EMPLEADOS TRABAJANDO EN EL PROYECTO,
               DIAS QUE HACE QUE COMENZÓ EL TRABAJO EN EL PROYECTO
               **/
               
               
              
            
            
            /** VAMOS A LANZAR UN NUEVO PROYECTO, REGISTRAMOS EN LA BASE 
                DE DATOS**/
                
             
                
             /*** PARA CADA EMPLEADO  (**todos los empleados**)
                  SU NOMBRE, SALARIO
                  CANTIDAD DE PROYECTOS EN LOS QUE TRABAJA, (*si no trabaja no lo puedo perder**)
                  CANTIDAD DE EMPLEADOS A LOS QUE SUPERVISA
                  
                  ******/
                  
                  
              /****   1º uso la combinación externa left join
                         si una tupla de empleado en este instante no está referenciado en 
                         la tabla empleados_proyectos, para no perderlo, tengo que usar left join
                      2º en esta consulta, 
                      vamos a combinar tablas con relación a muchos dos veces
                        
                        
                    ********/    
                  
                
              /** seguimos..*/
              
             
                      
                      
                
             
                      
         /*** OBTENER PARA  CADA DIRECTOR EN LA EMPRESA:
              SU CLAVE Y NOMBRE
              EL DEPARTAMENTO QUE DIRIGE (EL NOMBRE DEL DEPARTAMENTO)
              LA FECHA DESDE QUE DIRIGE ESE DEPARTAMENTO,
              LA CANTIDAD DE EMPLEADOS A LOS QUE DIRIGE 
              Y EL SALARIO MEDIO DEL DEPARTAMENTO
              ***/
              
              /*** LOS EMPLEADOS QUE SON DIRECTORES SON LOS QUE SI COMBINAN
                    EN LA  RELACIÓN SER DIRECTOR DE DEPARTAMENTO.
                    SI A CADA EMPLEADO LE PEGO LA TUPLA DEL DEPARTAMENTO QUE DIRIGE,
                    SÓLO LOS DIRECTORES ENCUENTRAN  UNA TUPLA PARA COMBINAR,
                    ¿USO INNER O USO LEFT?---> USO INNER PARA SELECCIONAR A 
                    LOS DIRECTORES**/ 
 
 




 /*(0,1)  LA COLUMNA DIRECTOR TIENE RESTRICCIÓN DE UNICIDAD*/
     /** AHORA A CADA DIRECTOR LO COMBINAMOS CON LAS TUPLAS DE LOS EMPLEADOS
         QUE PERTENECEN AL DEPARTAMENTO QUE ÉL DIRIGE**/
         
      
	  
	  
         /*** AHORA VAMOS A INSERTAR UN NUEVO DEPARTAMENTO
              PERO SIN EMPLEADOS ASIGNADOS EN EL NUEVO DEPARTAMENTO**/
              
          INSERT INTO `empresa`.`DEPARTAMENTOS`
          (`NOMBRE`, `DIRECTOR`, `PRIMA_SUELDO`, `FECHA_INICIO`) 
          VALUES ('NUEVO_DEPARTAMENTO', '5', '2000', '2022-02-10');    
    select * from empleados where id_empleado=5;   
    
             SELECT * FROM DEPARTAMENTOS;
             SELECT * FROM EMPLEADOS WHERE DEPARTAMENTO=5;/*VACÍA*/
      SELECT   /*POR CADA GRUPO*/
                      ED.ID_EMPLEADO AS CLAVE_DIRECTOR,
                      ED.NOMBRE AS DIRECTOR,
                      D.NOMBRE AS DEPARTAMENTO,
                      D.FECHA_INICIO AS FECHA_DIRECCION,
                      COUNT(E.ID_EMPLEADO) AS CANTIDAD_EMPLEADOS_QUE_DIRIGE,
                      AVG(E.SALARIO) AS SALARIO_MEDIO_DEPARTAMENTO,
                      MAX(E.SALARIO) AS VALOR_SALARIO_MAS_ALTO_DEL_DEPARTAMENTO
                      
                FROM EMPLEADOS AS ED INNER JOIN DEPARTAMENTOS AS D
                                       ON ED.ID_EMPLEADO=D.DIRECTOR
                                           LEFT JOIN EMPLEADOS AS E 
                                                 ON D.NUMERO=E.DEPARTAMENTO  /*(0,N)*/
                GROUP BY ED.ID_EMPLEADO;    
                
                
              
                           
          /** AÑADIR AL INFORME ANTERIOR
               LA CANTIDAD DE PROYECTOS QUE DIRIGE, 
                 SON LOS LANZADOS POR EL DEPARTAMENTO QUE ÉL DIRIGE**/
                 
                 
           
                 
                /*** ATENCIÓN D.NOMBRE ES AK, EXISTE ÍNDICE ÚNICO**/ 
         /*** HEMOS UTILIZADO COMBINACIÓN DE TABLAS CON RELACIÓN A MUCHOS
              MÁS DE UNA VEZ
                  DEPARTAMENTO TIENE EMPLEADOS ASIGNADOS
                  DEPARTAMENTO TIENE PROYECTOS LANZADOSÇ
              POR CADA DEPARTAMENTO VAMOS A TENER
                  1*N*N TUPLAS
                  1*20 EMPLEADOS*5 PROYECTOS --> 100 TUPLAS PARA EL DEPARTAMENTO
          **/        
                 
                 
     /**  ENUNCIADO:
         PARA AQUELLOS DEPARTAMENTOS QUE TENGAN  ALGÚN PROYECTO LANZADO
         OBTENER 
         SU NOMBRE,
         CLAVE DE SU DIRECTOR
         CANTIDAD DE EMPLEADOS QUE ESTÁN ASIGNADOS
         SU SALARIO MEDIO         
      **/
      
      /*** SE PUEDE HACER DE DOS FORMAS, LA SELECCIÓN DE LOS DEPARTAMENTOS
           A) COMBINACIÓN INTERNA ENTRE DEPARTAMENTOS Y PROYECTOS
           B) MEDIANTE UNA SUBCONSULTA
       ******/
       
     /*** SI FUESEN  TODOS LOS DEPARTAMENTOS DE LA EMPRESA, NO HARÍA FALTA SELECCIONAR 
          DEPARTAMENTOS
          **/
          
          
     
    
    /**** ENUNCIADO PROPUESTO ME OBLIGA A SELECCIONAR DEPARTAMENTOS**/
    
           
      
      
   /** ESTA NO DEBERÍA SER LA SOLUCIÓN
    PORQUE HEMOS COMBINADO LA TABLA PROYECTOS 
    Y NO NECESITO EN EL INFORME NINGÚN DATO DE PROYECTOS LANZADOS
    LA SOLUCIÓN EN ESTE CASO MÁS EFICIENTE ES UTILIZAR UNA SUBCONSULTA
    PARA SELECCIONAR DEPARTAMENTOS
    
    *****/
    
   /*** VAMOS A SELECCIONAR DEPARTAMENTOS CON WHERE
        PERO UNA EXPRESIÓN O CONDICIÓN QUE PRECISA LEER EN OTRA TABLA
    ***/
    
    
  /**
       SELECT   
     
         FROM DEPARTAMENTOS AS D
         WHERE D.NUMERO IN ( LISTA DE VALORES);
   **/      
    
   /**SELECCIONAS LOS DEPARTAMENTOS QUE CUMPLAN:  QUE SU CLAVE PRIMARIA
      ESTÁ REFERENCIADA EN LA TABLA PROYECTOS**/    
      /*ESTA CONSULTA: CLAVES DE DEPARTAMENTO QUE ESTÁN REFERENCIADAS EN LA TABLA
                       PROYECTOS- CLAVES DE DEPARTAMENTOS QUE TIENEN ALGÚN PROYECTO
                       LANZADO
     */                  
      S 
         
 /** O TAMBÍÉN ...*/       
          
         
    /* TODAVÍA MÁS EFICIENTE,, ES NECESARIO PARA APROVECHAR EFICIENCIA INNER**/     
         
         
    /*** COMBINACIÓN EXTERNA POR LA DERECHA**/
    
    
    /** DE CADA EMPLEADO OBTENER, 
        TODOS LOS EMPLEADOS, SIN PERDER A NINGUNO, AUNQUE NO TRABAJE
        EN NINGÚN PROYECTO EN INSTANTE----> USO DE COMBNACIÓN EXTERNA {LEFT, RIGHT}
         SU NOMBRE , SALARIO Y CANTIDAD DE PROYECTOS EN LOS QUE TRABAJA
         **/
       
       
       
		 
         
         /****  enunciado   OBTENER PARA CADA DIRECTOR
              SU NOMBRE, SALARIO Y FECHA DE NACIMIENTO
              ******************/
              
              
           
                                       
                                       
      /**** OBTENER PARA CADA DIRECTOR
              SU NOMBRE, SALARIO Y FECHA DE NACIMIENTO
              PRIMA QUE COBRA Y LA FECHA DESDE QUE ES DIRECTOR
              ******************/    
              
      
                                
       /** PARA CADA SUPERVISOR EN LA EMPRESA
          OBTENER SU NOMBRE,  SU SALARIO, CLAVE DEL DEPARTAMENTO AL QUE ESTÁ ASIGNADO
       **********/
       
     /*  SELECT  
           FROM EMPLEADOS
           WHERE ID_EMPLEADO IN (*LISTA DE CLAVES DE LOS SUPERVISORES**); 
        */   
           
	/************************* SUBCONSULTAS****************************************/	   
		   
       
       
       /** PARA CADA SUPERVISOR
           SU CLAVE Y CANTIDAD DE PROYECTOS EN LOS QUE TRABAJA Y TOTAL HORAS
           DE TRABAJO EN LOS DISTINTOS PROYECTOS
           INTERESAN SÓLO LOS SUPERVISORES QUE ESTÁN TRABAJANDO EN ALGÚN PROYECTO  
           **/    
           
		   
		   
		   
		   
		   
             
   /*** FROM PARTIMOS DE EP, PORQUE SI HAY ALGÚN
        EMPLEADO SUPERVISOR QUE NO ESTÁ REFERNCIADO EN EP
        NO IMPORTA NO TRAERLO AL INFORME
      **/
      
             
       /** 
           ENUNCIADO
           PARA CADA SUPERVISOR
           SU CLAVE Y CANTIDAD DE PROYECTOS EN LOS QUE TRABAJA Y TOTAL HORAS
           DE TRABAJO EN LOS DISTINTOS PROYECTOS
           INTERESAN TODOS LOS SUPERVISORES  
           **/  
           
           

		  
       /** USAMOS UNA SUBCONSULTA PARA SELECCIONAR A LOS SUPERVISORES
           ESTA SUBCONSULTA SÓLO SE EJECUTA UNA VEZ,  ES LO PRIMERO QUE SE EJECUTA**/
       
       /** 
           ENUNCIADO
           PARA CADA SUPERVISOR
           SU CLAVE Y CANTIDAD DE PROYECTOS EN LOS QUE TRABAJA Y TOTAL HORAS
           DE TRABAJO EN LOS DISTINTOS PROYECTOS
           INTERESAN TODOS LOS SUPERVISORES 
           CANTIDAD DE SUPERVISADOS QUE ATIENDE
           Y SALARIO MEDIO DE SUS SUPERVISADOS
        *******/  
       /*** AHORA DECIDO SELECCIONAR A LOS SUPERVISORES CON USO DE INNER,
          PORQUE ESTA VEZ TENEMOS QUE TRAER A LA CONSULTAS
          A LOS SUPERVISADOS, EN LA CONSULTA ANTERIOR NO HACÍA FALTA*/
          
                                  
            
        
        
                            
            
      
    /**HEMOS EMPLEADO EN LAS COLUMNAS DE SELECCIÓN
       UNA SUBCONSULTA, ES UNA SUBCONSULTA CORRELACIONADA,
       PORQUE INTERVIENE UN DATO (UNA COLUMNA) EXTERIOR A LA CONSULTA**/
       /* ESTA CONSULTA NO SE PUEDE EJECUTAR POR SEPARADO, FUERA DE  LA CONSULTA**/
                
   
                           
                           
    /* ENUNCIADO
        PARA CADA EMPLEADO OBTENER:
        SU CLAVE , NOMBRE,  CANTIDAD DE FAMILIARES QUE TIENE REGISTRADOS
        CANTIDAD DE PROYECTOS EN LOS QUE TRABAJA, TOTAL HORAS DE TRABAJO,
        PRIMER DIA DE TRABAJO EN CUALQUIERA DE LOS PROYECTOS 
        NOMBRE DEL DEPARTAMENTO AL QUE PERTENECE         
        
      **/  
      
      
                                     
      
      
    /**OTRA FORMA**/
    /**NO COMBINAMOS TABLA DEPARTAMENTOS PARA TRAER SU NOMBRE
       SUSTITUIMOS ESE INNER JOIN POR UNA SUBCONSULTA
       CORRELACIONADA*/
      
 
         
      /** PARA LOS EMPLEADOS DE VENTAS O ADMINISTRACIÓN OBTENER:
          SU NOMBRE, SALARIO Y EL NOMBRE DE SU DIRECTOR**/
          
          
          
      
      
                           