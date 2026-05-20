package orphanage.servlet;

import orphanage.dao.DonationDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/donation-report")
public class DonationReportServlet extends HttpServlet {
    private DonationDAO donationDAO = new DonationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        double totalAmount = donationDAO.getTotalAmount();
        int totalDonations = donationDAO.getTotalCount();
        req.setAttribute("totalAmount", totalAmount);
        req.setAttribute("totalDonations", totalDonations);
        req.getRequestDispatcher("/donation/donation-report.jsp").forward(req, resp);
    }
}