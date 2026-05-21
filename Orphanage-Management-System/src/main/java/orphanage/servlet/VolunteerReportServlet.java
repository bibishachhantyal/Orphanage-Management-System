package orphanage.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import orphanage.service.ReportService;

import java.io.IOException;
import java.util.Map;

@WebServlet("/admin/volunteer-report")
public class VolunteerReportServlet extends HttpServlet {
    private final ReportService reportService = new ReportService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        Map<String, Integer> statusCounts = reportService.getVolunteerStatusCounts();
        req.setAttribute("statusCounts", statusCounts);
        req.setAttribute("pendingApplications", reportService.getPendingVolunteerApplications());
        req.setAttribute("chartMax", reportService.chartMax(statusCounts));
        req.getRequestDispatcher("/admin/volunteer-report.jsp").forward(req, resp);
    }
}
