package servlets;

import dao.VolunteerDAO;
import models.Volunteer;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/volunteer/*")
public class VolunteerServlet extends HttpServlet {

    private VolunteerDAO volunteerDAO = new VolunteerDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String path = request.getPathInfo();

        if (path == null || path.equals("/")) {
            request.setAttribute("volunteers", volunteerDAO.getAllVolunteers());
            request.getRequestDispatcher("/volunteer/volunteer-list.jsp").forward(request, response);
        } else if (path.equals("/new")) {
            request.getRequestDispatcher("/volunteer/volunteer-form.jsp").forward(request, response);
        } else if (path.startsWith("/edit/")) {
            int id = Integer.parseInt(path.substring(6));
            request.setAttribute("volunteer", volunteerDAO.getVolunteerById(id));
            request.getRequestDispatcher("/volunteer/volunteer-form.jsp").forward(request, response);
        } else if (path.startsWith("/delete/")) {
            int id = Integer.parseInt(path.substring(8));
            volunteerDAO.deleteVolunteer(id);
            response.sendRedirect(request.getContextPath() + "/volunteer");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String status = request.getParameter("status");

        Volunteer volunteer = new Volunteer(fullName, email, phone, address, status);

        if ("update".equals(action)) {
            volunteer.setId(Integer.parseInt(request.getParameter("id")));
            volunteerDAO.updateVolunteer(volunteer);
        } else {
            volunteerDAO.addVolunteer(volunteer);
        }

        response.sendRedirect(request.getContextPath() + "/volunteer");
    }
}