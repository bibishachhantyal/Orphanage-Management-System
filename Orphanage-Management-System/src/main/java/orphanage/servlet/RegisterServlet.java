package orphanage.servlet;

import orphanage.dao.UserDAO;
import orphanage.model.User;
import orphanage.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String username = trim(req.getParameter("username"));
        String email = trim(req.getParameter("email"));
        String password = req.getParameter("password");
        String confirm = req.getParameter("confirm_password");
        String fullName = trim(req.getParameter("full_name"));
        String phone = trim(req.getParameter("phone"));
        String address = trim(req.getParameter("address"));

        if (username.isEmpty() || email.isEmpty() || password == null || password.isBlank()) {
            req.setAttribute("error", "Username, email, and password are required.");
            forward(req, resp);
            return;
        }
        if (!password.equals(confirm)) {
            req.setAttribute("error", "Passwords do not match.");
            forward(req, resp);
            return;
        }
        if (!PasswordUtil.isStrongPassword(password)) {
            req.setAttribute("error", "Password must be at least 8 characters and include uppercase, lowercase, a number, and a special character (e.g. Admin@123).");
            forward(req, resp);
            return;
        }
        if (userDAO.usernameExists(username)) {
            req.setAttribute("error", "Username is already taken.");
            forward(req, resp);
            return;
        }
        if (userDAO.emailExists(email)) {
            req.setAttribute("error", "Email is already registered.");
            forward(req, resp);
            return;
        }

        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword_hash(PasswordUtil.hashPassword(password));
        user.setRole("USER");
        user.setApproved(false);
        user.setFullName(fullName.isEmpty() ? null : fullName);
        user.setPhone(phone.isEmpty() ? null : phone);
        user.setAddress(address.isEmpty() ? null : address);
        userDAO.save(user);

        req.setAttribute("success", "Registration submitted. Await admin approval.");
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }

    private void forward(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }

    private static String trim(String s) {
        return s == null ? "" : s.trim();
    }
}
