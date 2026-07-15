-- ============================================
-- EV Charge & Range Analysis - Database Schema
-- ============================================

CREATE DATABASE IF NOT EXISTS ev_analysis;
USE ev_analysis;

-- ============================================
-- TABLE CREATION
-- ============================================

CREATE TABLE vehicles (
    vehicle_id INT PRIMARY KEY,
    make VARCHAR(50),
    model VARCHAR(50),
    year INT,
    vehicle_type VARCHAR(30),
    battery_capacity_kwh FLOAT,
    rated_range_km FLOAT,
    efficiency_wh_per_km FLOAT,
    price_inr FLOAT
);

CREATE TABLE charging_sessions (
    session_id INT PRIMARY KEY,
    vehicle_id INT,
    charger_type VARCHAR(30),
    charging_power_kw FLOAT,
    start_percent INT,
    end_percent INT,
    charge_time_mins INT,
    temperature_c INT,
    city VARCHAR(50),
    session_date DATE,
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id)
);

-- ============================================
-- DATA IMPORT
-- Use MySQL Workbench "Table Data Import Wizard"
-- on vehicles.csv and charging_sessions.csv,
-- or run the LOAD DATA commands below
-- (update file paths to match your machine)
-- ============================================

-- LOAD DATA INFILE 'path/to/vehicles.csv'
-- INTO TABLE vehicles
-- FIELDS TERMINATED BY ','
-- ENCLOSED BY '"'
-- LINES TERMINATED BY '\n'
-- IGNORE 1 ROWS;

-- LOAD DATA INFILE 'path/to/charging_sessions.csv'
-- INTO TABLE charging_sessions
-- FIELDS TERMINATED BY ','
-- ENCLOSED BY '"'
-- LINES TERMINATED BY '\n'
-- IGNORE 1 ROWS;

-- ============================================
-- SQL OPERATIONS
-- ============================================

-- 1. JOIN: vehicle details with their charging sessions
SELECT v.make, v.model, c.charger_type, c.charge_time_mins
FROM vehicles v
JOIN charging_sessions c ON v.vehicle_id = c.vehicle_id;

-- 2. AGGREGATE: average charge time by charger type
SELECT charger_type, AVG(charge_time_mins) AS avg_charge_time_mins
FROM charging_sessions
GROUP BY charger_type
ORDER BY avg_charge_time_mins;

-- 3. FILTER + SORT: SUVs sorted by rated range
SELECT make, model, rated_range_km
FROM vehicles
WHERE vehicle_type = 'SUV'
ORDER BY rated_range_km DESC;

-- 4. SUBQUERY: vehicles more efficient than the average
SELECT make, model, efficiency_wh_per_km
FROM vehicles
WHERE efficiency_wh_per_km < (SELECT AVG(efficiency_wh_per_km) FROM vehicles);

-- 5. AGGREGATE + JOIN: average charge time per vehicle make
SELECT v.make, AVG(c.charge_time_mins) AS avg_charge_time_mins
FROM vehicles v
JOIN charging_sessions c ON v.vehicle_id = c.vehicle_id
GROUP BY v.make
ORDER BY avg_charge_time_mins;

-- 6. COUNT: number of charging sessions per city
SELECT city, COUNT(*) AS session_count
FROM charging_sessions
GROUP BY city
ORDER BY session_count DESC;

-- 7. CASE / conditional bucketing: temperature buckets
SELECT
    CASE
        WHEN temperature_c < 25 THEN 'Cool (<25C)'
        WHEN temperature_c < 35 THEN 'Moderate (25-35C)'
        ELSE 'Hot (>35C)'
    END AS temp_bucket,
    AVG(charge_time_mins) AS avg_charge_time_mins
FROM charging_sessions
GROUP BY temp_bucket;

-- 8. Range efficiency ranking (top 5 most range-efficient vehicles)
SELECT make, model, rated_range_km, battery_capacity_kwh,
       ROUND(rated_range_km / battery_capacity_kwh, 2) AS km_per_kwh
FROM vehicles
ORDER BY km_per_kwh DESC
LIMIT 5;
