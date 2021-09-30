--Vamos a crear un procedimiento almacenado que contenga las siguientes instrucciones:

--eliminación de la tabla "libros" si existe;
-- creación de la tabla "libros" con: codigo, titulo, autor, editorial, precio, cantidad;
-- ingreso de algunos registros.

--En primer lugar, debemos eliminarlo, si existe (no hemos aprendido aún a eliminar procedimientos almacenados, en próximos capítulos lo veremos):

 if object_id('pa_crear_libros') is not null
  drop procedure pa_crear_libros;
--Creamos el procedimiento:

 create procedure pa_crear_libros 
 as
  if object_id('libros')is not null
   drop table libros
  create table libros(
   codigo int identity,
   titulo varchar(40),
   autor varchar(30),
   editorial varchar(20),
   precio decimal(5,2),
   cantidad smallint,
   primary key(codigo)
  )
  insert into libros values('Uno','Richard Bach','Planeta',15,5)
  insert into libros values('Ilusiones','Richard Bach','Planeta',18,50)
  insert into libros values('El aleph','Borges','Emece',25,9)
  insert into libros values('Aprenda PHP','Mario Molina','Nuevo siglo',45,100)
  insert into libros values('Matematica estas ahi','Paenza','Nuevo siglo',12,50)
  insert into libros values('Java en 10 minutos','Mario Molina','Paidos',35,300);
Disponemos un punto y coma (;) en la última instrucción del procedimiento almacenado.

--Ejecutamos el procedimiento:

 exec pa_crear_libros;
--Veamos si ha creado la tabla:

 select *from libros;
--Ejecutamos el procedimiento almacenado del sistema "sp_help" y el nombre del procedimiento almacenado para verificar que existe el procedimiento creado recientemente:

 exec sp_help pa_crear_libros;
--Aparece el nombre, propietario, tipo y fecha de creación.

--Necesitamos un procedimiento almacenado que muestre los libros de los cuales hay menos de 10. En primer lugar, lo eliminamos si existe:

 if object_id('pa_libros_limite_stock') is not null
  drop procedure pa_libros_limite_stock;
--Creamos el procedimiento:

 create proc pa_libros_limite_stock
  as
   select *from libros
   where cantidad <=10;
--Ejecutamos el procedimiento almacenado del sistema "sp_help" junto al nombre del procedimiento creado recientemente para verificar que existe:

 exec sp_help pa_libros_limite_stock;
--Aparece el nombre, propietario, tipo y fecha de creación.

--Lo ejecutamos:

 exec pa_libros_limite_stock;
--Modificamos algún registro y volvemos a ejecutar el procedimiento:

 update libros set cantidad=2 where codigo=4;
 exec pa_libros_limite_stock;
--Note que el resultado del procedimiento ha cambiado porque los datos han cambiado.
