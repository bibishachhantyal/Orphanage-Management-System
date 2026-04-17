-- ===================================================================
-- ORPHANAGE MANAGEMENT SYSTEM – COMPLETE QUERIES
-- Includes: CRUD, Reports, Search, Login, Dashboard, Transactions
-- ===================================================================

-- ------------------------------------------------------
-- 1. AUTHENTICATION & USER MANAGEMENT
-- ------------------------------------------------------

-- Login (check credentials and get role)
SELECT user_id, full_name, email, role, status, password_hash
FROM `user`
WHERE (email = ? OR username = ?) AND status = 'active';

-- Register new user (pending approval)
INSERT INTO `user` (full_name, username, email, password_hash, phone, role, status)
VALUES (?, ?, ?, ?, ?, 'volunteer', 'pending');

-- Get all users (admin)
SELECT user_id, full_name, email, role, status, created_at
FROM `user`
ORDER BY created_at DESC;

-- Approve a user (admin)
UPDATE `user`
SET status = 'active'
WHERE user_id = ? AND role != 'admin';

-- ------------------------------------------------------
-- 2. CHILD MANAGEMENT (CRUD)
-- ------------------------------------------------------

-- Create child
INSERT INTO child (
    full_name, date_of_birth, gender, health_status,
    education_level, admission_reason, admission_date,
    status, added_by_user_id
) VALUES (?, ?, ?, ?, ?, ?, CURDATE(), 'active', ?);

-- Read all children (with who added them)
SELECT c.*, u.full_name AS added_by_name
FROM child c
         LEFT JOIN `user` u ON c.added_by_user_id = u.user_id
ORDER BY c.child_id DESC;

-- Read single child
SELECT * FROM child WHERE child_id = ?;

-- Update child
UPDATE child
SET full_name = ?, date_of_birth = ?, gender = ?,
    health_status = ?, education_level = ?, status = ?
WHERE child_id = ?;

-- Delete child (only if no adoption/guardian links – use with care)
DELETE FROM child WHERE child_id = ?;

-- ------------------------------------------------------
-- 3. DONOR MANAGEMENT (CRUD)
-- ------------------------------------------------------

INSERT INTO donor (full_name, email, phone, address, donor_type, registered_by)
VALUES (?, ?, ?, ?, ?, ?);

SELECT * FROM donor ORDER BY donor_id DESC;

SELECT * FROM donor WHERE donor_id = ?;

UPDATE donor SET full_name = ?, email = ?, phone = ?, address = ? WHERE donor_id = ?;

DELETE FROM donor WHERE donor_id = ?;

-- ------------------------------------------------------
-- 4. DONATION MANAGEMENT (CRUD)
-- ------------------------------------------------------

INSERT INTO donation (donor_id, donation_type, amount, description, donation_date, status, received_by)
VALUES (?, ?, ?, ?, CURDATE(), 'pending', ?);

SELECT d.*, donor.full_name AS donor_name
FROM donation d
         LEFT JOIN donor ON d.donor_id = donor.donor_id
ORDER BY d.donation_id DESC;

SELECT * FROM donation WHERE donation_id = ?;

UPDATE donation SET status = 'completed', amount = ? WHERE donation_id = ?;

DELETE FROM donation WHERE donation_id = ?;

-- ------------------------------------------------------
-- 5. INVENTORY & LOGS (CRUD + logs)
-- ------------------------------------------------------

-- Add new item
INSERT INTO inventory (item_name, category, quantity, unit, last_updated, updated_by)
VALUES (?, ?, ?, ?, CURDATE(), ?);

-- View all inventory
SELECT * FROM inventory ORDER BY item_id;

-- Update quantity (add stock)
UPDATE inventory SET quantity = quantity + ?, last_updated = CURDATE(), updated_by = ? WHERE item_id = ?;

-- Remove stock (with log – done in application via transaction)
UPDATE inventory SET quantity = quantity - ?, last_updated = CURDATE(), updated_by = ? WHERE item_id = ?;

-- Log inventory action (called after stock change)
INSERT INTO inventory_log (item_id, action_type, quantity_changed, reason, performed_by)
VALUES (?, ?, ?, ?, ?);

-- View inventory logs
SELECT l.*, i.item_name
FROM inventory_log l
         JOIN inventory i ON l.item_id = i.item_id
ORDER BY l.log_date DESC;

-- ------------------------------------------------------
-- 6. REPORTS FOR ADMIN DASHBOARD (HIGH MARKS)
-- ------------------------------------------------------

-- 6.1 Children by status (active/adopted/transferred)
SELECT status, COUNT(*) AS total FROM child GROUP BY status;

-- 6.2 Monthly donation summary (current year)
SELECT
    DATE_FORMAT(donation_date, '%Y-%m') AS month,
    SUM(CASE WHEN donation_type = 'money' THEN amount ELSE 0 END) AS total_money,
    COUNT(CASE WHEN donation_type = 'goods' THEN 1 END) AS goods_count
FROM donation
WHERE YEAR(donation_date) = YEAR(CURDATE()) AND status = 'completed'
GROUP BY month
ORDER BY month DESC;

-- 6.3 Top 5 donors (by total monetary amount)
SELECT
    donor.full_name,
    SUM(donation.amount) AS total_given
FROM donation
         JOIN donor ON donation.donor_id = donor.donor_id
WHERE donation_type = 'money' AND donation.status = 'completed'
GROUP BY donor.donor_id
ORDER BY total_given DESC
    LIMIT 5;

-- 6.4 Low stock alert (quantity < 10)
SELECT item_id, item_name, category, quantity
FROM inventory
WHERE quantity < 10
ORDER BY quantity ASC;

-- 6.5 Upcoming birthdays (next 30 days)
SELECT
    child_id,
    full_name,
    date_of_birth,
    DATE_ADD(date_of_birth, INTERVAL YEAR(CURDATE()) - YEAR(date_of_birth) YEAR) AS birthday_this_year
FROM child
WHERE status = 'active'
HAVING birthday_this_year BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY);

-- 6.6 Most frequent donation items (goods)
SELECT description, COUNT(*) AS times_donated
FROM donation
WHERE donation_type = 'goods' AND status = 'completed'
GROUP BY description
ORDER BY times_donated DESC
    LIMIT 5;

-- 6.7 Staff count by department (if staff table populated)
SELECT department, COUNT(*) AS staff_count
FROM staff
WHERE status = 'active'
GROUP BY department;

-- ------------------------------------------------------
-- 7. SEARCH FEATURES
-- ------------------------------------------------------

-- Search children by name (partial match)
SELECT * FROM child WHERE full_name LIKE CONCAT('%', ?, '%');

-- Search donations by date range
SELECT * FROM donation WHERE donation_date BETWEEN ? AND ?;

-- Search inventory by item name
SELECT * FROM inventory WHERE item_name LIKE CONCAT('%', ?, '%');

-- Search donors by name
SELECT * FROM donor WHERE full_name LIKE CONCAT('%', ?, '%');

-- ------------------------------------------------------
-- 8. USER PORTAL QUERIES
-- ------------------------------------------------------

-- Get own profile
SELECT user_id, full_name, username, email, phone, role, status, created_at
FROM `user`
WHERE user_id = ?;

-- Update own profile (except password)
UPDATE `user`
SET full_name = ?, phone = ?
WHERE user_id = ?;

-- Change password
UPDATE `user`
SET password_hash = ?
WHERE user_id = ?;

-- View adoptions initiated by this guardian (if user linked to guardian)
SELECT a.*, child.full_name AS child_name
FROM adoption a
         JOIN child ON a.child_id = child.child_id
WHERE a.guardian_id = (SELECT guardian_id FROM guardian WHERE user_id = ?);

-- ------------------------------------------------------
-- 9. DASHBOARD STATISTICS CARDS (for home page)
-- ------------------------------------------------------

SELECT COUNT(*) AS total_active_children FROM child WHERE status = 'active';
SELECT COUNT(*) AS total_donations_this_month FROM donation WHERE MONTH(donation_date) = MONTH(CURDATE()) AND YEAR(donation_date) = YEAR(CURDATE()) AND status = 'completed';
SELECT COUNT(*) AS pending_user_approvals FROM `user` WHERE status = 'pending';
SELECT IFNULL(SUM(amount), 0) AS total_revenue_this_year FROM donation WHERE donation_type = 'money' AND status = 'completed' AND YEAR(donation_date) = YEAR(CURDATE());

