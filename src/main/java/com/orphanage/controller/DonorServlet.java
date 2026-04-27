package com.orphanage.controller;

import com.orphanage.dao.DonorDAO;
import com.orphanage.model.Donor;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.util.List;

/**
 * DonorServlet — handles CRUD operations for donors.
 *
 * GET  /donors              → list all donors
 * GET  /donors?action=new   → show empty donor form
 * GET  /donors?action=edit&id=X  → show pre-filled donor form
 * GET  /donors?action=delete&id=X → delete donor, redirect to list
 * POST /donors              → create or update donor
 */
@WebServlet(name = "DonorServlet", urlPatterns = {"/donors"})
public class DonorServlet extends HttpServlet {

    private DonorDAO donorDAO;

    @Override
    public void init() throws ServletException {
        donorDAO = new DonorDAO();
    }

    // ------------------------------------------------------------------ //
    // GET — list, new form, edit form, delete
    // ------------------------------------------------------------------ //
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "new":
                    showForm(req, resp, null);
                    break;
                case "edit":
                    int editId = parseId(req.getParameter("id"));
                    Donor donor = donorDAO.findById(editId);
                    if (donor == null) {
                        resp.sendRedirect(req.getContextPath() + "/donors?error=Donor+not+found");
                        return;
                    }
                    showForm(req, resp, donor);
                    break;
                case "delete":
                    int deleteId = parseId(req.getParameter("id"));
                    donorDAO.delete(deleteId);
                    resp.sendRedirect(req.getContextPath() + "/donors?msg=deleted");
                    break;
                default:
                    listDonors(req, resp);
                    break;
            }
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/donors?error=Invalid+donor+ID");
        }
    }

    // ------------------------------------------------------------------ //
    // POST — create or update
    // ------------------------------------------------------------------ //
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        try {
            String idParam = req.getParameter("id");
            boolean isUpdate = (idParam != null && !idParam.isBlank());

            // Validate inputs
            String fullName = requireNonBlank(req.getParameter("fullName"), "Full name");
            String email = requireNonBlank(req.getParameter("email"), "Email");
            String phone = trimOrNull(req.getParameter("phone"));
            String address = trimOrNull(req.getParameter("address"));
            String donationType = requireNonBlank(req.getParameter("donationType"), "Donation type");
            BigDecimal totalDonated = parseBigDecimal(req.getParameter("totalDonated"));

            // Build donor entity
            Donor donor = new Donor();
            donor.setFullName(fullName);
            donor.setEmail(email.toLowerCase());
            donor.setPhone(phone);
            donor.setAddress(address);
            donor.setDonationType(donationType.toUpperCase());
            donor.setTotalDonated(totalDonated);

            if (isUpdate) {
                int id = Integer.parseInt(idParam);
                donor.setId(id);

                // Check duplicate email (excluding current donor)
                if (donorDAO.emailExists(email.toLowerCase(), id)) {
                    req.setAttribute("error", "A donor with this email already exists.");
                    req.setAttribute("donor", donor);
                    req.getRequestDispatcher("/donor-form.jsp").forward(req, resp);
                    return;
                }

                donorDAO.update(donor);
                resp.sendRedirect(req.getContextPath() + "/donors?msg=updated");
            } else {
                // Check duplicate email (new donor)
                if (donorDAO.emailExists(email.toLowerCase(), 0)) {
                    req.setAttribute("error", "A donor with this email already exists.");
                    req.setAttribute("donor", donor);
                    req.getRequestDispatcher("/donor-form.jsp").forward(req, resp);
                    return;
                }

                donorDAO.create(donor);
                resp.sendRedirect(req.getContextPath() + "/donors?msg=created");
            }

        } catch (IllegalArgumentException e) {
            req.setAttribute("error", e.getMessage());
            req.getRequestDispatcher("/donor-form.jsp").forward(req, resp);
        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }
    }

    // ------------------------------------------------------------------ //
    // Helpers
    // ------------------------------------------------------------------ //
    private void listDonors(HttpServletRequest req, HttpServletResponse resp)
            throws SQLException, ServletException, IOException {
        List<Donor> donors = donorDAO.findAll();
        req.setAttribute("donorList", donors);
        req.getRequestDispatcher("/donor-list.jsp").forward(req, resp);
    }

    private void showForm(HttpServletRequest req, HttpServletResponse resp, Donor donor)
            throws ServletException, IOException {
        if (donor != null) {
            req.setAttribute("donor", donor);
        }
        req.getRequestDispatcher("/donor-form.jsp").forward(req, resp);
    }

    private int parseId(String s) {
        if (s == null || s.isBlank()) throw new NumberFormatException("Missing ID");
        return Integer.parseInt(s.trim());
    }

    private String requireNonBlank(String v, String fieldName) {
        if (v == null || v.isBlank()) throw new IllegalArgumentException(fieldName + " is required");
        return v.trim();
    }

    private String trimOrNull(String v) {
        if (v == null || v.isBlank()) return null;
        return v.trim();
    }

    private BigDecimal parseBigDecimal(String v) {
        if (v == null || v.isBlank()) return BigDecimal.ZERO;
        try {
            BigDecimal bd = new BigDecimal(v.trim());
            if (bd.compareTo(BigDecimal.ZERO) < 0) {
                throw new IllegalArgumentException("Total donated cannot be negative");
            }
            return bd;
        } catch (NumberFormatException e) {
            throw new IllegalArgumentException("Invalid amount format");
        }
    }
}
