CREATE DATABASE clinic;

-- Patients table
CREATE TABLE patients (
  id INT GENERATED ALWAYS AS IDENTITY,
  name VARCHAR(255),
  date_of_birth DATE,
  PRIMARY KEY(id)
);

-- Medical history table
CREATE TABLE medical_histories (
  id INT GENERATED ALWAYS AS IDENTITY,
  admitted_at TIMESTAMP(0),
  patient_id INT,
  status VARCHAR(255),
  PRIMARY KEY(id)
);

-- Treatments table
CREATE TABLE treatments (
  id INT GENERATED ALWAYS AS IDENTITY,
  type VARCHAR(255),
  name VARCHAR(255),
  PRIMARY KEY(id)
);
