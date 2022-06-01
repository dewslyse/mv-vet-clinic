/* Database schema to keep the structure of entire database. */

-- Owners table
CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name TEXT,
    age INT,
    PRIMARY KEY(id)
);

-- Species table
CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name TEXT,
    PRIMARY KEY(id)
);

-- Animals table
CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name TEXT NOT NULL,
    date_of_birth DATE,
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL NOT NULL,
    species TEXT,
    PRIMARY KEY(id)
);

-- Remove species column from animals table
ALTER TABLE animals
DROP COLUMN species;
