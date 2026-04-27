package com.orphanage.util;

import java.time.LocalDate;
import java.time.format.DateTimeParseException;

public class DateUtil {
    private DateUtil() {}

    public static LocalDate parseIsoDate(String v, String fieldName) {
        if (v == null || v.isBlank()) throw new IllegalArgumentException(fieldName + " is required");
        try {
            return LocalDate.parse(v.trim());
        } catch (DateTimeParseException e) {
            throw new IllegalArgumentException("Invalid " + fieldName + " (use YYYY-MM-DD)");
        }
    }
}
