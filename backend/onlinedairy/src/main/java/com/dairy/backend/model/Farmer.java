//package com.dairy.backend.model;
//
//
//import jakarta.persistence.*;
//import lombok.Data;
//
//import java.util.Map;
//
//@Entity
//@Data
//public class Farmer {
//    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
//    private Long id;
//    private String name;
//    // Other farmer details can be added
//
//    @ElementCollection
//    @CollectionTable(name = "farmer_bank_details", joinColumns = @JoinColumn(name = "farmer_id"))
//    @MapKeyColumn(name = "bank_detail_key")
//    @Column(name = "bank_detail_value")
//    private Map<String, String> bankDetails; // Stores "accountHolder", "accountNumber", "ifscCode"
//
//    private double walletMoney = 0.0;
//    public Farmer() {}
//
//    public Farmer(String name) {
//        this.name = name;
//    }
//
//}
//
package com.dairy.backend.model;

import jakarta.persistence.*;
import lombok.Data;

@Entity
@Data
public class Farmer {
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
    private double walletMoney = 0.0;
}
