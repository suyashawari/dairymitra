package com.dairy.backend.model;

import jakarta.persistence.Embeddable;
import lombok.Data;

@Data
@Embeddable
public class BankDetails {
    private String accountHolder;
    private String accountNumber;
    private String ifscCode;

    // Getters and setters
    // ...
}
