-- Generado por Oracle SQL Developer Data Modeler 21.2.0.183.1957
--   en:        2021-09-21 20:46:45 COT
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE cargo (
    no_cargo INTEGER NOT NULL,
    nombre   VARCHAR2(50 CHAR) NOT NULL
);

ALTER TABLE cargo ADD CONSTRAINT cargo_pk PRIMARY KEY ( no_cargo );

CREATE TABLE empleado (
    dni                   INTEGER NOT NULL,
    nombres               VARCHAR2(100 CHAR) NOT NULL,
    primer_apellido       VARCHAR2(100 CHAR),
    segundo_apellido      VARCHAR2(100 CHAR),
    fecha_de_contratacion DATE NOT NULL,
    sede_no_sede          INTEGER NOT NULL,
    estrato_no_estrato    INTEGER NOT NULL,
    cargo_no_cargo        INTEGER NOT NULL,
    edad                  INTEGER NOT NULL,
    sueldo                FLOAT(15) NOT NULL
);

CREATE UNIQUE INDEX empleado__idx ON
    empleado (
        sede_no_sede
    ASC );

CREATE UNIQUE INDEX empleado__idxv1 ON
    empleado (
        cargo_no_cargo
    ASC );

CREATE UNIQUE INDEX empleado__idxv2 ON
    empleado (
        estrato_no_estrato
    ASC );

ALTER TABLE empleado ADD CONSTRAINT empleado_pk PRIMARY KEY ( dni );

CREATE TABLE estrato (
    no_estrato INTEGER NOT NULL,
    nombre     VARCHAR2(40 CHAR) NOT NULL
);

ALTER TABLE estrato ADD CONSTRAINT estrato_pk PRIMARY KEY ( no_estrato );

CREATE TABLE sede (
    no_sede INTEGER NOT NULL,
    sede    VARCHAR2(50 CHAR) NOT NULL
);

ALTER TABLE sede ADD CONSTRAINT sede_pk PRIMARY KEY ( no_sede );

ALTER TABLE empleado
    ADD CONSTRAINT empleado_cargo_fk FOREIGN KEY ( cargo_no_cargo )
        REFERENCES cargo ( no_cargo );

ALTER TABLE empleado
    ADD CONSTRAINT empleado_estrato_fk FOREIGN KEY ( estrato_no_estrato )
        REFERENCES estrato ( no_estrato );

ALTER TABLE empleado
    ADD CONSTRAINT empleado_sede_fk FOREIGN KEY ( sede_no_sede )
        REFERENCES sede ( no_sede );



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                             4
-- CREATE INDEX                             3
-- ALTER TABLE                              7
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
