-- Smart Gym Management System Database Schema
CREATE DATABASE IF NOT EXISTS gym_db;
USE gym_db;

-- Users table for authentication (Admin and Staff)
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    role ENUM('admin', 'staff') DEFAULT 'staff',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Plans table
CREATE TABLE plans (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    duration INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    description TEXT,
    status ENUM('active', 'inactive') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Trainers table
CREATE TABLE trainers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    specialization VARCHAR(100),
    mobile VARCHAR(15),
    email VARCHAR(100),
    experience INT,
    salary DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Members table (with login capability)
CREATE TABLE members (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    age INT,
    gender ENUM('Male', 'Female', 'Other'),
    mobile VARCHAR(15) UNIQUE,
    email VARCHAR(100),
    password VARCHAR(255),
    plan_id INT,
    trainer_id INT,
    join_date DATE NOT NULL,
    expiry_date DATE,
    status ENUM('active', 'inactive', 'expired') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Attendance table
CREATE TABLE attendance (
    id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    date DATE NOT NULL,
    status ENUM('present', 'absent') DEFAULT 'present',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Payments table
CREATE TABLE payments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    member_id INT NOT NULL,
    plan_id INT,
    amount DECIMAL(10,2) NOT NULL,
    payment_method ENUM('cash', 'card', 'upi', 'bank_transfer') DEFAULT 'cash',
    payment_date DATE NOT NULL,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert default admin user (password: admin123)
INSERT INTO users (username, password, role) VALUES 
('admin', '$2a$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi', 'admin');

-- Insert sample plans
INSERT INTO plans (name, duration, price, description) VALUES 
('Basic Plan', 30, 1500.00, 'Access to gym equipment and basic facilities'),
('Premium Plan', 30, 2500.00, 'Access to all facilities including personal trainer sessions'),
('Annual Plan', 365, 15000.00, 'Full year access with all premium benefits'),
('Student Plan', 30, 1000.00, 'Special discounted plan for students');

-- Insert sample trainers
INSERT INTO trainers (name, specialization, mobile, email, experience, salary) VALUES 
('John Smith', 'Weight Training', '9876543210', 'john@gym.com', 5, 25000.00),
('Sarah Johnson', 'Cardio & Fitness', '9876543211', 'sarah@gym.com', 3, 22000.00),
('Mike Wilson', 'Yoga & Flexibility', '9876543212', 'mike@gym.com', 7, 28000.00);

-- Insert sample members (password: member123 for all)
INSERT INTO members (name, age, gender, mobile, email, password, plan_id, trainer_id, join_date, expiry_date, status) VALUES 
('Alice Brown', 25, 'Female', '9876543213', 'alice@email.com', '$2a$10$vegBSD.8FFY9j7.ubGLl.OLfj81L8g9bXQkwRCFWC/RVHqC5VY94.', 1, 1, '2024-01-15', '2024-02-14', 'active'),
('Bob Davis', 30, 'Male', '9876543214', 'bob@email.com', '$2a$10$vegBSD.8FFY9j7.ubGLl.OLfj81L8g9bXQkwRCFWC/RVHqC5VY94.', 2, 2, '2024-01-20', '2024-02-19', 'active'),
('Carol White', 28, 'Female', '9876543215', 'carol@email.com', '$2a$10$vegBSD.8FFY9j7.ubGLl.OLfj81L8g9bXQkwRCFWC/RVHqC5VY94.', 3, 3, '2024-02-01', '2025-02-01', 'active'),
('David Green', 35, 'Male', '9876543216', 'david@email.com', '$2a$10$vegBSD.8FFY9j7.ubGLl.OLfj81L8g9bXQkwRCFWC/RVHqC5VY94.', 1, 1, '2024-02-10', '2024-03-11', 'active');

-- Insert sample attendance records
INSERT INTO attendance (member_id, date, status) VALUES 
(1, '2024-01-16 09:00:00', 'present'),
(1, '2024-01-17 09:00:00', 'present'),
(2, '2024-01-21 10:00:00', 'present'),
(2, '2024-01-22 10:00:00', 'absent'),
(3, '2024-02-02 08:00:00', 'present'),
(4, '2024-02-11 07:00:00', 'present');

-- Insert sample payments
INSERT INTO payments (member_id, plan_id, amount, payment_method, payment_date, notes) VALUES 
(1, 1, 1500.00, 'cash', '2024-01-15', 'Initial payment'),
(2, 2, 2500.00, 'card', '2024-01-20', 'Credit card payment'),
(3, 3, 15000.00, 'bank_transfer', '2024-02-01', 'Annual plan payment'),
(4, 1, 1500.00, 'upi', '2024-02-10', 'UPI payment');