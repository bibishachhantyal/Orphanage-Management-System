# Database Schema Documentation

## Overview
The Orphanage Management System uses a MySQL database named `orphanage_db` with 14 normalized tables (3NF). The schema supports user authentication, child management, donations, volunteers, inventory, events, and adoptions.

## Complete List of Tables

| Table | Purpose |
|-------|---------|
| `user` | User authentication and roles (admin, staff, donor, volunteer) |
| `child` | Orphaned children details (personal, health, education) |
| `donor` | Donor information (individuals and organizations) |
| `donation` | Donation records (money, goods, service) |
| `staff` | Staff profiles linked to users |
| `guardian` | Potential adoptive parents/guardians |
| `child_guardian` | Junction table: many-to-many between child and guardian |
| `medical_record` | Health history of each child |
| `education_record` | Schooling and academic progress |
| `inventory` | Items in stock (food, clothes, supplies) |
| `inventory_log` | Audit log for inventory changes |
| `event` | Special events (fundraisers, outings) |
| `event_child` | Junction table: which children attended which events |
| `adoption` | Adoption applications and status tracking |

## Key Relationships

- `user` → `child` (one-to-many: added_by_user_id)
- `user` → `donation` (one-to-many: received_by)
- `user` → `staff` (one-to-one)
- `donor` → `donation` (one-to-many)
- `child` → `medical_record`, `education_record` (one-to-many)
- `child` ↔ `guardian` (many-to-many via child_guardian)
- `inventory` → `inventory_log` (one-to-many)
- `event` ↔ `child` (many-to-many via event_child)
- `child` → `adoption` (one-to-one)

## Sample Data (for testing)

### Insert an admin user (password_hash is placeholder – replace with actual hash in production)
```sql
INSERT INTO `user` (full_name, username, email, password_hash, phone, role, status)
VALUES ('System Admin', 'admin', 'admin@orphanage.com', 'dummy_hash', '0000000000', 'admin', 'active');

INSERT INTO child (full_name, date_of_birth, gender, health_status, admission_date, added_by_user_id)
VALUES ('Test Child', '2018-05-10', 'Male', 'Good', CURDATE(), 1);

INSERT INTO donor (full_name, email, donor_type) VALUES ('John Doe', 'john@example.com', 'individual');
INSERT INTO donation (donor_id, donation_type, amount, donation_date, status, received_by)
VALUES (1, 'money', 1000.00, CURDATE(), 'completed', 1);