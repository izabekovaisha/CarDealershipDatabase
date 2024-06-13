# Car Dealership Database

This project contains SQL scripts to create and populate a Car Dealership database. The database includes tables for dealerships, vehicles, inventory, sales contracts, and lease contracts. Additionally, there are test scripts to verify the integrity of the database and ensure that it has been populated correctly.

## Table of Contents

- [Database Schema](#database-schema)
- [Installation](#installation)
- [Usage](#usage)
- [Test Queries](#test-queries)
- [Contributing](#contributing)


## Database Schema

The database schema includes the following tables:

1. `dealerships` - Stores information about each dealership.
2. `vehicles` - Stores information about each vehicle.
3. `inventory` - Links vehicles to dealerships.
4. `sales_contract` - Stores information about sales contracts.
5. `lease_contract` - Stores information about lease contracts.

### Create Tables

The script `db_script.sql` contains the SQL commands to create the necessary tables.

```sql
-- Drop the database if it exists
DROP DATABASE IF EXISTS car_dealership;
 
-- Create the car_dealership database
CREATE DATABASE car_dealership;
 
-- CREATE DATABASE IF NOT EXISTS car_dealership;
 
-- Switch to the car_dealership database
USE car_dealership;
 
-- Drop tables if they exist
DROP TABLE IF EXISTS dealerships;
DROP TABLE IF EXISTS vehicles;
DROP TABLE IF EXISTS inventory;
DROP TABLE IF EXISTS sales_contracts;
DROP TABLE IF EXISTS lease_contracts;
 
-- Create the dealerships table
CREATE TABLE dealerships (
    dealership_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    address VARCHAR(50) NOT NULL,
    phone VARCHAR(20) NOT NULL
);
 
-- Create the vehicles table
CREATE TABLE vehicles (
    VIN VARCHAR(10) PRIMARY KEY NOT NULL,
    year YEAR NOT NULL,
    make VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    vehicle_type VARCHAR(20) NOT NULL,
    color VARCHAR(20) NOT NULL,
    odometer INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    SOLD BOOLEAN NOT NULL
);
 
-- Create the inventory table
CREATE TABLE inventory (
    dealership_id INT NOT NULL,
    VIN VARCHAR(10) NOT NULL,
    FOREIGN KEY (dealership_id) REFERENCES dealerships(dealership_id),
    FOREIGN KEY (VIN) REFERENCES vehicles(VIN)
);
 
-- Create the sales_contract table
CREATE TABLE sales_contract (
    sales_contract_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    VIN VARCHAR(10) NOT NULL,
    sales_tax DECIMAL(10, 2) NOT NULL,
    recording_fee DECIMAL(10, 2) NOT NULL,
    processing_fee DECIMAL(10, 2) NOT NULL,
    total_cost DECIMAL(10, 2) NOT NULL,
    finance BOOLEAN NOT NULL,
    monthly_payment DECIMAL(10, 2),
    FOREIGN KEY (VIN) REFERENCES vehicles(VIN)
);
 
-- Create the lease_contract table
CREATE TABLE lease_contract (
    lease_contract_id INT AUTO_INCREMENT NOT NULL PRIMARY KEY,
    VIN VARCHAR(10) NOT NULL,
    ending_value DECIMAL(10, 2) NOT NULL,
    lease_fee DECIMAL(10, 2) NOT NULL,
    total_cost DECIMAL(10, 2) NOT NULL,
    monthly_payment DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (VIN) REFERENCES vehicles(VIN)
);
```

## Populate Tables
The script `db_script.sql` also contains the SQL commands to populate the tables with sample data.

```sql
-- Insert sample data into dealerships table
INSERT INTO dealerships (`name`, address, phone)
VALUES 
('D & B Used Cars', '111 Old Benrook Rd', '817-555-5555'),
('CarMax', '456 Lunar Lane', '713-555-5678'),
('EcoRides', '789 Green St', '832-555-3030'),
('Tesla Motors', '101 Diamond Dr', '650-555-6789'),
('Hendrick Chevrolet', '100 Auto Mall Dr', '919-555-4321');
 
-- Insert sample data into vehicles table
INSERT INTO vehicles (VIN, `year`, make, model, vehicle_type, color, odometer, price, SOLD)
VALUES 
('60934', 2021, 'BMW', 'X5', 'SUV', 'blue', 55500, 55000.00, TRUE),
('20486', 2018, 'Toyota', 'Camry', 'Sedan','green', 25000, 20000.00, FALSE),
('40448', 2015, 'Honda', 'Civic', 'Sedan', 'black', 35000, 18000.00, FALSE),
('70782', 2023, 'Ford', 'F-150', 'Truck', 'gray', 60000, 12000.00, TRUE),
('10123', 2020, 'Chevrolet', 'Equinox', 'SUV', 'white', 45000.00, 25000.00, FALSE);
 
-- Insert sample data into inventory table
INSERT INTO inventory (dealership_id, VIN)
VALUES 
(1, '60934'),
(2, '20486'),
(3, '40448'),
(4, '70782'),
(5, '10123');
 
-- Insert sample data into sales_contract table
INSERT INTO sales_contract (VIN, sales_tax, recording_fee, processing_fee, total_cost, finance, monthly_payment)
VALUES 
('60934', 2000.00, 100.00, 50.00, 92700.00, TRUE, 500.00), 
('20486', 2400.00, 120.00, 60.00, 13680.00, FALSE, NULL),
('40448', 1500.00, 75.00, 35.00, 19910.00, TRUE, 400.00),
('70782', 1800.00, 90.00, 45.00, 20790.00, FALSE, NULL),
('10123', 2200.00, 1110.00, 55.00, 25900.00, TRUE, 600.00);
 
-- Insert sample data into lease_contract table
INSERT INTO lease_contract (VIN, ending_value, lease_fee, total_cost, monthly_payment)
VALUES 
('60934', 15000.00, 100.00, 20100.00, 300.00), 
('20486', 12000.00, 200.00, 25200.00, 400.00),
('40448', 17000.00, 150.00, 22000.00, 350.00),
('70782', 14000.00, 120.00, 18000.00, 300.00),
('10123', 20000.00, 180.00, 27000.00, 400.00);
```

## Installation
### To set up the database:

- Clone this repository to your local machine.
- Open your MySQL client and connect to your MySQL server.
- Run the `db_script.sql` script to create the database and tables.
- Run the `db_script.sql` script to populate the tables with sample data.

## Test Queries
Several test queries have been provided to verify the correctness of the database. Each query is in its own .sql file.

### 1_script.sql:
```sql
-- Get all dealerships:
SELECT *
FROM dealerships;
```

### 2_script.sql:
```sql
-- Find all vehicles for a specific dealership:
SELECT d.name AS dealership_name, v.*
FROM dealerships d
INNER JOIN inventory i ON d.dealership_id = i.dealership_id
INNER JOIN vehicles v ON i.VIN = v.VIN
WHERE d.name = 'D & B Used Cars';
```

### 3_script.sql:
```sql
-- Find a car by VIN:
SELECT *
FROM vehicles
WHERE VIN = '60934';
```

### 4_script.sql:
```sql
-- Find the dealership where a certain car is located, by VIN:
SELECT d.*
FROM dealerships d
INNER JOIN inventory i ON d.dealership_id = i.dealership_id
WHERE i.VIN = '60934';
```

### 5_script.sql:
```sql
-- Find all dealerships that have a certain car type:
SELECT d.*
FROM dealerships d
INNER JOIN inventory i ON d.dealership_id = i.dealership_id
INNER JOIN vehicles v ON i.VIN = v.VIN
WHERE v.color = 'blue' AND v.make = 'BMW' AND v.model = 'X5';
```

### 6_script.sql:
```sql
-- Get all sales information for a specific dealer for a specific date range:
SELECT s.*
FROM sales_contract s
INNER JOIN inventory i ON s.VIN = i.VIN
INNER JOIN vehicles v ON i.VIN = v.VIN
INNER JOIN dealerships d ON d.dealership_id = i.dealership_id
WHERE d.name = 'D & B Used Cars'
AND v.year BETWEEN 2020 AND 2023;
```

## Contributing
Contributions are welcome! Please create a pull request with detailed information about the changes.






