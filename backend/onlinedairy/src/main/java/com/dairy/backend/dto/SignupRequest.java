package com.dairy.backend.dto;

import com.dairy.backend.model.BankDetails;
import lombok.Data;

@Data
public class SignupRequest {
    private String name;
    private String email;
    private String phoneNumber;
    private String address;
    private String password;
    private String role; // e.g., "ROLE_FARMER", "ROLE_MANAGER", "ROLE_EMPLOYEE"
    private BankDetails bankDetails;
}
