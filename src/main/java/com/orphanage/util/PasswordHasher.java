package com.orphanage.util;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;

public class PasswordHasher {
    private static final int SALT_BYTES = 16;

    private PasswordHasher() {}

    public static String generateSaltBase64() {
        byte[] salt = new byte[SALT_BYTES];
        new SecureRandom().nextBytes(salt);
        return Base64.getEncoder().encodeToString(salt);
    }

    public static String hashPasswordBase64(String password, String saltBase64) {
        if (password == null) password = "";
        if (saltBase64 == null) saltBase64 = "";

        byte[] salt = Base64.getDecoder().decode(saltBase64);
        byte[] pwdBytes = password.getBytes(StandardCharsets.UTF_8);

        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            md.update(salt);
            byte[] digest = md.digest(pwdBytes);
            return Base64.getEncoder().encodeToString(digest);
        } catch (NoSuchAlgorithmException e) {
            throw new IllegalStateException("SHA-256 not available", e);
        }
    }

    public static boolean verify(String password, String saltBase64, String expectedHashBase64) {
        if (expectedHashBase64 == null) return false;
        String actual = hashPasswordBase64(password, saltBase64);
        return constantTimeEquals(actual, expectedHashBase64);
    }

    private static boolean constantTimeEquals(String a, String b) {
        if (a == null || b == null) return false;
        byte[] ba = a.getBytes(StandardCharsets.UTF_8);
        byte[] bb = b.getBytes(StandardCharsets.UTF_8);
        int diff = ba.length ^ bb.length;
        for (int i = 0; i < Math.min(ba.length, bb.length); i++) diff |= ba[i] ^ bb[i];
        return diff == 0;
    }
}
