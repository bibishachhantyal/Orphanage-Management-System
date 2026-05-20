package orphanage.servlet;

import orphanage.dao.DonorDAO;
import orphanage.model.Donor;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/donor/list")
public class DonorServlet extends HttpServlet {
    private DonorDAO dao = new DonorDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null || action.equals("list")) {
            List<Donor> list = dao.getAllDonors();
            req.setAttribute("donors", list);
            req.getRequestDispatcher("/donor/donor-list.jsp").forward(req, resp);
        } else if (action.equals("add")) {
            req.getRequestDispatcher("/donor/donor-form.jsp").forward(req, resp);
        } else if (action.equals("edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Donor d = dao.getDonorById(id);
            req.setAttribute("donor", d);
            req.getRequestDispatcher("/donor/donor-form.jsp").forward(req, resp);
        } else if (action.equals("delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            dao.deleteDonor(id);
            resp.sendRedirect(req.getContextPath() + "/donor/list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        Donor d = new Donor();
        d.setFull_name(req.getParameter("full_name"));
        d.setEmail(req.getParameter("email"));
        d.setPhone(req.getParameter("phone"));
        d.setAddress(req.getParameter("address"));
        d.setDonor_type(req.getParameter("donor_type"));
        if ("create".equals(action)) {
            dao.addDonor(d);
        } else if ("update".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            d.setId(id);
            dao.updateDonor(d);
        }
        resp.sendRedirect(req.getContextPath() + "/donor/list");
    }
}