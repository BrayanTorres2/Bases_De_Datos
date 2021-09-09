--Trabajamos con la tabla "libros" de una librería.
--Eliminamos la tabla si existe:

 if object_id ('libros') is not null
  drop table libros;
--Creamos la tabla:

 create table libros(
  codigo int identity,
  titulo varchar(40) not null,
  autor varchar(20) default 'Desconocido',
  editorial varchar(20),
  precio decimal(6,2),
  cantidad tinyint default 0,
  primary key (codigo)
 );
--Ingresamos algunos registros:

 insert into libros (titulo,autor,editorial,precio)
  values('El aleph','Borges','Emece',25);
 insert into libros
  values('Java en 10 minutos','Mario Molina','Siglo XXI',50.40,100);
 insert into libros (titulo,autor,editorial,precio,cantidad)
  values('Alicia en el pais de las maravillas','Lewis Carroll','Emece',15,50);
--Mostramos sólo los 12 primeros caracteres de los títulos de los libros y sus autores, empleando la función "substring()":

 select substring(titulo,1,12) as titulo
  from libros;
--Mostramos sólo los 12 primeros caracteres de los títulos de los libros y sus autores, ahora empleando la función "left()":
 select left(titulo,12) as titulo
  from libros;
--Mostramos los títulos de los libros y sus precios convirtiendo este último a cadena de caracteres con un solo decimal, empleando la función "str":

 select titulo,
  str(precio,6,1)
  from libros;
--Mostramos los títulos de los libros y sus precios convirtiendo este último a cadena de caracteres especificando un solo argumento:

 select titulo,
  str(precio)
  from libros;
--Se redondea a entero.

--Mostramos los títulos, autores y editoriales de todos libros, al último campo lo queremos en mayúsculas:

  select titulo, autor, upper(editorial)
   from libros;
