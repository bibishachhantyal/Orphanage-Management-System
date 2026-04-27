package com.orphanage.util;

import java.util.regex.Pattern;

public class ValidationHelper {
    private static final Pattern EMAIL = Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$");
    private static final Pattern PHONE = Pattern.compile("^[0-9]{7,15}$");

    private ValidationHelper() {}

    public static String requireNonBlank(String v, String fieldName) {
        if (v == null || v.isBlank()) throw new IllegalArgumentException(fieldName + " is required");
        return v.trim();
    }

    public static String validateEmail(String email) {
        email = requireNonBlank(email, "Email");
        if (!EMAIL.matcher(email).matches()) throw new IllegalArgumentException("Invalid email format");
        return email.toLowerCase();
    }

    public static String validatePhoneOptional(String phone) {
        if (phone == null || phone.isBlank()) return null;
        phone = phone.trim();
        if (!PHONE.matcher(phone).matches()) throw new IllegalArgumentException("Invalid phone number");
        return phone;
    }

    public static String validateRole(String role) {
        role = requireNonBlank(role, "Role").toUpperCase();
        if (!role.equals("ADMIN") && !role.equals("DONOR") && !role.equals("VOLUNTEER")) {
            throw new IllegalArgumentException("Role must be ADMIN, DONOR, or VOLUNTEER");
        }
        return role;
    }

    public static void validatePassword(String password) {
        requireNonBlank(password, "Password");
        if (password.length() < 6) throw new IllegalArgumentException("Password must be at least 6 characters");
    }
}
