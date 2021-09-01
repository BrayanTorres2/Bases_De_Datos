Trabajamos con la tabla "libros" de una librería.
Eliminamos la tabla si existe:

 if object_id ('libros') is not null
  drop table libros;
Creamos la tabla:

 create table libros(
  codigo int identity,
  titulo varchar(40) not null,
  autor varchar(20) default 'Desconocido',
  editorial varchar(20),
  precio decimal(6,2),
 );
Ingresamos algunos registros:

 insert into libros
  values('El aleph','Borges','Emece',15.90);
 insert into libros
  values('Antología poética','Borges','Planeta',39.50);
 insert into libros
  values('Java en 10 minutos','Mario Molina','Planeta',50.50);
 insert into libros
  values('Alicia en el pais de las maravillas','Lewis Carroll','Emece',19.90);
 insert into libros
  values('Martin Fierro','Jose Hernandez','Emece',25.90);
 insert into libros
  values('Martin Fierro','Jose Hernandez','Paidos',16.80);
 insert into libros
  values('Aprenda PHP','Mario Molina','Emece',19.50);
 insert into libros
  values('Cervantes y el quijote','Borges','Paidos',18.40);
Recuperamos los libros cuyo autor sea igual a "Borges" y cuyo precio no supere los 20 pesos:

 select * from libros
  where (autor='Borges') and
  (precio<=20);
Seleccionamos los libros cuyo autor es "Borges" y/o cuya editorial es "Planeta":

 select * from libros
  where autor='Borges' or
  editorial='Planeta';
Recuperamos los libros cuya editorial NO es "Planeta":

 select * from libros
  where not editorial='Planeta';
Veamos cómo el uso de paréntesis hace que SQL Server evalúe en forma diferente ciertas consultas aparentemente iguales:

 select * from libros
  where (autor='Borges') or
  (editorial='Paidos' and precio<20);

 select * from libros
  where (autor='Borges' or editorial='Paidos') and
  (precio<20);
