package orphanage.servlet;

import orphanage.dao.OrphanDAO;
import orphanage.util.WishlistUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/user/wishlist")
public class WishlistServlet extends HttpServlet {

    private final OrphanDAO orphanDAO = new OrphanDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        HttpSession session = req.getSession();
        req.setAttribute("orphans", orphanDAO.getOrphansByIds(WishlistUtil.getIdsAsList(session)));
        req.setAttribute("wishlistIds", WishlistUtil.getIds(session));
        req.getRequestDispatcher("/user/wishlist.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        String idParam = req.getParameter("orphanId");
        String redirect = req.getParameter("redirect");
        HttpSession session = req.getSession();

        if (idParam != null && !idParam.isBlank()) {
            try {
                int orphanId = Integer.parseInt(idParam.trim());
                if ("remove".equalsIgnoreCase(action)) {
                    WishlistUtil.remove(session, orphanId);
                } else {
                    WishlistUtil.add(session, orphanId);
                }
            } catch (NumberFormatException ignored) { }
        }

        String target = redirect != null && !redirect.isBlank()
                ? redirect
                : req.getContextPath() + "/user/wishlist";
        resp.sendRedirect(target);
    }
}
