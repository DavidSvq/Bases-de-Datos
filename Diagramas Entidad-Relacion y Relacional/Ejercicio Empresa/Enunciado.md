### Se trata de realizar el diseño de la base de datos en el modelo E/R para una empresa
Una empresa necesita organizar la siguiente información referente a su organización interna.


La empresa está organizada en una serie de departamentos. Cada departamento tiene un código, nombre y presupuesto anual. Cada departamento está ubicado en un centro de trabajo. La información que se desea guardar del centro de trabajo es el código de centro, nombre, población y dirección del centro.

La empresa tiene una serie de empleados. Cada empleado tiene un teléfono, fecha de alta en la empresa, NIF y nombre. De cada empleado también interesa saber el número de hijos que tiene y el salario de cada empleado.

A esta empresa también le interesa tener guardada información sobre los hijos de los empleados. Cada hijo de un empleado tendrá un código, nombre y fecha de nacimiento.


Se desea mantener también información sobre las habilidades de los empleados (por ejemplo, mercadotecnia, trato con el cliente, fresador, operador de telefonía, etc...). Cada habilidad tendrá una descripción y un código”.
Sobre este supuesto diseñar el modelo E/R y el modelo relacional teniendo en cuenta los siguientes aspectos:
Un empleado está asignado a un único departamento. Un departamento estará compuesto por uno o más empleados.
Cada departamento se ubica en un único centro de trabajo. Estos se componen de uno o más departamentos.
Un empleado puede tener varios hijos.
Un empleado puede tener varias habilidades, y una misma habilidad puede ser poseída por empleados diferentes.
Un centro de trabajo es dirigido por un empleado. Un mismo empleado puede dirigir centros de trabajo distintos.
