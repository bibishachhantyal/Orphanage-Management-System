package com.orphanage.controller;

import com.orphanage.dao.ResourceDAO;
import com.orphanage.model.Resource;
import com.orphanage.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.SQLException;

@WebServlet(name = "ResourceRequestServlet", urlPatterns = {"/request-resource"})
public class ResourceRequestServlet extends HttpServlet {
    private final ResourceDAO resourceDAO = new ResourceDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/requestResource.jsp").forward(req, resp);
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
            String itemName = req.getParameter("itemName");
            if (itemName == null || itemName.isBlank()) throw new IllegalArgumentException("Item name is required");

            int quantity = Integer.parseInt(req.getParameter("quantity"));
            if (quantity <= 0) throw new IllegalArgumentException("Quantity must be positive");

            String priority = req.getParameter("priority");
            if (priority == null || priority.isBlank()) priority = "MEDIUM";
            priority = priority.trim().toUpperCase();
            if (!priority.equals("LOW") && !priority.equals("MEDIUM") && !priority.equals("HIGH")) {
                throw new IllegalArgumentException("Priority must be LOW, MEDIUM, or HIGH");
            }

            Resource r = new Resource();
            r.setUserId(user.getId());
            r.setItemName(itemName.trim());
            r.setQuantity(quantity);
            r.setPriority(priority);
            r.setStatus("PENDING");

            resourceDAO.createRequest(r);
            resp.sendRedirect(req.getContextPath() + "/user/dashboard.jsp?msg=request_success");
        } catch (IllegalArgumentException e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/requestResource.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }
}
