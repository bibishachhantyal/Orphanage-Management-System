package orphanage.servlet;

import orphanage.dao.*;
import orphanage.model.TimeSlotStats;
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
        TimeSlotStats visitorSlots = statsDAO.getVisitorStats();
        TimeSlotStats donorSlots = statsDAO.getDonorActivityStats();
        TimeSlotStats volunteerSlots = statsDAO.getVolunteerStats();
        TimeSlotStats userRegSlots = statsDAO.getRegistrationStats();
        req.setAttribute("visitorSlots", visitorSlots);
        req.setAttribute("donorSlots", donorSlots);
        req.setAttribute("volunteerSlots", volunteerSlots);
        req.setAttribute("userRegSlots", userRegSlots);
        req.setAttribute("chartSlotMax", maxSlotValue(visitorSlots, donorSlots, volunteerSlots, userRegSlots));
        req.setAttribute("chartFlowMax", maxFlowTotal(visitorSlots, donorSlots, volunteerSlots, userRegSlots));
        req.getRequestDispatcher("/admin/dashboard.jsp").forward(req, resp);
    }

    private static int maxSlotValue(TimeSlotStats... stats) {
        int max = 1;
        for (TimeSlotStats s : stats) {
            max = Math.max(max, s.getMorning());
            max = Math.max(max, s.getAfternoon());
            max = Math.max(max, s.getEvening());
        }
        return max;
    }

    private static int maxFlowTotal(TimeSlotStats... stats) {
        int max = 1;
        for (TimeSlotStats s : stats) {
            max = Math.max(max, s.getTotal());
        }
        return max;
    }
}
