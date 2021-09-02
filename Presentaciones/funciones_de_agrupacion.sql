 create table libros(
  codigo int identity,
  titulo varchar(40) not null,
  autor varchar(30) default 'Desconocido',
  editorial varchar(15),
  precio decimal(5,2),
  cantidad tinyint,
  primary key(codigo)
 );
--Ingresamos algunos registros:

 insert into libros
  values('El aleph','Borges','Planeta',15,null);
 insert into libros
  values('Martin Fierro','Jose Hernandez','Emece',22.20,200);
 insert into libros
  values('Antologia poetica','J.L. Borges','Planeta',null,150);
 insert into libros
  values('Aprenda PHP','Mario Molina','Emece',18.20,null);
 insert into libros
  values('Cervantes y el quijote','Bioy Casares- J.L. Borges','Paidos',null,100);
 insert into libros
  values('Manual de PHP', 'J.C. Paez', 'Siglo XXI',31.80,120);
 insert into libros
  values('Harry Potter y la piedra filosofal','J.K. Rowling',default,45.00,90);
 insert into libros
  values('Harry Potter y la camara secreta','J.K. Rowling','Emece',46.00,100);
 insert into libros (titulo,autor,cantidad)
  values('Alicia en el pais de las maravillas','Lewis Carroll',220);
 insert into libros (titulo,autor,cantidad)
  values('PHP de la A a la Z',default,0);
--Para conocer la cantidad total de libros, sumamos las cantidades de cada uno:

 select sum(cantidad)
  from libros;
--Retorna 980; verifique la suma, sumando los valores de todos los registros del campo "cantidad".

--Queremos saber cuántos libros tenemos de la editorial "Emece":

 select sum(cantidad)
  from libros
  where editorial='Emece';
retorna 300.

--Queremos saber cuál es el libro más costoso; usamos la función "max()":

 select max(precio)
  from libros;
retorna 46.00.

--Para conocer el precio mínimo de los libros de "Rowling" tipeamos:

 select min(precio)
  from libros
  where autor like '%Rowling%';
retorna 45.00.

--Queremos saber el promedio del precio de los libros referentes a "PHP":

 select avg(precio)
  from libros
  where titulo like '%PHP%';
--Devuelve 25.00. Note que hay 3 libros sobre "PHP", pero uno de ellos tiene precio nulo entonces SQL Server no lo incluye para calcular el promedio.
