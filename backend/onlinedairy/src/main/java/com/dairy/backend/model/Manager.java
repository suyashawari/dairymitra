//package com.dairy.backend.model;
//
//import jakarta.persistence.Entity;
//import jakarta.persistence.GeneratedValue;
//import jakarta.persistence.GenerationType;
//import jakarta.persistence.Id;
//import lombok.Data;
//
//@Entity
//@Data
//public class Manager {
//    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
//    private Long id;
//    private String name;
//    // Additional management details can be added
//
//    public Manager() {}
//
//    public Manager(String name) {
//        this.name = name;
//    }
//}
package com.dairy.backend.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
public class Manager {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private String email;
    private String phoneNumber;
    private String address;
    private String password;
    private String role;  // e.g., "ROLE_MANAGER"

    @Embedded
    private BankDetails bankDetails;
}
