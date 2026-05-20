-- =====================================================
-- Orphanage Management System – Complete Database Setup
-- =====================================================

CREATE DATABASE IF NOT EXISTS orphanagesystem_db;
USE orphanagesystem_db;

-- 1. Users table
CREATE TABLE users (
                       id INT AUTO_INCREMENT PRIMARY KEY,
                       username VARCHAR(50) NOT NULL UNIQUE,
                       email VARCHAR(100) NOT NULL UNIQUE,
                       password_hash VARCHAR(255) NOT NULL,
                       role ENUM('ADMIN','USER','DONOR','VOLUNTEER') DEFAULT 'USER',
                       approved TINYINT(1) NOT NULL DEFAULT 0,
                       full_name VARCHAR(100) DEFAULT NULL,
                       phone VARCHAR(20) DEFAULT NULL,
                       address TEXT DEFAULT NULL,
                       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE contact_messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    subject VARCHAR(200) NOT NULL,
    message TEXT NOT NULL,
    submitted_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status ENUM('unread', 'read') DEFAULT 'unread'
);

CREATE TABLE volunteer_applications (
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

-- 2. Orphans table (photo + credential-style fields for admin / detail screens)
CREATE TABLE orphans (
                         orphan_id INT AUTO_INCREMENT PRIMARY KEY,
                         first_name VARCHAR(60) NOT NULL,
                         last_name VARCHAR(60) NOT NULL,
                         date_of_birth DATE NOT NULL,
                         gender ENUM('Male','Female','Other') NOT NULL,
                         health_status VARCHAR(100) DEFAULT 'Good',
                         education_level VARCHAR(50) DEFAULT 'None',
                         enrollment_date DATE,
                         status ENUM('active','inactive','adopted') DEFAULT 'active',
                         notes TEXT,
                         photo_path VARCHAR(255) DEFAULT 'images/orphans/placeholder.svg',
                         birth_certificate_ref VARCHAR(80) DEFAULT NULL,
                         blood_group VARCHAR(10) DEFAULT NULL,
                         guardian_name VARCHAR(100) DEFAULT NULL,
                         guardian_phone VARCHAR(30) DEFAULT NULL
);

-- 3. Donors table
CREATE TABLE donors (
                        id INT AUTO_INCREMENT PRIMARY KEY,
                        full_name VARCHAR(100) NOT NULL,
                        email VARCHAR(100) NOT NULL UNIQUE,
                        phone VARCHAR(20),
                        address TEXT,
                        donor_type ENUM('Individual','Corporate') DEFAULT 'Individual'
);

-- 4. Volunteers table
CREATE TABLE volunteers (
                            id INT AUTO_INCREMENT PRIMARY KEY,
                            full_name VARCHAR(100) NOT NULL,
                            email VARCHAR(100) NOT NULL UNIQUE,
                            phone VARCHAR(20),
                            skill_area VARCHAR(100),
                            availability VARCHAR(100),
                            joined_date DATE,
                            status ENUM('Active','Inactive') DEFAULT 'Active'
);

-- 5. Donations table (foreign keys to donors and orphans)
CREATE TABLE donations (
                           id INT AUTO_INCREMENT PRIMARY KEY,
                           donor_id INT NOT NULL,
                           orphan_id INT NULL,
                           amount DECIMAL(12,2) NOT NULL,
                           donation_date DATE NOT NULL,
                           payment_method ENUM('Cash','Bank Transfer','Online') DEFAULT 'Cash',
                           purpose VARCHAR(200),
                           FOREIGN KEY (donor_id) REFERENCES donors(id),
                           FOREIGN KEY (orphan_id) REFERENCES orphans(orphan_id) ON DELETE SET NULL
);

-- =====================================================
-- SAMPLE DATA (many records for realistic testing)
-- =====================================================

-- Demo logins — password: Admin@123 (BCrypt)
INSERT INTO users (username, email, password_hash, role, approved, full_name) VALUES
('admin', 'admin@hopehaven.org', '$2a$10$/HEJ8Jf6bw5HN9TavQ8YbeLeL3qNCPa91AMAhG9BhLMJORZqLhrsu', 'ADMIN', 1, 'System Administrator'),
('donor', 'donor@hopehaven.org', '$2a$10$/HEJ8Jf6bw5HN9TavQ8YbeLeL3qNCPa91AMAhG9BhLMJORZqLhrsu', 'DONOR', 1, 'Demo Donor'),
('volunteer', 'volunteer@hopehaven.org', '$2a$10$/HEJ8Jf6bw5HN9TavQ8YbeLeL3qNCPa91AMAhG9BhLMJORZqLhrsu', 'VOLUNTEER', 1, 'Demo Volunteer'),
('bibisha', 'bibisha.chhantyal@hopehaven.org', '$2a$10$/HEJ8Jf6bw5HN9TavQ8YbeLeL3qNCPa91AMAhG9BhLMJORZqLhrsu', 'USER', 1, 'Bibisha Chhantyal');

-- ORPHANS (15 records) — sample credential fields for demos
INSERT INTO orphans (first_name, last_name, date_of_birth, gender, health_status, education_level, enrollment_date, status, notes, photo_path, birth_certificate_ref, blood_group, guardian_name, guardian_phone) VALUES
('Ram', 'Thapa', '2015-03-12', 'Male', 'Good', 'Grade 2', '2020-01-10', 'active', 'Enjoys drawing', 'images/orphans/placeholder.svg', 'BC-NP-2015-0312-M', 'O+', 'Sita Thapa', '9801110001'),
('Sita', 'Rai', '2013-07-25', 'Female', 'Good', 'Grade 4', '2019-06-15', 'active', 'Excellent in maths', 'images/orphans/placeholder.svg', 'BC-NP-2013-0725-F', 'A+', 'Ramesh Rai', '9801110002'),
('Hari', 'Shrestha', '2016-11-01', 'Male', 'Healthy', 'Grade 1', '2021-02-20', 'active', 'Loves cricket', 'images/orphans/placeholder.svg', 'BC-NP-2016-1101-M', 'B+', 'Laxmi Shrestha', '9801110003'),
('Gita', 'Karki', '2012-04-18', 'Female', 'Good', 'Grade 5', '2018-09-05', 'active', 'Participates in debate', 'images/orphans/placeholder.svg', 'BC-NP-2012-0418-F', 'AB+', 'Govinda Karki', '9801110004'),
('Bikash', 'Tamang', '2017-08-30', 'Male', 'Good', 'Kindergarten', '2022-03-11', 'active', 'Very active child', 'images/orphans/placeholder.svg', 'BC-NP-2017-0830-M', 'O-', 'Mina Tamang', '9801110005'),
('Sunita', 'Magar', '2014-02-14', 'Female', 'Average', 'Grade 3', '2020-11-20', 'active', 'Needs extra care', 'images/orphans/placeholder.svg', 'BC-NP-2014-0214-F', 'A-', 'Bimal Magar', '9801110006'),
('Krishna', 'Gurung', '2011-06-22', 'Male', 'Good', 'Grade 6', '2018-01-25', 'adopted', 'Adopted in 2024', 'images/orphans/placeholder.svg', 'BC-NP-2011-0622-M', 'B-', 'Office guardian record', '9801110007'),
('Maya', 'Pun', '2018-05-05', 'Female', 'Good', 'Kindergarten', '2023-07-10', 'active', 'Loves painting', 'images/orphans/placeholder.svg', 'BC-NP-2018-0505-F', 'O+', 'Sarita Pun', '9801110008'),
('Raj', 'Limbu', '2010-09-09', 'Male', 'Good', 'Grade 7', '2017-03-15', 'active', 'Represents school in sports', 'images/orphans/placeholder.svg', 'BC-NP-2010-0909-M', 'A+', 'Tanka Limbu', '9801110009'),
('Anita', 'Subedi', '2016-12-12', 'Female', 'Good', 'Grade 2', '2021-10-01', 'active', 'Good at music', 'images/orphans/placeholder.svg', 'BC-NP-2016-1212-F', 'B+', 'Uma Subedi', '9801110010'),
('Prabin', 'Bista', '2014-10-10', 'Male', 'Healthy', 'Grade 3', '2020-06-18', 'active', 'Very curious', 'images/orphans/placeholder.svg', 'BC-NP-2014-1010-M', 'O+', 'Kamal Bista', '9801110011'),
('Rina', 'Dahal', '2013-01-20', 'Female', 'Good', 'Grade 4', '2019-08-22', 'active', 'High academic performance', 'images/orphans/placeholder.svg', 'BC-NP-2013-0120-F', 'A-', 'Sushma Dahal', '9801110012'),
('Suman', 'Adhikari', '2015-04-15', 'Male', 'Average', 'Grade 2', '2021-02-28', 'inactive', 'Temporarily transferred', 'images/orphans/placeholder.svg', 'BC-NP-2015-0415-M', 'B+', 'Hari Adhikari', '9801110013'),
('Priya', 'Oli', '2017-07-07', 'Female', 'Good', 'Grade 1', '2023-01-14', 'active', 'Always smiling', 'images/orphans/placeholder.svg', 'BC-NP-2017-0707-F', 'O+', 'Sabita Oli', '9801110014'),
('Aashish', 'Shahi', '2012-11-11', 'Male', 'Good', 'Grade 6', '2018-09-09', 'active', 'Sports enthusiast', 'images/orphans/placeholder.svg', 'BC-NP-2012-1111-M', 'AB-', 'Rupa Shahi', '9801110015');

-- DONORS (20 records)
INSERT INTO donors (full_name, email, phone, address, donor_type) VALUES
                                                                      ('Rajesh Kumar', 'rajesh@gmail.com', '9801234567', 'Kathmandu, Nepal', 'Individual'),
                                                                      ('ABC Foundation', 'info@abcfound.org', '9809876543', 'Pokhara, Nepal', 'Corporate'),
                                                                      ('Sunita Maharjan', 'sunita@yahoo.com', '9851234567', 'Lalitpur, Nepal', 'Individual'),
                                                                      ('Hari Prasad Neupane', 'hari@gmail.com', '9841234567', 'Biratnagar, Nepal', 'Individual'),
                                                                      ('Global Aid Org', 'contact@globalaid.org', '9812345678', 'New York, USA', 'Corporate'),
                                                                      ('Ram Sharan Upreti', 'ram@samaj.com', '9861234567', 'Butwal, Nepal', 'Individual'),
                                                                      ('Women for Children', 'wfc@women.org', '9823456789', 'Kathmandu, Nepal', 'Corporate'),
                                                                      ('Sita Devi Pokharel', 'sita@donate.com', '9801112222', 'Hetauda, Nepal', 'Individual'),
                                                                      ('Helping Hands NGO', 'help@hands.org', '9812223333', 'London, UK', 'Corporate'),
                                                                      ('Gopal Thapa', 'gopal@gmail.com', '9843334444', 'Nepalgunj, Nepal', 'Individual'),
                                                                      ('Education For All', 'efa@global.org', '9804445555', 'Delhi, India', 'Corporate'),
                                                                      ('Mina Basnet', 'mina@yahoo.com', '9855556666', 'Dharan, Nepal', 'Individual'),
                                                                      ('Rotary Club Kathmandu', 'rotary@club.org', '9816667777', 'Kathmandu, Nepal', 'Corporate'),
                                                                      ('Ramesh Silwal', 'ramesh@silwal.com', '9847778888', 'Chitwan, Nepal', 'Individual'),
                                                                      ('Lions Club Intl', 'lions@club.com', '9828889999', 'Chicago, USA', 'Corporate'),
                                                                      ('Shova Tandukar', 'shova@gmail.com', '9800001111', 'Bhaktapur, Nepal', 'Individual'),
                                                                      ('UNICEF Nepal', 'unicef@nepal.org', '9811112222', 'Kathmandu, Nepal', 'Corporate'),
                                                                      ('Kiran Rai', 'kiran@rai.com', '9842223333', 'Dhulikhel, Nepal', 'Individual'),
                                                                      ('Care Nepal', 'care@nepal.org', '9803334444', 'Pokhara, Nepal', 'Corporate'),
                                                                      ('Bishnu Adhikari', 'bishnu@gmail.com', '9854445555', 'Janakpur, Nepal', 'Individual');

-- VOLUNTEERS (15 records)
INSERT INTO volunteers (full_name, email, phone, skill_area, availability, joined_date, status) VALUES
                                                                                                    ('Priya Shrestha', 'priya@gmail.com', '9841111111', 'Teaching', 'Weekends', '2023-01-15', 'Active'),
                                                                                                    ('Arjun Pandey', 'arjun@gmail.com', '9842222222', 'Healthcare', 'Weekday Mornings', '2023-03-20', 'Active'),
                                                                                                    ('Meera Adhikari', 'meera@gmail.com', '9843333333', 'Counseling', 'Flexible', '2023-06-01', 'Active'),
                                                                                                    ('Sagar Neupane', 'sagar@gmail.com', '9844444444', 'Sports Coaching', 'Evenings', '2023-07-10', 'Active'),
                                                                                                    ('Anu Thapa', 'anu@gmail.com', '9855555555', 'Art Therapy', 'Weekends', '2023-09-05', 'Active'),
                                                                                                    ('Ramesh Khadka', 'ramesh@gmail.com', '9866666666', 'Maintenance', 'Weekday Afternoons', '2024-01-20', 'Active'),
                                                                                                    ('Sita Dhital', 'sita@volunteer.com', '9877777777', 'Food Distribution', 'Weekends', '2024-02-14', 'Active'),
                                                                                                    ('Krishna Jamarkattel', 'krishna@gmail.com', '9888888888', 'Teaching Assistant', 'Mornings', '2024-03-01', 'Active'),
                                                                                                    ('Rita Gautam', 'rita@gmail.com', '9899999999', 'Child Care', 'Evenings', '2024-04-10', 'Inactive'),
                                                                                                    ('Hari Bohara', 'hari@gmail.com', '9801010101', 'Computer Training', 'Weekends', '2024-05-15', 'Active'),
                                                                                                    ('Goma Sunar', 'goma@gmail.com', '9812121212', 'Music', 'Evenings', '2024-06-05', 'Active'),
                                                                                                    ('Dilip Shrestha', 'dilip@gmail.com', '9823232323', 'Library Management', 'Weekdays', '2024-07-20', 'Active'),
                                                                                                    ('Sabina K.C.', 'sabina@gmail.com', '9834343434', 'Health Checkup', 'Weekend Mornings', '2024-08-01', 'Active'),
                                                                                                    ('Bikram Basnet', 'bikram@gmail.com', '9845454545', 'Event Planning', 'Flexible', '2024-09-10', 'Active'),
                                                                                                    ('Manisha Rijal', 'manisha@gmail.com', '9856565656', 'Tutoring', 'Evenings', '2024-10-01', 'Active');

-- DONATIONS (25 records – some linked to a specific orphan, some general)
INSERT INTO donations (donor_id, orphan_id, amount, donation_date, payment_method, purpose) VALUES
                                                                                                (1, 1, 25000.00, '2024-01-15', 'Bank Transfer', 'Education support for Ram'),
                                                                                                (2, NULL, 100000.00, '2024-02-10', 'Online', 'General orphanage fund'),
                                                                                                (3, 2, 15000.00, '2024-03-05', 'Cash', 'School supplies for Sita'),
                                                                                                (4, 3, 5000.00, '2024-03-20', 'Cash', 'Winter clothes'),
                                                                                                (5, NULL, 75000.00, '2024-04-01', 'Bank Transfer', 'Medical fund'),
                                                                                                (6, 4, 12000.00, '2024-04-15', 'Online', 'Books and stationery'),
                                                                                                (7, NULL, 200000.00, '2024-05-10', 'Bank Transfer', 'Building renovation'),
                                                                                                (8, 5, 8000.00, '2024-05-22', 'Cash', 'Birthday gift for Bikash'),
                                                                                                (1, 6, 30000.00, '2024-06-05', 'Online', 'Nutrition program'),
                                                                                                (3, 7, 10000.00, '2024-06-18', 'Bank Transfer', 'Tuition fees'),
                                                                                                (9, NULL, 50000.00, '2024-07-01', 'Cash', 'Festival support'),
                                                                                                (10, 8, 6000.00, '2024-07-15', 'Online', 'Art supplies for Maya'),
                                                                                                (2, 9, 40000.00, '2024-08-02', 'Bank Transfer', 'Sports equipment'),
                                                                                                (11, NULL, 120000.00, '2024-08-20', 'Online', 'New computer lab'),
                                                                                                (12, 10, 7500.00, '2024-09-05', 'Cash', 'Music instruments for Anita'),
                                                                                                (5, 11, 22000.00, '2024-09-18', 'Bank Transfer', 'Health checkup camp'),
                                                                                                (13, NULL, 35000.00, '2024-10-01', 'Online', 'Emergency fund'),
                                                                                                (14, 12, 9000.00, '2024-10-15', 'Cash', 'Exam support'),
                                                                                                (6, 13, 18000.00, '2024-11-02', 'Bank Transfer', 'Winter blankets'),
                                                                                                (15, NULL, 60000.00, '2024-11-20', 'Online', 'Orphanage vehicle'),
                                                                                                (7, 14, 12500.00, '2024-12-05', 'Cash', 'Educational tour for Priya'),
                                                                                                (16, 15, 5500.00, '2024-12-15', 'Online', 'Textbooks'),
                                                                                                (8, 1, 20000.00, '2025-01-10', 'Bank Transfer', 'Continued education for Ram'),
                                                                                                (17, NULL, 300000.00, '2025-01-25', 'Online', 'New building construction'),
                                                                                                (18, 2, 25000.00, '2025-02-10', 'Cash', 'Special needs support for Sita');

-- Additional donations for current year (2026)
INSERT INTO donations (donor_id, orphan_id, amount, donation_date, payment_method, purpose) VALUES
                                                                                                (4, 3, 7500.00, '2026-03-01', 'Cash', 'School bag and uniform'),
                                                                                                (9, 5, 15000.00, '2026-03-15', 'Bank Transfer', 'Hygiene kit project'),
                                                                                                (11, NULL, 80000.00, '2026-04-05', 'Online', 'Staff training program'),
                                                                                                (19, 7, 12000.00, '2026-04-20', 'Cash', 'Medical checkup camp'),
                                                                                                (20, 9, 10000.00, '2026-05-01', 'Online', 'Sports day event');

-- =====================================================
-- Upgrade (run manually if you already created the old schema)
-- =====================================================
-- ALTER TABLE orphans ADD COLUMN photo_path VARCHAR(255) DEFAULT 'images/orphans/placeholder.svg' AFTER notes;
-- ALTER TABLE orphans ADD COLUMN birth_certificate_ref VARCHAR(80) DEFAULT NULL AFTER photo_path;
-- ALTER TABLE orphans ADD COLUMN blood_group VARCHAR(10) DEFAULT NULL AFTER birth_certificate_ref;
-- ALTER TABLE orphans ADD COLUMN guardian_name VARCHAR(100) DEFAULT NULL AFTER blood_group;
-- ALTER TABLE orphans ADD COLUMN guardian_phone VARCHAR(30) DEFAULT NULL AFTER guardian_name;

-- =====================================================
-- End of script
-- =====================================================