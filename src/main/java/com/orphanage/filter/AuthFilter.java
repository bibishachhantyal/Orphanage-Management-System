package com.orphanage.filter;

import com.orphanage.model.User;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter("/*")
public class AuthFilter implements Filter {

    @Override
    public void init(FilterConfig filterConfig) {}

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest  req  = (HttpServletRequest)  request;
        HttpServletResponse resp = (HttpServletResponse) response;

        HttpSession session = req.getSession(false);
        // Read the "user" object from session
        User user = (session == null) ? null : (User) session.getAttribute("user");
        String role = (user == null) ? null : user.getRole();

        String uri         = req.getRequestURI();
        String contextPath = req.getContextPath();
        String path        = uri.substring(contextPath.length());

        // Always allow static resources (CSS, JS, images, fonts)
        if (isStaticResource(path)) {
            chain.doFilter(request, response);
            return;
        }

        boolean isAuthPage = path.equals("/login") || path.equals("/register")
                          || path.equals("/login.jsp") || path.equals("/register.jsp")
                          || path.equals("/logout") || path.equals("/error.jsp");

        if (user == null && !isAuthPage) {
            resp.sendRedirect(contextPath + "/login");
            return;
        }

        if (user != null && isAuthPage && !path.equals("/logout")) {
            // Already logged in — go to appropriate dashboard
            if ("ADMIN".equalsIgnoreCase(role)) {
                resp.sendRedirect(contextPath + "/admin/dashboard");
            } else {
                resp.sendRedirect(contextPath + "/user/dashboard.jsp");
            }
            return;
        }

        if (path.startsWith("/admin/") && !"ADMIN".equalsIgnoreCase(role)) {
            resp.sendRedirect(contextPath + "/user/dashboard.jsp");
            return;
        }

        chain.doFilter(request, response);
    }

    /**
     * Check if the request is for a static resource.
     * Uses both path prefix AND file extension checks for maximum reliability.
     */
    private boolean isStaticResource(String path) {
        // Path-based check
        if (path.startsWith("/static/")) return true;

        // Extension-based check for common static file types
        String lowerPath = path.toLowerCase();
        return lowerPath.endsWith(".css")
            || lowerPath.endsWith(".js")
            || lowerPath.endsWith(".png")
            || lowerPath.endsWith(".jpg")
            || lowerPath.endsWith(".jpeg")
            || lowerPath.endsWith(".gif")
            || lowerPath.endsWith(".svg")
            || lowerPath.endsWith(".ico")
            || lowerPath.endsWith(".woff")
            || lowerPath.endsWith(".woff2")
            || lowerPath.endsWith(".ttf")
            || lowerPath.endsWith(".eot")
            || lowerPath.endsWith(".map");
    }

    @Override
    public void destroy() {}
}
