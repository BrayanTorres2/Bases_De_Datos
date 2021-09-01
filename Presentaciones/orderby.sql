 create table libros(
  codigo int identity,
  titulo varchar(40) not null,
  autor varchar(20) default 'Desconocido',
  editorial varchar(20),
  precio decimal(6,2),
  primary key (codigo)
 );
  insert into libros (titulo,autor,editorial,precio)
  values('El aleph','Borges','Emece',25.33);
 insert into libros
  values('Java en 10 minutos','Mario Molina','Siglo XXI',50.65);
 insert into libros (titulo,autor,editorial,precio)
  values('Alicia en el pais de las maravillas','Lewis Carroll','Emece',19.95);
 insert into libros (titulo,autor,editorial,precio)
  values('Alicia en el pais de las maravillas','Lewis Carroll','Planeta',15);

Recuperamos los registros ordenados por el título:

select * from libros
 order by titulo;
Ordenamos los registros por el campo "precio", referenciando el campo por su posición en la lista de selección:

 select titulo,autor,precio
  from libros order by 3;
Los ordenamos por "editorial", de mayor a menor empleando "desc":

 select * from libros
  order by editorial desc;
Ordenamos por dos campos:

 select * from libros
  order by titulo,editorial;
Ordenamos en distintos sentidos:

 select * from libros
  order by titulo asc, editorial desc;
Podemos ordenar por un campo que no se lista en la selección:

 select titulo, autor
  from libros
  order by precio;
Está permitido ordenar por valores calculados:

 select titulo, autor, editorial,
 precio+(precio*0.1) as 'precio con descuento'
 from libros
 order by 4;  
