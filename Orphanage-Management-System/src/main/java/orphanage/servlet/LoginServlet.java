package orphanage.servlet;

import orphanage.model.User;
import orphanage.service.ServiceResult;
import orphanage.service.UserService;
import orphanage.util.CookieUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private final UserService userService = new UserService();
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

        ServiceResult<User> result = userService.authenticate(username, password);
        if (!result.isSuccess()) {
            req.setAttribute("error", result.getMessage());
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }

        User user = result.getData();
        HttpSession existing = req.getSession(false);
        if (existing != null) {
            existing.invalidate();
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
