-- ===================================================================
-- DATABASE: orphanage_db
-- COURSEWORK: CS5054NP Advanced Programming & Technologies
-- DESCRIPTION: Complete schema for Orphanage Management System
-- NORMALIZATION: 3NF (Third Normal Form)
-- ===================================================================

-- Create and use database (drop existing for clean setup)
DROP DATABASE IF EXISTS orphanage_db;
CREATE DATABASE orphanage_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE orphanage_db;

-- ===============================
-- 1. USER table (authentication & roles)
-- ===============================
CREATE TABLE `user` (
                        user_id INT PRIMARY KEY AUTO_INCREMENT,
                        full_name VARCHAR(100) NOT NULL,
                        username VARCHAR(50) NOT NULL UNIQUE,
                        email VARCHAR(100) NOT NULL UNIQUE,
                        password_hash VARCHAR(255) NOT NULL,
                        phone VARCHAR(20) UNIQUE,
                        role ENUM('admin', 'staff', 'donor', 'volunteer') NOT NULL,
                        status ENUM('active', 'inactive', 'pending') DEFAULT 'pending',
                        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                        INDEX idx_email (email),
                        INDEX idx_status (status)
) ENGINE=InnoDB;

-- ===============================
-- 2. CHILD table
-- ===============================
CREATE TABLE child (
                       child_id INT PRIMARY KEY AUTO_INCREMENT,
                       full_name VARCHAR(100) NOT NULL,
                       date_of_birth DATE NOT NULL,
                       gender ENUM('Male', 'Female', 'Other') NOT NULL,
                       health_status TEXT,
                       education_level VARCHAR(100),
                       admission_reason TEXT,
                       admission_date DATE NOT NULL,
                       status ENUM('active', 'adopted', 'transferred') DEFAULT 'active',
                       added_by_user_id INT,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                       FOREIGN KEY (added_by_user_id) REFERENCES `user`(user_id) ON DELETE SET NULL,
                       INDEX idx_name (full_name),
                       INDEX idx_status (status),
                       INDEX idx_dob (date_of_birth)
) ENGINE=InnoDB;

-- ===============================
-- 3. DONOR table
-- ===============================
CREATE TABLE donor (
                       donor_id INT PRIMARY KEY AUTO_INCREMENT,
                       full_name VARCHAR(100) NOT NULL,
                       email VARCHAR(100),
                       phone VARCHAR(20),
                       address TEXT,
                       donor_type ENUM('individual', 'organization') DEFAULT 'individual',
                       registered_at DATETIME DEFAULT CURRENT_TIMESTAMP,
                       registered_by INT,
                       FOREIGN KEY (registered_by) REFERENCES `user`(user_id) ON DELETE SET NULL,
                       INDEX idx_name (full_name)
) ENGINE=InnoDB;

-- ===============================
-- 4. DONATION table
-- ===============================
CREATE TABLE donation (
                          donation_id INT PRIMARY KEY AUTO_INCREMENT,
                          donor_id INT,
                          donation_type ENUM('money', 'goods', 'service') NOT NULL,
                          amount DECIMAL(10,2),
                          description TEXT,
                          donation_date DATE NOT NULL,
                          status ENUM('pending', 'completed', 'cancelled') DEFAULT 'pending',
                          received_by INT,
                          FOREIGN KEY (donor_id) REFERENCES donor(donor_id) ON DELETE SET NULL,
                          FOREIGN KEY (received_by) REFERENCES `user`(user_id) ON DELETE SET NULL,
                          INDEX idx_date (donation_date),
                          INDEX idx_status (status)
) ENGINE=InnoDB;

-- ===============================
-- 5. STAFF table
-- ===============================
CREATE TABLE staff (
                       staff_id INT PRIMARY KEY AUTO_INCREMENT,
                       user_id INT UNIQUE,
                       position VARCHAR(100),
                       department VARCHAR(100),
                       hire_date DATE,
                       salary DECIMAL(10,2),
                       status ENUM('active', 'inactive') DEFAULT 'active',
                       FOREIGN KEY (user_id) REFERENCES `user`(user_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ===============================
-- 6. GUARDIAN table
-- ===============================
CREATE TABLE guardian (
                          guardian_id INT PRIMARY KEY AUTO_INCREMENT,
                          full_name VARCHAR(100) NOT NULL,
                          relationship VARCHAR(50),
                          phone VARCHAR(20),
                          email VARCHAR(100),
                          address TEXT,
                          id_proof_type VARCHAR(50),
                          id_proof_number VARCHAR(100),
                          INDEX idx_name (full_name)
) ENGINE=InnoDB;

-- ===============================
-- 7. CHILD_GUARDIAN (junction)
-- ===============================
CREATE TABLE child_guardian (
                                id INT PRIMARY KEY AUTO_INCREMENT,
                                child_id INT NOT NULL,
                                guardian_id INT NOT NULL,
                                assigned_date DATE,
                                notes TEXT,
                                FOREIGN KEY (child_id) REFERENCES child(child_id) ON DELETE CASCADE,
                                FOREIGN KEY (guardian_id) REFERENCES guardian(guardian_id) ON DELETE CASCADE,
                                UNIQUE KEY unique_pair (child_id, guardian_id)
) ENGINE=InnoDB;

-- ===============================
-- 8. MEDICAL_RECORD
-- ===============================
CREATE TABLE medical_record (
                                record_id INT PRIMARY KEY AUTO_INCREMENT,
                                child_id INT NOT NULL,
                                diagnosis TEXT,
                                treatment TEXT,
                                doctor_name VARCHAR(100),
                                visit_date DATE NOT NULL,
                                notes TEXT,
                                recorded_by INT,
                                FOREIGN KEY (child_id) REFERENCES child(child_id) ON DELETE CASCADE,
                                FOREIGN KEY (recorded_by) REFERENCES `user`(user_id) ON DELETE SET NULL,
                                INDEX idx_visit (visit_date)
) ENGINE=InnoDB;

-- ===============================
-- 9. EDUCATION_RECORD
-- ===============================
CREATE TABLE education_record (
                                  record_id INT PRIMARY KEY AUTO_INCREMENT,
                                  child_id INT NOT NULL,
                                  school_name VARCHAR(100),
                                  grade VARCHAR(20),
                                  academic_year VARCHAR(20),
                                  performance TEXT,
                                  notes TEXT,
                                  FOREIGN KEY (child_id) REFERENCES child(child_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ===============================
-- 10. INVENTORY
-- ===============================
CREATE TABLE inventory (
                           item_id INT PRIMARY KEY AUTO_INCREMENT,
                           item_name VARCHAR(100) NOT NULL,
                           category VARCHAR(50),
                           quantity INT NOT NULL DEFAULT 0,
                           unit VARCHAR(20),
                           last_updated DATE,
                           updated_by INT,
                           FOREIGN KEY (updated_by) REFERENCES `user`(user_id) ON DELETE SET NULL,
                           INDEX idx_category (category)
) ENGINE=InnoDB;

-- ===============================
-- 11. INVENTORY_LOG
-- ===============================
CREATE TABLE inventory_log (
                               log_id INT PRIMARY KEY AUTO_INCREMENT,
                               item_id INT NOT NULL,
                               action_type ENUM('Added', 'Removed', 'Updated') NOT NULL,
                               quantity_changed INT,
                               reason TEXT,
                               log_date DATETIME DEFAULT CURRENT_TIMESTAMP,
                               performed_by INT,
                               FOREIGN KEY (item_id) REFERENCES inventory(item_id) ON DELETE CASCADE,
                               FOREIGN KEY (performed_by) REFERENCES `user`(user_id) ON DELETE SET NULL,
                               INDEX idx_date (log_date)
) ENGINE=InnoDB;

-- ===============================
-- 12. EVENT (fixed reserved keyword with backticks)
-- ===============================
CREATE TABLE `event` (
                         event_id INT PRIMARY KEY AUTO_INCREMENT,
                         title VARCHAR(100) NOT NULL,
                         description TEXT,
                         event_date DATE NOT NULL,
                         location VARCHAR(255),
                         status ENUM('planned', 'ongoing', 'completed', 'cancelled') DEFAULT 'planned',
                         created_by INT,
                         FOREIGN KEY (created_by) REFERENCES `user`(user_id) ON DELETE SET NULL,
                         INDEX idx_date (event_date)
) ENGINE=InnoDB;

-- ===============================
-- 13. EVENT_CHILD (junction)
-- ===============================
CREATE TABLE event_child (
                             id INT PRIMARY KEY AUTO_INCREMENT,
                             event_id INT NOT NULL,
                             child_id INT NOT NULL,
                             FOREIGN KEY (event_id) REFERENCES `event`(event_id) ON DELETE CASCADE,
                             FOREIGN KEY (child_id) REFERENCES child(child_id) ON DELETE CASCADE,
                             UNIQUE KEY unique_event_child (event_id, child_id)
) ENGINE=InnoDB;

-- ===============================
-- 14. ADOPTION
-- ===============================
CREATE TABLE adoption (
                          adoption_id INT PRIMARY KEY AUTO_INCREMENT,
                          child_id INT NOT NULL,
                          guardian_id INT NOT NULL,
                          application_date DATE NOT NULL,
                          approval_date DATE,
                          status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
                          notes TEXT,
                          approved_by INT,
                          FOREIGN KEY (child_id) REFERENCES child(child_id) ON DELETE CASCADE,
                          FOREIGN KEY (guardian_id) REFERENCES guardian(guardian_id) ON DELETE CASCADE,
                          FOREIGN KEY (approved_by) REFERENCES `user`(user_id) ON DELETE SET NULL,
                          INDEX idx_status (status)
) ENGINE=InnoDB;

