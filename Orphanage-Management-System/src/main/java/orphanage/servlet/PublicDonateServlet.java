package orphanage.servlet;

import orphanage.service.DonationService;
import orphanage.service.ServiceResult;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/donate")
public class PublicDonateServlet extends HttpServlet {
    private final DonationService donationService = new DonationService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("orphans", donationService.getActiveOrphansForDonateForm());
        req.getRequestDispatcher("/donate.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        ServiceResult<String> result = donationService.processPublicDonation(
                trim(req.getParameter("full_name")),
                trim(req.getParameter("email")),
                trim(req.getParameter("phone")),
                trim(req.getParameter("amount")),
                trim(req.getParameter("purpose")),
                trim(req.getParameter("payment_method")),
                trim(req.getParameter("orphan_id")));

        if (!result.isSuccess()) {
            req.setAttribute("error", result.getMessage());
            req.setAttribute("orphans", donationService.getActiveOrphansForDonateForm());
            req.getRequestDispatcher("/donate.jsp").forward(req, resp);
            return;
        }

        resp.sendRedirect(req.getContextPath() + "/thankyou.jsp?type=donation&name=" + urlEncode(result.getData()));
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
