create database heathcare_db;
use heathcare_db;
-- Creat patients table
CREATE TABLE patients (
    patient_id INTEGER PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    date_of_birth DATE,
    gender TEXT,
    address TEXT,
    city TEXT,
    state TEXT,
    zip_code TEXT
);
-- Create doctors table
CREATE TABLE doctors (
    doctor_id INTEGER PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    specialty TEXT
);
-- Create admissions table
CREATE TABLE admissions (
    admission_id INTEGER PRIMARY KEY,
    patient_id INTEGER,
    admission_date DATE,
    discharge_date DATE,
    doctor_id INTEGER,
    diagnosis TEXT,
    FOREIGN KEY (patient_id) REFERENCES patients (patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors (doctor_id)
);
-- Create treatments table
CREATE TABLE treatments (
    treatment_id INTEGER PRIMARY KEY,
    admission_id INTEGER,
    treatment_date DATE,
    treatment_description TEXT,
    treatment_cost REAL,
    FOREIGN KEY (admission_id) REFERENCES admissions (admission_id)
);

-- the analysis will be performed using sample data only

-- Insert data into patients table
INSERT INTO patients (patient_id, first_name, last_name, date_of_birth, gender, address, city, state, zip_code)
VALUES
(1, 'Akash', 'Debnath', '2010-05-21', 'Male', '86, LN road', 'Kolkata', 'West Bengal', '700065'),
(2, 'Tania', 'Debnath', '2004-12-17', 'Female', '456 Agb layout', 'Bangalore', 'Karnataka', '560090');

-- Insert data into doctors table
INSERT INTO doctors (doctor_id, first_name, last_name, specialty)
VALUES
(1, 'Dr. Vikram', 'Sen', 'Cardiology'),
(2, 'Dr. Sanjeev', 'Kapoor', 'Neurology');

-- Insert data into admissions table
INSERT INTO admissions (admission_id, patient_id, admission_date, discharge_date, doctor_id, diagnosis)
VALUES
(1, 1, '2023-05-01', '2023-05-10', 1, 'Heart Disease'),
(2, 2, '2023-05-15', '2023-05-20', 2, 'Migraine');

-- Insert data into treatments table
INSERT INTO treatments (treatment_id, admission_id, treatment_date, treatment_description, treatment_cost)
VALUES
(1, 1, '2023-05-02', 'Blood Test', 700.00),
(2, 1, '2023-05-03', 'X-Ray', 500.00),
(3, 2, '2023-05-16', 'MRI Scan', 1500.00),
(4, 2, '2023-05-17', 'Medication', 200.00);


-- performing analytics

-- Total admissions by Doctors
-- This query will provide the total number of admissions handled by each doctor. This helps in understanding which doctors have higher patient loads.
SELECT d.doctor_id, d.first_name, d.last_name, COUNT(a.admission_id) AS total_admissions
FROM doctors d
JOIN admissions a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.first_name, d.last_name;

-- Average Treatment Cost per Admission
-- This query calculates the average treatment cost for each admission. It helps in identifying admissions that are more costly on average.
SELECT a.admission_id, AVG(t.treatment_cost) AS average_treatment_cost
FROM admissions a
JOIN treatments t ON a.admission_id = t.admission_id
GROUP BY a.admission_id;

-- Patient Demographics
-- This query provides the total number of patients grouped by gender. It helps in understanding the gender distribution of the patients.
SELECT gender, COUNT(patient_id) AS total_patients
FROM patients
GROUP BY gender;

-- Total Treatment Costs per Patient
-- This query calculates the total treatment costs incurred by each patient. It helps in identifying patients who have incurred higher healthcare costs.
SELECT p.patient_id, p.first_name, p.last_name, SUM(t.treatment_cost) AS total_treatment_cost
FROM patients p
JOIN admissions a ON p.patient_id = a.patient_id
JOIN treatments t ON a.admission_id = t.admission_id
GROUP BY p.patient_id, p.first_name, p.last_name;

-- Number of Admissions per Specialty
-- This query shows the number of admissions handled by doctors of each specialty. It helps in understanding which specialties are most in demand.
SELECT d.specialty, COUNT(a.admission_id) AS total_admissions
FROM doctors d
JOIN admissions a ON d.doctor_id = a.doctor_id
GROUP BY d.specialty;

-- Most Common Diagnoses
-- This query identifies the most common diagnoses among patients. It helps in focusing on the most frequent health issues.
SELECT a.diagnosis, COUNT(a.admission_id) AS total_cases
FROM admissions a
GROUP BY a.diagnosis
ORDER BY total_cases DESC
LIMIT 5;

-- Total Number of Treatments by Treatment Type
-- This query counts the total number of each type of treatment performed. It helps in understanding the most commonly performed treatments.
SELECT t.treatment_description, COUNT(t.treatment_id) AS total_treatments
FROM treatments t
GROUP BY t.treatment_description
ORDER BY total_treatments DESC;

-- Top Treatments by Cost
-- This query identifies the most expensive treatments based on the average cost. It helps in understanding which treatments are the costliest.
SELECT t.treatment_description, AVG(t.treatment_cost) AS average_cost
FROM treatments t
GROUP BY t.treatment_description
ORDER BY average_cost DESC
LIMIT 5;

-- Inserting more data into the tables
INSERT INTO patients (patient_id, first_name, last_name, date_of_birth, gender, address, city, state, zip_code)
VALUES
(3, 'Anita', 'Rao', '1990-01-15', 'Female', '789 Pine St', 'Bangalore', 'Karnataka', '560001'),
(4, 'Ravi', 'Kumar', '1985-03-25', 'Male', '101 Cherry St', 'Chennai', 'Tamil Nadu', '600001'),
(5, 'Sneha', 'Patel', '1978-07-30', 'Female', '202 Birch St', 'Ahmedabad', 'Gujarat', '380001'),
(6, 'Amit', 'Sharma', '1965-11-10', 'Male', '303 Maple St', 'Mumbai', 'Maharashtra', '400001'),
(7, 'Priya', 'Mehta', '1995-05-22', 'Female', '404 Oak St', 'Delhi', 'Delhi', '110001');

INSERT INTO doctors (doctor_id, first_name, last_name, specialty)
VALUES
(3, 'Dr. Suresh', 'Naik', 'Orthopedics'),
(4, 'Dr. Kavita', 'Iyer', 'Dermatology'),
(5, 'Dr. Rajesh', 'Verma', 'Pediatrics'),
(6, 'Dr. Neha', 'Agarwal', 'Oncology'),
(7, 'Dr. Amit', 'Singh', 'Gastroenterology');

INSERT INTO admissions (admission_id, patient_id, admission_date, discharge_date, doctor_id, diagnosis)
VALUES
(3, 3, '2023-06-01', '2023-06-10', 3, 'Fracture'),
(4, 4, '2023-06-15', '2023-06-20', 4, 'Skin Allergy'),
(5, 5, '2023-06-25', '2023-07-05', 5, 'Bronchitis'),
(6, 6, '2023-07-10', '2023-07-20', 6, 'Lung Cancer'),
(7, 7, '2023-07-22', '2023-07-30', 7, 'Gastritis');

INSERT INTO treatments (treatment_id, admission_id, treatment_date, treatment_description, treatment_cost)
VALUES
(5, 3, '2023-06-02', 'X-Ray', 300.00),
(6, 3, '2023-06-03', 'Cast Application', 500.00),
(7, 4, '2023-06-16', 'Skin Biopsy', 400.00),
(8, 4, '2023-06-17', 'Medication', 200.00),
(9, 5, '2023-06-26', 'Chest X-Ray', 250.00),
(10, 5, '2023-06-27', 'Nebulization', 150.00),
(11, 6, '2023-07-11', 'CT Scan', 700.00),
(12, 6, '2023-07-12', 'Chemotherapy', 1500.00),
(13, 7, '2023-07-23', 'Endoscopy', 800.00),
(14, 7, '2023-07-24', 'Medication', 100.00);











