package orphanage.servlet;

import orphanage.dao.DonationDAO;
import orphanage.dao.DonorDAO;
import orphanage.dao.OrphanDAO;
import orphanage.model.Donation;
import orphanage.model.Donor;
import orphanage.model.Orphan;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/donation/list")
public class DonationServlet extends HttpServlet {
    private DonationDAO dao = new DonationDAO();
    private DonorDAO donorDAO = new DonorDAO();
    private OrphanDAO orphanDAO = new OrphanDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        // Populate donors and orphans for dropdowns in add/edit form
        req.setAttribute("donors", donorDAO.getAllDonors());
        req.setAttribute("orphans", orphanDAO.getActiveOrphansForPublic());

        if (action == null || action.equals("list")) {
            List<Donation> list = dao.getAllDonations();
            req.setAttribute("donations", list);
            Map<Integer, String> donorNames = new HashMap<>();
            for (Donor don : donorDAO.getAllDonors()) {
                donorNames.put(don.getId(), don.getFull_name());
            }
            Map<Integer, String> orphanNames = new HashMap<>();
            for (Orphan o : orphanDAO.getAllOrphans()) {
                orphanNames.put(o.getOrphan_id(), o.getFirst_name() + " " + o.getLast_name());
            }
            req.setAttribute("donorNames", donorNames);
            req.setAttribute("orphanNames", orphanNames);
            req.getRequestDispatcher("/donation/donation-list.jsp").forward(req, resp);
        } else if (action.equals("add")) {
            req.getRequestDispatcher("/donation/donation-form.jsp").forward(req, resp);
        } else if (action.equals("edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Donation d = dao.getDonationById(id);
            req.setAttribute("donation", d);
            req.getRequestDispatcher("/donation/donation-form.jsp").forward(req, resp);
        } else if (action.equals("delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            dao.deleteDonation(id);
            resp.sendRedirect(req.getContextPath() + "/donation/list");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        Donation d = new Donation();
        d.setDonor_id(Integer.parseInt(req.getParameter("donor_id")));
        String orphanIdParam = req.getParameter("orphan_id");
        if (orphanIdParam != null && !orphanIdParam.isEmpty()) {
            d.setOrphan_id(Integer.parseInt(orphanIdParam));
        } else {
            d.setOrphan_id(0); // will be stored as NULL in DB (DAO handles via setNull)
        }
        d.setAmount(Double.parseDouble(req.getParameter("amount")));
        d.setDonation_date(req.getParameter("donation_date"));
        d.setPayment_method(req.getParameter("payment_method"));
        d.setPurpose(req.getParameter("purpose"));

        if ("create".equals(action)) {
            dao.addDonation(d);
        } else if ("update".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            d.setId(id);
            dao.updateDonation(d);
        }
        resp.sendRedirect(req.getContextPath() + "/donation/list");
    }
}