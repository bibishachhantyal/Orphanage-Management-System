package com.orphanage.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * Donor entity — represents a donor record in the system.
 */
public class Donor {
    private int id;
    private String fullName;
    private String email;
    private String phone;
    private String address;
    private String donationType;       // MONETARY or IN_KIND
    private BigDecimal totalDonated;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    // ------------------------------------------------------------------ //
    // Constructors
    // ------------------------------------------------------------------ //
    public Donor() {
        this.totalDonated = BigDecimal.ZERO;
    }

    public Donor(int id, String fullName, String email, String phone,
                 String address, String donationType, BigDecimal totalDonated) {
        this.id = id;
        this.fullName = fullName;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.donationType = donationType;
        this.totalDonated = totalDonated;
    }

    // ------------------------------------------------------------------ //
    // Getters & Setters
    // ------------------------------------------------------------------ //
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getDonationType() { return donationType; }
    public void setDonationType(String donationType) { this.donationType = donationType; }

    public BigDecimal getTotalDonated() { return totalDonated; }
    public void setTotalDonated(BigDecimal totalDonated) { this.totalDonated = totalDonated; }

    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }

    public LocalDateTime getUpdatedAt() { return updatedAt; }
    public void setUpdatedAt(LocalDateTime updatedAt) { this.updatedAt = updatedAt; }

    // ------------------------------------------------------------------ //
    // toString
    // ------------------------------------------------------------------ //
    @Override
    public String toString() {
        return "Donor{" +
                "id=" + id +
                ", fullName='" + fullName + '\'' +
                ", email='" + email + '\'' +
                ", phone='" + phone + '\'' +
                ", donationType='" + donationType + '\'' +
                ", totalDonated=" + totalDonated +
                '}';
    }
}
