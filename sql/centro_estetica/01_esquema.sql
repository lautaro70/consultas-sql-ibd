-- Centro de estética: esquema (Práctica 5, Ejercicio 1)

CREATE TABLE Cliente (
    codCliente  INTEGER PRIMARY KEY,
    nombreYAp   VARCHAR NOT NULL,
    DNI         INTEGER NOT NULL UNIQUE,
    telefono    VARCHAR,
    direccion   VARCHAR,
    sexo        VARCHAR,
    edad        INTEGER
);

CREATE TABLE Esteticista (
    codEst       INTEGER PRIMARY KEY,
    nombre       VARCHAR NOT NULL,
    apellido     VARCHAR NOT NULL,
    DNI          INTEGER NOT NULL UNIQUE,
    fecha_nac    DATE,
    especialidad VARCHAR
);

CREATE TABLE Producto (
    codProd     INTEGER PRIMARY KEY,
    nombreP     VARCHAR NOT NULL,
    descripcion VARCHAR,
    stock       INTEGER,
    precio      DECIMAL(10, 2)
);

CREATE TABLE Aplicacion (
    nroAplicacion INTEGER PRIMARY KEY,
    codEst        INTEGER NOT NULL REFERENCES Esteticista (codEst),
    codCliente    INTEGER NOT NULL REFERENCES Cliente (codCliente),
    costoTotal    DECIMAL(10, 2),
    fecha         DATE NOT NULL
);

-- precio: precio del producto al momento de la aplicación
CREATE TABLE ProductoAplicado (
    nroAplicacion INTEGER NOT NULL REFERENCES Aplicacion (nroAplicacion),
    codProd       INTEGER NOT NULL REFERENCES Producto (codProd),
    cantidad      INTEGER NOT NULL,
    precio        DECIMAL(10, 2) NOT NULL,
    PRIMARY KEY (nroAplicacion, codProd)
);
