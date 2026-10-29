-- Vuelos: esquema (Práctica 5, Ejercicio 2)

CREATE TABLE Ciudad (
    codCiudad INTEGER PRIMARY KEY,
    nombre    VARCHAR NOT NULL,
    pais      VARCHAR NOT NULL
);

CREATE TABLE Aerolinea (
    codAerolinea INTEGER PRIMARY KEY,
    nombre       VARCHAR NOT NULL,
    origen       VARCHAR
);

CREATE TABLE Cliente (
    codCliente   INTEGER PRIMARY KEY,
    nombre       VARCHAR NOT NULL,
    apellido     VARCHAR NOT NULL,
    pasaporte    VARCHAR NOT NULL UNIQUE,
    nacionalidad VARCHAR
);

CREATE TABLE Vuelo (
    codVuelo           VARCHAR PRIMARY KEY,
    fecha              DATE NOT NULL,
    hora               TIME,
    cod_ciudad_origen  INTEGER NOT NULL REFERENCES Ciudad (codCiudad),
    cod_ciudad_destino INTEGER NOT NULL REFERENCES Ciudad (codCiudad),
    cantidad_pasajes   INTEGER NOT NULL,
    codAerolinea       INTEGER NOT NULL REFERENCES Aerolinea (codAerolinea)
);

CREATE TABLE Pasaje (
    codReserva INTEGER PRIMARY KEY,
    asiento    VARCHAR,
    codVuelo   VARCHAR NOT NULL REFERENCES Vuelo (codVuelo),
    codCliente INTEGER NOT NULL REFERENCES Cliente (codCliente),
    precio     DECIMAL(10, 2)
);
