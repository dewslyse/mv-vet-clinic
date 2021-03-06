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
  PRIMARY KEY(id),
  FOREIGN KEY (patients_id) REFERENCES patients(id)
);

-- Treatments table
CREATE TABLE treatments (
  id INT GENERATED ALWAYS AS IDENTITY,
  type VARCHAR(255),
  name VARCHAR(255),
  PRIMARY KEY(id)
);

-- Invoices table
CREATE TABLE invoices (
  id INT GENERATED ALWAYS AS IDENTITY,
  total_amount DECIMAL,
  generated_at TIMESTAMP(0),
  payed_at TIMESTAMP(0),
  medical_history_id INT,
  FOREIGN KEY (medical_history_id) REFERENCES medical_histories(id)
);

-- Invoices items table
CREATE TABLE invoice_items (
  id INT GENERATED ALWAYS AS IDENTITY,
  unit_price DECIMAL,
  quantity INT,
  total_price DECIMAL,
  invoice_id INT,
  treatment_id INT,
  PRIMARY KEY(id),
  FOREIGN KEY (invoice_id) REFERENCES invoices(id),
  FOREIGN KEY (treatment_id) REFERENCES treatments(id)
);

-- Join Table
CREATE TABLE medical_histories_treatments (
  id SERIAL PRIMARY KEY,
  medical_histories_id INT,
  treatment_id INT,
  FOREIGN KEY (medical_histories_id) REFERENCES medical_histories(id),
  FOREIGN KEY (treatment_id) REFERENCES treatments(id)
)

-- Foreign Key Indexes
CREATE INDEX medical_histories_index ON medical_histories(id);

CREATE INDEX patients_index ON patients(id);

CREATE INDEX treatments_index ON treatments(id);

CREATE INDEX invoices_index ON invoices(id);

CREATE INDEX ON medical_histories_treatments(treatment_id, medical_histories_id);
