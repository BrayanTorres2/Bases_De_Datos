--Trabajamos con la tabla "libros" de una librería.
--Eliminamos la tabla si existe y la creamos nuevamente:

 if object_id('libros') is not null
  drop table libros;

 create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(20),
  precio decimal(5,2),
  primary key(codigo) 
 );
--Ingresamos algunos registros:

 insert into libros values ('Uno','Richard Bach','Planeta',15);
 insert into libros values ('Ilusiones','Richard Bach','Planeta',12);
 insert into libros values ('El aleph','Borges','Emece',25);
 insert into libros values ('Aprenda PHP','Mario Molina','Nuevo siglo',50);
 insert into libros values ('Matematica estas ahi','Paenza','Nuevo siglo',18);
 insert into libros values ('Puente al infinito','Richard Bach','Sudamericana',14);
 insert into libros values ('Antología','J. L. Borges','Paidos',24);
 insert into libros values ('Java en 10 minutos','Mario Molina','Siglo XXI',45);
 insert into libros values ('Antología','Borges','Planeta',34);
--Eliminamos el procedimiento llamado "pa_autor_promedio", si existe y luego lo creamos para que reciba el nombre de un autor y nos retorne el promedio de los precios de todos los libros de tal autor:

 if object_id('pa_autor_promedio') is not null
  drop proc pa_autor_promedio;

 create procedure pa_autor_promedio
  @autor varchar(30)='%',
  @promedio decimal(6,2) output
  as 
  select @promedio=avg(precio)
   from libros
   where autor like @autor;

--Ejecutamos el procedimiento "sp_help" seguido del nombre del procedimiento creado:

 exec sp_help pa_autor_promedio;
--Obtenemos la fecha de creación e información sobre sus parámetros (nombre, tipo, longitud, etc.).

--Veamos el texto de nuestro procedimiento:

 exec sp_helptext pa_autor_promedio;
--Ejecutamos el procedimiento almacenado del sistema "sp_stored_procedures":

 exec sp_stored_procedures;
--muestra todos los procedimientos almacenados, los propietarios, etc., entre ellos se encuentra el procedimiento "pa_autor_promedio".

--Ejecutamos el procedimiento anterior pero enviándole un valor para el primer parámetro:

 exec sp_stored_procedures 'pa_%';
--Ejecutamos "sp_depends" seguido del nombre del procedimiento "pa_autor_promedio":

 exec sp_depends pa_autor_promedio;
--Obtenemos la siguiente información: los objetos de los cuales depende el procedimiento, en este caso, los campos y tablas referenciadas en el mismo: el nombre del objeto (libros), el tipo de objeto (tabla), el campo (autor y precio) y demás información que no analizaremos.

--En caso que haya objetos que dependen del procedimiento, aparece otra tabla; aquí no aparece porque el procedimiento no tiene objetos que dependan de él.

--Ejecutamos el procedimiento "sp_depends" seguido del nombre de la tabla "libros":

 exec sp_depends libros;
--aparece todos los objetos que dependen de ella; en este caso, únicamente el procedimiento creado anteriormente.

--Consultamos la tabla del sistema "sysobjects":

 select * from sysobjects;
--Nos muestra nombre y varios datos de todos los objetos de la base de datos actual. La columna "xtype" indica el tipo de objeto. "P" indica que es un procedimiento almacenado.

--Recuperamos todos los procedimientos almacenados creados por nosotros de la tabla "sysobjects":

 select * from sysobjects
  where xtype='P' and-- tipo procedimiento
  name like 'pa%';--búsqueda con comodín
--deben aparecer el procedimiento creado anteriormente.

--Eliminamos el procedimiento:

 drop proc pa_autor_promedio;
--Ejecutamos "sp_depends" seguido del nombre de la tabla "libros":

 exec sp_depends libros;
--Aparece un mensaje indicando que la tabla no tiene objetos que dependan de ella ni ella depende de ningún objeto.
