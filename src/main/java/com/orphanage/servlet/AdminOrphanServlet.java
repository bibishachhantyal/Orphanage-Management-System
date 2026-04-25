package com.orphanage.servlet;

import com.orphanage.dao.OrphanDAO;
import com.orphanage.model.Orphan;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/orphan")
public class AdminOrphanServlet extends HttpServlet {
    private OrphanDAO dao = new OrphanDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            List<Orphan> list = dao.getAllOrphans();
            req.setAttribute("orphans", list);
            req.getRequestDispatcher("/admin/orphan-list.jsp").forward(req, resp);
        } else if (action.equals("add")) {
            req.getRequestDispatcher("/admin/orphan-form.jsp").forward(req, resp);
        } else if (action.equals("edit")) {
            int id = Integer.parseInt(req.getParameter("id"));
            Orphan o = dao.getOrphanById(id);
            req.setAttribute("orphan", o);
            req.getRequestDispatcher("/admin/orphan-form.jsp").forward(req, resp);
        } else if (action.equals("delete")) {
            int id = Integer.parseInt(req.getParameter("id"));
            dao.deleteOrphan(id);
            resp.sendRedirect(req.getContextPath() + "/admin/orphan");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        String name = req.getParameter("name");
        int age = Integer.parseInt(req.getParameter("age"));
        if ("create".equals(action)) {
            Orphan o = new Orphan();
            o.setName(name);
            o.setAge(age);
            dao.addOrphan(o);
        } else if ("update".equals(action)) {
            int id = Integer.parseInt(req.getParameter("id"));
            Orphan o = new Orphan();
            o.setId(id);
            o.setName(name);
            o.setAge(age);
            dao.updateOrphan(o);
        }
        resp.sendRedirect(req.getContextPath() + "/admin/orphan");
    }
}