CREATE DATABASE IF NOT EXISTS ev_analysis;
USE ev_analysis;

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

-- JOIN
SELECT v.make, v.model, c.charger_type, c.charge_time_mins
FROM vehicles v
JOIN charging_sessions c ON v.vehicle_id = c.vehicle_id;

-- AGGREGATE
SELECT charger_type, AVG(charge_time_mins) AS avg_charge_time_mins
FROM charging_sessions
GROUP BY charger_type
ORDER BY avg_charge_time_mins;

-- FILTER + SORT
SELECT make, model, rated_range_km
FROM vehicles
WHERE vehicle_type = 'SUV'
ORDER BY rated_range_km DESC;

-- SUBQUERY
SELECT make, model, efficiency_wh_per_km
FROM vehicles
WHERE efficiency_wh_per_km < (SELECT AVG(efficiency_wh_per_km) FROM vehicles);
