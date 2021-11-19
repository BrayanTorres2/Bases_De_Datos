--Una librería almacena los datos de sus libros en una tabla denominada "libros".
--Eliminamos la tabla si existe:

 if object_id('libros') is not null
  drop table libros;
--Creamos la tablas, con la siguiente estructura:

 create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(20),
  precio decimal(6,2), 
  stock int,
  constraint PK_libros primary key(codigo)
 );
--Ingresamos algunos registros en "libros":

 insert into libros values('Uno','Richard Bach','Planeta',15,100);
 insert into libros values('Alicia en el pais...','Lewis Carroll','Planeta',18,50);
 insert into libros values('El aleph','Borges','Emece',25,200);
 insert into libros values('Aprenda PHP','Mario Molina','Nuevo siglo',45,200);
--Creamos un disparador para evitar que se modifiquen los datos de la tabla "libros":

 create trigger DIS_libros_actualizar
  on libros
  for update
  as
    raiserror('Los datos de la tabla "libros" no pueden modificarse', 10, 1)
    rollback transaction;
--Intentamos realizar alguna actualización en "libros":

 update libros set titulo='Alicia en el pais de las maravillas' where codigo=2;
--El disparador se activó, mostró un mensaje y deshizo la actualización. Podemos comprobarlo consultando la tabla "libros".

--Eliminamos el disparador creado anteriormente (tema que veremos más adelante):

 drop trigger DIS_libros_actualizar;
--Creamos un disparador que evite que se actualice el campo "precio" de la tabla "libros":

 create trigger DIS_libros_actualizar_precio
  on libros
  for update
  as
   if update(precio)
   begin
    raiserror('El precio de un libro no puede modificarse.', 10, 1)
    rollback transaction
   end;
--Veamos qué sucede si intentamos actualizar el precio de un libro:

 update libros set precio=30 where codigo=2;
--El disparador se activa, muestra un mensaje y deshace la transacción.

--Veamos qué sucede al actualizar el campo "titulo":

 update libros set titulo='Alicia en el pais de las maravillas' where codigo=2;
--El disparador se activa y realiza la transacción. Lo verificamos consultando la tabla:

 select *from libros;
--Veamos qué sucede si intentamos actualizar el precio y la editorial de un libro:

 update libros set precio=30,editorial='Emece' where codigo=1;
--El disparador se activa, muestra un mensaje y deshace la transacción; el registro no fue actualizado, verificamos:

 select *from libros;
--Eliminamos el disparador creado anteriormente:

 drop trigger DIS_libros_actualizar_precio;
--Creamos un disparador de actualización que muestra el valor anterior y nuevo valor de los registros actualizados. El trigger debe controlar que la actualización se realice en los campos "titulo", "autor" y "editorial" y no en los demás campos (precio y stock)); si se modifican los campos permitidos y ninguno de los no permitidos, mostrará los antiguos y nuevos valores consultando las tablas "deleted" e "inserted", en caso que se actualice un campo no permitido, el disparador muestra un mensaje y deshace la transacción:

 create trigger DIS_libros_actualizar2
  on libros
  for update
  as
   if (update(titulo) or update(autor) or update(editorial)) and
    not (update(precio) or update(stock))
   begin
    select (d.titulo+'-'+ d.autor+'-'+d.editorial) as 'registro anterior',
    (i.titulo+'-'+ i.autor+'-'+i.editorial) as 'registro actualizado'
     from deleted as d
     join inserted as i
     on d.codigo=i.codigo
   end
   else
   begin
    raiserror('El precio y stock no pueden modificarse. La actualización no se realizó.', 10, 1)
    rollback transaction
   end;
--Veamos qué sucede si modificamos campos permitidos:

 update libros set editorial='Paidos', autor='Desconocido' where codigo>3;
--El trigger se dispara y muestra los registros modificados, los valores antes y después de la transacción.

--Veamos qué sucede si en la sentencia "update" intentamos modificar algún campo no permitido:

 update libros set editorial='Paidos', precio=30 where codigo>3;
--El trigger se dispara y muestra el mensaje de error, la transacción no se realizó.

--Intentamos modificar el código de un libro:

 update libros set codigo=9 where codigo>=3; 
--El disparador no llega a dispararse porque SQL Server muestra un mensaje de error ya que el campo "codigo", por ser "identity", no puede modificarse.
