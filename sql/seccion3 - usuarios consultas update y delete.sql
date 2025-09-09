/*

-- NOTA IMPORTANTE --
-- Los siguientes inserts estan inlcuidos en el archivo /docker/docker-entrypoint-initdb.d/init.sql --
-- si es necesario se pueden ejecutar de nuevo --


START TRANSACTION;

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
-- ROLLBACK;


-- revision de datos creados --
SELECT COUNT(id) as 'Cantidad', SUBSTRING(correo, INSTR(correo, '@'), LENGTH(correo)) AS 'Email Server'
FROM usuarios
GROUP BY SUBSTRING(correo, INSTR(correo, '@'), LENGTH(correo));


-- 1. Usuarios registrados últimos 30 días.
-- 2. Contar usuarios con correo @gmail.com.
-- 3. Actualizar nombre de usuario con id=10.
-- 4. Eliminar usuario con id=15. 

*/



-- 1. Usuarios registrados últimos 30 días.
SELECT id, nombre as 'Nombre', correo as 'E-mail', fecha_nacimiento as 'Fecha de Nacimiento', fecha_registro as 'Fecha Registro'
FROM usuarios
WHERE fecha_registro <= date_add(CURDATE(), INTERVAL -30 DAY )
ORDER BY fecha_registro DESC;

-- 2. Contar usuarios con correo @gmail.com.
SELECT COUNT(id) as 'Usuarios GMail'
FROM usuarios
WHERE SUBSTRING(correo, INSTR(correo, '@'), LENGTH(correo)) = '@gmail.com';

-- 3. Actualizar nombre de usuario con id=10.
SELECT * FROM usuarios WHERE id = 10;
START TRANSACTION;
	UPDATE usuarios SET nombre = 'Usuario 10 - ACTUALIZADO' WHERE id = 10;
COMMIT;
SELECT * FROM usuarios WHERE id = 10;

-- 4. Eliminar usuario con id=15. 
SELECT * FROM usuarios WHERE id = 15;
START TRANSACTION;
	DELETE FROM usuarios WHERE id = 15;
COMMIT;
SELECT * FROM usuarios WHERE id = 15;


