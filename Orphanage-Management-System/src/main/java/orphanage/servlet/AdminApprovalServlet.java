package orphanage.servlet;

import orphanage.dao.ContactMessageDAO;
import orphanage.dao.UserDAO;
import orphanage.dao.VolunteerApplicationDAO;
import orphanage.dao.VolunteerDAO;
import orphanage.model.Volunteer;
import orphanage.model.VolunteerApplication;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.time.LocalDate;

@WebServlet("/admin/approvals")
public class AdminApprovalServlet extends HttpServlet {

    private final UserDAO userDAO = new UserDAO();
    private final VolunteerApplicationDAO applicationDAO = new VolunteerApplicationDAO();
    private final VolunteerDAO volunteerDAO = new VolunteerDAO();
    private final ContactMessageDAO contactDAO = new ContactMessageDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        String idParam = req.getParameter("id");
        if (action == null || idParam == null) {
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            return;
        }

        try {
            int id = Integer.parseInt(idParam.trim());
            switch (action) {
                case "approveUser" -> userDAO.setApproved(id, true);
                case "rejectUser" -> userDAO.deleteById(id);
                case "approveVolunteer" -> approveVolunteer(id);
                case "rejectVolunteer" -> applicationDAO.updateStatus(id, "rejected");
                case "markContactRead" -> contactDAO.markAsRead(id);
                default -> { }
            }
        } catch (NumberFormatException ignored) { }

        resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
    }

    private void approveVolunteer(int applicationId) {
        VolunteerApplication app = applicationDAO.findById(applicationId);
        if (app == null || !"pending".equalsIgnoreCase(app.getStatus())) {
            return;
        }
        Volunteer v = new Volunteer();
        v.setFull_name(app.getFullName());
        v.setEmail(app.getEmail());
        v.setPhone(app.getPhone());
        v.setSkill_area(app.getSkillArea());
        v.setAvailability(app.getAvailability());
        v.setJoined_date(LocalDate.now().toString());
        v.setStatus("Active");
        volunteerDAO.addVolunteer(v);
        applicationDAO.updateStatus(applicationId, "approved");
    }
}
