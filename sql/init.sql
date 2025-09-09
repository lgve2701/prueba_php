-- 0. aunque la base se crea con el docker, se revisa
CREATE DATABASE IF NOT EXISTS db_prueba_dnc;


-- **************************************************************************************************** --

USE db_prueba_dnc;

-- 1. tablas --
CREATE TABLE IF NOT EXISTS usuarios 
(
	id INT AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(120) NOT NULL,
	correo VARCHAR(160) NOT NULL UNIQUE,
	password_hash VARCHAR(255) NOT NULL,
	fecha_nacimiento DATE NOT NULL,
	fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS productos 
(
	id INT AUTO_INCREMENT PRIMARY KEY,
	nombre VARCHAR(255) NOT NULL,
	precio FLOAT NULL,
	stock FLOAT NULL,
	fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS productos_venta
(
	id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(255) NOT NULL,
    descripcion VARCHAR(2000) NULL,
    imagen VARCHAR(255),
    precio FLOAT NULL,
    stock FLOAT NULL,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


-- **************************************************************************************************** --

-- 3. procedimientos --
DROP PROCEDURE IF EXISTS `sp_usuarios_insert`;
DROP PROCEDURE IF EXISTS `sp_usuarios_lista`;
DROP PROCEDURE IF EXISTS `sp_usuarios_login`;
DROP PROCEDURE IF EXISTS `sp_usuarios_revisar_existencia`;
DROP PROCEDURE IF EXISTS `sp_productos_venta_select`;

-- crud: insert --
DELIMITER $$
CREATE PROCEDURE sp_usuarios_insert(
    IN p_nombre VARCHAR(120),
    IN p_correo VARCHAR(160),
    IN p_password_hash VARCHAR(255),
    IN p_fecha_nacimiento DATE
)
BEGIN
	DECLARE p_id INT DEFAULT 0;

	INSERT INTO usuarios(nombre, correo, password_hash, fecha_nacimiento)
	VALUES(p_nombre, p_correo, p_password_hash, p_fecha_nacimiento);
    
    SELECT p_id = LAST_INSERT_ID();

	SELECT id, nombre, correo, fecha_nacimiento
	FROM usuarios 
	WHERE usuario = p_usuario 
	AND id = p_id;
    
END$$
DELIMITER ;

-- listado --
DELIMITER $$
CREATE PROCEDURE sp_usuarios_lista(
	IN p_limit INT
)
BEGIN
	IF (p_limit = 0) THEN
		SELECT id, nombre, correo, fecha_nacimiento
		FROM usuarios;
	ELSE
		SELECT id, nombre, correo, fecha_nacimiento
		FROM usuarios
        LIMIT p_limit;
	END IF;

END $$
DELIMITER ;

-- login --
DELIMITER $$
CREATE PROCEDURE sp_usuarios_login(
    IN p_usuario VARCHAR(50)
)
BEGIN
	SELECT id, nombre, correo, password_hash
	FROM usuarios 
	WHERE usuario = p_usuario;
END$$
DELIMITER ;

-- validar que usuario/email no exista --
DELIMITER $$
CREATE PROCEDURE sp_usuarios_revisar_existencia(
	IN p_campo VARCHAR(50),
	IN p_valor VARCHAR(160)
)
BEGIN
	SET p_campo = LOWER(p_campo);
	IF (p_campo = 'usuario') THEN
		SELECT id
		FROM usuarios
		WHERE usuario = p_valor;    
    ELSEIF (p_campo = 'email') THEN
		SELECT id
		FROM usuarios
		WHERE correo = p_valor;    
    END IF;
END$$
DELIMITER ;

-- crud: Read --
DELIMITER $$
CREATE PROCEDURE sp_productos_venta_select()
BEGIN 
	SELECT id, nombre, descripcion, IFNULL(imagen, 'no_image.jpg') as 'imagen', precio, stock
    FROM productos_venta;
END$$
DELIMITER ;


-- **************************************************************************************************** --

-- 4. carga de datos ejemplo --
START TRANSACTION;

-- productos ejemplo para tarjetas expandibles --
INSERT INTO productos_venta(nombre, descripcion, imagen, precio, stock)
VALUES(
	'Notebook ASUS Vivobook', 
	'Notebook ASUS Vivobook Go E1504GA-NJ058W Con Procesador Intel Core i3 N305 De 1.8Ghz Memoria RAM DDR4 De 8GB Almacenamiento De 512GB En SSD Sistema Operativo Windows 11 Home Single Language Color Negro Pantalla De 15.6"', 
    'laptop_vivobook.png',
	2350,
	10
);

INSERT INTO productos_venta(nombre, descripcion, imagen, precio, stock)
VALUES(
	'Servidor Dell PowerEdge', 
	'Servidor Dell PowerEdge T160 Con Procesador Xeon Version E-2434 De 3.4 Ghz Memoria RAM ECC DDR5 De 16GB Almacenamiento De 2TB Garantia Basica', 
    'servidor_poweredge_t160.jpeg',
	12550,
	5
);

INSERT INTO productos_venta(nombre, descripcion, imagen, precio, stock)
VALUES(
	'APPLE MACBOOK AIR', 
	'APPLE MACBOOK AIR M1 PANTALLA DE 13.3" 8GB DE RAM 256GB DE ALMACENAMIENTO COLOR SILVER TECLADO INGLES MGN93LL/A', 
    'apple_macbook_air.png',
	8436,
	12
);

INSERT INTO productos_venta(nombre, descripcion, precio, stock)
VALUES(
	'Equipo Todo En Uno HP', 
	'Equipo Todo En Uno Marca HP Modelo 24-cr0233La Con Procesador AMD Ryzen 3 7320U De 2.4 Ghz Memoria RAM LPDDR5 De 8GB Almacenamiento De 512GB En SSD M.2 Pantalla De 23.8" Sistema Operativo Windows 11 Home Single Language', 
	6403,
	2
);

-- seccion 3: datos para consultas de usuarios --
INSERT INTO usuarios (nombre, correo, password_hash, fecha_nacimiento, fecha_registro)
  SELECT 
    CONCAT('Usuario ', n) AS nombre,
    CONCAT('usuario', n, '@ejemplo.com') AS correo,
    SHA2(CONCAT('Password!', n), 256) AS password_hash,
    DATE_ADD('1980-01-01', INTERVAL (FLOOR(1 + (RAND() * 8000))) DAY) AS fecha_nacimiento,
    DATE_ADD('2025-01-01', INTERVAL (FLOOR(1 + (RAND() * 365))) DAY) AS fecha_registro
  FROM (
    SELECT @row := @row + 1 AS n
    FROM information_schema.tables t1, information_schema.tables t2, (SELECT @row:=0) init
    LIMIT 100
  ) x;
-- usuarios con cuentas @gmail.com --
INSERT INTO usuarios (nombre, correo, password_hash, fecha_nacimiento, fecha_registro)
  SELECT 
    CONCAT('Usuario ', n) AS nombre,
    CONCAT('usuario', n, '@gmail.com') AS correo,
    SHA2(CONCAT('Password!', n), 256) AS password_hash,
    DATE_ADD('1980-01-01', INTERVAL (FLOOR(1 + (RAND() * 8000))) DAY) AS fecha_nacimiento,
    DATE_ADD('2025-01-01', INTERVAL (FLOOR(1 + (RAND() * 365))) DAY) AS fecha_registro
  FROM (
    SELECT @row := @row + 1 AS n
    FROM information_schema.tables t1, information_schema.tables t2, (SELECT @row:=0) init
    LIMIT 25
  ) x;



COMMIT;

