use empresa;
drop table if exists audita_empleados_proyectos;
create table  if not exists audita_empleados_proyectos
(
   linea_texto varchar(255),
   fulltext busca_palabras (linea_texto)


) ENGINE MyIsam;