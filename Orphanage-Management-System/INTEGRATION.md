# Integration guide — new pages & features

## 1. Database

Run the upgrade script on your existing MySQL database:

```bash
mysql -u root -p < upgrade.sql
```

Or paste `upgrade.sql` into phpMyAdmin / MySQL Workbench.

This adds:

- `users.approved`, `full_name`, `phone`, `address`
- Tables `contact_messages`, `volunteer_applications`
- Sets `approved = 1` for existing `admin` and `bibisha` accounts

## 2. Build and run

From `Orphanage-Management-System/`:

```bash
mvn clean package cargo:run
```

Open: **http://localhost:8081/orphanage/**

## 3. New URLs

| URL | Type | Description |
|-----|------|-------------|
| `/orphanage/about.html` | Static HTML | About us |
| `/orphanage/contact.html` | Static HTML | Contact form → `submitContact` |
| `/orphanage/thankyou.jsp` | JSP | Success after contact/volunteer |
| `/orphanage/register` | Servlet | Registration (BCrypt, pending approval) |
| `/orphanage/login` | Servlet | Login with remember-me & approval check |
| `/orphanage/apply-volunteer` | Servlet | Public volunteer application |
| `/orphanage/user/wishlist` | Servlet | Session wishlist (login required) |
| `/orphanage/admin/approvals` | Servlet POST | Approve users, volunteers, mark messages read |

## 4. Testing checklist

1. **Contact:** Submit form on `contact.html` → `thankyou.jsp` → message appears on admin dashboard.
2. **Register:** Create account → see success message → cannot login until admin approves.
3. **Admin:** Approve user → user can login → redirected to `/user/dashboard`.
4. **Volunteer:** Submit `apply-volunteer` → admin approves → row in `volunteers` table.
5. **Wishlist:** Login as USER → browse `/public/orphans` → Add to wishlist → view `/user/wishlist`.
6. **Search:** On user dashboard, search by child name, guardian, or blood group.

## 5. Demo logins

After `upgrade.sql`:

- **Admin:** `admin` / `1234`
- **User:** `bibisha` / `1234`

## 6. Configuration

- JDBC settings: `src/main/java/orphanage/util/DatabaseConnection.java`
- Session timeout: 30 minutes in `WEB-INF/web.xml`
- Auth filter: `AuthFilter.java` protects `/admin/*`, `/user/*`, `/donor/*`, `/volunteer/*`, `/donation/*`

Public (no login): `about.html`, `contact.html`, `login`, `register`, `apply-volunteer`, `thankyou.jsp`, `index.jsp`, `/public/orphans`.
