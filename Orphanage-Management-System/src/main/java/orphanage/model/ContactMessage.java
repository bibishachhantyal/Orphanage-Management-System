package orphanage.model;

import java.sql.Timestamp;

public class ContactMessage {
    private int id;
    private String name;
    private String email;
    private String subject;
    private String message;
    private Timestamp submittedDate;
    private String status;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getSubject() { return subject; }
    public void setSubject(String subject) { this.subject = subject; }
    public String getMessage() { return message; }
    public void setMessage(String message) { this.message = message; }
    public Timestamp getSubmittedDate() { return submittedDate; }
    public void setSubmittedDate(Timestamp submittedDate) { this.submittedDate = submittedDate; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}
