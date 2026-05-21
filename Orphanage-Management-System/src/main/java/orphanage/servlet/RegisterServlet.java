package orphanage.servlet;

import orphanage.service.ServiceResult;
import orphanage.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        ServiceResult<?> result = userService.register(
                trim(req.getParameter("username")),
                trim(req.getParameter("email")),
                req.getParameter("password"),
                req.getParameter("confirm_password"),
                trim(req.getParameter("full_name")),
                trim(req.getParameter("phone")),
                trim(req.getParameter("address")));

        if (!result.isSuccess()) {
            req.setAttribute("error", result.getMessage());
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }

        req.setAttribute("success", "Registration submitted. Await admin approval.");
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }

    private static String trim(String s) {
        return s == null ? "" : s.trim();
    }
}
