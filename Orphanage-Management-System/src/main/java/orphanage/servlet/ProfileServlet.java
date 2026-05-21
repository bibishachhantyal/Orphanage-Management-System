package orphanage.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import orphanage.model.User;
import orphanage.service.ServiceResult;
import orphanage.service.UserService;

import java.io.IOException;

@WebServlet("/user/profile")
public class ProfileServlet extends HttpServlet {
    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        User user = currentUser(req);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        req.setAttribute("profileUser", userService.findById(user.getId()));
        req.getRequestDispatcher("/user/profile.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        User user = currentUser(req);
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        ServiceResult<User> result = userService.updateProfile(
                user.getId(),
                trim(req.getParameter("full_name")),
                trim(req.getParameter("email")),
                trim(req.getParameter("phone")),
                trim(req.getParameter("address")),
                req.getParameter("current_password"),
                req.getParameter("new_password"),
                req.getParameter("confirm_password"));

        if (!result.isSuccess()) {
            req.setAttribute("error", result.getMessage());
            req.setAttribute("profileUser", userService.findById(user.getId()));
            req.getRequestDispatcher("/user/profile.jsp").forward(req, resp);
            return;
        }

        HttpSession session = req.getSession(false);
        if (session != null) {
            session.setAttribute("user", result.getData());
            session.setAttribute("username", result.getData().getUsername());
        }
        resp.sendRedirect(req.getContextPath() + "/user/profile?updated=1");
    }

    private static User currentUser(HttpServletRequest req) {
        HttpSession session = req.getSession(false);
        if (session == null) {
            return null;
        }
        return (User) session.getAttribute("user");
    }

    private static String trim(String s) {
        return s == null ? "" : s.trim();
    }
}
