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

COMMIT;


/*
-- **************************************************************************************************** --

INSERT INTO productos(nombre, precio, stock) VALUES('Producto_1',1720,186);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_2',717.18,165);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_3',1145.98,31);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_4',279.82,17);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_5',86.01,437);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_6',960.21,211);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_7',299.31,82);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_8',1557.06,3);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_9',18.5,266);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_10',39.18,361);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_11',1510.2,12);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_12',1443.13,425);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_13',1492.99,187);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_14',1540.73,472);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_15',809.36,344);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_16',1359.97,63);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_17',378.64,166);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_18',837.23,159);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_19',703.35,383);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_20',1079.47,296);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_21',1268.08,91);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_22',915.36,270);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_23',658.65,77);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_24',1245.18,403);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_25',1466.13,243);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_26',1007.14,182);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_27',985.54,250);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_28',1392.5,353);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_29',45.56,219);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_30',1882.73,48);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_31',1436.75,257);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_32',1168.78,18);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_33',175.38,457);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_34',1928.2,333);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_35',131.79,170);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_36',1582.58,147);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_37',265.76,416);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_38',1855.23,405);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_39',315.83,100);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_40',1005.46,300);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_41',392.53,402);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_42',1551.8,206);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_43',788.78,91);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_44',973.06,153);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_45',544.87,263);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_46',1437.11,320);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_47',18.65,496);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_48',1128.35,226);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_49',679.57,411);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_50',1691.91,361);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_51',1956.16,51);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_52',420.2,293);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_53',1611.38,180);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_54',1544.9,168);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_55',1242.56,379);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_56',318.72,23);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_57',116.27,441);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_58',669.93,408);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_59',204.67,48);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_60',912.75,45);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_61',1986,28);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_62',1277.15,445);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_63',416.63,313);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_64',1885.71,276);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_65',1284.13,101);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_66',1802.36,326);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_67',1916.25,282);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_68',786.72,372);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_69',1843.16,148);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_70',246.18,389);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_71',1807.18,169);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_72',662.35,339);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_73',1343.76,439);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_74',125.59,63);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_75',1183.2,251);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_76',1685.67,463);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_77',784.04,116);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_78',1011.15,303);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_79',263.45,343);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_80',1208.03,93);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_81',911.5,477);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_82',815.97,267);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_83',1881.69,462);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_84',1861.35,475);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_85',1265.77,66);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_86',752.49,399);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_87',1519.45,298);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_88',990.78,82);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_89',791.58,364);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_90',161.8,31);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_91',313.73,428);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_92',194.22,35);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_93',496.04,132);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_94',1722.07,484);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_95',1238.5,14);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_96',1367.55,344);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_97',173.98,176);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_98',1978.32,192);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_99',418.98,302);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_100',1009.21,436);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_101',802.92,45);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_102',951.7,17);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_103',1673.86,65);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_104',805.57,180);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_105',1204.89,354);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_106',1473.42,50);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_107',1633.21,180);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_108',1172.54,198);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_109',1093.28,117);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_110',420.4,381);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_111',1396.75,373);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_112',1983.44,454);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_113',48.71,9);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_114',1667.46,247);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_115',512.48,119);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_116',531.99,473);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_117',1343.39,163);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_118',278.98,153);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_119',40.8,420);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_120',1408.97,441);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_121',224.46,302);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_122',1118.79,327);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_123',541.11,452);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_124',1891.08,475);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_125',1784.03,367);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_126',1987.25,340);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_127',976.92,268);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_128',1297.82,492);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_129',1991.13,438);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_130',344.96,175);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_131',1378.68,109);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_132',963.7,298);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_133',1361.3,459);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_134',924.83,390);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_135',359.29,272);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_136',760.29,446);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_137',1745.7,463);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_138',160.89,249);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_139',31.44,241);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_140',591.29,25);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_141',1334.47,322);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_142',1749,458);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_143',891.16,159);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_144',1620.4,366);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_145',1985.15,368);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_146',1606.97,117);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_147',1518.19,19);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_148',497.55,256);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_149',1964.66,211);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_150',442.98,16);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_151',1971.58,198);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_152',1509.03,257);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_153',1680.71,23);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_154',1645.32,236);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_155',1222.86,87);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_156',1496.61,81);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_157',1810.26,460);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_158',1244.75,136);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_159',423.94,131);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_160',218.57,3);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_161',1876.91,207);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_162',1279.02,120);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_163',780.48,185);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_164',37.63,413);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_165',131.35,241);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_166',127.01,409);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_167',1444.31,39);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_168',2000,368);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_169',978.19,204);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_170',274.45,218);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_171',1476.82,489);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_172',209.08,248);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_173',548.99,265);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_174',568.82,315);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_175',1296.05,172);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_176',1679.39,372);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_177',1944.94,14);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_178',858.55,350);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_179',156.39,42);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_180',1610.61,494);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_181',1871.8,450);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_182',1204.04,86);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_183',90.96,130);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_184',337.46,499);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_185',1933.88,456);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_186',411.4,146);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_187',999.42,69);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_188',1240.16,161);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_189',76.55,316);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_190',1169.88,247);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_191',263.64,97);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_192',713.37,491);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_193',1367.86,247);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_194',789.61,443);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_195',996.31,435);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_196',675.4,208);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_197',1711.63,454);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_198',246.92,381);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_199',1698.41,333);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_200',1042.93,183);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_201',992.22,12);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_202',377.1,357);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_203',203.11,197);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_204',1507.61,130);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_205',1754.36,386);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_206',46.29,59);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_207',1579.07,175);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_208',292.39,22);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_209',1758.2,382);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_210',1982.08,463);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_211',1003.88,409);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_212',1526.74,275);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_213',406.78,208);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_214',866.55,239);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_215',1876.4,427);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_216',1236.87,246);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_217',1820.46,157);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_218',1786.34,153);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_219',1507.16,72);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_220',1209.73,219);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_221',1514.88,474);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_222',1844.8,340);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_223',360.22,405);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_224',244.81,290);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_225',141.35,424);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_226',1567.87,202);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_227',437.92,414);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_228',1513.44,167);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_229',1951.09,364);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_230',1621.21,443);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_231',1301.08,422);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_232',60.77,59);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_233',569.61,308);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_234',856.87,409);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_235',1329.61,137);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_236',819.45,170);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_237',1341.89,126);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_238',1353.63,352);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_239',1262.3,388);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_240',1670.95,196);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_241',1289.85,460);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_242',1684.74,142);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_243',1103.21,204);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_244',1763.92,232);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_245',47.07,169);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_246',81.23,32);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_247',532.72,467);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_248',923.43,87);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_249',1298.42,328);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_250',1220.38,148);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_251',1027.24,303);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_252',1775.86,314);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_253',1522.93,205);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_254',418.55,89);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_255',1541.7,162);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_256',376.51,70);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_257',1671.04,460);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_258',1573.95,15);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_259',1400.81,450);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_260',348.44,59);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_261',530.31,54);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_262',821.89,433);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_263',773.71,357);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_264',613.86,422);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_265',751.68,324);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_266',18.54,490);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_267',1465.99,288);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_268',62.1,55);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_269',1313.34,123);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_270',1053.55,39);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_271',592.55,466);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_272',298.66,194);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_273',1341.1,360);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_274',1138,46);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_275',415.66,117);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_276',1623.16,41);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_277',333.58,419);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_278',646.12,116);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_279',122.9,311);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_280',462.4,429);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_281',1193.4,68);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_282',1094.94,193);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_283',918.96,488);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_284',1097.76,98);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_285',543.64,478);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_286',1923.18,389);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_287',1027.42,202);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_288',55.44,364);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_289',1217.5,104);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_290',1705.79,496);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_291',1798.13,468);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_292',1964.17,82);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_293',1411.87,271);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_294',1066.21,29);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_295',1498.64,458);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_296',1788.93,125);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_297',567.79,64);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_298',510.1,251);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_299',433.43,442);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_300',1950.25,122);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_301',1644.92,311);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_302',1918.34,317);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_303',1260.12,392);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_304',1766.47,293);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_305',879.3,243);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_306',906.91,438);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_307',131.69,41);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_308',1381.72,10);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_309',1989.32,322);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_310',150.98,148);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_311',588.27,68);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_312',519.23,252);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_313',1678.38,282);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_314',745.87,472);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_315',1996.12,292);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_316',1231.6,444);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_317',1632.75,467);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_318',1107.96,60);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_319',1782.47,460);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_320',971.65,78);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_321',415.67,74);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_322',1824.18,486);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_323',85.61,134);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_324',1566.74,284);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_325',792.55,179);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_326',300.18,7);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_327',1186.31,34);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_328',805.39,113);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_329',1107.68,244);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_330',680.61,334);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_331',187.14,254);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_332',146.45,352);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_333',1785.65,159);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_334',1705.97,403);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_335',543.22,161);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_336',1557.24,189);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_337',88.22,417);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_338',1811.67,439);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_339',1850.73,198);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_340',792.12,420);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_341',1755.26,417);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_342',1186.23,119);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_343',1390.41,472);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_344',1379.41,228);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_345',1086.71,407);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_346',553.51,93);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_347',1587.67,135);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_348',18.8,77);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_349',1157.18,205);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_350',1198.1,348);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_351',1838.22,72);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_352',1819.41,385);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_353',1531.23,268);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_354',1804.8,11);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_355',305.43,405);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_356',309.35,215);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_357',1572.86,70);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_358',396.15,41);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_359',27.18,295);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_360',373,128);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_361',666.67,334);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_362',1173.57,440);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_363',1160.94,88);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_364',97.78,67);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_365',709.45,297);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_366',501.03,414);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_367',1312.13,138);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_368',934.81,254);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_369',766.73,102);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_370',1865.45,20);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_371',862.24,426);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_372',535.14,246);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_373',507.08,45);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_374',1015.15,369);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_375',947.28,274);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_376',1401,42);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_377',594.24,453);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_378',493.46,109);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_379',1042.33,49);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_380',164.16,460);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_381',1562.62,341);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_382',1395.7,397);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_383',683.38,105);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_384',1090.76,161);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_385',1965.26,212);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_386',1630.28,389);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_387',1727.48,282);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_388',1680.8,186);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_389',193.92,449);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_390',100.23,236);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_391',124.69,108);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_392',814.6,231);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_393',658.97,254);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_394',356.71,97);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_395',1162.99,92);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_396',1362.84,59);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_397',841.85,154);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_398',169.79,51);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_399',1877.4,484);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_400',653.54,89);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_401',436.54,169);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_402',1196.83,457);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_403',1687.33,432);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_404',867.98,292);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_405',240.33,75);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_406',721.14,462);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_407',907.88,229);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_408',858.15,458);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_409',727.61,25);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_410',610.02,68);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_411',1926.49,315);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_412',1167.9,151);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_413',968.31,419);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_414',941.66,60);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_415',1830.03,499);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_416',578.26,5);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_417',1002.23,158);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_418',197.71,108);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_419',837.56,366);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_420',1420.51,231);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_421',1483.1,8);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_422',1167.9,442);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_423',213.88,213);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_424',8.07,85);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_425',1599.57,334);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_426',274.8,99);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_427',277.52,452);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_428',1503.52,341);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_429',1391.13,394);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_430',143.12,35);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_431',1111.26,233);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_432',1761.78,194);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_433',1545.83,388);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_434',1851.37,420);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_435',1335.4,483);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_436',1112.42,478);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_437',149.5,82);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_438',364.81,345);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_439',798.82,436);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_440',1070.15,152);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_441',1148.95,241);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_442',691.65,476);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_443',1006.96,147);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_444',1913.5,397);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_445',38.37,349);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_446',790.94,214);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_447',1001.24,444);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_448',1217.09,294);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_449',1198.57,291);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_450',192.86,208);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_451',1135.9,370);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_452',1938.54,21);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_453',1937.97,91);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_454',1163.26,289);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_455',663.44,9);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_456',150.94,358);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_457',652.99,62);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_458',1784.95,326);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_459',1085.42,39);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_460',62.55,476);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_461',1823.13,371);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_462',232.56,116);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_463',1302.16,89);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_464',383.04,439);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_465',1146.65,10);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_466',1805.24,225);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_467',1167.51,486);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_468',1885.63,31);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_469',964.73,89);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_470',547.88,66);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_471',1508.94,478);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_472',1196.81,216);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_473',835.93,466);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_474',1711.39,68);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_475',703.84,140);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_476',1097.86,277);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_477',684.63,128);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_478',1840.62,344);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_479',1261.47,29);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_480',1626.92,97);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_481',1194.43,153);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_482',1446.2,475);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_483',1075.68,228);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_484',683.7,338);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_485',923.96,86);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_486',323.9,49);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_487',262.16,479);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_488',1643.1,373);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_489',124.68,179);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_490',1784.54,381);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_491',1420.39,139);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_492',215.79,400);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_493',816.15,377);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_494',234.5,248);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_495',28.76,321);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_496',411.68,197);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_497',1178.39,440);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_498',1468.05,16);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_499',600.63,296);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_500',1755.43,55);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_501',496.81,471);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_502',655.06,98);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_503',584.36,209);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_504',1212.12,495);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_505',326.46,267);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_506',1394.05,463);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_507',1146.35,135);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_508',622.94,35);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_509',493.45,309);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_510',1076.58,407);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_511',58.53,434);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_512',1312.18,168);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_513',1994.99,218);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_514',1182.22,84);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_515',1230.77,89);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_516',995.47,248);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_517',1766.76,439);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_518',1920.58,414);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_519',1510.56,376);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_520',1879.31,444);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_521',1868.93,224);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_522',1551.68,109);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_523',1149.84,169);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_524',1080.85,478);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_525',1875.09,438);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_526',1420.59,194);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_527',1558.33,109);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_528',223.22,136);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_529',1030.57,193);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_530',1032.42,283);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_531',828.52,339);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_532',330.2,238);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_533',92.5,143);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_534',661.87,202);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_535',1774.33,345);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_536',1143.28,354);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_537',1391.36,28);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_538',1844.53,373);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_539',1538.78,178);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_540',1440.14,64);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_541',647.8,404);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_542',1315.69,242);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_543',1550.2,334);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_544',41.2,83);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_545',875.64,155);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_546',1511.85,121);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_547',291.89,357);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_548',470.1,392);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_549',192.44,189);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_550',894.54,233);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_551',871.5,110);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_552',516.28,100);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_553',92.83,167);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_554',1475.75,296);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_555',735.34,399);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_556',1452.42,364);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_557',652.73,371);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_558',322.27,494);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_559',121.6,208);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_560',801.93,25);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_561',1420.51,373);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_562',1217.47,486);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_563',1463.75,284);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_564',135.77,415);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_565',42.43,198);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_566',548.47,375);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_567',821.85,290);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_568',1115.34,236);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_569',1702.34,289);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_570',1037.6,131);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_571',593.06,76);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_572',201.2,374);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_573',1184.43,194);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_574',1711.9,400);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_575',1543.78,79);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_576',344.98,301);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_577',1496.55,391);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_578',1095.08,296);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_579',1385.53,266);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_580',291.01,150);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_581',1882.07,237);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_582',1601.65,210);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_583',1913.43,481);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_584',760.14,361);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_585',259.67,213);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_586',744.02,367);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_587',995.27,248);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_588',776.05,294);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_589',522.7,319);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_590',431.61,224);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_591',1511.33,426);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_592',429.99,206);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_593',417.28,2);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_594',163.86,249);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_595',434.97,284);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_596',319.75,423);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_597',633.11,403);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_598',1566.22,21);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_599',496.84,360);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_600',1139.96,15);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_601',1562.47,231);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_602',78.83,256);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_603',1304.48,460);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_604',935.09,10);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_605',1683.2,427);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_606',793.76,483);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_607',1126.18,410);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_608',1501.85,223);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_609',247.53,413);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_610',1759.53,58);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_611',829.31,400);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_612',168.81,249);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_613',995.85,171);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_614',776.34,372);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_615',534.64,108);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_616',1662.27,465);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_617',580.42,268);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_618',1299.89,399);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_619',1421.69,303);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_620',1567.21,171);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_621',1635.82,156);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_622',336,296);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_623',1551.9,462);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_624',1648.55,433);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_625',1697.71,425);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_626',844.78,168);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_627',1874.55,163);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_628',864.16,482);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_629',1840.23,11);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_630',1577.51,159);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_631',150.6,155);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_632',1290.34,279);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_633',1827.34,20);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_634',1459.2,406);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_635',1439.13,482);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_636',549.55,426);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_637',1064.65,368);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_638',827.51,293);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_639',1731.78,170);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_640',964.3,27);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_641',500.3,195);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_642',437.2,253);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_643',1922.12,101);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_644',1944,399);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_645',1445.89,273);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_646',858.28,231);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_647',1837.02,52);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_648',925.9,154);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_649',548.67,404);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_650',449.25,28);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_651',561.54,405);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_652',796.8,108);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_653',1814.02,160);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_654',489.2,335);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_655',276.8,353);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_656',1116.64,223);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_657',93.61,343);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_658',281.45,34);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_659',1389.82,15);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_660',753.2,234);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_661',1754.08,424);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_662',40.37,42);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_663',660.51,464);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_664',166.68,289);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_665',1559.36,411);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_666',1697.51,91);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_667',980.04,140);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_668',102.5,296);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_669',1305.93,379);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_670',376.45,480);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_671',1679.66,283);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_672',544.83,253);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_673',1060.13,467);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_674',644.55,102);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_675',1562.43,225);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_676',841.07,390);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_677',1468.81,2);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_678',723.08,304);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_679',508.09,288);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_680',620.27,460);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_681',1552.71,441);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_682',1390.76,55);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_683',1998.9,461);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_684',757.14,433);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_685',42.63,195);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_686',957.8,48);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_687',260.81,247);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_688',775.52,445);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_689',1801.6,176);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_690',1241.63,191);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_691',569.98,98);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_692',261.84,456);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_693',359.06,116);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_694',1779.97,182);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_695',1174.24,438);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_696',1708.57,201);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_697',972.59,253);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_698',643.18,378);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_699',574.95,271);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_700',1251.38,10);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_701',926.53,38);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_702',405.79,346);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_703',167.39,240);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_704',1196.88,491);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_705',1399.11,59);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_706',1671.78,368);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_707',1641.14,437);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_708',1885.34,343);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_709',1997.2,88);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_710',876.63,332);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_711',1299.26,344);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_712',1406.95,387);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_713',882.75,314);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_714',893.48,206);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_715',1706.12,182);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_716',1005.97,130);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_717',1574.06,370);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_718',1199.69,99);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_719',634.58,106);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_720',663.48,441);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_721',1005.26,334);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_722',980.33,173);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_723',1312.35,380);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_724',1572.71,88);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_725',1090.93,221);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_726',1156.12,76);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_727',1556.24,345);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_728',1502.3,191);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_729',334.95,365);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_730',145.13,56);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_731',17.22,236);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_732',1858.28,407);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_733',613.65,88);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_734',1394.86,121);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_735',19.71,135);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_736',1330.85,136);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_737',1051.01,250);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_738',1743.26,335);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_739',1613.27,232);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_740',799.87,56);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_741',992.65,108);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_742',1444.13,183);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_743',374.7,255);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_744',1710.84,125);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_745',1400.06,451);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_746',1914.79,460);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_747',1852.14,435);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_748',1571.03,227);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_749',855.64,17);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_750',941,230);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_751',1141.75,392);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_752',683.37,59);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_753',565.7,317);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_754',1285.24,189);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_755',1590.87,344);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_756',81.57,260);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_757',1415.49,44);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_758',709.22,327);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_759',1566.51,354);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_760',808.54,55);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_761',1050.35,2);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_762',1808.23,473);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_763',753.44,378);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_764',624.31,481);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_765',82.52,76);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_766',1154.73,89);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_767',57.34,371);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_768',484.75,410);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_769',645.09,21);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_770',1144.15,495);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_771',48.85,499);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_772',21.76,52);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_773',453.91,449);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_774',330.88,165);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_775',704.8,161);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_776',833.41,11);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_777',506.6,497);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_778',1919.32,79);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_779',1177.71,122);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_780',129.05,122);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_781',1841.46,267);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_782',746.98,441);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_783',237.04,465);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_784',1385.51,407);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_785',1684.75,354);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_786',173.67,303);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_787',1537.73,487);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_788',1122.72,27);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_789',1919.44,341);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_790',1100.77,112);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_791',402.72,112);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_792',1148.88,470);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_793',300.2,255);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_794',1152.31,250);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_795',1940.39,226);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_796',1657.83,110);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_797',1010.43,475);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_798',1569.11,288);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_799',320,116);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_800',690.2,134);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_801',254.93,131);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_802',1675.19,196);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_803',423.58,100);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_804',1657.99,376);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_805',357.09,31);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_806',1683.74,106);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_807',512.06,335);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_808',728.67,452);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_809',1457.82,294);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_810',798.9,299);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_811',1979.37,97);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_812',606.09,232);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_813',837.75,34);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_814',1012.42,426);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_815',1904.87,273);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_816',1013.89,90);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_817',17.43,181);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_818',96.76,241);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_819',704.18,147);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_820',764.4,311);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_821',1374.15,303);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_822',1327.03,383);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_823',900.05,500);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_824',483,157);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_825',979.21,361);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_826',222.54,257);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_827',1116.03,257);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_828',1663.43,247);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_829',1651.64,393);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_830',127.79,333);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_831',1007.72,165);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_832',1879.67,253);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_833',515.06,289);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_834',547.23,7);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_835',1376.89,342);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_836',682.29,31);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_837',619.33,81);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_838',1045.24,293);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_839',1527.96,419);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_840',1424.34,449);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_841',276.78,127);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_842',271.15,190);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_843',338.51,403);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_844',1665.31,82);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_845',774.98,244);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_846',954.32,147);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_847',103.36,162);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_848',970.44,28);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_849',1925.9,398);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_850',519.93,200);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_851',1984.56,445);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_852',640.57,385);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_853',1535.37,201);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_854',820.91,415);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_855',32.9,480);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_856',686.86,358);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_857',1111.11,394);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_858',1178.63,363);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_859',1917.59,187);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_860',1917.52,461);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_861',1157.22,28);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_862',1141.87,387);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_863',52.26,193);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_864',302.67,415);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_865',1299.3,289);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_866',1422.6,428);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_867',42.84,346);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_868',1881.04,59);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_869',474.71,486);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_870',764.49,334);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_871',1495.63,86);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_872',698.47,151);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_873',448.36,492);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_874',858.3,448);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_875',177.4,201);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_876',1371.38,347);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_877',778.04,242);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_878',1464.83,410);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_879',835.41,324);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_880',1745.5,32);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_881',507.26,25);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_882',1399.56,237);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_883',1554.42,239);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_884',1540.25,143);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_885',29.24,300);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_886',1503,286);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_887',1812.12,489);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_888',1492.23,32);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_889',1490.03,468);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_890',470.48,99);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_891',913.54,224);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_892',747.09,175);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_893',1468.95,191);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_894',1086.03,300);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_895',1840.12,382);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_896',456.95,499);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_897',896.19,83);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_898',526.05,429);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_899',1769.8,453);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_900',680.97,318);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_901',1267.51,238);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_902',1277.19,282);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_903',1680.21,338);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_904',461.71,84);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_905',1530.46,74);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_906',363.24,231);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_907',1018.12,216);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_908',1320.23,63);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_909',1086.79,479);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_910',875.7,478);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_911',1731.18,390);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_912',301.21,470);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_913',1178.26,318);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_914',1081.89,313);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_915',1133.39,319);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_916',32.42,161);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_917',1388.95,340);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_918',882.28,218);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_919',204.8,144);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_920',1100.36,356);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_921',280.12,6);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_922',1074.66,368);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_923',1753.88,425);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_924',738.8,136);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_925',1630.06,369);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_926',885.49,494);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_927',1497.37,298);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_928',597.29,426);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_929',315.04,427);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_930',1022.67,218);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_931',1621.86,37);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_932',1979.8,352);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_933',182.83,164);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_934',25.71,293);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_935',1336.88,329);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_936',903.44,20);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_937',1711.2,172);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_938',1072.75,140);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_939',1195.17,283);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_940',1954.33,359);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_941',1398.1,394);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_942',1952.73,473);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_943',371.99,257);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_944',919.06,357);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_945',1845.48,377);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_946',1388.19,401);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_947',1146.32,41);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_948',1458.76,270);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_949',1902.85,479);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_950',83.46,273);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_951',211.95,152);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_952',1733.78,435);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_953',1094.99,80);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_954',992.72,112);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_955',1046.5,428);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_956',1520.58,268);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_957',1776.06,182);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_958',236.03,413);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_959',955.98,279);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_960',306.44,441);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_961',883.84,107);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_962',1305.07,336);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_963',1911.72,149);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_964',1252.73,451);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_965',1985.08,208);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_966',1658,411);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_967',984.98,366);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_968',1968.35,107);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_969',317.9,392);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_970',1481.8,250);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_971',1191.65,109);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_972',1796.61,404);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_973',486.81,499);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_974',1324.79,20);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_975',1723.32,282);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_976',750.96,401);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_977',1655.56,274);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_978',602.23,445);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_979',466.31,145);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_980',1942.32,25);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_981',952.32,349);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_982',1914.64,3);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_983',293.31,255);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_984',1800.99,240);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_985',1102.23,498);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_986',291.01,104);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_987',898.61,269);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_988',672.86,134);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_989',436.76,439);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_990',1548.55,230);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_991',337.65,273);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_992',323.98,424);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_993',942.96,462);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_994',1689.68,26);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_995',1440.12,227);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_996',1456.73,271);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_997',837.17,14);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_998',1433.75,284);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_999',752.42,236);
INSERT INTO productos(nombre, precio, stock) VALUES('Producto_1000',701.8,335);
*/


