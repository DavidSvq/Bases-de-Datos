### Ejercicio: Sistema de Gestión para una Universidad 🎓
El objetivo de este ejercicio es diseñar una base de datos completa para un sistema de gestión de una universidad. Esta base de datos debe permitir gestionar información sobre estudiantes, profesores, asignaturas, departamentos, cursos, horarios, exámenes, y calificaciones. A continuación, se describen las tablas principales y sus relaciones.
Entidades y Atributos
Estudiantes: Almacena información sobre los estudiantes matriculados en la universidad. Cada estudiante tiene un identificador único, nombre, apellidos, fecha de nacimiento, dirección, correo electrónico, y teléfono.
Atributos: estudiante_id (clave primaria), nombre, apellidos, fecha_nacimiento, direccion, email, telefono
Profesores: Almacena información sobre los profesores. Cada profesor tiene un identificador único, nombre, apellidos, especialidad, dirección de correo electrónico, y número de teléfono.
Atributos: profesor_id (clave primaria), nombre, apellidos, especialidad, email, telefono
Asignaturas: Representa las asignaturas que se ofrecen en la universidad. Cada asignatura tiene un identificador único, un nombre, una descripción, y el número de créditos que otorga.
Atributos: asignatura_id (clave primaria), nombre,profesor_id, descripcion, creditos
Departamentos: Almacena los departamentos de la universidad. Cada departamento tiene un identificador único, un nombre, y un jefe de departamento (referencia a un profesor).
Atributos: departamento_id (clave primaria), nombre, jefe_departamento
Cursos: Representa los diferentes cursos o programas de estudio. Cada curso tiene un identificador único, un nombre, una descripción, y un nivel académico.
Atributos: curso_id (clave primaria), nombre, descripcion, nivel_academico
Horarios: Almacena información sobre los horarios de las asignaturas impartidas. Cada horario tiene un identificador único, un profesor, una asignatura, un aula, un día de la semana, y la hora de inicio y finalización.
Atributos: horario_id (clave primaria),,dia_semana, hora_inicio, hora_fin
Exámenes: Representa los exámenes programados para las asignaturas. Cada examen tiene un identificador único, una asignatura, un profesor responsable, una fecha, y la duración del examen.
Atributos: examen_id (clave primaria), asignatura_id  , fecha_examen, duracion_minutos
Calificaciones: Almacena las calificaciones obtenidas por los estudiantes en los exámenes. Cada calificación tiene un identificador único, un estudiante, un examen, y la nota obtenida.
Atributos: calificacion_id (clave primaria), estudiante_id , examen_id , nota
Relaciones
Estudiantes y Cursos: Un estudiante puede estar matriculado en un curso específico. Cada curso tiene varios estudiantes. Debes crear una relación que permita conocer qué estudiantes están matriculados en qué cursos.
Profesores y Departamentos: Un profesor puede pertenecer a un solo departamento, pero un departamento puede tener varios profesores. Debes gestionar cómo vincular a cada profesor con su departamento.
Asignaturas y Departamentos: Cada asignatura está asociada a un departamento, y cada departamento ofrece varias asignaturas
Cursos y Asignatura: Cada curso tiene varias asignaturas asociadas, y cada asignatura puede estar en varios cursos. Esta relación debe permitir gestionar los contenidos académicos ofrecidos en cada curso.
Asignaturas y Profesores: Cada asignatura puede ser impartida por varios profesores, y un profesor puede impartir varias asignaturas. Debes modelar cómo se asignan los profesores a las asignaturas y en qué horarios.
Horarios y Asignatura: Cada horario define una asignatura que se imparte en un aula específica. Es importante gestionar el uso de las aulas para evitar solapamientos.
Exámenes y Asignaturas: Un examen está asociado a una asignatura específica. Cada asignatura puede tener múltiples exámenes durante el semestre.
Calificaciones - Estudiantes | Calificaciones - Examenes: Cada calificación corresponde a un estudiante y a un examen específico. Es necesario definir cómo se vinculan los estudiantes con sus respectivas calificaciones.
## Tareas
- A) Modelo Entidad-Relación (ER): Realiza el modelo entidad-relación que refleje las entidades mencionadas, sus atributos y las relaciones entre ellas. Asegúrate de definir claramente las modalidades y crear las entidades intermedias necesarias para las relaciones N:M donde sea necesario.
- B) Modelo Relacional: Transforma el modelo ER en un modelo relacional. 
- C) Normalización: Evalúa si el modelo cumple con las tres primeras formas normales (1FN, 2FN, 3FN). Describe los pasos necesarios para normalizar la base de datos y eliminar cualquier redundancia o dependencia transitoria.
- D) Crea las tablas correspondientes al modelo en MySQL