--Una librería almacena la información de sus libros para la venta en dos tablas, "libros" y "editoriales".
--Eliminamos ambas tablas, si existen y las creamos:

 if object_id('libros') is not null
  drop table libros;
 if object_id('editoriales') is not null
  drop table editoriales;

 create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30) default 'Desconocido',
  codigoeditorial tinyint not null,
  precio decimal(5,2)
 );
 create table editoriales(
  codigo tinyint identity,
  nombre varchar(20),
  primary key (codigo)
);
--Ingresamos algunos registros en ambas tablas:

 insert into editoriales values('Planeta');
 insert into editoriales values('Emece');
 insert into editoriales values('Siglo XXI');

 insert into libros values('El aleph','Borges',1,20);
 insert into libros values('Martin Fierro','Jose Hernandez',1,30);
 insert into libros values('Aprenda PHP','Mario Molina',2,50);
 insert into libros values('Java en 10 minutos',default,4,45);
--Realizamos una combinación izquierda para obtener los datos de los libros, incluyendo el nombre de la editorial:

  select titulo,nombre
  from editoriales as e
  left join libros as l
  on codigoeditorial = e.codigo;
--Las editoriales de las cuales no hay libros, es decir, cuyo código de editorial no está presente en "libros" aparece en el resultado, pero con el valor "null" en el campo "titulo".

--Realizamos la misma consulta anterior pero cambiamos el orden de las tablas:

  select titulo,nombre
  from libros as l
  left join editoriales as e
  on codigoeditorial = e.codigo;
--El resultado mostrará el título del libro y el nombre de la editorial; los títulos cuyo código de editorial no está presente en "editoriales" aparecen en el resultado, pero con el valor "null" en el campo "nombre".

--Restringimos el resultado de una consulta considerando solamente los registros que encuentran coincidencia en la tabla de la derecha, es decir, cuyo valor de código está presente en "libros":

 select titulo,nombre
  from editoriales as e
  left join libros as l
  on e.codigo=codigoeditorial
  where codigoeditorial is not null;
--Mostramos las editoriales que NO están presentes en "libros", es decir, que NO encuentran coincidencia en la tabla de la derecha:

 select titulo,nombre
  from editoriales as e
  left join libros as l
  on e.codigo=codigoeditorial
  where codigoeditorial is null;
