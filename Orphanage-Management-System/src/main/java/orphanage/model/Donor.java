package orphanage.model;

public class Donor {
    private int id;
    private String full_name;
    private String email;
    private String phone;
    private String address;
    private String donor_type;
    // getters/setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getFull_name() { return full_name; }
    public void setFull_name(String full_name) { this.full_name = full_name; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }
    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }
    public String getDonor_type() { return donor_type; }
    public void setDonor_type(String donor_type) { this.donor_type = donor_type; }
}