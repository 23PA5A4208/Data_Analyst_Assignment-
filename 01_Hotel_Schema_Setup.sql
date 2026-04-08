-- =====================================================
-- PlatinumRx DA Assignment - Hotel Management System
-- Schema Setup Script
-- =====================================================

-- Create Database
CREATE DATABASE IF NOT EXISTS hotel_management;
USE hotel_management;

-- =====================================================
-- Table: users
-- Stores customer information
-- =====================================================
CREATE TABLE IF NOT EXISTS users (
    user_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone_number VARCHAR(15),
    mail_id VARCHAR(100),
    billing_address TEXT
);

-- =====================================================
-- Table: bookings
-- Stores room booking information
-- =====================================================
CREATE TABLE IF NOT EXISTS bookings (
    booking_id VARCHAR(50) PRIMARY KEY,
    booking_date DATETIME NOT NULL,
    room_no VARCHAR(50) NOT NULL,
    user_id VARCHAR(50),
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- =====================================================
-- Table: items
-- Stores menu items available at the hotel
-- =====================================================
CREATE TABLE IF NOT EXISTS items (
    item_id VARCHAR(50) PRIMARY KEY,
    item_name VARCHAR(100) NOT NULL,
    item_rate DECIMAL(10, 2) NOT NULL
);

-- =====================================================
-- Table: booking_commercials
-- Stores billing details for each booking
-- =====================================================
CREATE TABLE IF NOT EXISTS booking_commercials (
    id VARCHAR(50) PRIMARY KEY,
    booking_id VARCHAR(50),
    bill_id VARCHAR(50) NOT NULL,
    bill_date DATETIME NOT NULL,
    item_id VARCHAR(50),
    item_quantity DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (booking_id) REFERENCES bookings(booking_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);

-- =====================================================
-- Insert Sample Data into users
-- =====================================================
INSERT INTO users (user_id, name, phone_number, mail_id, billing_address) VALUES
('21wrcxuy-67erfn', 'John Doe', '97XXXXXXXX', 'john.doe@example.com', 'XX, Street Y, ABC City'),
('22abcxyz-12defg', 'Jane Smith', '98XXXXXXXX', 'jane.smith@example.com', 'YY, Street Z, XYZ City'),
('23pqrstu-34vwxy', 'Bob Johnson', '99XXXXXXXX', 'bob.johnson@example.com', 'ZZ, Street W, PQR City'),
('24mnopqr-56stuv', 'Alice Brown', '91XXXXXXXX', 'alice.brown@example.com', 'AA, Street B, LMN City'),
('25ghijkl-78mnop', 'Charlie Davis', '92XXXXXXXX', 'charlie.davis@example.com', 'BB, Street C, GHI City');

-- =====================================================
-- Insert Sample Data into bookings
-- =====================================================
INSERT INTO bookings (booking_id, booking_date, room_no, user_id) VALUES
('bk-09f3e-95hj', '2021-09-23 07:36:48', 'rm-bhf9-aerjn', '21wrcxuy-67erfn'),
('bk-q034-q4o', '2021-10-15 14:22:10', 'rm-xyz1-abcd2', '22abcxyz-12defg'),
('bk-nov21-001', '2021-11-05 09:15:30', 'rm-nov1-room1', '23pqrstu-34vwxy'),
('bk-nov21-002', '2021-11-18 16:45:00', 'rm-nov2-room2', '21wrcxuy-67erfn'),
('bk-oct21-001', '2021-10-20 11:30:00', 'rm-oct1-room1', '24mnopqr-56stuv'),
('bk-oct21-002', '2021-10-25 19:00:00', 'rm-oct2-room2', '25ghijkl-78mnop'),
('bk-sep21-001', '2021-09-10 08:00:00', 'rm-sep1-room1', '22abcxyz-12defg'),
('bk-nov21-003', '2021-11-28 13:20:00', 'rm-nov3-room3', '24mnopqr-56stuv'),
('bk-dec21-001', '2021-12-01 10:00:00', 'rm-dec1-room1', '21wrcxuy-67erfn'),
('bk-oct21-003', '2021-10-05 15:45:00', 'rm-oct3-room3', '23pqrstu-34vwxy');

-- =====================================================
-- Insert Sample Data into items
-- =====================================================
INSERT INTO items (item_id, item_name, item_rate) VALUES
('itm-a9e8-q8fu', 'Tawa Paratha', 18.00),
('itm-a07vh-aer8', 'Mix Veg', 89.00),
('itm-w978-23u4', 'Paneer Butter Masala', 199.00),
('itm-biryani-001', 'Chicken Biryani', 249.00),
('itm-dal-001', 'Dal Makhani', 149.00),
('itm-roti-001', 'Butter Naan', 35.00),
('itm-soup-001', 'Tomato Soup', 79.00),
('itm-salad-001', 'Green Salad', 69.00),
('itm-dessert-001', 'Gulab Jamun', 49.00),
('itm-beverage-001', 'Mango Lassi', 59.00);

-- =====================================================
-- Insert Sample Data into booking_commercials
-- =====================================================
INSERT INTO booking_commercials (id, booking_id, bill_id, bill_date, item_id, item_quantity) VALUES
('q34r-3q4o8-q34u', 'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:03:22', 'itm-a9e8-q8fu', 3),
('q3o4-ahf32-o2u4', 'bk-09f3e-95hj', 'bl-0a87y-q340', '2021-09-23 12:03:22', 'itm-a07vh-aer8', 1),
('134lr-oyfo8-3qk4', 'bk-q034-q4o', 'bl-34qhd-r7h8', '2021-09-23 12:05:37', 'itm-w978-23u4', 0.5),
('bill-oct-001', 'bk-oct21-001', 'bl-oct21-001', '2021-10-20 14:00:00', 'itm-biryani-001', 2),
('bill-oct-002', 'bk-oct21-001', 'bl-oct21-001', '2021-10-20 14:00:00', 'itm-dal-001', 1),
('bill-oct-003', 'bk-oct21-002', 'bl-oct21-002', '2021-10-25 21:00:00', 'itm-biryani-001', 4),
('bill-oct-004', 'bk-oct21-002', 'bl-oct21-002', '2021-10-25 21:00:00', 'itm-roti-001', 6),
('bill-oct-005', 'bk-oct21-003', 'bl-oct21-003', '2021-10-05 18:30:00', 'itm-paneer-001', 2),
('bill-nov-001', 'bk-nov21-001', 'bl-nov21-001', '2021-11-05 12:00:00', 'itm-soup-001', 2),
('bill-nov-002', 'bk-nov21-001', 'bl-nov21-001', '2021-11-05 12:00:00', 'itm-salad-001', 1),
('bill-nov-003', 'bk-nov21-002', 'bl-nov21-002', '2021-11-18 19:30:00', 'itm-biryani-001', 3),
('bill-nov-004', 'bk-nov21-002', 'bl-nov21-002', '2021-11-18 19:30:00', 'itm-dessert-001', 3),
('bill-nov-005', 'bk-nov21-003', 'bl-nov21-003', '2021-11-28 15:00:00', 'itm-beverage-001', 5),
('bill-sep-001', 'bk-sep21-001', 'bl-sep21-001', '2021-09-10 12:30:00', 'itm-a9e8-q8fu', 4),
('bill-sep-002', 'bk-sep21-001', 'bl-sep21-001', '2021-09-10 12:30:00', 'itm-a07vh-aer8', 2),
('bill-dec-001', 'bk-dec21-001', 'bl-dec21-001', '2021-12-01 13:00:00', 'itm-biryani-001', 2),
('bill-dec-002', 'bk-dec21-001', 'bl-dec21-001', '2021-12-01 13:00:00', 'itm-dal-001', 1),
('bill-dec-003', 'bk-dec21-001', 'bl-dec21-001', '2021-12-01 13:00:00', 'itm-roti-001', 4);

-- =====================================================
-- Verify Data Insertion
-- =====================================================
SELECT 'Users Count' as table_name, COUNT(*) as record_count FROM users
UNION ALL
SELECT 'Bookings Count', COUNT(*) FROM bookings
UNION ALL
SELECT 'Items Count', COUNT(*) FROM items
UNION ALL
SELECT 'Booking Commercials Count', COUNT(*) FROM booking_commercials;
