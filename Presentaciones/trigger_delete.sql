--Una librería almacena los datos de sus libros en una tabla denominada "libros" y en otra tabla llamada "ventas", las ventas de los mismos.
--Eliminamos las tablas si existen:

 if object_id('ventas') is not null
  drop table ventas;
 if object_id('libros') is not null
  drop table libros;
--Creamos las tablas, con las siguientes estructuras:

 create table libros(
  codigo int identity,
  titulo varchar(40),
  autor varchar(30),
  editorial varchar(20),
  precio decimal(6,2), 
  stock int,
  constraint PK_libros primary key(codigo)
 );

 create table ventas(
  numero int identity,
  fecha datetime,
  codigolibro int not null,
  precio decimal (6,2),
  cantidad int,
  constraint PK_ventas primary key(numero),
  constraint FK_ventas_codigolibro
   foreign key (codigolibro) references libros(codigo)
   on delete no action
 );
--Ingresamos algunos registros en "libros" y en "ventas":

 insert into libros values('Uno','Richard Bach','Planeta',15,100);
 insert into libros values('Ilusiones','Richard Bach','Planeta',18,50);
 insert into libros values('El aleph','Borges','Emece',25,200);
 insert into libros values('Aprenda PHP','Mario Molina','Emece',45,200);

 insert into ventas values('2018/01/01',1,15,1);
 insert into ventas values('2018/01/01',2,18,2);
--Creamos un disparador para actualizar el campo "stock" de la tabla "libros" cuando se elimina un registro de la tabla "ventas" (por ejemplo, si el comprador devuelve los libros comprados):

 create trigger DIS_ventas_borrar
  on ventas
  for delete 
 as
   update libros set stock= libros.stock+deleted.cantidad
   from libros
   join deleted
   on deleted.codigolibro=libros.codigo;
Eliminamos un registro de "ventas":

 delete from ventas where numero=2; 
--Al ejecutar la sentencia de eliminación anterior, se disparó el trigger, el registro se eliminó de la tabla del disparador ("ventas") y se actualizó el stock en "libros". Verifiquemos que el disparador se ejecutó consultando la tabla "libros" y vemos si el stock aumentó:

 select *from libros where codigo=2;
--Verificamos que el registro se eliminó de "ventas":

 select *from ventas;
--Creamos un disparador para controlar que no se elimine más de un registro de la tabla "libros". El disparador se activa cada vez que se ejecuta un "delete" sobre "libros", controlando la cantidad de registros que se están eliminando; si se está eliminando más de un registro, el disparador retorna un mensaje de error y deshace la transacción:

 create trigger DIS_libros_borrar
  on libros
  for delete
  as
   if (select count(*) from deleted) > 1
   begin
    raiserror('No puede eliminar más de un libro',16,1)
    rollback transaction
   end;
--Solicitamos la eliminación de varios registros de "libros":

 delete from libros where editorial='Emece';
--Se activa el disparador y deshace la transacción.

--Solicitamos la eliminación de un solo libro:

 delete from libros where codigo=4;
--Se activa el disparador y permite la transacción; consultamos la tabla y vemos que el libro fue eliminado:

 select *from libros;
--Note que eliminamos libros que no estaban en "ventas; si hubiésemos intentado eliminar un libro cuyo código esté en "ventas", la restricción "foreign key" no lo hubiese permitido; la restricción evita que se ejecute el "delete", el trigger no llega a dispararse.
