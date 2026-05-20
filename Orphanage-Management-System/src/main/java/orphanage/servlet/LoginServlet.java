package orphanage.servlet;

import orphanage.dao.UserDAO;
import orphanage.model.User;
import orphanage.util.CookieUtil;
import orphanage.util.PasswordUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAO();
    private static final int REMEMBER_SECONDS = 7 * 24 * 60 * 60;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String remembered = CookieUtil.getCookieValue(req, "remember_user");
        if (remembered != null && !remembered.isBlank()) {
            req.setAttribute("rememberedUsername", remembered);
        }
        req.getRequestDispatcher("/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String username = trim(req.getParameter("username"));
        String password = req.getParameter("password");
        boolean remember = "on".equals(req.getParameter("remember"));

        User user = userDAO.findByUsername(username);
        if (user == null || !PasswordUtil.checkPassword(password, user.getPassword_hash())) {
            req.setAttribute("error", "Invalid username or password.");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }
        if (!user.isApproved()) {
            req.setAttribute("error", "Your account is pending admin approval.");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        HttpSession session = req.getSession(true);
        session.setAttribute("user", user);
        session.setAttribute("username", user.getUsername());

        if (remember) {
            CookieUtil.addCookie(resp, "remember_user", username, REMEMBER_SECONDS);
        } else {
            CookieUtil.deleteCookie(resp, "remember_user");
        }

        String role = user.getRole() != null ? user.getRole().toUpperCase() : "USER";
        String target = switch (role) {
            case "ADMIN" -> "/admin/dashboard";
            case "DONOR", "VOLUNTEER", "USER" -> "/user/dashboard";
            default -> "/user/dashboard";
        };
        resp.sendRedirect(req.getContextPath() + target);
    }

    private static String trim(String s) {
        return s == null ? "" : s.trim();
    }
}
