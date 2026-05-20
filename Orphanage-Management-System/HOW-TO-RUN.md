# How to run this project (Windows)

You borrowed this folder from a friend. Follow these steps **in order**.

## 1. Open the correct folder

In Cursor / VS Code / IntelliJ, open **only** this folder:

```
GrpCourseworkJava\Orphanage-Management-System
```

Do **not** open the whole zip root or only `target` — open the folder that contains `pom.xml`.

## 2. Install requirements (one time)

| Tool | Why |
|------|-----|
| **JDK 17+** | Compiles Java (you may have Java 25 — that is OK) |
| **Maven** | Builds and runs the server |
| **XAMPP** | MySQL database |

## 3. Start MySQL

1. Open **XAMPP Control Panel**
2. Click **Start** next to **MySQL** (must show green “Running”)
3. If it fails, another program may be using port 3306 — stop other MySQL installs

## 4. Create the database (first time only)

Double-click **`setup-database.bat`** in this folder.

Or in Command Prompt:

```bat
cd path\to\Orphanage-Management-System
setup-database.bat
```

## 5. Run the website

Double-click **`run.bat`**.

Wait until you see Tomcat started, then open in **Chrome / Edge**:

**http://localhost:8081/orphanage/**

> Not 8080. Not by opening `index.jsp` as a file. Use the URL above.

## 6. Login

| Username | Password | Role |
|----------|----------|------|
| admin | Admin@123 | Administrator |
| donor | Admin@123 | Donor portal |
| volunteer | Admin@123 | Volunteer portal |
| bibisha | Admin@123 | General user |

New registrations need a **strong** password like `Admin@123` (uppercase, lowercase, number, special character).

If login fails after an older install, run **`setup-database.bat`** again (or run `upgrade.sql` in MySQL) to reset demo passwords.

---

## Common errors and fixes

### “Maven not found” / “mvn is not recognized”
Install Maven and add it to PATH, or run from a terminal where `mvn -version` works.

### “MySQL connection” / blank pages / 500 error
- Start MySQL in XAMPP
- Run `setup-database.bat`
- If your MySQL root has a **password**, edit `src\main\java\orphanage\util\DatabaseConnection.java` line 13:
  ```java
  private static final String PASSWORD = "your_mysql_password";
  ```
  Then run `run.bat` again.

### “Port 8081 already in use”
Another server is running. Close other Tomcat/Java windows, or change port in `pom.xml` (cargo.servlet.port).

### Opening `about.html` works but login does not
Static HTML works without the server; **JSP and login need `run.bat`** (Tomcat).

### IDE shows red errors but project runs
Import as **Maven project** and set JDK 17+ in Project Structure.

### Friend’s PC worked, yours does not
Your machine still needs: MySQL running + database imported + `run.bat` (not just copying files).

---

## Run from command line (alternative)

```bat
cd Orphanage-Management-System
mvn package -DskipTests
mvn cargo:run
```

Then visit: **http://localhost:8081/orphanage/**
