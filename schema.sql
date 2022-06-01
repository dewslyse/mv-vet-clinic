/* Database schema to keep the structure of entire database. */

-- Owners table
CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name TEXT,
    age INT,
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
    PRIMARY KEY(id)
);

ALTER TABLE animals
ADD COLUMN species TEXT;
