Este ejercicio fue creado con metodología SPA - Single Page Application.

Aunque utiliza diferentes archivos para su operación, todo el ambiente de uso se ejecuta en la misma vista "index.php", y se muestran sus diferentes opciones de acuerdo los parametros enviados.

-- INSTALACION --

Instalar docker desktop (https://www.docker.com/products/docker-desktop/)

Descargar la carpeta con el codigo desde github: https://github.com/lgve2701/prueba_php/tree/master Ramas: -master -feature/form-validation: version con las opciones ya funcionales -feature/scripts: agregados los scripts sql y python (importante: el script python no funciona aun).

Instlación de archivos docker:

Abrir Visual Studio Code y abrir la carpeta descargada. Abrir la terminal y navegar a la carpeta docker "cd docker"

Si no se utiliza VS Code: En cmd windows ir a la carpeta docker

Dentro de la carpeta docker incluída en el proyecto se encuentran:

archivo: docker-compose.yml - archivo con instrucciones para montar php y mysql.
archivo: Dockerfile - archivo con instrucciones para agregar librerias [mysqli] [pdo] [pdo_mysql] a php
carpeta: docker-entrypoint-initdb.d
archivo script: init.sql - archivo con instrucciones para crear base de datos y tablas de prueba.
Ejecutar el comando "docker-compose up -d" - Este comando genera los dockers necesarios para realizar pruebas php y mysql. Tambien crea la base de datos de prueba y crea las tablas y registros iniciales.

Abrir un navegardor de internet y escribir localhost:8080.

Para reiniciar/reintentar se debe detener y remover docker: "docker-compose down -v" - "docker rm mysql_prueba_dnc"

*. Si no se desea utilizar docker, se puede pegar el contenido de la carpeta en el servidor apache de preferencia (xamp, laragon, etc).

-- PRUEBAS --

La pagina es intuitiva:

Home muestra un logo_black.svg generado con Figma y el token php.

Navegación superior tiene el mismo logo.svg generado en Figma.

Usuarios: registro de información de usuarios nuevos. La misma página indica si algun dato no fue ingresado correctamente.

Productos: Contiene 2 ejemplos para listar productos (Esta opción se alimenta de la tabla [productos_venta], donde se pueden agregar mas ejemplos) 2.1 Acordion: en el título muestra el nombre y precio. Al hacer clic expande la sección para mostrar los detalles del producto. 2.2 Tarjetas: Muestra tarjetas con la imagen y nombre del producto. Al hacer clic expande la tarjeta mostrando los detalles del producto.

-- REVISION --

Se puede utilizar un editor de consultas como MySQL Workbench para revisar las tablas: usuarios productos procuctos_venta
