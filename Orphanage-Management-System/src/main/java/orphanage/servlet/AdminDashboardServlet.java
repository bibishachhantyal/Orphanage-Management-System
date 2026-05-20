package orphanage.servlet;

import orphanage.dao.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {
    private final OrphanDAO orphanDAO = new OrphanDAO();
    private final DonorDAO donorDAO = new DonorDAO();
    private final VolunteerDAO volunteerDAO = new VolunteerDAO();
    private final DonationDAO donationDAO = new DonationDAO();
    private final UserDAO userDAO = new UserDAO();
    private final VolunteerApplicationDAO applicationDAO = new VolunteerApplicationDAO();
    private final ContactMessageDAO contactDAO = new ContactMessageDAO();
    private final AdminStatsDAO statsDAO = new AdminStatsDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("totalOrphans", orphanDAO.getTotalCount());
        req.setAttribute("totalDonors", donorDAO.getTotalCount());
        req.setAttribute("totalVolunteers", volunteerDAO.getTotalCount());
        req.setAttribute("totalDonations", donationDAO.getTotalAmount());
        req.setAttribute("pendingUsers", userDAO.findPendingApproval());
        req.setAttribute("pendingVolunteerApps", applicationDAO.findPending());
        req.setAttribute("contactMessages", contactDAO.findAllOrderByDateDesc());
        req.setAttribute("visitorSlots", statsDAO.getVisitorStats());
        req.setAttribute("donorSlots", statsDAO.getDonorActivityStats());
        req.setAttribute("volunteerSlots", statsDAO.getVolunteerStats());
        req.setAttribute("userRegSlots", statsDAO.getRegistrationStats());
        req.getRequestDispatcher("/admin/dashboard.jsp").forward(req, resp);
    }
}
