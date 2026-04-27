package com.orphanage.model;

import java.time.LocalDate;

public class Sponsor {
    private int id;
    private int userId;
    private String childName;     // simple milestone field (can be FK later)
    private double monthlyAmount;
    private LocalDate startDate;
    private String note;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getChildName() { return childName; }
    public void setChildName(String childName) { this.childName = childName; }

    public double getMonthlyAmount() { return monthlyAmount; }
    public void setMonthlyAmount(double monthlyAmount) { this.monthlyAmount = monthlyAmount; }

    public LocalDate getStartDate() { return startDate; }
    public void setStartDate(LocalDate startDate) { this.startDate = startDate; }

    public String getNote() { return note; }
    public void setNote(String note) { this.note = note; }
}
