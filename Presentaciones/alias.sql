
--Trabajamos con nuestra tabla "agenda".
--Eliminamos la tabla si existe:

 if object_id('agenda') is not null
  drop table agenda;
--Creamos la tabla:

 create table agenda(
  nombre varchar(30),
  domicilio varchar(30),
  telefono varchar(11)
 );
--Ingresamos algunos registros:

 insert into agenda
  values('Juan Perez','Avellaneda 908','4252525');
 insert into agenda
  values('Marta Lopez','Sucre 34','4556688');
 insert into agenda
  values('Carlos Garcia','Sarmiento 1258',null);
--Mostramos la información con el encabezado "NombreYApellido" para el campo "nombre":

 select nombre as NombreYApellido,
  domicilio,telefono
  from agenda;
--Mostramos la información con el encabezado "Nombre y apellido" para el campo "nombre", necesitamos emplear comillas:

 select nombre as 'Nombre y apellido',
  domicilio,telefono
  from agenda;
--La palabra clave "as" es opcional, podemos obviarla:

 select nombre 'Nombre y apellido',
  domicilio,telefono
  from agenda;
