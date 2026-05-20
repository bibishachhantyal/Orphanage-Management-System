package orphanage.model;

public class Donation {
    private int id;
    private int donor_id;
    private int orphan_id;
    private double amount;
    private String donation_date;
    private String payment_method;
    private String purpose;
    // getters/setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getDonor_id() { return donor_id; }
    public void setDonor_id(int donor_id) { this.donor_id = donor_id; }
    public int getOrphan_id() { return orphan_id; }
    public void setOrphan_id(int orphan_id) { this.orphan_id = orphan_id; }
    public double getAmount() { return amount; }
    public void setAmount(double amount) { this.amount = amount; }
    public String getDonation_date() { return donation_date; }
    public void setDonation_date(String donation_date) { this.donation_date = donation_date; }
    public String getPayment_method() { return payment_method; }
    public void setPayment_method(String payment_method) { this.payment_method = payment_method; }
    public String getPurpose() { return purpose; }
    public void setPurpose(String purpose) { this.purpose = purpose; }
}