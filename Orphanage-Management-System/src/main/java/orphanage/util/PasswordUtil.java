package orphanage.util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordUtil {

  private static final String STRONG_PATTERN =
      "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&#^()_\\-+=.,])[A-Za-z\\d@$!%*?&#^()_\\-+=.,]{8,}$";

  /** At least 8 chars with upper, lower, digit, and special (e.g. Admin@123). */
  public static boolean isStrongPassword(String plain) {
    return plain != null && plain.matches(STRONG_PATTERN);
  }

    public static String hashPassword(String plain) {
        return BCrypt.hashpw(plain, BCrypt.gensalt());
    }

    /** Verifies a plain password against a BCrypt hash stored in the database. */
    public static boolean checkPassword(String plain, String stored) {
        if (plain == null || stored == null) {
            return false;
        }
        if (!stored.startsWith("$2a$") && !stored.startsWith("$2b$")) {
            return false;
        }
        try {
            return BCrypt.checkpw(plain, stored);
        } catch (IllegalArgumentException e) {
            return false;
        }
    }
}
