package orphanage.servlet;

import orphanage.dao.OrphanDAO;
import orphanage.model.Orphan;
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
    private final OrphanDAO dao = new OrphanDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null || "list".equals(action)) {
            String statusFilter = req.getParameter("status");
            if (statusFilter == null || statusFilter.isBlank()) {
                statusFilter = "all";
            }
            List<Orphan> list = dao.getOrphansByStatus(statusFilter);
            req.setAttribute("orphans", list);
            req.setAttribute("statusFilter", statusFilter);
            req.setAttribute("activeCount", dao.getActiveCount());
            req.getRequestDispatcher("/admin/orphan-list.jsp").forward(req, resp);
        } else if ("add".equals(action)) {
            req.setAttribute("newRecord", Boolean.TRUE);
            req.setAttribute("orphan", new Orphan());
            req.getRequestDispatcher("/admin/orphan-form.jsp").forward(req, resp);
        } else if ("edit".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            Orphan o = dao.getOrphanById(id);
            req.setAttribute("orphan", o);
            req.getRequestDispatcher("/admin/orphan-form.jsp").forward(req, resp);
        } else if ("view".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            Orphan o = dao.getOrphanById(id);
            if (o == null) {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
                return;
            }
            req.setAttribute("orphan", o);
            req.setAttribute("ageYears", DateUtil.computeAgeYears(o.getDate_of_birth()));
            req.getRequestDispatcher("/admin/orphan-detail.jsp").forward(req, resp);
        } else if ("delete".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            dao.deleteOrphan(id);
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
        Orphan o = new Orphan();
        o.setFirst_name(trim(req.getParameter("first_name")));
        o.setLast_name(trim(req.getParameter("last_name")));
        o.setDate_of_birth(trim(req.getParameter("date_of_birth")));
        o.setGender(trim(req.getParameter("gender")));
        o.setHealth_status(trim(req.getParameter("health_status")));
        o.setEducation_level(trim(req.getParameter("education_level")));
        o.setEnrollment_date(trim(req.getParameter("enrollment_date")));
        o.setStatus(trim(req.getParameter("status")));
        o.setNotes(req.getParameter("notes"));
        o.setPhoto_path(trim(req.getParameter("photo_path")));
        o.setBirth_certificate_ref(trim(req.getParameter("birth_certificate_ref")));
        o.setBlood_group(trim(req.getParameter("blood_group")));
        o.setGuardian_name(trim(req.getParameter("guardian_name")));
        o.setGuardian_phone(trim(req.getParameter("guardian_phone")));

        if (o.getFirst_name().isEmpty() || o.getLast_name().isEmpty()) {
            req.setAttribute("error", "First name and last name are required.");
            req.setAttribute("orphan", o);
            req.setAttribute("newRecord", "create".equals(action));
            req.getRequestDispatcher("/admin/orphan-form.jsp").forward(req, resp);
            return;
        }
        if (!isEnrollmentConsistent(o.getDate_of_birth(), o.getEnrollment_date())) {
            req.setAttribute("error", "Enrollment date cannot be before date of birth.");
            req.setAttribute("orphan", o);
            req.setAttribute("newRecord", "create".equals(action));
            if ("update".equals(action) && req.getParameter("orphan_id") != null) {
                try {
                    o.setOrphan_id(Integer.parseInt(req.getParameter("orphan_id")));
                } catch (NumberFormatException ignored) { }
            }
            req.getRequestDispatcher("/admin/orphan-form.jsp").forward(req, resp);
            return;
        }

        if ("create".equals(action)) {
            dao.addOrphan(o);
        } else if ("update".equals(action)) {
            int id = Integer.parseInt(req.getParameter("orphan_id"));
            o.setOrphan_id(id);
            dao.updateOrphan(o);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/orphan");
    }

    private static String trim(String s) {
        return s == null ? "" : s.trim();
    }

    /** ISO yyyy-MM-dd strings compare lexicographically by calendar order */
    static boolean isEnrollmentConsistent(String dob, String enrollment) {
        if (enrollment == null || enrollment.isBlank()) {
            return true;
        }
        if (dob == null || dob.isBlank()) {
            return true;
        }
        return enrollment.compareTo(dob) >= 0;
    }
}
