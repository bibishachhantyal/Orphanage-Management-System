package orphanage.service;

import orphanage.dao.OrphanDAO;
import orphanage.model.Orphan;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

public class OrphanService {
    private final OrphanDAO orphanDAO = new OrphanDAO();

    public List<Orphan> listByStatus(String statusFilter) {
        return orphanDAO.getOrphansByStatus(statusFilter);
    }

    public Orphan getById(int id) {
        return orphanDAO.getOrphanById(id);
    }

    public int getActiveCount() {
        return orphanDAO.getActiveCount();
    }

    public List<Orphan> searchActive(String query) {
        if (query == null || query.isBlank()) {
            return List.of();
        }
        return orphanDAO.searchActiveOrphans(query.trim());
    }

    public List<Orphan> getActiveForPublic() {
        return orphanDAO.getActiveOrphansForPublic();
    }

    public Map<String, Integer> getStatusCounts() {
        return orphanDAO.getCountByStatus();
    }

    public ServiceResult<Void> create(Orphan orphan) {
        String error = validate(orphan);
        if (error != null) {
            return ServiceResult.fail(error);
        }
        orphanDAO.addOrphan(orphan);
        return ServiceResult.ok();
    }

    public ServiceResult<Void> update(Orphan orphan) {
        if (orphan.getOrphan_id() <= 0) {
            return ServiceResult.fail("Invalid orphan record.");
        }
        String error = validate(orphan);
        if (error != null) {
            return ServiceResult.fail(error);
        }
        orphanDAO.updateOrphan(orphan);
        return ServiceResult.ok();
    }

    public void delete(int id) {
        orphanDAO.deleteOrphan(id);
    }

    public Orphan buildFromRequest(String firstName, String lastName, String dob, String gender,
                                   String health, String education, String enrollment, String status,
                                   String notes, String photo, String birthCert, String bloodGroup,
                                   String guardianName, String guardianPhone) {
        Orphan o = new Orphan();
        o.setFirst_name(trim(firstName));
        o.setLast_name(trim(lastName));
        o.setDate_of_birth(trim(dob));
        o.setGender(trim(gender));
        o.setHealth_status(trim(health));
        o.setEducation_level(trim(education));
        o.setEnrollment_date(trim(enrollment));
        o.setStatus(trim(status));
        o.setNotes(notes);
        o.setPhoto_path(trim(photo));
        o.setBirth_certificate_ref(trim(birthCert));
        o.setBlood_group(trim(bloodGroup));
        o.setGuardian_name(trim(guardianName));
        o.setGuardian_phone(trim(guardianPhone));
        return o;
    }

    public String validate(Orphan o) {
        if (o.getFirst_name().isEmpty() || o.getLast_name().isEmpty()) {
            return "First name and last name are required.";
        }
        if (!isEnrollmentConsistent(o.getDate_of_birth(), o.getEnrollment_date())) {
            return "Enrollment date cannot be before date of birth.";
        }
        return null;
    }

    static boolean isEnrollmentConsistent(String dob, String enrollment) {
        if (enrollment == null || enrollment.isBlank()) {
            return true;
        }
        if (dob == null || dob.isBlank()) {
            return true;
        }
        return enrollment.compareTo(dob) >= 0;
    }

    private static String trim(String s) {
        return s == null ? "" : s.trim();
    }
}
