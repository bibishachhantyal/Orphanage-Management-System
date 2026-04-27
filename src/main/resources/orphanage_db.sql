CREATE DATABASE IF NOT EXISTS orphanage_db;
USE orphanage_db;

-- CREATE TABLE IF NOT EXISTS users (
--     id INT PRIMARY KEY AUTO_INCREMENT,
--     full_name VARCHAR(100) NOT NULL,
--     email VARCHAR(100) NOT NULL UNIQUE,
--     phone VARCHAR(20),
--     role VARCHAR(20) NOT NULL,
--     password_hash VARCHAR(255) NOT NULL,
--     password_salt VARCHAR(255) NOT NULL,
--     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
-- );
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

CREATE TABLE IF NOT EXISTS donations (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    method VARCHAR(30) NOT NULL,
    note VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_donations_user
        FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS sponsors (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    child_name VARCHAR(100) NOT NULL,
    monthly_amount DECIMAL(10, 2) NOT NULL,
    start_date DATE NOT NULL,
    note VARCHAR(255),
    CONSTRAINT fk_sponsors_user
        FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS resource_requests (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    item_name VARCHAR(100) NOT NULL,
    quantity INT NOT NULL,
    priority VARCHAR(20) NOT NULL,
    status VARCHAR(20) DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_resource_requests_user
        FOREIGN KEY (user_id) REFERENCES users(id)
        ON DELETE CASCADE
);

-- ============================================================
-- Donor Management table
-- ============================================================
CREATE TABLE IF NOT EXISTS donors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    address TEXT,
    donation_type ENUM('Individual', 'Organization') DEFAULT 'Individual',
    total_donated DECIMAL(12, 2) DEFAULT 0.00,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);
-- ============================================
-- SAMPLE DATA
-- ============================================

-- Admin account (use PasswordHasher in production)
INSERT INTO users (full_name, email, phone, password, role) VALUES
    ('System Admin', 'admin@orphanage.org', '9800000000', 'admin123', 'ADMIN');

-- Sample users
INSERT INTO users (full_name, email, phone, password, role) VALUES
                                                                ('Rajesh Sharma',   'rajesh@gmail.com',   '9801234567', 'password123', 'DONOR'),
                                                                ('Sunita Karki',    'sunita@gmail.com',   '9812345678', 'password123', 'VOLUNTEER'),
                                                                ('Bikash Tamang',   'bikash@gmail.com',   '9823456789', 'password123', 'DONOR');

-- Sample donors
INSERT INTO donors (full_name, email, phone, address, donation_type, total_donated) VALUES
                                                                                        ('Sita Thapa',            'sita@gmail.com',       '9841111111', 'Kathmandu, Nepal',   'MONETARY',  50000.00),
                                                                                        ('Ramesh Adhikari',       'ramesh.a@mail.com',     '9841222222', 'Pokhara, Nepal',     'IN_KIND',   15000.00),
                                                                                        ('Nepal Hope Foundation', 'info@nepalhope.org',    '014500000',  'Lalitpur, Nepal',    'MONETARY',  200000.00),
                                                                                        ('Anita Gurung',          'anita.g@mail.com',      '9841333333', 'Bhaktapur, Nepal',   'IN_KIND',   20000.00),
                                                                                        ('Prakash Shrestha',      'prakash@mail.com',      '9841444444', 'Patan, Nepal',       'MONETARY',  75000.00);

-- Sample donation transactions
INSERT INTO donations (user_id, amount, payment_method, note) VALUES
                                                                  (2, 5000.00,   'CASH',  'Monthly contribution'),
                                                                  (2, 10000.00,  'BANK',  'School supplies fund'),
                                                                  (3, 15000.00,  'UPI',   'Festival donation'),
                                                                  (4, 8000.00,   'CARD',  'Winter clothing drive'),
                                                                  (1, 25000.00,  'BANK',  'Annual admin donation');
