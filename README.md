# Orphanage Management System (Standalone)

## 1) Build
```bash
mvn clean package
```

## 2) Run locally (Tomcat via Cargo)
```bash
mvn clean package cargo:run
```

Then open:
`http://localhost:8080/OrphanageManagementSystem/login`

## 3) MySQL setup for your Member 3 User Backend
Import your database schema (provided by Member 1):
* File location expected by this project: `src/main/resources/orphanage_db.sql`
* Replace the placeholder SQL in that file with Member 1’s real `orphanage_db.sql`.

### Required DB tables (Member 3)
The User Backend DAOs expect at least these tables/columns (names must match Member 1’s SQL):
* `users(id, full_name, email, phone, role, password_hash, password_salt)`
* `donations(id, user_id, amount, method, note, ...)`
* `sponsors(id, user_id, child_name, monthly_amount, start_date, note, ...)`
* `resource_requests(id, user_id, item_name, quantity, priority, status, ...)`

### Connection credentials
This project reads DB connection from environment variables:
* `ORPHANAGE_DB_URL`
* `ORPHANAGE_DB_USER`
* `ORPHANAGE_DB_PASSWORD`

If not set, it defaults to:
* `jdbc:mysql://localhost:3306/orphanage_db`
* user `root`
* empty password

## 4) Notes for coursework submission
Each member should commit only their own code changes to GitHub.

