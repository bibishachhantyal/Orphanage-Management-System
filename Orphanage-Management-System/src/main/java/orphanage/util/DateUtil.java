package orphanage.util;

import java.time.LocalDate;
import java.time.Period;
import java.time.format.DateTimeParseException;

public final class DateUtil {
    private DateUtil() { }

    /** Uses system date; for display only (coursework). */
    public static int computeAgeYears(String isoDate) {
        if (isoDate == null || isoDate.length() < 10) {
            return 0;
        }
        try {
            LocalDate dob = LocalDate.parse(isoDate.substring(0, 10));
            return Period.between(dob, LocalDate.now()).getYears();
        } catch (DateTimeParseException e) {
            return 0;
        }
    }
}
