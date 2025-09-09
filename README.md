Este ejercicio fue creado con metodología SPA - Single Page Application. 

Aunque utiliza diferentes archivos para su operación, 
todo el ambiente de uso se ejecuta en la misma vista "index.php", 
y se muestran sus diferentes opciones de acuerdo los parametros enviados.


-- INSTALACION --

1. Instalar docker desktop (https://www.docker.com/products/docker-desktop/)

2. Descargar la carpeta con el codigo desde github: https://github.com/lgve2701/prueba_php/tree/master 
	Ramas: 
	-master: version final completa
	-feature/form-validation: version con las opciones ya funcionales 
	-feature/scripts: agregados los scripts sql y python (importante: el script python no funciona aun).

3. Pegar carpeta en raiz de servidor PHP, por ejemplo "../www/html"

4. Abrir el archivo "SQL/init.sql" en cualquier editor MySQL como workbench y ejecutar.
	Este script crea las tablas y stored procedures necesarios para las pruebas.

5. Configurar variables de conexión MySQL en archivo "API/utils.php"
		$host = "localhost";
		$dbname = "db_prueba_dnc"; // el script init.sql crea la base de pruebas
		$username = '{usuario}';
		$password = '{password}';
        $port = "3306"; // si la base utiliza otro puerto cambiar

5. Ingrear a "localhost" en un navegador de internet.


-- PRUEBAS --

La pagina es intuitiva:

1. Home muestra un logo_black.svg generado con Figma y el token php.

2. Navegación superior tiene el mismo logo.svg generado en Figma.

3. Usuarios: registro de información de usuarios nuevos. La misma página indica si algun dato no fue ingresado correctamente.

4. Productos: Contiene 2 ejemplos para listar productos (Esta opción se alimenta de la tabla [productos_venta], donde se pueden agregar mas ejemplos)
	2.1 Acordion: en el título muestra el nombre y precio. Al hacer clic expande la sección para mostrar los detalles del producto.
	2.2 Tarjetas: Muestra tarjetas con la imagen y nombre del producto. Al hacer clic expande la tarjeta mostrando los detalles del producto.


-- REVISION --

Se puede utilizar un editor de consultas como MySQL Workbench para revisar las tablas:
	usuarios
	productos
	procuctos_venta

