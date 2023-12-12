

DROP DATABASE IF EXISTS tienda;
CREATE DATABASE tienda CHARACTER SET utf8mb4;
USE tienda;

CREATE TABLE fabricante (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
);

CREATE TABLE producto (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  precio DOUBLE NOT NULL,
  codigo_fabricante INT UNSIGNED NOT NULL,
  FOREIGN KEY (codigo_fabricante) REFERENCES fabricante(codigo)
);

INSERT INTO fabricante VALUES(1, 'Asus');
INSERT INTO fabricante VALUES(2, 'Lenovo');
INSERT INTO fabricante VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricante VALUES(4, 'Samsung');
INSERT INTO fabricante VALUES(5, 'Seagate');
INSERT INTO fabricante VALUES(6, 'Crucial');
INSERT INTO fabricante VALUES(7, 'Gigabyte');
INSERT INTO fabricante VALUES(8, 'Huawei');
INSERT INTO fabricante VALUES(9, 'Xiaomi');

INSERT INTO producto VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO producto VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO producto VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO producto VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO producto VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT INTO producto VALUES(9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO producto VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

USE tienda;
-- Lista el nombre de todos los productos que hay en la tabla "producto".
SELECT nombre FROM producto;
-- Lista los nombres y precios de todos los productos de la tabla "producto".
SELECT nombre,precio FROM producto;
-- Lista todas las columnas de la tabla "producto".
SHOW COLUMNS FROM tienda.producto;
-- Lista el nombre de los "productos", el precio en euros y el precio en dólares estadounidenses (USD).
SELECT nombre,precio, (precio * 1.09) AS precio_usd FROM producto;
-- Lista el nombre de los "productos", el precio en euros y el precio en dólares estadounidenses. Utiliza los siguientes sobrenombre para las columnas: nombre de "producto", euros, dólares estadounidenses.
SELECT nombre as 'nombre de "producto"',precio AS euros, (precio * 1.09) AS 'dólares estadounidenses' FROM producto;
-- Lista los nombres y precios de todos los productos de la tabla "producto", convirtiendo los nombres a mayúscula.
SELECT UPPER(nombre),precio FROM producto;
-- Lista los nombres y precios de todos los productos de la tabla "producto", convirtiendo los nombres a minúscula.
SELECT LOWER(nombre),precio FROM producto;
-- Lista el nombre de todos los fabricantes en una columna, y en otra columna obtenga en mayúsculas los dos primeros caracteres del nombre del fabricante.
SELECT nombre,UPPER(LEFT(nombre, 2)) FROM fabricante;
-- Lista los nombres y precios de todos los productos de la tabla "producto", redondeando el valor del precio.
SELECT nombre,ROUND(precio,1) AS precio_redondeado FROM producto;
-- Lista los nombres y precios de todos los productos de la tabla "producto", truncando el valor del precio para mostrarlo sin ninguna cifra decimal.
SELECT nombre,FLOOR(precio) AS precio_floor FROM producto;
-- Lista el código de los fabricantes que tienen productos en la tabla "producto".
SELECT f.codigo FROM fabricante f JOIN  producto p  ON f.codigo = p.codigo_fabricante;
-- Lista el código de los fabricantes que tienen productos en la tabla "producto", eliminando los códigos que aparecen repetidos.
SELECT DISTINCT f.codigo FROM fabricante f JOIN  producto p  ON f.codigo = p.codigo_fabricante;
-- Lista los nombres de los fabricantes ordenados de forma ascendente.
SELECT nombre FROM fabricante ORDER BY nombre ASC;
-- Lista los nombres de los fabricantes ordenados de forma descendente.
SELECT nombre FROM fabricante ORDER BY nombre DESC;
-- Lista los nombres de los productos ordenados, en primer lugar, por el nombre de forma ascendente y, en segundo lugar, por el precio de forma descendente.
SELECT nombre FROM producto ORDER BY nombre ASC, precio DESC;
-- Devuelve una lista con las 5 primeras filas de la tabla "fabricante".
SELECT nombre FROM fabricante LIMIT 5;
-- Devuelve una lista con 2 filas a partir de la cuarta fila de la tabla "fabricante". La cuarta fila también debe incluirse en la respuesta.
SELECT nombre FROM fabricante LIMIT 2 OFFSET 3;
-- Lista el nombre y precio del producto más barato. (Utiliza solo las cláusulas ORDER BY y LIMIT). NOTA: Aquí no podrías usar MIN(precio), necesitarías GROUP BY
SELECT nombre FROM producto ORDER BY precio ASC LIMIT 1;
-- Lista el nombre y precio del producto más caro. (Utiliza solamente las cláusulas ORDER BY y LIMIT). NOTA: Aquí no podrías usar MAX(precio), necesitarías GROUP BY.
SELECT nombre FROM producto ORDER BY precio DESC LIMIT 1;
-- Lista el nombre de todos los productos del fabricante cuyo código de fabricante es igual a 2.
SELECT nombre FROM producto WHERE codigo_fabricante = 2;
-- Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos.
SELECT p.nombre, p.precio, f.nombre  FROM fabricante f RIGHT JOIN  producto p  ON f.codigo = p.codigo_fabricante;
-- Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos los productos de la base de datos. Ordena el resultado por el nombre del fabricante, por orden alfabético.
SELECT p.nombre, p.precio, f.nombre  FROM fabricante f RIGHT JOIN  producto p  ON f.codigo = p.codigo_fabricante ORDER BY f.nombre ASC;
-- Devuelve una lista con el código del producto, nombre del producto, código del fabricante y nombre del fabricante, de todos los productos de la base de datos.
SELECT p.codigo, p.nombre, f.codigo, c.nombre  FROM fabricante f RIGHT JOIN  producto p  ON f.codigo = p.codigo_fabricante ORDER BY f.nombre ASC;
-- Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más barato.
SELECT p.nombre, p.precio, f.nombre  FROM fabricante f RIGHT JOIN  producto p  ON f.codigo = p.codigo_fabricante  WHERE  p.precio = ( SELECT MIN(precio) FROM producto );
-- Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto más caro.
SELECT p.nombre, p.precio, f.nombre  FROM fabricante f RIGHT JOIN  producto p  ON f.codigo = p.codigo_fabricante  WHERE  p.precio = ( SELECT MAX(precio) FROM producto );
-- Devuelve una lista de todos los productos del fabricante Lenovo.
SELECT p.* FROM fabricante f RIGHT JOIN  producto p  ON f.codigo = p.codigo_fabricante  WHERE  f.nombre = 'Lenovo';
-- Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio mayor que 200€.
SELECT p.* FROM fabricante f RIGHT JOIN  producto p  ON f.codigo = p.codigo_fabricante  WHERE  f.nombre = 'Crucial' AND p.precio > 200;
-- Devuelve una lista con todos los productos de los fabricantes Asus, Hewlett-Packard y Seagate. Sin utilizar el operador IN.
SELECT p.* FROM fabricante f RIGHT JOIN  producto p  ON f.codigo = p.codigo_fabricante  
WHERE  f.nombre = 'Asus' OR f.nombre = 'Hewlett-Packard' OR f.nombre = 'Seagate';
-- Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard y Seagate. Usando el operador IN.
SELECT p.* FROM fabricante f RIGHT JOIN  producto p  ON f.codigo = p.codigo_fabricante  
WHERE f.nombre IN  ('Asus', 'Hewlett-Packard', 'Seagate');
-- Devuelve un listado con el nombre y el precio de todos los productos de los fabricantes cuyo nombre acabe por la vocal e.
SELECT p.* FROM fabricante f RIGHT JOIN  producto p  ON f.codigo = p.codigo_fabricante WHERE f.nombre  like '%s';
-- Devuelve un listado con el nombre y precio de todos los productos de cuyos fabricantes contenga el carácter w en su nombre.
SELECT p.* FROM fabricante f RIGHT JOIN  producto p  ON f.codigo = p.codigo_fabricante WHERE f.nombre  like '%w%';
-- Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos los productos que tengan un precio mayor o igual a 180€. Ordena el resultado, en primer lugar, por el precio (en orden descendente) y, en segundo lugar, por el nombre (en orden ascendente).
SELECT p.nombre, p.precio, f.nombre  FROM fabricante f RIGHT JOIN  producto p  ON f.codigo = p.codigo_fabricante  WHERE  p.precio = ( SELECT MIN(precio) FROM producto );
-- Devuelve un listado con el código y el nombre de fabricante, sólo de aquellos fabricantes que tienen productos asociados en la base de datos.
SELECT DISTINCT f.codigo, f.nombre FROM fabricante f JOIN  producto p  ON f.codigo = p.codigo_fabricante;
-- Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los productos que tiene cada uno de ellos. El listado deberá mostrar también a aquellos fabricantes que no tienen productos asociados.
SELECT DISTINCT f.codigo, f.nombre, p.nombre FROM fabricante f LEFT JOIN  producto p  ON f.codigo = p.codigo_fabricante;
-- Devuelve un listado en el que sólo aparezcan aquellos fabricantes que no tienen ningún producto asociado.
SELECT DISTINCT f.codigo, f.nombre, p.nombre FROM fabricante f LEFT JOIN  producto p  ON f.codigo = p.codigo_fabricante WHERE p.nombre IS NULL;
-- Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).
SELECT * FROM producto WHERE codigo_fabricante = (SELECT codigo FROM fabricante WHERE nombre = 'Lenovo');
-- Devuelve todos los datos de los productos que tienen el mismo precio que el producto más caro del fabricante Lenovo. (Sin utilizar INNER JOIN).
SELECT * FROM producto WHERE precio = (SELECT precio from producto WHERE codigo_fabricante =(SELECT codigo FROM fabricante WHERE nombre = 'Lenovo') ORDER BY precio DESC LIMIT 1);
-- Lista el nombre del producto más caro del fabricante Lenovo.
SELECT nombre from producto WHERE codigo_fabricante =(SELECT codigo FROM fabricante WHERE nombre = 'Lenovo') ORDER BY precio DESC LIMIT 1;
-- Lista el nombre del producto más barato del fabricante Hewlett-Packard.
SELECT nombre from producto WHERE codigo_fabricante =(SELECT codigo FROM fabricante WHERE nombre = 'Hewlett-Packard') ORDER BY precio ASC LIMIT 1;
-- Devuelve todos los productos de la base de datos que tienen un precio mayor o igual al producto más caro del fabricante Lenovo.
SELECT * FROM producto WHERE precio >= (SELECT precio from producto WHERE codigo_fabricante =(SELECT codigo FROM fabricante WHERE nombre = 'Lenovo') ORDER BY precio DESC LIMIT 1);
-- Lista todos los productos del fabricante Asus que tienen un precio superior al precio medio de todos sus productos.
SELECT * FROM producto WHERE precio >= (SELECT AVG(precio) from producto WHERE codigo_fabricante =(SELECT codigo FROM fabricante WHERE nombre = 'Asus'));