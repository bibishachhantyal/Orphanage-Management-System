package orphanage.util;

import jakarta.servlet.http.HttpSession;

import java.util.ArrayList;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Set;

public final class WishlistUtil {

    private static final String SESSION_KEY = "wishlistOrphanIds";

    private WishlistUtil() { }

    @SuppressWarnings("unchecked")
    public static Set<Integer> getIds(HttpSession session) {
        Object raw = session.getAttribute(SESSION_KEY);
        if (raw instanceof Set) {
            return (Set<Integer>) raw;
        }
        if (raw instanceof List) {
            return new LinkedHashSet<>((List<Integer>) raw);
        }
        LinkedHashSet<Integer> set = new LinkedHashSet<>();
        session.setAttribute(SESSION_KEY, set);
        return set;
    }

    public static List<Integer> getIdsAsList(HttpSession session) {
        return new ArrayList<>(getIds(session));
    }

    public static void add(HttpSession session, int orphanId) {
        getIds(session).add(orphanId);
    }

    public static void remove(HttpSession session, int orphanId) {
        getIds(session).remove(orphanId);
    }

    public static boolean contains(HttpSession session, int orphanId) {
        return getIds(session).contains(orphanId);
    }
}
