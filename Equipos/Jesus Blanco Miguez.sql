
    Drop DATABASE IF EXISTS liga_baloncesto;
    CREATE DATABASE IF NOT EXISTS liga_baloncesto;
    
    USE liga_baloncesto;
    
    Drop table if exists jugadores;
    CREATE TABLE IF NOT EXISTS jugadores
    (
      ID_jugador INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
      NOMBRE_apellidos  VARCHAR(30) NOT NULL,
      FECHA_NAC DATE NOT NULL,
      Nacionalidad Enum('española','americana','inglesa','jamaicana','yugoslava') not null,
      Equipo INTEGER UNSIGNED  NOT NULL,
	  Dorsal int null,
      FOREIGN KEY (Equipo) REFERENCES equipos(ID_equipo)
                       ON DELETE CASCADE 
                       ON UPDATE CASCADE,
      PRIMARY KEY(ID_jugador),
      
      INDEX FK_equipo (Equipo)
      
      
    )ENGINE = InnoDB;
    
    Drop table if exists equipos;
    CREATE TABLE IF NOT EXISTS equipos
    (
       ID_equipo INTEGER UNSIGNED NOT NULL,
       NOMBRE_equipo VARCHAR(30) NOT NULL,
       Nombre_entrenador VARCHAR(55) NOT NULL ,
	   Nombre_cancha varchar(30) unique not null,
	   Poblacion varchar(25) not null,
	   Año_fundacion year null,
       Capitan INTEGER UNSIGNED NOT NULL,
       PRIMARY KEY (ID_CURSO),
       FOREIGN KEY (Capitan) REFERENCES jugadores(ID_jugador)
                              ON DELETE RESTRICT
                              ON UPDATE CASCADE,                       
       UNIQUE INDEX  FK_capitan (Capitan)
       )ENGINE = InnoDB;
    
    ALTER TABLE jugadores
     ADD
      FOREIGN KEY (equipo) REFERENCES equipos(ID_equipo)
                     ON DELETE RESTRICT
                     ON UPDATE CASCADE;
    
    Drop table if exists equipos_equipos; 
    CREATE TABLE IF NOT EXISTS equipos_equipos
    (
       id_partido INTEGER NOT NULL,
	   equipo_visitante INTEGER unsigned NOT NULL,
	   equipo_local INTEGER unsigned NOT NULL,
	   fecha_partido date null,
	   puntos_local int not null default 0,
	   puntos_visitante int not null default 0,
       PRIMARY KEY (id_partido),
	   
       FOREIGN KEY (equipo_visitante) REFERENCES equipos(ID_equipo)
                       ON DELETE CASCADE 
                       ON UPDATE CASCADE,
       INDEX FK_equipo_visitante (equipo_visitante),
	   
	   FOREIGN KEY (equipo_local) REFERENCES equipos(ID_equipo)
                       ON DELETE CASCADE 
                       ON UPDATE CASCADE,
       INDEX FK_equipo_local (equipo_local)
	   
    )ENGINE = InnoDB;
    
    /*5
	
	*/
	/*6
    jugador
	*/
	/*7
	equipos
	*/