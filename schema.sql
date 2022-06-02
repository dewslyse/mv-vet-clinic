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

-- Add column species_id which is a foreign key referencing species table
ALTER TABLE animals
ADD COLUMN species_id INT REFERENCES species (id);

-- Add column owner_id which is a foreign key referencing the owners table
ALTER TABLE animals
ADD COLUMN owner_id INT REFERENCES owners (id);

-- Vets table
CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY,
    name TEXT,
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY(id)
);

-- Join table: Specializations
CREATE TABLE specializations (
    species_id INT,
    vets_id INT,
    PRIMARY KEY (species_id, vets_id),
    FOREIGN KEY (species_id) REFERENCES species (id),
    FOREIGN KEY (vets_id) REFERENCES vets (id)
);

-- Join table: Visits
CREATE TABLE visits (
    animals_id INT,
    vets_id INT,
    date_of_visit DATE,
    PRIMARY KEY (animals_id, vets_id),
    FOREIGN KEY (animals_id) REFERENCES animals (id),
    FOREIGN KEY (vets_id) REFERENCES vets (id)
);
