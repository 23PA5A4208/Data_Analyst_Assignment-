-- =====================================================
-- PlatinumRx DA Assignment - Clinic Management System
-- Schema Setup Script
-- =====================================================

-- Create Database
CREATE DATABASE IF NOT EXISTS clinic_management;
USE clinic_management;

-- =====================================================
-- Table: clinics
-- Stores clinic location and identification information
-- =====================================================
CREATE TABLE IF NOT EXISTS clinics (
    cid VARCHAR(50) PRIMARY KEY,
    clinic_name VARCHAR(100) NOT NULL,
    city VARCHAR(50) NOT NULL,
    state VARCHAR(50) NOT NULL,
    country VARCHAR(50) DEFAULT 'India'
);

-- =====================================================
-- Table: customer
-- Stores patient/customer information
-- =====================================================
CREATE TABLE IF NOT EXISTS customer (
    uid VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    mobile VARCHAR(15)
);

-- =====================================================
-- Table: clinic_sales
-- Stores sales transactions for each clinic
-- =====================================================
CREATE TABLE IF NOT EXISTS clinic_sales (
    oid VARCHAR(50) PRIMARY KEY,
    uid VARCHAR(50),
    cid VARCHAR(50),
    amount DECIMAL(12, 2) NOT NULL,
    datetime DATETIME NOT NULL,
    sales_channel VARCHAR(50) NOT NULL,
    FOREIGN KEY (uid) REFERENCES customer(uid),
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

-- =====================================================
-- Table: expenses
-- Stores expense records for each clinic
-- =====================================================
CREATE TABLE IF NOT EXISTS expenses (
    eid VARCHAR(50) PRIMARY KEY,
    cid VARCHAR(50),
    description VARCHAR(200),
    amount DECIMAL(12, 2) NOT NULL,
    datetime DATETIME NOT NULL,
    FOREIGN KEY (cid) REFERENCES clinics(cid)
);

-- =====================================================
-- Insert Sample Data into clinics
-- =====================================================
INSERT INTO clinics (cid, clinic_name, city, state, country) VALUES
('cnc-0100001', 'XYZ Clinic', 'Mumbai', 'Maharashtra', 'India'),
('cnc-0100002', 'ABC Health Center', 'Delhi', 'Delhi', 'India'),
('cnc-0100003', 'Sunrise Medical', 'Bangalore', 'Karnataka', 'India'),
('cnc-0100004', 'City Care Clinic', 'Mumbai', 'Maharashtra', 'India'),
('cnc-0100005', 'Green Life Hospital', 'Pune', 'Maharashtra', 'India'),
('cnc-0100006', 'Metro Diagnostics', 'Delhi', 'Delhi', 'India'),
('cnc-0100007', 'Wellness Point', 'Bangalore', 'Karnataka', 'India'),
('cnc-0100008', 'Care Plus Clinic', 'Chennai', 'Tamil Nadu', 'India'),
('cnc-0100009', 'Health First', 'Hyderabad', 'Telangana', 'India'),
('cnc-0100010', 'MediCare Center', 'Pune', 'Maharashtra', 'India');

-- =====================================================
-- Insert Sample Data into customer
-- =====================================================
INSERT INTO customer (uid, name, mobile) VALUES
('cust-001', 'Jon Doe', '97XXXXXXXX'),
('cust-002', 'Sarah Williams', '98XXXXXXXX'),
('cust-003', 'Michael Brown', '99XXXXXXXX'),
('cust-004', 'Emily Johnson', '91XXXXXXXX'),
('cust-005', 'David Lee', '92XXXXXXXX'),
('cust-006', 'Lisa Anderson', '93XXXXXXXX'),
('cust-007', 'Robert Taylor', '94XXXXXXXX'),
('cust-008', 'Jennifer Martinez', '95XXXXXXXX'),
('cust-009', 'James Wilson', '96XXXXXXXX'),
('cust-010', 'Maria Garcia', '90XXXXXXXX'),
('cust-011', 'William Davis', '88XXXXXXXX'),
('cust-012', 'Patricia Miller', '87XXXXXXXX'),
('cust-013', 'Thomas Rodriguez', '86XXXXXXXX'),
('cust-014', 'Linda Martinez', '85XXXXXXXX'),
('cust-015', 'Charles Hernandez', '84XXXXXXXX');

-- =====================================================
-- Insert Sample Data into clinic_sales
-- =====================================================
INSERT INTO clinic_sales (oid, uid, cid, amount, datetime, sales_channel) VALUES
('ord-00100-00100', 'cust-001', 'cnc-0100001', 24999.00, '2021-09-23 12:03:22', 'sodat'),
('ord-00100-00101', 'cust-002', 'cnc-0100001', 15000.00, '2021-01-15 10:30:00', 'walk-in'),
('ord-00100-00102', 'cust-003', 'cnc-0100002', 32000.00, '2021-02-20 14:45:00', 'online'),
('ord-00100-00103', 'cust-004', 'cnc-0100003', 18500.00, '2021-03-10 09:00:00', 'sodat'),
('ord-00100-00104', 'cust-005', 'cnc-0100004', 42000.00, '2021-04-05 16:20:00', 'walk-in'),
('ord-00100-00105', 'cust-006', 'cnc-0100005', 28000.00, '2021-05-12 11:15:00', 'online'),
('ord-00100-00106', 'cust-007', 'cnc-0100006', 35000.00, '2021-06-18 13:30:00', 'sodat'),
('ord-00100-00107', 'cust-008', 'cnc-0100007', 22000.00, '2021-07-25 15:45:00', 'walk-in'),
('ord-00100-00108', 'cust-009', 'cnc-0100008', 45000.00, '2021-08-08 08:30:00', 'online'),
('ord-00100-00109', 'cust-010', 'cnc-0100009', 31000.00, '2021-09-14 17:00:00', 'sodat'),
('ord-00100-00110', 'cust-011', 'cnc-0100010', 27000.00, '2021-10-22 12:00:00', 'walk-in'),
('ord-00100-00111', 'cust-012', 'cnc-0100001', 38000.00, '2021-11-05 10:45:00', 'online'),
('ord-00100-00112', 'cust-013', 'cnc-0100002', 29000.00, '2021-12-18 14:30:00', 'sodat'),
('ord-00100-00113', 'cust-014', 'cnc-0100003', 52000.00, '2021-01-28 16:00:00', 'walk-in'),
('ord-00100-00114', 'cust-015', 'cnc-0100004', 33000.00, '2021-02-14 09:15:00', 'online'),
('ord-00100-00115', 'cust-001', 'cnc-0100005', 41000.00, '2021-03-22 11:30:00', 'sodat'),
('ord-00100-00116', 'cust-002', 'cnc-0100006', 26000.00, '2021-04-30 13:45:00', 'walk-in'),
('ord-00100-00117', 'cust-003', 'cnc-0100007', 48000.00, '2021-05-15 15:00:00', 'online'),
('ord-00100-00118', 'cust-004', 'cnc-0100008', 34000.00, '2021-06-20 08:45:00', 'sodat'),
('ord-00100-00119', 'cust-005', 'cnc-0100009', 39000.00, '2021-07-10 10:00:00', 'walk-in'),
('ord-00100-00120', 'cust-006', 'cnc-0100010', 55000.00, '2021-08-25 14:15:00', 'online'),
('ord-00100-00121', 'cust-007', 'cnc-0100001', 21000.00, '2021-09-05 16:30:00', 'sodat'),
('ord-00100-00122', 'cust-008', 'cnc-0100002', 44000.00, '2021-10-12 12:45:00', 'walk-in'),
('ord-00100-00123', 'cust-009', 'cnc-0100003', 30000.00, '2021-11-20 09:30:00', 'online'),
('ord-00100-00124', 'cust-010', 'cnc-0100004', 47000.00, '2021-12-05 11:00:00', 'sodat');

-- =====================================================
-- Insert Sample Data into expenses
-- =====================================================
INSERT INTO expenses (eid, cid, description, amount, datetime) VALUES
('exp-0100-00100', 'cnc-0100001', 'first-aid supplies', 557.00, '2021-09-23 07:36:48'),
('exp-0100-00101', 'cnc-0100001', 'staff salaries', 15000.00, '2021-01-15 09:00:00'),
('exp-0100-00102', 'cnc-0100002', 'medical equipment', 22000.00, '2021-02-20 10:00:00'),
('exp-0100-00103', 'cnc-0100003', 'utility bills', 8500.00, '2021-03-10 11:00:00'),
('exp-0100-00104', 'cnc-0100004', 'rent', 25000.00, '2021-04-05 12:00:00'),
('exp-0100-00105', 'cnc-0100005', 'pharmacy stock', 18000.00, '2021-05-12 13:00:00'),
('exp-0100-00106', 'cnc-0100006', 'diagnostic tools', 28000.00, '2021-06-18 14:00:00'),
('exp-0100-00107', 'cnc-0100007', 'maintenance', 12000.00, '2021-07-25 15:00:00'),
('exp-0100-00108', 'cnc-0100008', 'staff salaries', 30000.00, '2021-08-08 16:00:00'),
('exp-0100-00109', 'cnc-0100009', 'medical supplies', 20000.00, '2021-09-14 17:00:00'),
('exp-0100-00110', 'cnc-0100010', 'equipment repair', 16000.00, '2021-10-22 18:00:00'),
('exp-0100-00111', 'cnc-0100001', 'marketing', 8000.00, '2021-11-05 19:00:00'),
('exp-0100-00112', 'cnc-0100002', 'insurance', 12000.00, '2021-12-18 20:00:00'),
('exp-0100-00113', 'cnc-0100003', 'staff training', 9500.00, '2021-01-28 21:00:00'),
('exp-0100-00114', 'cnc-0100004', 'pharmacy stock', 21000.00, '2021-02-14 22:00:00'),
('exp-0100-00115', 'cnc-0100005', 'utility bills', 11000.00, '2021-03-22 23:00:00'),
('exp-0100-00116', 'cnc-0100006', 'rent', 32000.00, '2021-04-30 08:00:00'),
('exp-0100-00117', 'cnc-0100007', 'medical equipment', 35000.00, '2021-05-15 09:30:00'),
('exp-0100-00118', 'cnc-0100008', 'maintenance', 14000.00, '2021-06-20 10:30:00'),
('exp-0100-00119', 'cnc-0100009', 'diagnostic tools', 25000.00, '2021-07-10 11:30:00'),
('exp-0100-00120', 'cnc-0100010', 'staff salaries', 38000.00, '2021-08-25 12:30:00'),
('exp-0100-00121', 'cnc-0100001', 'medical supplies', 13000.00, '2021-09-05 13:30:00'),
('exp-0100-00122', 'cnc-0100002', 'first-aid supplies', 7000.00, '2021-10-12 14:30:00'),
('exp-0100-00123', 'cnc-0100003', 'equipment repair', 15500.00, '2021-11-20 15:30:00'),
('exp-0100-00124', 'cnc-0100004', 'marketing', 9000.00, '2021-12-05 16:30:00');

-- =====================================================
-- Verify Data Insertion
-- =====================================================
SELECT 'Clinics Count' as table_name, COUNT(*) as record_count FROM clinics
UNION ALL
SELECT 'Customers Count', COUNT(*) FROM customer
UNION ALL
SELECT 'Sales Count', COUNT(*) FROM clinic_sales
UNION ALL
SELECT 'Expenses Count', COUNT(*) FROM expenses;
