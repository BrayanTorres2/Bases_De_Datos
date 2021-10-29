--3.1
  SELECT top 1 nombre,año
  FROM ventas_regiones
  group by nombre, año
  order by SUM(ventas) desc
--3.2
SELECT genero, SUM(ventas) ventas
  FROM ventas_regiones
  Group by genero
  order by SUM(ventas) desc
--3.3
SELECT region, editorial, SUM(ventas) ventas
  FROM ventas_regiones
  Group by region,editorial
  order by SUM(ventas) desc
--4.1
  create proc cuarto1
   @editorial varchar(max)
   as
   select * from ventas_regiones where editorial like @editorial and año between 1970 and 2000
 --4.2
 
 create proc cuarto2
 @genero varchar(max),
 @region varchar(max)
 as
 select nombre, genero, region from ventas_regiones where genero like @genero and region like @region
 --4.3
 create proc cuarto3
 @año varchar(max)
 as
 select nombre, año, region from ventas_regiones where año like @año and region like 'Europa'
 --4.4
 create proc cuarto4
 @nombreaeditar varchar(max),
 @nombrenuevo varchar(max)
 as
 update videojuegos set nombre = @nombrenuevo where nombre = @nombreaeditar
--4.5
create proc cuarto5
 @nombre varchar(max),
 @plataforma varchar(max),
 @año varchar(max),
 @genero varchar(max),
 @editorial varchar(max),
 @ventas_na float,
 @ventas_eu float,
 @ventas_jp float,
 @ventas_ot float
 as
 insert into videojuegos(nombre, plataforma, año, genero, editorial, ventas_NA, ventas_EU, ventas_JP,ventas_Otros, ventas_Globales)
 values(@nombre, @plataforma, @año, @genero, @editorial, @ventas_na, @ventas_eu, @ventas_jp, @ventas_ot, (@ventas_na+@ventas_eu+@ventas_jp+@ventas_ot))



