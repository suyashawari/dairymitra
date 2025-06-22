//
//
//package com.dairy.backend.model;
//
//import jakarta.persistence.*;
//import lombok.AllArgsConstructor;
//import lombok.Data;
//import lombok.NoArgsConstructor;
//
//
//@Entity
//@Data
//@AllArgsConstructor
//@NoArgsConstructor
//public class MilkRequest {
//
//    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
//    private Long id;
//
//    private double liters;
//    private double fatPercentage;
//    private double proteinPercentage;
//    private double waterContent;
//    private double pricePerLiter;
//
//    // Request status: PENDING, APPROVED, or REJECTED
//    private String status;
//    @ManyToOne
//    @JoinColumn(name = "farmer_id")
//    private Farmer farmer;// Simple field to identify the farmer
//
//    // Constructors, getters, and setters
//
//
//
//    // Getters and setters below
//
//
//}
//
//

package com.dairy.backend.model;

import jakarta.persistence.*;
import lombok.Data;

import java.time.ZonedDateTime;
@Data
@Entity
@Table(name = "milk_requests")
public class MilkRequest {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private ZonedDateTime date;
    private double liters;
    private double fatPercentage;
    private double proteinPercentage;
    private int waterContent;
    private double pricePerLiter;
    private double totalPrice;
    private String paymentMethod;

    // New field to capture the status of the request
    private String status; // e.g., "SUCCESSFUL", "PENDING", etc.

    // Existing relationship for the farmer remains but can be set via the employee
    @ManyToOne
    private Farmer farmer;

    // You might want to capture the employee who added the request:
    private String employee; // Or create a relationship if Employee is an entity

    // Getters and setters
    // ...

    @PrePersist
    public void prePersist() {
        // If an employee is adding the request, mark it as successful automatically
        if (employee != null && !employee.isEmpty()) {
            this.status = "SUCCESSFUL";
        }
    }
}

