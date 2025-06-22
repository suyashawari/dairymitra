package com.dairy.backend.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
public class Employee {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private String email;
    private String phoneNumber;
    private String address;
    private String password;
    private String role;  // e.g., "ROLE_EMPLOYEE"

    @Embedded
    private BankDetails bankDetails;
}
