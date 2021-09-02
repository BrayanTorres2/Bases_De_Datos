Creamos la tabla:

 create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
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
  values('Harry Potter y la camara secreta','J.K. Rowling','Emece',null,100);
 insert into libros
  values('Alicia en el pais de las maravillas','Lewis Carroll','Paidos',22.50,200);
 insert into libros
  values('PHP de la A a la Z',null,null,null,0);
--Queremos saber la cantidad de libros de cada editorial, utilizando la cláusula "group by":

 select editorial, count(*)
  from libros
  group by editorial;
--El resultado muestra los nombres de las editoriales y la cantidad de registros para cada valor del campo. Note que los valores nulos se procesan como otro grupo.

--Obtenemos la cantidad libros con precio no nulo de cada editorial:

 select editorial, count(precio)
  from libros
  group by editorial;
--La salida muestra los nombres de las editoriales y la cantidad de registros de cada una, sin contar los que tienen precio nulo.

--Para conocer el total en dinero de los libros agrupados por editorial, tipeamos:

 select editorial, sum(precio)
  from libros
  group by editorial;
--Obtenemos el máximo y mínimo valor de los libros agrupados por editorial, en una sola sentencia:

 select editorial,
  max(precio) as mayor,
  min(precio) as menor
  from libros
  group by editorial;
--Calculamos el promedio del valor de los libros agrupados por editorial:

 select editorial, avg(precio)
  from libros
  group by editorial;
--Es posible limitar la consulta con "where". Vamos a contar y agrupar por editorial considerando solamente los libros cuyo precio es menor a 30 pesos:

 select editorial, count(*)
  from libros
  where precio<30
  group by editorial;
--Note que las editoriales que no tienen libros que cumplan la condición, no aparecen en la salida. Para que aparezcan todos los valores de editorial, incluso los que devuelven cero o "null" en la columna de agregado, debemos emplear la palabra clave "all" al lado de "group by":

 select editorial, count(*)
  from libros
  where precio<30
  group by all editorial;
