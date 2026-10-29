-- Centro de estética: datos de ejemplo (inventados para probar las consultas)

INSERT INTO Cliente VALUES
    (1, 'Laura Fernández', 40111222, '221-555-0101', 'Calle 7 N° 1234, La Plata', 'Femenino', 23),
    (2, 'Martín López',    30222333, '221-555-0102', 'Calle 50 N° 456, La Plata', 'Masculino', 34),
    (3, 'Sofía Romero',    25333444, '221-555-0103', 'Av. 13 N° 789, La Plata', 'Femenino', 41),
    (4, 'Julián Castro',   35444555, '221-555-0104', 'Calle 12 N° 321, City Bell', 'Masculino', 29),
    (5, 'Valeria Sosa',    38329663, '221-555-0105', 'Calle 1 N° 654, Ensenada', 'Femenino', 27);

INSERT INTO Esteticista VALUES
    (1, 'Ana',   'Gómez', 28111000, '1985-04-12', 'Coloración'),
    (2, 'Bruno', 'Díaz',  31222000, '1990-09-30', 'Manicuría'),
    (3, 'Carla', 'Ruiz',  33333000, '1993-01-18', 'Pedicuría'),
    (4, 'Diego', 'Paz',   36444000, '1997-06-05', 'Cosmetología');

INSERT INTO Producto VALUES
    (1, 'tintura',          'Tintura permanente',        40, 1200),
    (2, 'manicura',         'Kit de manicura',           25,  900),
    (3, 'pedicura',         'Kit de pedicura',           20, 1100),
    (4, 'esmalte',          'Esmalte semipermanente',    60,  450),
    (5, 'crema hidratante', 'Crema hidratante de manos', 30,  700),
    (6, 'mascarilla',       'Mascarilla facial',         15,  800);

INSERT INTO Aplicacion VALUES
    (1, 2, 2, 1150, '2018-05-10'),
    (2, 2, 4, 1200, '2018-11-03'),
    (3, 1, 1, 2100, '2019-03-15'),
    (4, 1, 3,  900, '2019-07-20'),
    (5, 2, 5, 1800, '2019-09-02'),
    (6, 3, 5, 1430, '2020-02-14'),
    (7, 3, 3, 1300, '2020-06-30'),
    (8, 1, 1, 2100, '2019-12-01'),
    (9, 4, 4, 1650, '2021-04-10');

INSERT INTO ProductoAplicado VALUES
    (1, 4, 1,  450), (1, 5, 1,  700),
    (2, 1, 1, 1200),
    (3, 1, 1, 1200), (3, 4, 2,  450),
    (4, 2, 1,  900),
    (5, 3, 1, 1100), (5, 5, 1,  700),
    (6, 4, 1,  480), (6, 2, 1,  950),
    (7, 1, 1, 1300),
    (8, 1, 1, 1200), (8, 2, 1,  900),
    (9, 4, 1,  500), (9, 3, 1, 1150);
