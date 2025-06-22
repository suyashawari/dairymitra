//package com.dairy.backend.model;
//
//import jakarta.persistence.*;
//import java.time.LocalDateTime;
//
//@Entity
//@Table(name = "payments")
//public class Payment {
//
//    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
//    private Long id;
//
//    private Long milkRequestId;
//    private String farmerName;
//    private double amount;
//    private LocalDateTime paymentDate;
//
//    @Enumerated(EnumType.STRING)
//    private TransactionType transactionType; // Uses ENUM instead of string literals
//
//    // Getters and Setters
//    public Long getId() {
//        return id;
//    }
//
//    public void setId(Long id) {
//        this.id = id;
//    }
//
//    public Long getMilkRequestId() {
//        return milkRequestId;
//    }
//
//    public void setMilkRequestId(Long milkRequestId) {
//        this.milkRequestId = milkRequestId;
//    }
//
//    public String getFarmerName() {
//        return farmerName;
//    }
//
//    public void setFarmerName(String farmerName) {
//        this.farmerName = farmerName;
//    }
//
//    public double getAmount() {
//        return amount;
//    }
//
//    public void setAmount(double amount) {
//        this.amount = amount;
//    }
//
//    public LocalDateTime getPaymentDate() {
//        return paymentDate;
//    }
//
//    public void setPaymentDate(LocalDateTime paymentDate) {
//        this.paymentDate = paymentDate;
//    }
//
//    public TransactionType getTransactionType() {
//        return transactionType;
//    }
//
//    public void setTransactionType(TransactionType transactionType) {
//        this.transactionType = transactionType;
//    }
//}
package com.dairy.backend.model;

import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "payments")
public class Payment {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private Long milkRequestId;
    private String farmerName;
    private double amount;
    private LocalDateTime paymentDate;

    @Enumerated(EnumType.STRING)
    private TransactionType transactionType; // Uses ENUM instead of string literals

    // Getters and Setters

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getMilkRequestId() {
        return milkRequestId;
    }

    public void setMilkRequestId(Long milkRequestId) {
        this.milkRequestId = milkRequestId;
    }

    public String getFarmerName() {
        return farmerName;
    }

    public void setFarmerName(String farmerName) {
        this.farmerName = farmerName;
    }

    public double getAmount() {
        return amount;
    }

    public void setAmount(double amount) {
        this.amount = amount;
    }

    public LocalDateTime getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(LocalDateTime paymentDate) {
        this.paymentDate = paymentDate;
    }

    public TransactionType getTransactionType() {
        return transactionType;
    }

    public void setTransactionType(TransactionType transactionType) {
        this.transactionType = transactionType;
    }
}
