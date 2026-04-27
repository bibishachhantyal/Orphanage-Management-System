package com.orphanage.controller;

import com.orphanage.dao.DonationDAO;
import com.orphanage.model.Donation;
import com.orphanage.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "DonationServlet", urlPatterns = {"/donate"})
public class DonationServlet extends HttpServlet {
    private final DonationDAO donationDAO = new DonationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/donate.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        // FIX: Get the User object from session (LoginServlet stores "user", not "userId")
        User user = (session == null) ? null : (User) session.getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        try {
            double amount = Double.parseDouble(req.getParameter("amount"));
            if (amount <= 0) throw new IllegalArgumentException("Amount must be positive");

            String method = req.getParameter("method");
            if (method == null || method.isBlank()) throw new IllegalArgumentException("Method is required");
            String note = req.getParameter("note");

            Donation d = new Donation();
            d.setUserId(user.getId());
            d.setAmount(amount);
            d.setMethod(method.trim().toUpperCase());
            d.setNote(note == null ? null : note.trim());

            donationDAO.create(d);
            resp.sendRedirect(req.getContextPath() + "/user/dashboard.jsp?msg=donation_success");
        } catch (IllegalArgumentException e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/donate.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }
}
