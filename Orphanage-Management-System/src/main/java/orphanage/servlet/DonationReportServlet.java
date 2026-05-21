package orphanage.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import orphanage.service.ReportService;

import java.io.IOException;
import java.util.Map;

@WebServlet("/admin/donation-report")
public class DonationReportServlet extends HttpServlet {
    private final ReportService reportService = new ReportService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Map<String, Double> byMethod = reportService.getDonationByPaymentMethod();
        req.setAttribute("totalAmount", reportService.getTotalDonationAmount());
        req.setAttribute("totalDonations", reportService.getTotalDonationCount());
        req.setAttribute("paymentBreakdown", byMethod);
        req.setAttribute("recentDonations", reportService.getRecentDonations(10));
        req.setAttribute("chartMax", chartMaxAmount(byMethod));
        req.getRequestDispatcher("/donation/donation-report.jsp").forward(req, resp);
    }

    private static int chartMaxAmount(Map<String, Double> values) {
        int max = 1;
        for (Double v : values.values()) {
            max = Math.max(max, (int) Math.ceil(v));
        }
        return max;
    }
}
