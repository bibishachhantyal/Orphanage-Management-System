# Orphanage Management System – Business Rules

These rules describe how the coursework application is intended to behave. They are suitable for report documentation or demos.

1. **Role-based access**  
   Only users with the `ADMIN` role may open any URL under `/admin/` (dashboard, orphan CRUD, donation reports from the admin menu). Regular users are redirected to the user dashboard if they try to access admin areas.

2. **Authentication for operations**  
   Managing donors, volunteers, donations, and the user dashboard requires a logged-in session. Unauthenticated visitors are redirected to the login page when they hit protected paths.

3. **Public orphan profiles**  
   The “Meet the children” public pages list only orphans whose status is **active**. Inactive or adopted children are not shown on the public site (privacy and accuracy of “children currently in care”).

4. **Admin orphan records**  
   Administrators can view the full orphan record, including photo path, birth-certificate reference, blood group, guardian contact, medical/education notes, and status (active, inactive, adopted).

5. **Donation integrity**  
   Every donation must be linked to an existing donor. Linking to a specific orphan is optional (general fund). If an orphan is chosen, it must exist in the database (enforced by foreign key in the schema).

6. **Registration defaults**  
   New accounts created through self-registration are always given the `USER` role. Admin accounts are created in the database (or by an administrator outside this demo flow).

7. **Password storage**  
   Passwords are stored using BCrypt hashes, not plain text. The sample database script uses hashes for the default admin and user so login works with the documented demo passwords.

8. **Enrollment vs date of birth**  
   When saving an orphan, the enrollment date must not be **before** the date of birth. The application rejects inconsistent dates and shows an error message.

---

*These rules are implemented to a practical “coursework” level: validation and access control in main servlets and filters, with some trust placed on direct database access by a DBA.*
