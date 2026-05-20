# 🏠 Orphanage Management System

> A complete web application for managing orphanages, donors, and volunteers. Built for coursework submission.

## 👥 Team 5 Members

| Role | Name | Responsibilities |
|------|------|------------------|
| Project Lead + Admin Backend | Bibisha Chhantyal| GitHub management, ER diagram, SQL schema, Admin CRUD (orphans) |
| Database Specialist | Rakshya Phagami | Database setup, normalization, indexes, connection pooling |
| User Backend | Pooja Subedi] | Login, registration, session handling, donor/volunteer features |
| Security & Validation |Krishtina Gurung | Password encryption (BCrypt), login filters, error pages, cookies |
| Frontend & Report | Sristy Bhandari | JSP pages, CSS responsiveness, wireframes, final PDF report |

## 🗓️ Milestone 1 (Due: May 4, 2026)

- ✅ Wireframes (login, admin, user)
- ✅ Database tables + ER diagram
- ✅ Login & registration (encrypted passwords)
- ✅ Sessions & filters
- ✅ Admin CRUD (orphans module)
- ✅ Draft report

## 🛠️ Tech Stack

- **Frontend**: JSP, HTML5, CSS3 (responsive), Bootstrap 5
- **Backend**: Java Servlets, JDBC
- **Database**: MySQL
- **Server**: Apache Tomcat 9/10
- **Security**: BCrypt for password hashing
- **Version Control**: Git + GitHub (private repo)

## 📂 Project Structure
Orphanage-Management-System/
├── src/
│ ├── main/
│ │ ├── java/
│ │ │ ├── com.orphanage.model/ (User, Orphan, Donation, Volunteer)
│ │ │ ├── com.orphanage.dao/ (UserDAO, OrphanDAO, DonationDAO)
│ │ │ ├── com.orphanage.servlet/ (LoginServlet, AdminOrphanServlet)
│ │ │ └── com.orphanage.util/ (PasswordUtil, DBConnection)
│ │ ├── webapp/
│ │ │ ├── admin/ (admin dashboard, orphan CRUD JSPs)
│ │ │ ├── user/ (login, register, user dashboard)
│ │ │ ├── WEB-INF/
│ │ │ │ └── web.xml
│ │ │ └── css/ (styles.css)
│ │ └── resources/
│ │ └── schema.sql (database creation script)
├── docs/
│ ├── er-diagram.png
│ ├── wireframes/
│ └── final-report.pdf
└── README.md

text

## 🚀 How to Run Locally

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/Orphanage-Management-System.git
Import into IDE (Eclipse/IntelliJ) as a Dynamic Web Project

Set up MySQL database

Create a database named orphanage_db

Run the schema.sql file from /src/main/resources/

Configure Tomcat

Add Tomcat 9+ server in your IDE

Deploy the project

Access the app

Home: http://localhost:8080/Orphanage-Management-System/

Admin login: (default: admin@orphanage.com / password123)

🔒 Branch Protection Rules
main branch is protected – requires pull request and 1 approval

All development happens on dev branch

Commit messages format: [M1] description (M1, M2, M3, M4, M5 for team members)

📝 Progress Log
Date	Task	Completed By
April 17, 2026	Repository created, ER diagram done, SQL schema pushed	[Your Name]
...	...	...
