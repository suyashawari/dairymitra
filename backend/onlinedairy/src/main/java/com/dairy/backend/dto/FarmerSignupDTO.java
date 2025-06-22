package com.dairy.backend.dto;

import java.util.Map;

public class FarmerSignupDTO {
    private String username;
    private String password;
    private Map<String, String> bankDetails;

    // Getters and Setters
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public Map<String, String> getBankDetails() { return bankDetails; }
    public void setBankDetails(Map<String, String> bankDetails) { this.bankDetails = bankDetails; }
}