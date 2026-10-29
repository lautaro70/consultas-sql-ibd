-- Centro de estética: consultas (Práctica 5, Ejercicio 1)

-- @1 Esteticistas que atendieron solamente durante 2019, ordenados por nombre, apellido y DNI
SELECT DISTINCT e.nombre, e.apellido, e.DNI, e.fecha_nac, e.especialidad
FROM Esteticista e
INNER JOIN Aplicacion a ON (e.codEst = a.codEst)
WHERE (YEAR(a.fecha) = 2019) AND e.codEst NOT IN (
    SELECT a2.codEst
    FROM Aplicacion a2
    WHERE (YEAR(a2.fecha) <> 2019)
)
ORDER BY e.nombre ASC, e.apellido ASC, e.DNI ASC;

-- @2 Edad promedio de los clientes a los que se les aplicó algún producto cuyo nombre termina en 'ura'
SELECT AVG(c.edad) AS promedio_edad
FROM Cliente c
WHERE c.codCliente IN (
    SELECT a.codCliente
    FROM Aplicacion a
    INNER JOIN ProductoAplicado pa ON (a.nroAplicacion = pa.nroAplicacion)
    INNER JOIN Producto p ON (pa.codProd = p.codProd)
    WHERE (p.nombreP LIKE '%ura')
);

-- @3 Cantidad de veces que se aplicó cada producto (incluidos los que nunca se aplicaron), de menor a mayor
SELECT p.nombreP, p.descripcion, p.stock, p.precio, COUNT(pa.nroAplicacion) AS cantidad
FROM Producto p
LEFT JOIN ProductoAplicado pa ON (p.codProd = pa.codProd)
GROUP BY p.codProd, p.nombreP, p.descripcion, p.stock, p.precio
ORDER BY cantidad ASC, p.nombreP ASC;

-- @4 Esteticistas que nunca atendieron a clientes menores de 25 años
SELECT e.nombre, e.apellido, e.DNI, e.fecha_nac, e.especialidad
FROM Esteticista e
WHERE e.codEst NOT IN (
    SELECT a.codEst
    FROM Aplicacion a
    INNER JOIN Cliente c ON (c.codCliente = a.codCliente)
    WHERE (c.edad < 25)
)
ORDER BY e.apellido, e.nombre;

-- @5 Aumentar un 20 % el precio del producto 'tintura'
UPDATE Producto
SET precio = precio * 1.20
WHERE (nombreP = 'tintura');

-- @6 Clientes que fueron atendidos en 2018 y no en 2019
SELECT DISTINCT c.nombreYAp, c.DNI, c.telefono, c.direccion, c.sexo, c.edad
FROM Cliente c
INNER JOIN Aplicacion a ON (c.codCliente = a.codCliente)
WHERE (YEAR(a.fecha) = 2018) AND c.codCliente NOT IN (
    SELECT a2.codCliente
    FROM Aplicacion a2
    WHERE (YEAR(a2.fecha) = 2019)
);

-- @7 Productos aplicados a clientas (sexo femenino) que además alguna vez se aplicaron a un precio menor a $500
SELECT p.nombreP, p.descripcion, p.stock, p.precio
FROM Producto p
INNER JOIN ProductoAplicado pa ON (p.codProd = pa.codProd)
INNER JOIN Aplicacion a ON (pa.nroAplicacion = a.nroAplicacion)
INNER JOIN Cliente c ON (a.codCliente = c.codCliente)
WHERE (c.sexo = 'Femenino')
INTERSECT
SELECT p.nombreP, p.descripcion, p.stock, p.precio
FROM Producto p
INNER JOIN ProductoAplicado pa ON (p.codProd = pa.codProd)
WHERE (pa.precio < 500);

-- @8 Productos aplicados al cliente con DNI 38329663
SELECT DISTINCT p.nombreP, p.descripcion, p.stock, p.precio
FROM Producto p
INNER JOIN ProductoAplicado pa ON (p.codProd = pa.codProd)
INNER JOIN Aplicacion a ON (pa.nroAplicacion = a.nroAplicacion)
INNER JOIN Cliente c ON (a.codCliente = c.codCliente)
WHERE (c.DNI = 38329663);

-- @9 Productos que fueron aplicados por todas las esteticistas
SELECT p.nombreP, p.descripcion, p.stock, p.precio
FROM Producto p
WHERE NOT EXISTS (
    SELECT *
    FROM Esteticista e
    WHERE NOT EXISTS (
        SELECT *
        FROM Aplicacion a
        INNER JOIN ProductoAplicado pa ON (a.nroAplicacion = pa.nroAplicacion)
        WHERE (a.codEst = e.codEst) AND (pa.codProd = p.codProd)
    )
);

-- @10 Cliente que más dinero gastó en el centro de estética
SELECT c.nombreYAp, c.DNI, c.telefono, c.direccion, c.sexo, c.edad, SUM(a.costoTotal) AS total_gastado
FROM Cliente c
INNER JOIN Aplicacion a ON (c.codCliente = a.codCliente)
GROUP BY c.codCliente, c.nombreYAp, c.DNI, c.telefono, c.direccion, c.sexo, c.edad
HAVING SUM(a.costoTotal) >= ALL (
    SELECT SUM(a2.costoTotal)
    FROM Aplicacion a2
    GROUP BY a2.codCliente
);
