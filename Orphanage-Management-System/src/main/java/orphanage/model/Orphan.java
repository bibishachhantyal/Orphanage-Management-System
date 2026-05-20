package orphanage.model;

public class Orphan {
    private int orphan_id;
    private String first_name;
    private String last_name;
    private String date_of_birth;
    private String gender;
    private String health_status;
    private String education_level;
    private String enrollment_date;
    private String status;
    private String notes;
    /** Web path under context, e.g. images/orphans/placeholder.svg */
    private String photo_path;
    private String birth_certificate_ref;
    private String blood_group;
    private String guardian_name;
    private String guardian_phone;

    public int getOrphan_id() { return orphan_id; }
    public void setOrphan_id(int orphan_id) { this.orphan_id = orphan_id; }
    public String getFirst_name() { return first_name; }
    public void setFirst_name(String first_name) { this.first_name = first_name; }
    public String getLast_name() { return last_name; }
    public void setLast_name(String last_name) { this.last_name = last_name; }
    public String getDate_of_birth() { return date_of_birth; }
    public void setDate_of_birth(String date_of_birth) { this.date_of_birth = date_of_birth; }
    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }
    public String getHealth_status() { return health_status; }
    public void setHealth_status(String health_status) { this.health_status = health_status; }
    public String getEducation_level() { return education_level; }
    public void setEducation_level(String education_level) { this.education_level = education_level; }
    public String getEnrollment_date() { return enrollment_date; }
    public void setEnrollment_date(String enrollment_date) { this.enrollment_date = enrollment_date; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }
    public String getPhoto_path() { return photo_path; }
    public void setPhoto_path(String photo_path) { this.photo_path = photo_path; }
    public String getBirth_certificate_ref() { return birth_certificate_ref; }
    public void setBirth_certificate_ref(String birth_certificate_ref) { this.birth_certificate_ref = birth_certificate_ref; }
    public String getBlood_group() { return blood_group; }
    public void setBlood_group(String blood_group) { this.blood_group = blood_group; }
    public String getGuardian_name() { return guardian_name; }
    public void setGuardian_name(String guardian_name) { this.guardian_name = guardian_name; }
    public String getGuardian_phone() { return guardian_phone; }
    public void setGuardian_phone(String guardian_phone) { this.guardian_phone = guardian_phone; }
}
