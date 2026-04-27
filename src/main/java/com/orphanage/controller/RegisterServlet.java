package com.orphanage.controller;

import com.orphanage.dao.UserDAOImpl;
import com.orphanage.dao.UserDAO;
import com.orphanage.model.User;
import com.orphanage.util.PasswordHasher;
import com.orphanage.util.ValidationHelper;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "RegisterServlet", urlPatterns = {"/register"})
public class RegisterServlet extends HttpServlet {
    private final UserDAO userDAO = new UserDAOImpl();

    // FIX: Added doGet() — without this, visiting /register gives 405 Method Not Allowed
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String fullName = ValidationHelper.requireNonBlank(req.getParameter("fullName"), "Full name");
            String email = ValidationHelper.validateEmail(req.getParameter("email"));
            String phone = ValidationHelper.validatePhoneOptional(req.getParameter("phone"));
            String role = ValidationHelper.validateRole(req.getParameter("role"));
            String password = req.getParameter("password");
            ValidationHelper.validatePassword(password);

            // Generate salt + hash
            String salt = PasswordHasher.generateSaltBase64();
            String hash = PasswordHasher.hashPasswordBase64(password, salt);

            // Build user entity
            User u = new User();
            u.setFullName(fullName);
            u.setEmail(email);
            u.setPhone(phone);
            u.setRole(role);
            u.setPasswordSalt(salt);
            u.setPasswordHash(hash);

            int userId = userDAO.registerUser(u);
            u.setId(userId);

            // Redirect to login with success message (don't auto-login)
            resp.sendRedirect(req.getContextPath() + "/login?msg=registered");

        } catch (IllegalArgumentException e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
        } catch (SQLException e) {
            req.setAttribute("error", "Registration failed. Email may already exist.");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
        }
    }
}
