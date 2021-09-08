
 create table secciones(
  codigo tinyint GENERATED ALWAYS as IDENTITY(START with 1 INCREMENT by 1),
  nombre varchar(20),
  sueldo decimal(5,2)
  constraint CK_secciones_sueldo check (sueldo>=0),
  constraint PK_secciones primary key (codigo)
 );

 create table empleados(
  legajo int identity,
  documento char(8)
   constraint CK_empleados_documento check (documento like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
  sexo char(1)
   constraint CK_empleados_sexo check (sexo in ('f','m')),
  apellido varchar(20),
  nombre varchar(20),
  domicilio varchar(30),
  seccion tinyint not null,
  cantidadhijos tinyint
   constraint CK_empleados_hijos check (cantidadhijos>=0),
  estadocivil char(10)
   constraint CK_empleados_estadocivil check (estadocivil in ('casado','divorciado','soltero','viudo')),
  fechaingreso datetime,
   constraint PK_empleados primary key (legajo),
  constraint FK_empleados_seccion
   foreign key (seccion)
   references secciones(codigo)
   on update cascade,
  constraint UQ_empleados_documento
   unique(documento)
);
--Ingresamos algunos registros:

 insert into secciones values('Administracion',300);
 insert into secciones values('Contaduría',400);
 insert into secciones values('Sistemas',500);
 insert into empleados values('22222222','f','Lopez','Ana','Colon 123',1,2,'casado','1990-10-10');
 insert into empleados values('23333333','m','Lopez','Luis','Sucre 235',1,0,'soltero','1990-02-10');
 insert into empleados values('24444444','m','Garcia','Marcos','Sarmiento 1234',2,3,'divorciado','1998-07-12');
 insert into empleados values('25555555','m','Gomez','Pablo','Bulnes 321',3,2,'casado','1998-10-09');
 insert into empleados values('26666666','f','Perez','Laura','Peru 1254',3,3,'casado','2000-05-09');
 
--Eliminamos la vista "vista_empleados" si existe:

 if object_id('vista_empleados') is not null
  drop view vista_empleados;
 
--Creamos la vista "vista_empleados", que es resultado de una combinación en la cual se muestran 5 campos:

 create view vista_empleados as
  select (apellido+' '+e.nombre) as nombre,sexo,
   s.nombre as seccion, cantidadhijos
   from empleados as e
   join secciones as s
   on codigo=seccion;
--Vemos la información de la vista:

 select * from vista_empleados;
--Ejecutamos "sp_help" enviándole como argumento el nombre de la vista:

 exec sp_help vista_empleados;
--Vemos el texto que define la vista:

 exec sp_helptext vista_empleados;
--Ejecutamos el procedimiento almacenado del sistema "sp_depends" seguido del nombre de la vista:

 exec sp_depends vista_empleados;
--aparecen las tablas y campos de las cuales depende la vista, es decir, las tablas referenciadas en la misma.

--Ejecutamos el procedimiento "sp_depends" seguido del nombre de la tabla "empleados":

 exec sp_depends empleados;
--aparece la vista "vista_empleados" y las restricciones que dependen de ella.

--Consultamos la tabla del sistema "sysobjects":

 select * from sysobjects;
--Si queremos ver todas las vistas creadas por nosotros, podemos tipear:

 select *from sysobjects
  where xtype='V' and-- tipo vista
  name like 'vista%';--búsqueda con comodín
