### Se trata de realizar el diseño de la base de datos en el modelo E/R para una cadena de hoteles.

Cada hotel (del que interesa almacenar su nombre, dirección, teléfono, año de construcción, etc.) se encuentra clasificado obligatoriamente en una categoría (por ejemplo, tres estrellas) pudiendo bajar o aumentar de categoría."
Cada categoría tiene asociada diversas informaciones, como, por ejemplo, el tipo de IVA que le corresponde y la descripción.
Los hoteles tienen diferentes clases de habitaciones (suites, dobles, individuales, etc.), que se numeran de forma que se pueda identificar fácilmente la planta en la que se encuentran. Así pues, de cada habitación se desea guardar el código y el tipo de habitación.
Los particulares pueden realizar reservas de las habitaciones de los hoteles. En la reserva de los particulares figurarán el nombre, la dirección y el teléfono.
Las agencias de viaje también pueden realizar reservas de las habitaciones. En caso de que la reserva la realice una agencia de viajes, se necesitarán los mismos datos que para los particulares, además del nombre de la persona para quien la agencia de viajes está realizando la reserva.
En los dos casos anteriores también se debe almacenar el precio de la reserva, la fecha de inicio y la fecha de fin de la reserva.