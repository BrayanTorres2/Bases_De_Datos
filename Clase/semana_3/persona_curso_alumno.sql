CREATE TABLE alumno (
    id_estudiante INTEGER NOT NULL,
    programa      VARCHAR2(100 CHAR) NOT NULL,
    persona_cc    INTEGER NOT NULL
);
drop table alumno
CREATE UNIQUE INDEX alumno__idx ON
    alumno (
        persona_cc
    ASC );

ALTER TABLE alumno ADD CONSTRAINT alumno_pk PRIMARY KEY ( id_estudiante );

CREATE TABLE alumno_curso (
    alumno_id_estudiante INTEGER NOT NULL,
    curso_id_curso       INTEGER NOT NULL
);

ALTER TABLE alumno_curso ADD CONSTRAINT alumno_curso_pk PRIMARY KEY ( alumno_id_estudiante,
                                                                      curso_id_curso );

CREATE TABLE curso (
    id_curso INTEGER NOT NULL,
    nombre   VARCHAR2(100 CHAR) NOT NULL,
    creditos INTEGER NOT NULL
);

ALTER TABLE curso ADD CONSTRAINT curso_pk PRIMARY KEY ( id_curso );

CREATE TABLE persona (
    cc               INTEGER NOT NULL,
    nombres          VARCHAR2(50 CHAR) NOT NULL,
    apellidos        VARCHAR2(50 CHAR) NOT NULL,
    fecha_nacimiento DATE NOT NULL
);

ALTER TABLE persona ADD CONSTRAINT persona_pk PRIMARY KEY ( cc );

ALTER TABLE alumno_curso
    ADD CONSTRAINT alumno_curso_alumno_fk FOREIGN KEY ( alumno_id_estudiante )
        REFERENCES alumno ( id_estudiante );

ALTER TABLE alumno_curso
    ADD CONSTRAINT alumno_curso_curso_fk FOREIGN KEY ( curso_id_curso )
        REFERENCES curso ( id_curso );

ALTER TABLE alumno
    ADD CONSTRAINT alumno_persona_fk FOREIGN KEY ( persona_cc )
        REFERENCES persona ( cc );

