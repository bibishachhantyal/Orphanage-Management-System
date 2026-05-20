package orphanage.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import orphanage.dao.OrphanDAO;
import orphanage.model.Orphan;

import orphanage.util.DateUtil;

import java.io.IOException;
import java.util.List;

/**
 * Public read-only orphan browsing (no login). Lists active children only;
 * detail view also restricted to active records.
 */
@WebServlet("/public/orphans")
public class PublicOrphanServlet extends HttpServlet {

    private final OrphanDAO dao = new OrphanDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String idParam = req.getParameter("id");
        if (idParam != null && !idParam.isBlank()) {
            try {
                int id = Integer.parseInt(idParam.trim());
                Orphan o = dao.getOrphanById(id);
                if (o == null || !"active".equalsIgnoreCase(o.getStatus())) {
                    resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                    return;
                }
                req.setAttribute("orphan", o);
                req.setAttribute("ageYears", DateUtil.computeAgeYears(o.getDate_of_birth()));
                req.getRequestDispatcher("/public/orphan-detail.jsp").forward(req, resp);
            } catch (NumberFormatException e) {
                resp.sendRedirect(req.getContextPath() + "/public/orphans");
            }
        } else {
            List<Orphan> list = dao.getActiveOrphansForPublic();
            req.setAttribute("orphans", list);
            req.getRequestDispatcher("/public/orphan-list.jsp").forward(req, resp);
        }
    }
}
