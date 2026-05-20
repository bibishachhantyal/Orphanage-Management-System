package orphanage.servlet;

import orphanage.dao.ContactMessageDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/submitContact")
public class SubmitContactServlet extends HttpServlet {

    private final ContactMessageDAO contactDAO = new ContactMessageDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String name = trim(req.getParameter("name"));
        String email = trim(req.getParameter("email"));
        String subject = trim(req.getParameter("subject"));
        String message = trim(req.getParameter("message"));

        if (name.isEmpty() || email.isEmpty() || subject.isEmpty() || message.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/contact.html?error=missing");
            return;
        }

        contactDAO.insert(name, email, subject, message);
        resp.sendRedirect(req.getContextPath() + "/thankyou.jsp?type=contact");
    }

    private static String trim(String s) {
        return s == null ? "" : s.trim();
    }
}
