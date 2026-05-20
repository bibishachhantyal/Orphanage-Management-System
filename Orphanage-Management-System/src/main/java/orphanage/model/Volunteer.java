package orphanage.model;

public class Volunteer {
    private int id;
    private String full_name;
    private String email;
    private String phone;
    private String skill_area;
    private String availability;
    private String joined_date;
    private String status;
    // getters/setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getFull_name() { return full_name; }
    public void setFull_name(String full_name) { this.full_name = full_name; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getSkill_area() { return skill_area; }
    public void setSkill_area(String skill_area) { this.skill_area = skill_area; }
    public String getAvailability() { return availability; }
    public void setAvailability(String availability) { this.availability = availability; }
    public String getJoined_date() { return joined_date; }
    public void setJoined_date(String joined_date) { this.joined_date = joined_date; }
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
}