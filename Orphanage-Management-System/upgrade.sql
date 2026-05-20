-- =====================================================
-- Orphanage Management System — Schema upgrade
-- Run after database.sql on an existing database
-- =====================================================

USE orphanagesystem_db;

-- User approval and profile fields (ignore "Duplicate column" if re-running)
ALTER TABLE users ADD COLUMN approved TINYINT(1) NOT NULL DEFAULT 0;
ALTER TABLE users ADD COLUMN full_name VARCHAR(100) DEFAULT NULL;
ALTER TABLE users ADD COLUMN phone VARCHAR(20) DEFAULT NULL;
ALTER TABLE users ADD COLUMN address TEXT DEFAULT NULL;

-- Existing demo accounts should be able to log in immediately
UPDATE users SET approved = 1 WHERE role = 'ADMIN';
UPDATE users SET approved = 1 WHERE username IN ('admin', 'bibisha');

-- Reset demo passwords to Admin@123 (BCrypt)
UPDATE users SET password_hash = '$2a$10$/HEJ8Jf6bw5HN9TavQ8YbeLeL3qNCPa91AMAhG9BhLMJORZqLhrsu'
WHERE username IN ('admin', 'bibisha', 'donor', 'volunteer');

-- Extend roles for donor and volunteer logins
ALTER TABLE users MODIFY role ENUM('ADMIN','USER','DONOR','VOLUNTEER') DEFAULT 'USER';

INSERT IGNORE INTO users (username, email, password_hash, role, approved, full_name) VALUES
('donor', 'donor@hopehaven.org', '$2a$10$/HEJ8Jf6bw5HN9TavQ8YbeLeL3qNCPa91AMAhG9BhLMJORZqLhrsu', 'DONOR', 1, 'Demo Donor'),
('volunteer', 'volunteer@hopehaven.org', '$2a$10$/HEJ8Jf6bw5HN9TavQ8YbeLeL3qNCPa91AMAhG9BhLMJORZqLhrsu', 'VOLUNTEER', 1, 'Demo Volunteer');

UPDATE users SET approved = 1, role = 'DONOR' WHERE username = 'donor';
UPDATE users SET approved = 1, role = 'VOLUNTEER' WHERE username = 'volunteer';

CREATE TABLE IF NOT EXISTS contact_messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    subject VARCHAR(200) NOT NULL,
    message TEXT NOT NULL,
    submitted_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('unread', 'read') DEFAULT 'unread'
);

CREATE TABLE IF NOT EXISTS volunteer_applications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    skill_area VARCHAR(100),
    availability VARCHAR(100),
    message TEXT,
    submitted_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending'
);
