package orphanage.servlet;

import orphanage.dao.DonationDAO;
import orphanage.dao.DonorDAO;
import orphanage.dao.OrphanDAO;
import orphanage.model.Donation;
import orphanage.model.Donor;
import orphanage.model.Orphan;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/donate")
public class PublicDonateServlet extends HttpServlet {
    private final DonorDAO donorDAO = new DonorDAO();
    private final DonationDAO donationDAO = new DonationDAO();
    private final OrphanDAO orphanDAO = new OrphanDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("orphans", orphanDAO.getActiveOrphansForPublic());
        req.getRequestDispatcher("/donate.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String name = trim(req.getParameter("full_name"));
        String email = trim(req.getParameter("email"));
        String phone = trim(req.getParameter("phone"));
        String amountStr = trim(req.getParameter("amount"));
        String purpose = trim(req.getParameter("purpose"));
        String payment = trim(req.getParameter("payment_method"));
        String orphanParam = trim(req.getParameter("orphan_id"));

        if (name.isEmpty() || email.isEmpty() || amountStr.isEmpty()) {
            req.setAttribute("error", "Please enter your name, email, and donation amount.");
            req.setAttribute("orphans", orphanDAO.getActiveOrphansForPublic());
            req.getRequestDispatcher("/donate.jsp").forward(req, resp);
            return;
        }

        double amount;
        try {
            amount = Double.parseDouble(amountStr);
            if (amount <= 0) {
                throw new NumberFormatException();
            }
        } catch (NumberFormatException e) {
            req.setAttribute("error", "Please enter a valid donation amount.");
            req.setAttribute("orphans", orphanDAO.getActiveOrphansForPublic());
            req.getRequestDispatcher("/donate.jsp").forward(req, resp);
            return;
        }

        Donor donor = donorDAO.findByEmail(email);
        if (donor == null) {
            donor = new Donor();
            donor.setFull_name(name);
            donor.setEmail(email);
            donor.setPhone(phone);
            donor.setAddress("");
            donor.setDonor_type("Individual");
            int id = donorDAO.addDonorReturningId(donor);
            if (id < 0) {
                req.setAttribute("error", "Could not save your details. Please try again.");
                req.setAttribute("orphans", orphanDAO.getActiveOrphansForPublic());
                req.getRequestDispatcher("/donate.jsp").forward(req, resp);
                return;
            }
            donor.setId(id);
        }

        Donation d = new Donation();
        d.setDonor_id(donor.getId());
        if (!orphanParam.isEmpty()) {
            try {
                d.setOrphan_id(Integer.parseInt(orphanParam));
            } catch (NumberFormatException ignored) {
                d.setOrphan_id(0);
            }
        } else {
            d.setOrphan_id(0);
        }
        d.setAmount(amount);
        d.setDonation_date(LocalDate.now().toString());
        d.setPayment_method(payment.isEmpty() ? "Online" : payment);
        d.setPurpose(purpose.isEmpty() ? "General orphanage support" : purpose);
        donationDAO.addDonation(d);

        resp.sendRedirect(req.getContextPath() + "/thankyou.jsp?type=donation&name=" + urlEncode(name));
    }

    private static String trim(String s) {
        return s == null ? "" : s.trim();
    }

    private static String urlEncode(String s) {
        try {
            return java.net.URLEncoder.encode(s, java.nio.charset.StandardCharsets.UTF_8);
        } catch (Exception e) {
            return "";
        }
    }
}
