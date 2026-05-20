package orphanage.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import orphanage.dao.DonationDAO;
import orphanage.dao.DonorDAO;
import orphanage.dao.OrphanDAO;
import orphanage.dao.VolunteerDAO;

import java.io.IOException;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

  private final OrphanDAO orphanDAO = new OrphanDAO();
  private final DonorDAO donorDAO = new DonorDAO();
  private final VolunteerDAO volunteerDAO = new VolunteerDAO();
  private final DonationDAO donationDAO = new DonationDAO();

  @Override
  protected void doGet(HttpServletRequest req, HttpServletResponse resp)
      throws ServletException, IOException {
    req.setAttribute("activeChildren", orphanDAO.getActiveCount());
    req.setAttribute("totalDonors", donorDAO.getTotalCount());
    req.setAttribute("totalVolunteers", volunteerDAO.getTotalCount());
    req.setAttribute("totalDonations", donationDAO.getTotalAmount());
    req.getRequestDispatcher("/index.jsp").forward(req, resp);
  }
}
