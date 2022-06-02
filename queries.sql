/*Queries that provide answers to the questions from all projects.*/

/*Animals whose names ends in "mon"*/
SELECT * FROM animals WHERE name LIKE '%mon';

/*Names of animals born between 2016 and 2019*/
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';

/*Names of animals that are neutered and have less than 3 escape attempts*/
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;

/*Date of birth of all animals named either "Agumon" or "Pikachu"*/
SELECT date_of_birth FROM animals WHERE name = 'Agumon' OR name = 'Pikachu';

/*Name and escape attempts of animals that weigh more than 10.5kg*/
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;

/*All animals that are neutered*/
SELECT * FROM animals WHERE neutered = true;

/*All animals not named Gabumon*/
SELECT * FROM animals WHERE name != 'Gabumon';

/*Animals with a weight between 10.4kg and 17.3kg (including the animals with the weights that equals precisely 10.4kg or 17.3kg)*/
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

-- Update and revert species column
BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- Update species column with 'digimon' or 'pokemon'
BEGIN;
UPDATE animals SET species = 'digimon'
WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon'
WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

-- Delete all records then roll back transaction
BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

-- Create a savepoint
BEGIN;
DELETE FROM animals
WHERE date_of_birth > '2022-01-01';
SAVEPOINT before_2022;

UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO before_2022;

UPDATE animals SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
COMMIT;

-- How many animals are there?
SELECT COUNT(*) FROM animals;

-- How many animals have never tried to escape?
SELECT COUNT(*) FROM animals
WHERE escape_attempts = 0;

-- What is the average weight of animals?
SELECT AVG(weight_kg) FROM animals;

-- Who escapes the most, neutered or not neutered animals?
SELECT neutered, COUNT(escape_attempts) FROM animals
GROUP BY neutered;

-- What is the minimum and maximum weight of each type of animal?
SELECT species, MIN(weight_kg), MAX(weight_kg) FROM animals
GROUP BY species;

-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species, AVG(escape_attempts) FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-01-01'
GROUP BY species;

/*Query multiple tables*/
-- What animals belong to Melody Pond?
SELECT animals.name FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name FROM animals
JOIN species ON animals.species_id = species.id
WHERE species.name = 'Pokemon';

-- List all owners and their animals
SELECT owners.full_name, animals.name FROM animals
FULL JOIN owners ON animals.owner_id = owners.id;

-- How many animals are there per species?
SELECT species.name, COUNT(*) FROM species
JOIN animals ON species.id = animals.species_id
GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name FROM animals
JOIN owners ON animals.owner_id = owners.id
JOIN species ON animals.species_id = species.id
WHERE owners.full_name = 'Jennifer Orwell' AND species.name = 'Digimon';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name FROM animals
JOIN owners ON animals.owner_id = owners.id
WHERE owners.full_name = 'Dean Winchester' AND animals.escape_attempts = 0;

-- Who owns the most animals?
SELECT owners.full_name FROM owners
JOIN animals ON owners.id = animals.owner_id
GROUP BY owners.full_name
ORDER BY COUNT(*) DESC
LIMIT 1;
