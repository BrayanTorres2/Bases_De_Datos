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
 );
--Ingresamos algunos registros en "libros":

 insert into libros values('Uno','Richard Bach',15,100);
 insert into libros values('Ilusiones','Richard Bach',18,50);
 insert into libros values('El aleph','Borges',25,200);
 insert into libros values('Aprenda PHP','Mario Molina',45,200);
--Cuando ingresamos un registro en "ventas", debemos:

-- controlar que el código del libro exista en "libros" (lo hacemos con la restricción "foreign key" establecida en "ventas"),

-- controlar que exista stock, lo cual no puede controlarse con una restricción "foreign key" porque el campo "stock" no es clave primaria en la tabla "libros"; tampoco puede establecerse una restricción "check", porque ese tipo de restricciones no pueden hacer referencia a campos de otras tablas.

-- disminuir el stock en la tabla "libros".

--Creamos un disparador para que se ejecute cada vez que una instrucción "insert" ingrese datos en "ventas"; el mismo controlará que haya stock en "libros" y actualizará el campo "stock":

 create trigger DIS_ventas_insertar
  on ventas
  for insert
  as
   declare @stock int
   select @stock= stock from libros
		 join inserted
		 on inserted.codigolibro=libros.codigo
		 where libros.codigo=inserted.codigolibro
  if (@stock>=(select cantidad from inserted))
    update libros set stock=stock-inserted.cantidad
     from libros
     join inserted
     on inserted.codigolibro=libros.codigo
     where codigo=inserted.codigolibro
  else
  begin
    raiserror ('Hay menos libros en stock de los solicitados para la venta', 16, 1)
    rollback transaction
  end
--Ingresamos un registro en "ventas":

 insert into ventas values('2018/04/01',1,15,1);
--Al ejecutar la sentencia de inserción anterior, se disparó el trigger, el registro se agregó a la tabla del disparador ("ventas") y disminuyó el valor del campo "stock" de "libros". Verifiquemos que el disparador se ejecutó consultando la tabla "ventas" y "libros":

 select *from ventas;
 select *from libros where codigo=1;
--Ingresamos un registro en "ventas", solicitando una cantidad superior al stock:

 insert into ventas values('2018/04/01',2,18,100);
--El disparador se ejecuta y muestra un mensaje, la inserción no se realizó porque la cantidad solicitada supera el stock.

--Finalmente probaremos ingresar una venta con un código de libro inexistente:

 insert into ventas values('2018/04/01',5,18,1);
--El trigger no llegó a ejecutarse, porque la comprobación de restricciones (que se ejecuta antes que el disparador) detectó que la infracción a la "foreign key"
