package com.dairy.backend.model;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(name = "app_user")
public class AppUser {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private String email;
    private String phoneNumber;
    private String address;
    private String password;
    private String role;  // e.g., "ROLE_FARMER"

    @Embedded
    private BankDetails bankDetails;

}
