package util;

public class InputValidator {

    public static String sanitize(String input) {
        if (input == null) return null;
        return input.replaceAll("['\";--]", "");
    }

    public static boolean isEmpty(String input) {
        return input == null || input.trim().isEmpty();
    }
}