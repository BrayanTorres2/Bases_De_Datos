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
 insert into libros values ('Puente al infinito','Bach Richard','Sudamericana',14);
 insert into libros values ('Antología','J. L. Borges','Paidos',24);
 insert into libros values ('Java en 10 minutos','Mario Molina','Siglo XXI',45);
 insert into libros values ('Cervantes y el quijote','Borges- Casares','Planeta',34);
--Eliminamos el procedimiento almacenado "pa_libros_autor" si existe:

 if object_id('pa_libros_autor') is not null
  drop procedure pa_libros_autor;
--Creamos el procedimiento para que reciba el nombre de un autor y muestre todos los libros del autor solicitado:

 create procedure pa_libros_autor
  @autor varchar(30) 
 as
  select titulo, editorial,precio
   from libros
   where autor= @autor;
--Ejecutamos el procedimiento:

 exec pa_libros_autor 'Richard Bach';
--Empleamos la otra sintaxis (por nombre) y pasamos otro valor:

 exec pa_libros_autor @autor='Borges';
--Eliminamos, si existe, el procedimiento "pa_libros_autor_editorial":

 if object_id('pa_libros_autor_editorial') is not null
  drop procedure pa_libros_autor_editorial;
--Creamos un procedimiento "pa_libros_autor_editorial" que recibe 2 parámetros, el nombre de un autor y el de una editorial:

 create procedure pa_libros_autor_editorial
  @autor varchar(30),
  @editorial varchar(20) 
 as
  select titulo, precio
   from libros
   where autor= @autor and
   editorial=@editorial;
--Ejecutamos el procedimiento enviando los parámetros por posición:

 exec pa_libros_autor_editorial 'Richard Bach','Planeta';
--Ejecutamos el procedimiento enviando otros valores y lo hacemos por nombre:

 exec pa_libros_autor_editorial @autor='Borges',@editorial='Emece';
--Si ejecutamos el procedimiento omitiendo los parámetros, aparecerá un mensaje de error.

--Eliminamos, si existe, el procedimiento "pa_libros_autor_editorial2":

 if object_id('pa_libros_autor_editorial2') is not null
  drop procedure pa_libros_autor_editorial2;
--Creamos el procedimiento almacenado "pa_libros_autor_editorial2" que recibe los mismos parámetros, esta vez definimos valores por defecto para cada parámetro:

 create procedure pa_libros_autor_editorial2
  @autor varchar(30)='Richard Bach',
  @editorial varchar(20)='Planeta' 
 as
  select titulo,autor,editorial,precio
   from libros
   where autor= @autor and
   editorial=@editorial;
--Ejecutamos el procedimiento anterior sin enviarle valores para verificar que usa los valores por defecto:

 exec pa_libros_autor_editorial2;
--Muestra los libros de "Richard Bach" y editorial "Planeta" (valores por defecto).

--Enviamos un solo parámetro al procedimiento:

 exec pa_libros_autor_editorial2 'Planeta';
--SQL Server asume que es el primero, y no hay registros cuyo autor sea "Planeta".

--Especificamos el segundo parámetro, enviando parámetros por nombre:

 exec pa_libros_autor_editorial2 @editorial='Planeta';
--Muestra los libros de "Richard Bach" (valor por defecto para "autor") de la editorial enviada como argumento ("Planeta").

--Ejecutamos el procedimiento enviando parámetros por nombre en distinto orden:

 exec pa_libros_autor_editorial2 @editorial='Nuevo siglo',@autor='Paenza';
--Definimos un procedimiento empleando patrones de búsqueda (antes verificamos si existe para eliminarlo):

 if object_id('pa_libros_autor_editorial3') is not null
  drop procedure pa_libros_autor_editorial3;
 
 create proc pa_libros_autor_editorial3
  @autor varchar(30) = '%',
  @editorial varchar(30) = '%'
 as 
  select titulo,autor,editorial,precio
   from libros
   where autor like @autor and
   editorial like @editorial;
--Ejecutamos el procedimiento enviando parámetro por posición, asume que es el primero:

 exec pa_libros_autor_editorial3 'P%';
--La sentencia anterior ejecuta el procedimiento almacenado "pa_libros_autor_editorial3" enviando un valor que es asumido como el primero y para el segundo parámetro toma el valor por defecto; muestra los libros cuyo autor comience con "P", de cualquier editorial.

--Ejecutamos el procedimiento especificando que el valor corresponde al segundo parámetro:

 exec pa_libros_autor_editorial3 @editorial='P%';
--La sentencia anterior ejecuta el procedimiento almacenado "pa_libros_autor_editorial3" enviando un valor para el segundo parámetro, para el primer parámetro toma el valor por defecto; muestra los libros de cualquier autor cuya editorial comience con "P".

--La sentencia siguiente muestra lo mismo que la anterior:

 exec pa_libros_autor_editorial3 default, 'P%';
