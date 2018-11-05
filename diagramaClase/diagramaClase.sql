use xlqhgpsg_DB_RHH; 

CREATE TABLE hospital(
    cod int PRIMARY KEY AUTO_INCREMENT,
    nombre varchar(50) NOT NULL,
    telefono varchar(50),
    direccion text not null,
    estado TINYINT(1)
)ENGINE = InnoDB;

CREATE TABLE persona(
    ci int PRIMARY KEY ,
    nombre varchar(50) not null ,
    apellido varchar(50) not null,
    direccion text,
    usuario varchar(50) not null UNIQUE,
    pass varchar(50) not null default '1234',
    intento tinyint(3) not null default '0',
    estado tinyint(1) not null default '1',
    tipo VARCHAR(1) not null default 'A',
    c tinyint(1) not NULL default '1',
    r tinyint(1) not NULL default '1',
    u tinyint(1) not NULL default '1',
    d tinyint(1) not NULL default '1',
    css VARCHAR(50),
    foto VARCHAR(50)
)ENGINE = InnoDB;

CREATE TABLE doctor(
    ci_persona int PRIMARY KEY,
    especialidad VARCHAR(50) NOT NULL,
    FOREIGN key(ci_persona)REFERENCES persona(ci),
    estado TINYINT(1)
)ENGINE = InnoDB;

CREATE TABLE paciente(
    ci_persona int PRIMARY KEY,
    FOREIGN key(ci_persona)REFERENCES persona(ci),
    estado TINYINT(1)
)ENGINE = InnoDB;

CREATE TABLE enfermera(
    ci_persona int PRIMARY KEY,
    especialidad VARCHAR(50) NOT NULL,
    FOREIGN key(ci_persona)REFERENCES persona(ci),
    estado TINYINT(1)
)ENGINE = InnoDB;

CREATE TABLE consultorio(
    cod_hostpital int,
    ci_doctor int,
    ubicacion VARCHAR(50) NOT NULL,
    numero int NOT NULL,
    PRIMARY KEY(cod_hostpital,ci_doctor),
    FOREIGN key(cod_hostpital)REFERENCES hospital(cod),
    FOREIGN key(ci_doctor)REFERENCES doctor(ci_persona),
    estado TINYINT(1)
)ENGINE = InnoDB;

CREATE TABLE cargo(
    cod_hostpital int,
    ci_enfermera int,
    funcion VARCHAR(50) NOT NULL,
    ubicacion VARCHAR(50) NOT NULL,
    PRIMARY KEY(cod_hostpital,ci_enfermera),
    FOREIGN key(cod_hostpital)REFERENCES hospital(cod),
    FOREIGN key(ci_enfermera)REFERENCES enfermera(ci_persona),
    estado TINYINT(1)
)ENGINE = InnoDB;

CREATE TABLE diagnostico(
    cod int AUTO_INCREMENT,
    ci_paciente int,
    ci_doctor int,
    descripcion VARCHAR(50) NOT NULL,
    fecha date NOT NULL,
    PRIMARY KEY(cod,ci_paciente),
    FOREIGN key(ci_paciente)REFERENCES paciente(ci_persona),
    FOREIGN key(ci_doctor)REFERENCES doctor(ci_persona),
    estado TINYINT(1)
)ENGINE = InnoDB;

CREATE TABLE cirugia(
    cod int AUTO_INCREMENT,
    cod_diagnostico int,
    ci_paciente_diagnostico int,
    descripcion VARCHAR(50) NOT NULL,
    fecha date NOT NULL,
    PRIMARY KEY(cod,cod_diagnostico,ci_paciente_diagnostico),
    FOREIGN key(cod_diagnostico)REFERENCES diagnostico(cod),
    FOREIGN key(ci_paciente_diagnostico)REFERENCES diagnostico(ci_paciente),
    estado TINYINT(1)
)ENGINE = InnoDB;

CREATE TABLE rol(
    ci_enfermera int,
    cod_cirugia int,
    cod_diagnostico_cirugia int,
    ci_paciente_diagnostico_cirugia int,
    funcion VARCHAR(50) NOT NULL,
    PRIMARY KEY(ci_enfermera,cod_cirugia,cod_diagnostico_cirugia,ci_paciente_diagnostico_cirugia),
    FOREIGN key(ci_paciente_diagnostico_cirugia)REFERENCES cirugia(ci_paciente_diagnostico),
    FOREIGN key(cod_diagnostico_cirugia)REFERENCES cirugia(cod_diagnostico),
    FOREIGN key(cod_cirugia)REFERENCES cirugia(cod),
    FOREIGN key(ci_enfermera)REFERENCES enfermera(ci_persona),
    estado TINYINT(1)
)ENGINE = InnoDB;

CREATE TABLE intervencion(
    ci_doctor int,
    cod_cirugia int,
    cod_diagnostico_cirugia int,
    ci_paciente_diagnostico_cirugia int,
    funcion VARCHAR(50) NOT NULL,
    PRIMARY KEY(ci_doctor,cod_cirugia,cod_diagnostico_cirugia,ci_paciente_diagnostico_cirugia),
    FOREIGN key(ci_paciente_diagnostico_cirugia)REFERENCES cirugia(ci_paciente_diagnostico),
    FOREIGN key(cod_diagnostico_cirugia)REFERENCES cirugia(cod_diagnostico),
    FOREIGN key(cod_cirugia)REFERENCES cirugia(cod),
    FOREIGN key(ci_doctor)REFERENCES doctor(ci_persona),
    estado TINYINT(1)
)ENGINE = InnoDB;

CREATE TABLE analisis(
    cod int AUTO_INCREMENT,
    cod_diagnostico int,
    ci_paciente_diagnostico int,
    fecha_orden date NOT NULL,
    tipo VARCHAR(50) not NULL,
    descripcion VARCHAR(50) not NULL,
    fecha_realizado date not null,
    resultado text not null,
    PRIMARY KEY(cod,cod_diagnostico,ci_paciente_diagnostico),
    FOREIGN key(ci_paciente_diagnostico)REFERENCES diagnostico(ci_paciente),
    FOREIGN key(cod_diagnostico)REFERENCES diagnostico(cod),
    estado TINYINT(1)
)ENGINE = InnoDB;

CREATE TABLE padecimiento(
    cod int AUTO_INCREMENT,
    cod_diagnostico int,
    ci_paciente_diagnostico int,
    tipo VARCHAR(50) not NULL,
    riesgo VARCHAR(50) not NULL,
    nombre VARCHAR(50) not NULL,
    descripcion text,
    resultado text not null,
    PRIMARY KEY(cod,cod_diagnostico,ci_paciente_diagnostico),
    FOREIGN key(ci_paciente_diagnostico)REFERENCES diagnostico(ci_paciente),
    FOREIGN key(cod_diagnostico)REFERENCES diagnostico(cod),
    estado TINYINT(1)
)ENGINE = InnoDB;

CREATE TABLE medicacion(
    cod int AUTO_INCREMENT,
    cod_padecimiento int,
    cod_diagnostico_padecimiento int,
    ci_paciente_diagnostico_padecimiento int,
    nombre VARCHAR(50) not NULL,
    descripcion text not null,
    indicacion text,
    tratamiento text,
    PRIMARY KEY(cod,cod_padecimiento,cod_diagnostico_padecimiento,ci_paciente_diagnostico_padecimiento),
    FOREIGN key(ci_paciente_diagnostico_padecimiento)REFERENCES padecimiento(ci_paciente_diagnostico),
    FOREIGN key(cod_diagnostico_padecimiento)REFERENCES padecimiento(cod_diagnostico),
    FOREIGN key(cod_padecimiento)REFERENCES padecimiento(cod),
    estado TINYINT(1)
)ENGINE = InnoDB;

CREATE TABLE receta(
    cod int AUTO_INCREMENT,
    cod_diagnostico int,
    ci_paciente_diagnostico int,
    descripcion VARCHAR(50) not NULL,
    indicacion text not null,
    PRIMARY KEY(cod,cod_diagnostico,ci_paciente_diagnostico),
    FOREIGN key(ci_paciente_diagnostico)REFERENCES diagnostico(ci_paciente),
    FOREIGN key(cod_diagnostico)REFERENCES diagnostico(cod),
    estado TINYINT(1)
)ENGINE = InnoDB;

CREATE TABLE tratamiento(
    cod int AUTO_INCREMENT,
    cod_receta int,
    cod_diagnostico_receta int,
    ci_paciente_diagnostico_receta int,
    inicio DATE not null,
    fin DATE not null,
    reconsulta date,
    descripcion text not null,
    indicacion text,
    PRIMARY KEY(cod,cod_receta,cod_diagnostico_receta,ci_paciente_diagnostico_receta),
    FOREIGN key(ci_paciente_diagnostico_receta)REFERENCES receta(ci_paciente_diagnostico),
    FOREIGN key(cod_diagnostico_receta)REFERENCES receta(cod_diagnostico),
    FOREIGN key(cod_receta)REFERENCES receta(cod),
    estado TINYINT(1)
)ENGINE = InnoDB;