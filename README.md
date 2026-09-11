BaseDeDatos-U1-Ej05-ControlAcademico

Base de Datos - Unidad 1 - Ejercicio 5

Consigna

Modelar el sistema de gestión académica de una facultad: carreras con su plan de estudio, asignaturas del plan con sus correlatividades, dictado en comisiones por ciclo lectivo con un profesor responsable y cupo, y matriculación de alumnos en comisiones registrando condición (Regular / Libre / Promocionado) y notas de los parciales rendidos.

Lógica

Carrera → Plan de Estudio → Asignatura (1:N encadenado). La asignatura cuelga del plan y no de la carrera: un mismo nombre de materia cambia de carga horaria y año según el plan, así que colgarla de la carrera obligaría a duplicarla en cada actualización curricular. La carrera tiene varios planes a lo largo del tiempo y el atributo estado del plan marca cuál es el vigente, en vez de un 1:1 rígido que borraría el histórico.

Correlatividades: autorrelación N:M sobre ASIGNATURA. Una materia puede exigir varias correlativas y a la vez ser correlativa de varias. Se resuelve con la entidad intermedia asignatura-correlativa, que se conecta dos veces a ASIGNATURA (1:N "requiere" y N:1 "es_req_de") y guarda Id_Asignatura (la que se quiere cursar) e Id_Correlativa (la que hay que tener aprobada). Los dos roles apuntan a la misma entidad, por eso las dos FK conviven en la misma tabla.

Comisión como entidad débil de contexto. La comisión concentra las tres asociaciones que el dictado necesita: ASIGNATURA 1:N COMISION (qué se dicta), CICLO-LECTIVO 1:N COMISION (cuándo), PROFESOR 1:N COMISION (quién). Todas son 1:N hacia comisión porque una comisión es una sola instancia concreta —Comisión A de Programación, 1er cuatrimestre 2026— mientras que una asignatura, un ciclo y un profesor participan de muchas. El cupo_maximo es atributo de la comisión y no de la asignatura porque el límite es por curso.

Alumno ↔ Comisión N:M con alumno-comision. Un alumno cursa muchas comisiones y una comisión tiene muchos alumnos. La intermedia guarda condicion y fecha_inscripcion, que son datos del hecho de la inscripción y no del alumno ni de la comisión.

Parciales en dos niveles. PARCIAL es la instancia de evaluación definida por la comisión (número, fecha, tipo, ponderación) — depende de la comisión, no del alumno. La nota individual va en inscripcion-parcial, intermedia entre la inscripción y el parcial, con el atributo nota. Si la nota se guardara como atributo de alumno-comision haría falta una columna por parcial (nota1, nota2...), lo que rompe 1FN y fija de antemano cuántas evaluaciones puede haber. Así el modelo soporta N parciales y recuperatorios sin tocar la estructura.

Resultado
<img width="2900" height="3050" alt="BaseDeDatos-U1-Ej05-ControlAcademico" src="https://github.com/user-attachments/assets/d512cc4d-72a2-4daa-854e-1ad62bddd2d2" />
