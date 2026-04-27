package util;

import org.mindrot.jbcrypt.BCrypt;

public class PasswordEncryption {

    public static String hashPassword(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt());
    }

    public static boolean verifyPassword(String password, String hash) {
        return BCrypt.checkpw(password, hash);
    }

    public static void main(String[] args) {
        String hash = hashPassword("test123");
        System.out.println("Hash: " + hash);
        System.out.println("Verify: " + verifyPassword("test123", hash));
    }
}