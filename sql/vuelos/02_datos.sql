-- Vuelos: datos de ejemplo (inventados para probar las consultas)

INSERT INTO Ciudad VALUES
    (1, 'Buenos Aires', 'Argentina'),
    (2, 'Salta',        'Argentina'),
    (3, 'Jujuy',        'Argentina'),
    (4, 'Córdoba',      'Argentina'),
    (5, 'Cancún',       'México');

INSERT INTO Aerolinea VALUES
    (1, 'Aerolíneas Argentinas', 'Argentina'),
    (2, 'LATAM',                 'Chile'),
    (3, 'Flybondi',              'Argentina');

INSERT INTO Cliente VALUES
    (1, 'Juan',  'Pérez',      'AAA111111', 'Argentina'),
    (2, 'Olena', 'Shevchenko', 'UKR222222', 'Ucrania'),
    (3, 'Lucía', 'Gómez',      'AAA333333', 'Argentina'),
    (4, 'Pedro', 'Silva',      'BRA444444', 'Brasil'),
    (5, 'Ana',   'Torres',     'AAA555555', 'Argentina');

-- AR1001 tiene capacidad para 3 pasajes y se vendieron 4 (sobreventa)
INSERT INTO Vuelo VALUES
    ('AR1001',  '2018-03-10', '08:30', 4, 1,   3, 1),
    ('AR1002',  '2018-07-22', '14:00', 1, 2, 150, 1),
    ('LA3001',  '2018-12-20', '23:15', 1, 5, 200, 2),
    ('FB2001',  '2019-01-15', '06:45', 1, 3, 180, 3),
    ('LA3002',  '2019-06-05', '22:40', 1, 5, 200, 2),
    ('LOM3524', '2019-09-09', '17:20', 2, 1, 120, 3),
    ('AR1003',  '2020-02-02', '11:10', 3, 2,  90, 1);

INSERT INTO Pasaje VALUES
    ( 1, '12A', 'AR1001',  1,  45000),
    ( 2, '12B', 'AR1001',  4,  45000),
    ( 3, '13A', 'AR1001',  3,  47000),
    ( 4, '13B', 'AR1001',  5,  47000),
    ( 5, '20C', 'AR1002',  2,  60000),
    ( 6, '21C', 'AR1002',  5,  60000),
    ( 7, '03F', 'LA3001',  1, 310000),
    ( 8, '03E', 'LA3001',  4, 310000),
    ( 9, '04A', 'LA3001',  3, 315000),
    (10, '10D', 'FB2001',  1,  52000),
    (11, '10E', 'FB2001',  5,  52000),
    (12, '07B', 'LA3002',  3, 330000),
    (13, '15A', 'LOM3524', 2,  58000),
    (14, '15B', 'LOM3524', 3,  58000),
    (15, '02C', 'AR1003',  5,  41000);
