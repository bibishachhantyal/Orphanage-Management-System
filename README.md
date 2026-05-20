# 🏠 Orphanage Management System – Milestone 1

> A complete web application for managing orphanages, donors, volunteers, and donations. Built with JSP, Servlets, MySQL, and Maven.  
> **Milestone 1 submission – May 4, 2026**

---

## 👥 Team 5 Members & Roles

| Member | Role | Responsibilities |
|--------|------|------------------|
| **Bibisha Chhantyal** (Lead) | Project Lead + Admin Backend | GitHub management, ER diagram, SQL schema, Orphan CRUD, merging PRs |
| **Rakshya Phagami** | Database Specialist | Database setup, normalization, indexes, connection pooling, backup |
| **Pooja Subedi** | User Backend | Login, registration, session handling, Donor module |
| **Krishtina Gurung** | Security & Validation | Password encryption (BCrypt), login filters, error pages, cookies, Volunteer module |
| **Sristy Bhandari** | Frontend & Report | JSP styling, CSS responsiveness, wireframes, final PDF report, Donation module |

---

## 🛠️ Technology Stack

| Layer | Technology |
|-------|------------|
| **Frontend** | JSP, HTML5, CSS3, Bootstrap 5 |
| **Backend** | Java Servlets, JDBC |
| **Database** | MySQL 8.0 |
| **Server** | Apache Tomcat 9 |
| **Security** | BCrypt for password hashing |
| **Build Tool** | Maven |
| **Version Control** | Git + GitHub (private repo) |
---

## 📁 Folder Structure
Orphanage-Management-System/
├── pom.xml
├── README.md
├── database_schema.sql
├── src/
│ └── main/
│ ├── java/
│ │ └── com/
│ │ └── orphanage/
│ │ ├── model/
│ │ │ ├── Orphan.java
│ │ │ ├── User.java
│ │ │ ├── Donor.java
│ │ │ ├── Volunteer.java
│ │ │ └── Donation.java
│ │ ├── dao/
│ │ │ ├── OrphanDAO.java
│ │ │ ├── UserDAO.java
│ │ │ ├── DonorDAO.java
│ │ │ ├── VolunteerDAO.java
│ │ │ └── DonationDAO.java
│ │ ├── servlet/
│ │ │ ├── AdminOrphanServlet.java
│ │ │ ├── LoginServlet.java
│ │ │ ├── RegisterServlet.java
│ │ │ ├── LogoutServlet.java
│ │ │ ├── DonorServlet.java
│ │ │ ├── VolunteerServlet.java
│ │ │ └── DonationServlet.java
│ │ └── util/
│ │ ├── DatabaseConnection.java
│ │ ├── PasswordUtil.java
│ │ └── AuthFilter.java
│ └── webapp/
│ ├── admin/
│ │ ├── orphan-list.jsp
│ │ └── orphan-form.jsp
│ ├── donor/
│ │ ├── donor-list.jsp
│ │ └── donor-form.jsp
│ ├── volunteer/
│ │ ├── volunteer-list.jsp
│ │ └── volunteer-form.jsp
│ ├── donation/
│ │ ├── donation-list.jsp
│ │ └── donation-form.jsp
│ ├── login.jsp
│ ├── register.jsp
│ ├── logout.jsp
│ ├── error404.jsp
│ ├── error500.jsp
│ ├── css/
│ │ └── styles.css
│ └── WEB-INF/
│ └── web.xml
├── docs/
│ ├── wireframes/ (screenshots of wireframes)
│ ├── er-diagram.png
│ └── final-report.pdf
└── target/ (generated WAR, ignored by Git)

---

## ✅ Milestone 1 Requirements Checklist

| Requirement | Status |
|-------------|--------|
| Wireframes (login, admin, user) | ✅ Included in `/docs/wireframes` |
| Database tables + ER diagram | ✅ `schema.sql` + ER diagram in `/docs` |
| Login & registration (encrypted passwords) | ✅ BCrypt hashing |
| Sessions & filters | ✅ `AuthFilter` protects `/admin/*` |
| Admin CRUD (orphans module) | ✅ Orphan list, add, edit, delete |
| Draft report | ✅ `final-report.pdf` (work in progress) |

---

## 🚀 How to Run Locally

### Prerequisites
- Java 8 or 11
- Apache Tomcat 9
- MySQL 8.0
- Maven (or use IntelliJ built‑in)
- Git

### Step‑by‑step

1. **Clone the repository**
   ```bash
   git clone https://github.com/bibishachhantyala24-tech/Orphanage-Management-System.git
   cd Orphanage-Management-System



---

## 📁 Folder Structure
