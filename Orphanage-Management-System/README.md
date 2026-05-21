# Hope Haven — Orphanage Management System

A full-stack Java web application for managing an orphanage: children in care, donors, donations, volunteers, user accounts, and admin reporting. Built as **Team 5 coursework** (Advanced Java / Web Technologies).

**Public GitHub repository:** https://github.com/bibishachhantyal/Orphanage-Management-System

---

## Team 5 — Members and roles

| Member | Role | Main contributions |
|--------|------|-------------------|
| **Bibisha Chhantyal** | Project lead, admin backend | GitHub, ER diagram, SQL schema, orphan CRUD, integration |
| **Rakshya Phagami** | Database specialist | MySQL setup, normalization, indexes, HikariCP pooling |
| **Pooja Subedi** | User backend | Login, registration, sessions, donor features, profile |
| **Krishtina Gurung** | Security & validation | BCrypt, `AuthFilter`, cookies, volunteer module, error pages |
| **Sristy Bhandari** | Frontend & report | JSP/CSS UI, wireframes, admin reports, coursework PDF |

---

## What the system does

### Public website
- Home page with charity messaging and navigation
- **Meet the children** — public profiles of *active* orphans only
- **Contact** form (stored for admin review)
- **Register** — new users (pending admin approval)
- **Login** with optional “remember me” cookie

### User portal (after login)
Roles: `USER`, `DONOR`, `VOLUNTEER` (plus `ADMIN` for staff).

- Dashboard with stats and quick links
- **Search** active children by name, guardian, or blood group (all role dashboards)
- **Wishlist** — save children of interest (USER role)
- **Profile** — update name, email, phone, address, and password
- Donors: donate and view donation records
- Volunteers: apply to volunteer, view directory

### Admin portal
- Dashboard with time-slot activity charts (CSS-based, no external JS libraries)
- **Children (orphans)** — full CRUD, status filter (active / inactive / adopted), photos & credentials
- **Donors, volunteers, donations** — CRUD modules
- **Approvals** — pending user registrations and volunteer applications; contact messages
- **Reports**
  - Donation analysis (totals, payment-method breakdown, recent entries)
  - Orphan status summary (active / inactive / adopted)
  - Volunteer activity (status counts, pending applications)

---

## Technology stack

| Layer | Technology |
|-------|------------|
| **View** | JSP, HTML5, CSS3 (Flexbox, responsive — **no Bootstrap**) |
| **Controller** | Jakarta Servlets 6 (`@WebServlet`, `@WebFilter`) |
| **Business logic** | `orphanage.service` package |
| **Data access** | `orphanage.dao` + JDBC |
| **Database** | MySQL 8 (`orphanagesystem_db`) |
| **Connection pool** | HikariCP 5 |
| **Security** | BCrypt password hashing, session-based auth |
| **Build & run** | Maven 3, Cargo embedded Tomcat 10 |
| **Java** | 17 |

---

## Architecture (MVC)

```
Browser (JSP)
    ↓
Servlet (controller)     e.g. LoginServlet, AdminOrphanServlet
    ↓
Service (business rules) e.g. UserService, OrphanService, DonationService
    ↓
DAO (SQL)                e.g. UserDAO, OrphanDAO
    ↓
MySQL (HikariCP pool)    DatabaseConnection.java
```

**Packages**
- `orphanage.servlet` — HTTP controllers
- `orphanage.service` — validation and workflows
- `orphanage.dao` — database access
- `orphanage.model` — entity beans
- `orphanage.util` — BCrypt, filters, cookies, dates

---

## Project structure

```
Orphanage-Management-System/
├── pom.xml                 # Maven build (WAR: orphanage.war)
├── database.sql            # Full schema + sample data
├── upgrade.sql             # Patch script for existing databases
├── setup-database.bat      # Windows: create DB (XAMPP)
├── run.bat                 # Build + start Tomcat on port 8081
├── stop-server.bat         # Stop Cargo/Tomcat
├── README.md               # This file
├── BUSINESS_RULES.md       # Rules for report / demo
├── docs/
│   └── er-diagram.png      # Entity-relationship diagram
└── src/main/
    ├── java/orphanage/
    │   ├── servlet/        # Controllers
    │   ├── service/        # Business logic
    │   ├── dao/            # JDBC data access
    │   ├── model/          # User, Orphan, Donation, …
    │   └── util/           # PasswordUtil, AuthFilter, …
    └── webapp/
        ├── admin/          # Admin JSPs
        ├── user/           # User portal JSPs
        ├── donation/       # Donation CRUD + reports
        ├── donor/          # Donor CRUD
        ├── volunteer/      # Volunteer CRUD
        ├── public/         # Public orphan listing
        ├── css/styles.css  # All styling
        ├── js/             # Minimal JS (password toggle, footer)
        └── WEB-INF/web.xml # Session timeout, error pages
```

---

## Database

- **Database name:** `orphanagesystem_db`
- **Main tables:** `users`, `orphans`, `donors`, `donations`, `volunteers`, `contact_messages`, `volunteer_applications`
- **Script:** run `database.sql` once (via `setup-database.bat` or MySQL client)
- **Diagram:** `docs/er-diagram.png`

Demo accounts (password for all: **`Admin@123`**):

| Username | Role | Purpose |
|----------|------|---------|
| `admin` | ADMIN | Full admin portal |
| `donor` | DONOR | Donor dashboard |
| `volunteer` | VOLUNTEER | Volunteer dashboard |
| `bibisha` | USER | General user + wishlist |

New registrations use role `USER`, `approved = 0` until an admin approves them. Passwords must be strong (e.g. `Admin@123`). **Phone numbers must be unique** when provided.

---

## Prerequisites

1. **JDK 17+** — [Adoptium](https://adoptium.net/) or Oracle JDK  
2. **Apache Maven 3.8+** — `mvn -version` must work in a terminal  
3. **XAMPP** (or MySQL 8) — MySQL service on port 3306  
4. **Git** — to clone this repository  

---

## Quick start (Windows)

1. **Clone the repository** (must be **public** on GitHub for submission):

   ```bash
   git clone https://github.com/bibishachhantyal/Orphanage-Management-System.git
   cd Orphanage-Management-System
   ```

   > If your clone contains a nested `Orphanage-Management-System` folder, `cd` into the folder that contains `pom.xml`.

2. **Start MySQL** in XAMPP Control Panel.

3. **Create the database** (first time only):

   Double-click `setup-database.bat`  
   or:

   ```bash
   "C:\xampp\mysql\bin\mysql.exe" -u root < database.sql
   ```

4. **Configure MySQL password** (if root has a password):

   Edit `src/main/java/orphanage/util/DatabaseConnection.java` — set `PASSWORD`.

5. **Run the application:**

   Double-click `run.bat`  
   or:

   ```bash
   mvn package -DskipTests
   mvn cargo:run
   ```

6. **Open in browser:**

   **http://localhost:8081/orphanage/**

7. **Log in:** `admin` / `Admin@123`

Press `Ctrl+C` in the terminal to stop the server, or use `stop-server.bat`.

---

## Important URLs

| URL | Access |
|-----|--------|
| `/` or `/home` | Public home |
| `/login`, `/register` | Authentication |
| `/public/orphans` | Active children (public) |
| `/user/dashboard` | User / donor / volunteer dashboard |
| `/user/profile` | Profile update |
| `/user/wishlist` | Saved children |
| `/donate` | Donation form (login required) |
| `/apply-volunteer` | Volunteer application (login required) |
| `/admin/dashboard` | Admin home |
| `/admin/orphan` | Orphan CRUD |
| `/admin/donation-report` | Donation analysis |
| `/admin/orphan-report` | Orphan status report |
| `/admin/volunteer-report` | Volunteer report |

Protected paths use `AuthFilter` (session required). Admin paths require role `ADMIN`.

---

## Security features

- Passwords stored as **BCrypt** hashes only (no plain-text fallback)
- **Session invalidation** on login to prevent session fixation
- **Role-based** redirect after login
- **AuthFilter** on `/admin/*`, `/user/*`, `/donation/*`, `/donor/*`, `/volunteer/*`, `/donate`, `/apply-volunteer`
- Strong password policy on register and profile password change
- Unique checks: username, email, and phone (registration and profile)

---

## Coursework checklist

| Requirement | Implementation |
|-------------|----------------|
| MVC with `util` + **`service`** packages | `orphanage.service.*` used by servlets |
| Login & registration | `LoginServlet`, `RegisterServlet`, `UserService` |
| Encrypted passwords | `PasswordUtil` + BCrypt |
| Sessions & filters | `AuthFilter`, session attributes |
| Admin CRUD (orphans) | `AdminOrphanServlet`, `OrphanService` |
| User profile update | `ProfileServlet`, `/user/profile` |
| User search | `user-search.jspf` on all user dashboards |
| Admin reports | Donation, orphan status, volunteer reports |
| Connection pooling | HikariCP in `DatabaseConnection` |
| Responsive UI without Bootstrap | `css/styles.css` only |
| Public GitHub repo | https://github.com/bibishachhantyal/Orphanage-Management-System |

---

## GitHub submission notes

1. Set the repository visibility to **Public** (Settings → Change visibility).  
2. Put this URL on your **report cover page:**  
   `https://github.com/bibishachhantyal/Orphanage-Management-System`  
3. Do **not** commit `target/`, `.idea/`, or local passwords.  
4. Recommended: keep `pom.xml` at the **repository root** when pushing (move files up if they are nested one level).

---

## Troubleshooting

| Problem | Fix |
|---------|-----|
| `mvn` not found | Install Maven and add to PATH |
| MySQL connection error | Start MySQL in XAMPP; run `setup-database.bat` |
| Login fails | Password is `Admin@123`; re-run `database.sql` |
| Port 8081 in use | Stop other Java/Tomcat processes or change port in `pom.xml` (`cargo.servlet.port`) |
| 404 on `/orphanage/` | Wait for Cargo to finish starting; check console for errors |
| Blank admin report | Ensure sample data exists — run `database.sql` |

---

## Related documentation

- **BUSINESS_RULES.md** — business rules for the report and demos  
- **upgrade.sql** — incremental DB changes for older copies of the project  

---

## License & academic use

This project was developed for educational coursework. External use beyond the course should respect your institution’s academic integrity policies.

**Hope Haven Orphanage Management System — Team 5, 2026**
