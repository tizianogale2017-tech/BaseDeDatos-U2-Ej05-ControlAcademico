-- Base de Datos I - Unidad 4 - Ej05: ControlAcademico
-- Script portable (SQLite / MySQL). En SQLite activar antes: PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS inscripcion_parcial;
DROP TABLE IF EXISTS PARCIAL;
DROP TABLE IF EXISTS alumno_comision;
DROP TABLE IF EXISTS COMISION;
DROP TABLE IF EXISTS ALUMNO;
DROP TABLE IF EXISTS PROFESOR;
DROP TABLE IF EXISTS CICLO_LECTIVO;
DROP TABLE IF EXISTS asignatura_correlativa;
DROP TABLE IF EXISTS ASIGNATURA;
DROP TABLE IF EXISTS PLAN_ESTUDIO;
DROP TABLE IF EXISTS CARRERA;

CREATE TABLE CARRERA (
    id_carrera INT PRIMARY KEY,
    codigo_carrera VARCHAR(50) UNIQUE,
    nombre_carrera VARCHAR(50),
    titulo_otorgado VARCHAR(100),
    duracion_anios INT,
    modalidad VARCHAR(50)
);

CREATE TABLE PLAN_ESTUDIO (
    id_plan INT PRIMARY KEY,
    id_carrera INT,
    codigo_plan VARCHAR(50) UNIQUE,
    anio_vigencia INT,
    resolucion VARCHAR(50),
    estado VARCHAR(100),
    carga_horaria_total DECIMAL(12,2),
    FOREIGN KEY (id_carrera) REFERENCES CARRERA(id_carrera)
);

CREATE TABLE ASIGNATURA (
    id_asignatura INT PRIMARY KEY,
    id_plan INT,
    codigo_asignatura VARCHAR(50) UNIQUE,
    nombre_asignatura VARCHAR(50),
    carga_horaria_semanal VARCHAR(100),
    anio_curricula INT,
    cuatrimestre VARCHAR(100),
    FOREIGN KEY (id_plan) REFERENCES PLAN_ESTUDIO(id_plan)
);

CREATE TABLE asignatura_correlativa (
    id_asig_corr INT PRIMARY KEY,
    id_asignatura INT,
    id_correlativa INT,
    FOREIGN KEY (id_asignatura) REFERENCES ASIGNATURA(id_asignatura),
    FOREIGN KEY (id_correlativa) REFERENCES ASIGNATURA(id_asignatura)
);

CREATE TABLE CICLO_LECTIVO (
    id_ciclo INT PRIMARY KEY,
    codigo_ciclo VARCHAR(50) UNIQUE,
    anio INT,
    cuatrimestre_ciclo INT,
    fecha_inicio DATE,
    fecha_fin DATE
);

CREATE TABLE PROFESOR (
    id_profesor INT PRIMARY KEY,
    legajo_profesor VARCHAR(50),
    dni_profesor INT,
    nombre_profesor VARCHAR(50),
    apellido_profesor VARCHAR(50),
    email_profesor VARCHAR(100) UNIQUE
);

CREATE TABLE ALUMNO (
    id_alumno INT PRIMARY KEY,
    legajo_alumno VARCHAR(50),
    dni_alumno INT,
    nombre_alumno VARCHAR(50),
    apellido_alumno VARCHAR(50),
    fecha_nacimiento DATE
);

CREATE TABLE COMISION (
    id_comision INT PRIMARY KEY,
    id_asignatura INT,
    id_ciclo INT,
    id_profesor INT,
    codigo_comision VARCHAR(50) UNIQUE,
    nombre_comision VARCHAR(100),
    cupo_maximo INT,
    turno VARCHAR(100),
    aula VARCHAR(100),
    FOREIGN KEY (id_asignatura) REFERENCES ASIGNATURA(id_asignatura),
    FOREIGN KEY (id_ciclo) REFERENCES CICLO_LECTIVO(id_ciclo),
    FOREIGN KEY (id_profesor) REFERENCES PROFESOR(id_profesor)
);

CREATE TABLE alumno_comision (
    id_alumno_comision INT PRIMARY KEY,
    id_alumno INT,
    id_comision INT,
    condicion VARCHAR(50),
    fecha_inscripcion DATE,
    FOREIGN KEY (id_alumno) REFERENCES ALUMNO(id_alumno),
    FOREIGN KEY (id_comision) REFERENCES COMISION(id_comision)
);

CREATE TABLE PARCIAL (
    id_parcial INT PRIMARY KEY,
    id_comision INT,
    codigo_parcial VARCHAR(100) UNIQUE,
    numero_parcial INT,
    fecha_parcial DATE,
    tipo_evaluacion VARCHAR(50),
    ponderacion INT,
    FOREIGN KEY (id_comision) REFERENCES COMISION(id_comision)
);

CREATE TABLE inscripcion_parcial (
    id_insc_parcial INT PRIMARY KEY,
    id_alumno_comision INT,
    id_parcial INT,
    nota INT,
    fecha_correccion DATE,
    FOREIGN KEY (id_alumno_comision) REFERENCES alumno_comision(id_alumno_comision),
    FOREIGN KEY (id_parcial) REFERENCES PARCIAL(id_parcial)
);

-- Datos de CARRERA
INSERT INTO CARRERA (id_carrera, codigo_carrera, nombre_carrera, modalidad, duracion_anios) VALUES (1, 'LSI', 'Lic. en Sistemas de Información', 'Presencial', 5);
INSERT INTO CARRERA (id_carrera, codigo_carrera, nombre_carrera, modalidad, duracion_anios) VALUES (2, 'APU', 'Analista Programador Univ.', 'Presencial', 3);
INSERT INTO CARRERA (id_carrera, codigo_carrera, nombre_carrera, modalidad, duracion_anios) VALUES (3, 'LAD', 'Lic. en Administración', 'Presencial', 4);
INSERT INTO CARRERA (id_carrera, codigo_carrera, nombre_carrera, modalidad, duracion_anios) VALUES (4, 'CPN', 'Contador Público', 'Híbrida', 5);

-- Datos de PLAN_ESTUDIO
INSERT INTO PLAN_ESTUDIO (id_plan, id_carrera, codigo_plan, anio_vigencia, resolucion) VALUES (1, 1, 'P-LSI-2019', 2019, 'RES-101/19');
INSERT INTO PLAN_ESTUDIO (id_plan, id_carrera, codigo_plan, anio_vigencia, resolucion) VALUES (2, 1, 'P-LSI-2024', 2024, 'RES-045/24');
INSERT INTO PLAN_ESTUDIO (id_plan, id_carrera, codigo_plan, anio_vigencia, resolucion) VALUES (3, 2, 'P-APU-2023', 2023, 'RES-077/23');
INSERT INTO PLAN_ESTUDIO (id_plan, id_carrera, codigo_plan, anio_vigencia, resolucion) VALUES (4, 3, 'P-LAD-2024', 2024, 'RES-060/24');

-- Datos de ASIGNATURA
INSERT INTO ASIGNATURA (id_asignatura, id_plan, codigo_asignatura, nombre_asignatura, anio_curricula) VALUES (1, 2, 'BD1', 'Base de Datos I', 1);
INSERT INTO ASIGNATURA (id_asignatura, id_plan, codigo_asignatura, nombre_asignatura, anio_curricula) VALUES (2, 2, 'PRG1', 'Programación I', 1);
INSERT INTO ASIGNATURA (id_asignatura, id_plan, codigo_asignatura, nombre_asignatura, anio_curricula) VALUES (3, 2, 'MAT1', 'Matemática I', 1);
INSERT INTO ASIGNATURA (id_asignatura, id_plan, codigo_asignatura, nombre_asignatura, anio_curricula) VALUES (4, 3, 'ALG1', 'Álgebra', 1);

-- Datos de asignatura_correlativa
INSERT INTO asignatura_correlativa (id_asig_corr, id_asignatura, id_correlativa) VALUES (1, 1, 2);
INSERT INTO asignatura_correlativa (id_asig_corr, id_asignatura, id_correlativa) VALUES (2, 2, 3);
INSERT INTO asignatura_correlativa (id_asig_corr, id_asignatura, id_correlativa) VALUES (3, 2, 4);
INSERT INTO asignatura_correlativa (id_asig_corr, id_asignatura, id_correlativa) VALUES (4, 3, 4);

-- Datos de CICLO_LECTIVO
INSERT INTO CICLO_LECTIVO (id_ciclo, codigo_ciclo, anio, cuatrimestre_ciclo, fecha_inicio) VALUES (1, '2024-2C', 2024, 2, '2024-08-05');
INSERT INTO CICLO_LECTIVO (id_ciclo, codigo_ciclo, anio, cuatrimestre_ciclo, fecha_inicio) VALUES (2, '2025-1C', 2025, 1, '2025-03-10');
INSERT INTO CICLO_LECTIVO (id_ciclo, codigo_ciclo, anio, cuatrimestre_ciclo, fecha_inicio) VALUES (3, '2025-2C', 2025, 2, '2025-08-04');
INSERT INTO CICLO_LECTIVO (id_ciclo, codigo_ciclo, anio, cuatrimestre_ciclo, fecha_inicio) VALUES (4, '2026-1C', 2026, 1, '2026-03-09');

-- Datos de PROFESOR
INSERT INTO PROFESOR (id_profesor, legajo_profesor, nombre_profesor, apellido_profesor, dni_profesor) VALUES (1, 'P-101', 'Ignacio', 'Fontaines', 22111000);
INSERT INTO PROFESOR (id_profesor, legajo_profesor, nombre_profesor, apellido_profesor, dni_profesor) VALUES (2, 'P-103', 'Julián', 'Sosa', 26333000);
INSERT INTO PROFESOR (id_profesor, legajo_profesor, nombre_profesor, apellido_profesor, dni_profesor) VALUES (3, 'P-104', 'Sofía', 'Ortega', 27444000);
INSERT INTO PROFESOR (id_profesor, legajo_profesor, nombre_profesor, apellido_profesor, dni_profesor) VALUES (4, 'P-105', 'Ricardo', 'Paz', 23555000);

-- Datos de ALUMNO
INSERT INTO ALUMNO (id_alumno, legajo_alumno, dni_alumno, nombre_alumno, apellido_alumno) VALUES (1, 'A-2401', 45123456, 'Martín', 'Rojas');
INSERT INTO ALUMNO (id_alumno, legajo_alumno, dni_alumno, nombre_alumno, apellido_alumno) VALUES (2, 'A-2402', 45234567, 'Lucía', 'Suárez');
INSERT INTO ALUMNO (id_alumno, legajo_alumno, dni_alumno, nombre_alumno, apellido_alumno) VALUES (3, 'A-2404', 44987654, 'Camila', 'Vega');
INSERT INTO ALUMNO (id_alumno, legajo_alumno, dni_alumno, nombre_alumno, apellido_alumno) VALUES (4, 'A-2405', 45678901, 'Franco', 'Molina');

-- Datos de COMISION
INSERT INTO COMISION (id_comision, id_asignatura, id_ciclo, id_profesor, codigo_comision) VALUES (1, 1, 4, 1, 'BD1-A');
INSERT INTO COMISION (id_comision, id_asignatura, id_ciclo, id_profesor, codigo_comision) VALUES (2, 2, 4, 2, 'PRG1-A');
INSERT INTO COMISION (id_comision, id_asignatura, id_ciclo, id_profesor, codigo_comision) VALUES (3, 3, 3, 3, 'MAT1-A');
INSERT INTO COMISION (id_comision, id_asignatura, id_ciclo, id_profesor, codigo_comision) VALUES (4, 4, 3, 4, 'ALG1-A');

-- Datos de alumno_comision
INSERT INTO alumno_comision (id_alumno_comision, id_alumno, id_comision, condicion, fecha_inscripcion) VALUES (1, 1, 1, 'Regular', '2026-03-02');
INSERT INTO alumno_comision (id_alumno_comision, id_alumno, id_comision, condicion, fecha_inscripcion) VALUES (2, 1, 2, 'Regular', '2026-03-02');
INSERT INTO alumno_comision (id_alumno_comision, id_alumno, id_comision, condicion, fecha_inscripcion) VALUES (3, 2, 1, 'Libre', '2026-03-03');
INSERT INTO alumno_comision (id_alumno_comision, id_alumno, id_comision, condicion, fecha_inscripcion) VALUES (4, 3, 3, 'Promocional', '2026-03-05');

-- Datos de PARCIAL
INSERT INTO PARCIAL (id_parcial, id_comision, numero_parcial, tipo_evaluacion, fecha_parcial) VALUES (1, 1, 1, 'Escrito', '2026-05-12');
INSERT INTO PARCIAL (id_parcial, id_comision, numero_parcial, tipo_evaluacion, fecha_parcial) VALUES (2, 1, 2, 'Práctico', '2026-06-30');
INSERT INTO PARCIAL (id_parcial, id_comision, numero_parcial, tipo_evaluacion, fecha_parcial) VALUES (3, 2, 1, 'Escrito', '2026-05-19');
INSERT INTO PARCIAL (id_parcial, id_comision, numero_parcial, tipo_evaluacion, fecha_parcial) VALUES (4, 3, 1, 'Oral', '2026-05-21');

-- Datos de inscripcion_parcial
INSERT INTO inscripcion_parcial (id_insc_parcial, id_alumno_comision, id_parcial, nota, fecha_correccion) VALUES (1, 1, 1, 8, '2026-05-20');
INSERT INTO inscripcion_parcial (id_insc_parcial, id_alumno_comision, id_parcial, nota, fecha_correccion) VALUES (2, 1, 2, 7, '2026-07-08');
INSERT INTO inscripcion_parcial (id_insc_parcial, id_alumno_comision, id_parcial, nota, fecha_correccion) VALUES (3, 3, 1, 4, '2026-05-22');
INSERT INTO inscripcion_parcial (id_insc_parcial, id_alumno_comision, id_parcial, nota, fecha_correccion) VALUES (4, 4, 4, 6, '2026-05-29');
