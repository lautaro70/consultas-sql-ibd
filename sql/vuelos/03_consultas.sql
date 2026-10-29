-- Vuelos: consultas (Práctica 5, Ejercicio 2)

-- @1 Clientes que viajaron con todas las aerolíneas
SELECT c.nombre, c.apellido, c.pasaporte, c.nacionalidad
FROM Cliente c
WHERE NOT EXISTS (
    SELECT *
    FROM Aerolinea a
    WHERE NOT EXISTS (
        SELECT *
        FROM Pasaje p
        INNER JOIN Vuelo v ON (v.codVuelo = p.codVuelo)
        WHERE (c.codCliente = p.codCliente) AND (v.codAerolinea = a.codAerolinea)
    )
);

-- @2 Cantidad de viajes con destino Buenos Aires que hizo cada cliente
SELECT c.nombre, c.apellido, c.pasaporte, c.nacionalidad, COUNT(*) AS cantidad
FROM Cliente c
INNER JOIN Pasaje p ON (p.codCliente = c.codCliente)
INNER JOIN Vuelo v ON (v.codVuelo = p.codVuelo)
INNER JOIN Ciudad ciu ON (v.cod_ciudad_destino = ciu.codCiudad)
WHERE (ciu.nombre = 'Buenos Aires')
GROUP BY c.codCliente, c.nombre, c.apellido, c.pasaporte, c.nacionalidad
ORDER BY cantidad DESC, c.apellido;

-- @3 Vuelos en los que se vendieron más pasajes que su capacidad (sobreventa)
SELECT v.codVuelo, v.fecha, v.hora, co.nombre AS origen, cd.nombre AS destino,
       v.cantidad_pasajes, COUNT(p.codReserva) AS vendidos
FROM Vuelo v
INNER JOIN Ciudad co ON (v.cod_ciudad_origen = co.codCiudad)
INNER JOIN Ciudad cd ON (v.cod_ciudad_destino = cd.codCiudad)
INNER JOIN Pasaje p ON (v.codVuelo = p.codVuelo)
GROUP BY v.codVuelo, v.fecha, v.hora, co.nombre, cd.nombre, v.cantidad_pasajes
HAVING COUNT(p.codReserva) > v.cantidad_pasajes;

-- @4 Clientes que viajaron solamente en 2018, ordenados por apellido y nombre
SELECT DISTINCT c.nombre, c.apellido, c.pasaporte, c.nacionalidad
FROM Cliente c
INNER JOIN Pasaje p ON (c.codCliente = p.codCliente)
INNER JOIN Vuelo v ON (p.codVuelo = v.codVuelo)
WHERE (YEAR(v.fecha) = 2018) AND (c.codCliente NOT IN (
    SELECT p2.codCliente
    FROM Pasaje p2
    INNER JOIN Vuelo v2 ON (p2.codVuelo = v2.codVuelo)
    WHERE (YEAR(v2.fecha) <> 2018)
))
ORDER BY c.apellido ASC, c.nombre ASC;

-- @5 Cantidad de pasajeros que llegó a cada ciudad durante 2018
SELECT ciu.nombre, ciu.pais, COUNT(p.codCliente) AS pasajeros
FROM Ciudad ciu
INNER JOIN Vuelo v ON (ciu.codCiudad = v.cod_ciudad_destino)
INNER JOIN Pasaje p ON (p.codVuelo = v.codVuelo)
WHERE (YEAR(v.fecha) = 2018)
GROUP BY ciu.codCiudad, ciu.nombre, ciu.pais
ORDER BY pasajeros DESC;

-- @6 Eliminar el vuelo LOM3524 (primero sus pasajes, porque lo referencian)
DELETE FROM Pasaje
WHERE (codVuelo = 'LOM3524');

DELETE FROM Vuelo
WHERE (codVuelo = 'LOM3524');

-- @7 Clientes que viajaron a Cancún en 2018 y no volvieron a viajar en 2019
SELECT DISTINCT c.nombre, c.apellido, c.pasaporte, c.nacionalidad
FROM Cliente c
INNER JOIN Pasaje p ON (p.codCliente = c.codCliente)
INNER JOIN Vuelo v ON (v.codVuelo = p.codVuelo)
INNER JOIN Ciudad ciu ON (ciu.codCiudad = v.cod_ciudad_destino)
WHERE (YEAR(v.fecha) = 2018) AND (ciu.nombre = 'Cancún') AND (c.codCliente NOT IN (
    SELECT p2.codCliente
    FROM Pasaje p2
    INNER JOIN Vuelo v2 ON (v2.codVuelo = p2.codVuelo)
    WHERE (YEAR(v2.fecha) = 2019)
));

-- @8 Vuelos con algún pasajero de nacionalidad ucraniana o con destino Buenos Aires
SELECT v.codVuelo, v.fecha, v.hora, v.cod_ciudad_origen, v.cod_ciudad_destino, v.cantidad_pasajes, v.codAerolinea
FROM Vuelo v
INNER JOIN Pasaje p ON (v.codVuelo = p.codVuelo)
INNER JOIN Cliente c ON (p.codCliente = c.codCliente)
WHERE (c.nacionalidad = 'Ucrania')
UNION
SELECT v.codVuelo, v.fecha, v.hora, v.cod_ciudad_origen, v.cod_ciudad_destino, v.cantidad_pasajes, v.codAerolinea
FROM Vuelo v
INNER JOIN Ciudad ciu ON (v.cod_ciudad_destino = ciu.codCiudad)
WHERE (ciu.nombre = 'Buenos Aires')
ORDER BY fecha;

-- @9 Clientes que viajaron a Salta y también a Jujuy
SELECT c.nombre, c.apellido, c.pasaporte, c.nacionalidad
FROM Cliente c
INNER JOIN Pasaje p ON (c.codCliente = p.codCliente)
INNER JOIN Vuelo v ON (v.codVuelo = p.codVuelo)
INNER JOIN Ciudad ciu ON (v.cod_ciudad_destino = ciu.codCiudad)
WHERE (ciu.nombre = 'Salta')
INTERSECT
SELECT c.nombre, c.apellido, c.pasaporte, c.nacionalidad
FROM Cliente c
INNER JOIN Pasaje p ON (c.codCliente = p.codCliente)
INNER JOIN Vuelo v ON (v.codVuelo = p.codVuelo)
INNER JOIN Ciudad ciu ON (v.cod_ciudad_destino = ciu.codCiudad)
WHERE (ciu.nombre = 'Jujuy');

-- @10 Aerolíneas que solo vuelan a destinos dentro de Argentina
SELECT DISTINCT a.nombre, a.origen
FROM Aerolinea a
INNER JOIN Vuelo v ON (v.codAerolinea = a.codAerolinea)
INNER JOIN Ciudad ciu ON (v.cod_ciudad_destino = ciu.codCiudad)
WHERE (ciu.pais = 'Argentina') AND (a.codAerolinea NOT IN (
    SELECT v2.codAerolinea
    FROM Vuelo v2
    INNER JOIN Ciudad ciu2 ON (v2.cod_ciudad_destino = ciu2.codCiudad)
    WHERE (ciu2.pais <> 'Argentina')
));
