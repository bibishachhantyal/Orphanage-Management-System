package orphanage.util;


import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

public class SessionUtil {
    public static HttpSession getSession(HttpServletRequest request) {
        return request.getSession();
    }
    public static void setAttribute(HttpServletRequest request, String name, Object value) {
        getSession(request).setAttribute(name, value);
    }
    public static Object getAttribute(HttpServletRequest request, String name) {
        return getSession(request).getAttribute(name);
    }
    public static void invalidate(HttpServletRequest request) {
        HttpSession session = request.getSession(false);
        if (session != null) session.invalidate();
    }
}