--Un pequeño restaurante tiene almacenados los nombres y precios de sus comidas en una tabla llamada "comidas" y en una tabla denominada "postres" los mismos datos de sus postres.
--Eliminamos las tablas, si existen:

 if object_id('comidas') is not null
  drop table comidas;
 if object_id('postres') is not null
  drop table postres;
--Creamos las tablas:

 create table comidas(
  codigo tinyint identity,
  nombre varchar(30),
  precio decimal(4,2)
 );

 create table postres(
  codigo tinyint identity,
  nombre varchar(30),
  precio decimal(4,2)
 );
--Ingresamos algunos registros:

 insert into comidas values('ravioles',5);
 insert into comidas values('tallarines',4);
 insert into comidas values('milanesa',7);
 insert into comidas values('cuarto de pollo',6);

 insert into postres values('flan',2.5);
 insert into postres values('porcion torta',3.5);
--El restaurante quiere combinar los registros de ambas tablas para mostrar los distintos menúes que ofrece. Lo hacemos usando un "cross join":

 select c.nombre as 'plato principal',
  p.nombre as 'postre',
  c.precio+p.precio as 'total'
  from comidas as c
  cross join postres as p;
--La salida muestra cada plato combinado con cada uno de los postres, agregamos una columna que calcula el precio total de cada menú. Se obtienen 8 registros.
