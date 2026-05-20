package orphanage.model;

import java.sql.Timestamp;

public class VolunteerApplication {
    private int id;
    private String fullName;
    private String email;
    private String phone;
    private String skillArea;
    private String availability;
    private String message;
    private Timestamp submittedDate;
    private String status;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getAvailability() { return availability; }
    public void setAvailability(String availability) { this.availability = availability; }
    public String getSkillArea() { return skillArea; }
    public void setSkillArea(String skillArea) { this.skillArea = skillArea; }
    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
    public Timestamp getSubmittedDate() { return submittedDate; }
    public void setSubmittedDate(Timestamp submittedDate) { this.submittedDate = submittedDate; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
