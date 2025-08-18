-- Crear base de datos
DROP DATABASE IF EXISTS periodic_table;
CREATE DATABASE periodic_table;
\c periodic_table

-- Tabla types
CREATE TABLE types(
  type_id SERIAL PRIMARY KEY,
  type VARCHAR(30) NOT NULL UNIQUE
);

-- Tabla elements
CREATE TABLE elements(
  atomic_number INT PRIMARY KEY,
  symbol VARCHAR(5) NOT NULL UNIQUE,
  name VARCHAR(30) NOT NULL UNIQUE
);

-- Tabla properties
CREATE TABLE properties(
  atomic_number INT PRIMARY KEY,
  type_id INT NOT NULL,
  atomic_mass NUMERIC NOT NULL,
  melting_point_celsius NUMERIC,
  boiling_point_celsius NUMERIC,
  FOREIGN KEY(atomic_number) REFERENCES elements(atomic_number),
  FOREIGN KEY(type_id) REFERENCES types(type_id)
);

-- Insertar types
INSERT INTO types(type) VALUES
('metal'), ('nonmetal'), ('metalloid');

-- Insertar elementos base
INSERT INTO elements(atomic_number, symbol, name) VALUES
(1, 'H', 'Hydrogen'),
(2, 'He', 'Helium'),
(3, 'Li', 'Lithium');

-- Insertar propiedades
INSERT INTO properties(atomic_number, type_id, atomic_mass, melting_point_celsius, boiling_point_celsius) VALUES
(1, 2, 1.008, -259.1, -252.9),
(2, 2, 4.0026, -272.2, -268.9),
(3, 1, 6.94, 180.5, 1342);
