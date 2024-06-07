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
    phone VARCHAR(10) NOT NULL
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
    monthly_payment DECIMAL(10, 2) NOT NULL,
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