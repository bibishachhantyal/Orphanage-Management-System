package orphanage.servlet;

import orphanage.dao.VolunteerDAO;
import orphanage.model.Volunteer;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/volunteer/list")
public class VolunteerServlet extends HttpServlet {
    private VolunteerDAO dao = new VolunteerDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null || action.equals("list")) {
            List<Volunteer> list = dao.getAllVolunteers();
            req.setAttribute("volunteers", list);
            req.getRequestDispatcher("/volunteer/volunteer-list.jsp").forward(req, resp);
        } else if (action.equals("add")) {
            req.getRequestDispatcher("/volunteer/volunteer-form.jsp").forward(req, resp);
        } else if (action.equals("edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Volunteer v = dao.getVolunteerById(id);
            req.setAttribute("volunteer", v);
            req.getRequestDispatcher("/volunteer/volunteer-form.jsp").forward(req, resp);
        } else if (action.equals("delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            dao.deleteVolunteer(id);
            resp.sendRedirect(req.getContextPath() + "/volunteer/list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        Volunteer v = new Volunteer();
        v.setFull_name(req.getParameter("full_name"));
        v.setEmail(req.getParameter("email"));
        v.setPhone(req.getParameter("phone"));
        v.setSkill_area(req.getParameter("skill_area"));
        v.setAvailability(req.getParameter("availability"));
        v.setJoined_date(req.getParameter("joined_date"));
        v.setStatus(req.getParameter("status"));
        if ("create".equals(action)) {
            dao.addVolunteer(v);
        } else if ("update".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            v.setId(id);
            dao.updateVolunteer(v);
        }
        resp.sendRedirect(req.getContextPath() + "/volunteer/list");
    }
}