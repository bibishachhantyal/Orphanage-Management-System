package com.orphanage.utils;

public class TestConnection {
    public static void main(String[] args) {
        try (var conn = DatabaseConnection.getConnection()) {
            System.out.println("✅ Connection successful!");
        } catch (Exception e) {
            System.out.println("❌ Connection failed: " + e.getMessage());
            e.printStackTrace();
        }
    }
}

