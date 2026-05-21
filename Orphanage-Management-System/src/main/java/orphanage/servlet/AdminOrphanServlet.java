package orphanage.servlet;

import orphanage.model.Orphan;
import orphanage.service.OrphanService;
import orphanage.service.ServiceResult;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import orphanage.util.DateUtil;

import java.io.IOException;
import java.util.List;

@WebServlet("/admin/orphan")
public class AdminOrphanServlet extends HttpServlet {
    private final OrphanService orphanService = new OrphanService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null || "list".equals(action)) {
            String statusFilter = req.getParameter("status");
            if (statusFilter == null || statusFilter.isBlank()) {
                statusFilter = "all";
            }
            List<Orphan> list = orphanService.listByStatus(statusFilter);
            req.setAttribute("orphans", list);
            req.setAttribute("statusFilter", statusFilter);
            req.setAttribute("activeCount", orphanService.getActiveCount());
            req.getRequestDispatcher("/admin/orphan-list.jsp").forward(req, resp);
        } else if ("add".equals(action)) {
            req.setAttribute("newRecord", Boolean.TRUE);
            req.setAttribute("orphan", new Orphan());
            req.getRequestDispatcher("/admin/orphan-form.jsp").forward(req, resp);
        } else if ("edit".equals(action)) {
            Integer id = parseOrphanId(req);
            if (id == null) {
                redirectInvalidId(req, resp);
                return;
            }
            Orphan o = orphanService.getById(id);
            if (o == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }
            req.setAttribute("orphan", o);
            req.getRequestDispatcher("/admin/orphan-form.jsp").forward(req, resp);
        } else if ("view".equals(action)) {
            Integer id = parseOrphanId(req);
            if (id == null) {
                redirectInvalidId(req, resp);
                return;
            }
            Orphan o = orphanService.getById(id);
            if (o == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }
            req.setAttribute("orphan", o);
            req.setAttribute("ageYears", DateUtil.computeAgeYears(o.getDate_of_birth()));
            req.getRequestDispatcher("/admin/orphan-detail.jsp").forward(req, resp);
        } else if ("delete".equals(action)) {
            Integer id = parseOrphanId(req);
            if (id == null) {
                redirectInvalidId(req, resp);
                return;
            }
            orphanService.delete(id);
            resp.sendRedirect(req.getContextPath() + "/admin/orphan");
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/orphan");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        Orphan o = orphanService.buildFromRequest(
                req.getParameter("first_name"), req.getParameter("last_name"),
                req.getParameter("date_of_birth"), req.getParameter("gender"),
                req.getParameter("health_status"), req.getParameter("education_level"),
                req.getParameter("enrollment_date"), req.getParameter("status"),
                req.getParameter("notes"), req.getParameter("photo_path"),
                req.getParameter("birth_certificate_ref"), req.getParameter("blood_group"),
                req.getParameter("guardian_name"), req.getParameter("guardian_phone"));

        if ("create".equals(action)) {
            ServiceResult<Void> result = orphanService.create(o);
            if (!result.isSuccess()) {
                req.setAttribute("error", result.getMessage());
                req.setAttribute("orphan", o);
                req.setAttribute("newRecord", Boolean.TRUE);
                req.getRequestDispatcher("/admin/orphan-form.jsp").forward(req, resp);
                return;
            }
        } else if ("update".equals(action)) {
            Integer id = parseOrphanIdParam(req.getParameter("orphan_id"));
            if (id == null) {
                req.setAttribute("error", "Invalid orphan record.");
                req.setAttribute("orphan", o);
                req.setAttribute("newRecord", Boolean.FALSE);
                req.getRequestDispatcher("/admin/orphan-form.jsp").forward(req, resp);
                return;
            }
            o.setOrphan_id(id);
            ServiceResult<Void> result = orphanService.update(o);
            if (!result.isSuccess()) {
                req.setAttribute("error", result.getMessage());
                req.setAttribute("orphan", o);
                req.setAttribute("newRecord", Boolean.FALSE);
                req.getRequestDispatcher("/admin/orphan-form.jsp").forward(req, resp);
                return;
            }
        }
        resp.sendRedirect(req.getContextPath() + "/admin/orphan");
    }

    private static Integer parseOrphanId(HttpServletRequest req) {
        return parseOrphanIdParam(req.getParameter("id"));
    }

    private static Integer parseOrphanIdParam(String raw) {
        if (raw == null || raw.isBlank()) {
            return null;
        }
        try {
            int id = Integer.parseInt(raw.trim());
            return id > 0 ? id : null;
        } catch (NumberFormatException e) {
            return null;
        }
    }

    private static void redirectInvalidId(HttpServletRequest req, HttpServletResponse resp)
            throws IOException {
        resp.sendRedirect(req.getContextPath() + "/admin/orphan?error=invalid-id");
    }
}
