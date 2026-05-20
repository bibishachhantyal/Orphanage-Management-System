package orphanage.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import orphanage.dao.DonationDAO;
import orphanage.model.User;
import orphanage.dao.OrphanDAO;
import orphanage.dao.VolunteerDAO;
import orphanage.util.WishlistUtil;

import java.io.IOException;

@WebServlet("/user/dashboard")
public class UserDashboardServlet extends HttpServlet {

    private final OrphanDAO orphanDAO = new OrphanDAO();
    private final DonationDAO donationDAO = new DonationDAO();
    private final VolunteerDAO volunteerDAO = new VolunteerDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setAttribute("donationCount", donationDAO.getTotalCount());
        req.setAttribute("volunteerHours", volunteerDAO.getTotalCount());
        req.setAttribute("sponsoredCount", orphanDAO.getActiveCount());
        req.setAttribute("wishlistCount", WishlistUtil.getIds(req.getSession()).size());

        String q = req.getParameter("q");
        if (q != null && !q.isBlank()) {
            req.setAttribute("searchQuery", q.trim());
            req.setAttribute("searchResults", orphanDAO.searchActiveOrphans(q));
        }

        HttpSession session = req.getSession(false);
        User user = session != null ? (User) session.getAttribute("user") : null;
        String role = user != null ? user.getRole() : "USER";

        String view = switch (role.toUpperCase()) {
            case "DONOR" -> "/user/donor-dashboard.jsp";
            case "VOLUNTEER" -> "/user/volunteer-dashboard.jsp";
            default -> "/user/dashboard.jsp";
        };
        req.getRequestDispatcher(view).forward(req, resp);
    }
}
