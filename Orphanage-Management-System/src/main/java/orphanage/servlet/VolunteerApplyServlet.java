package orphanage.servlet;

import orphanage.dao.VolunteerApplicationDAO;
import orphanage.model.VolunteerApplication;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/apply-volunteer")
public class VolunteerApplyServlet extends HttpServlet {

    private final VolunteerApplicationDAO applicationDAO = new VolunteerApplicationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/apply_volunteer.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        VolunteerApplication app = new VolunteerApplication();
        app.setFullName(trim(req.getParameter("full_name")));
        app.setEmail(trim(req.getParameter("email")));
        app.setPhone(trim(req.getParameter("phone")));
        app.setSkillArea(trim(req.getParameter("skill_area")));
        app.setAvailability(trim(req.getParameter("availability")));
        app.setMessage(trim(req.getParameter("message")));

        if (app.getFullName().isEmpty() || app.getEmail().isEmpty()) {
            req.setAttribute("error", "Full name and email are required.");
            req.getRequestDispatcher("/apply_volunteer.jsp").forward(req, resp);
            return;
        }

        applicationDAO.insert(app);
        resp.sendRedirect(req.getContextPath() + "/thankyou.jsp?type=volunteer");
    }

    private static String trim(String s) {
        return s == null ? "" : s.trim();
    }
}
