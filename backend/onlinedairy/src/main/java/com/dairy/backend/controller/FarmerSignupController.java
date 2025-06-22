package com.dairy.backend.controller;

import com.dairy.backend.dto.FarmerSignupDTO;
import com.dairy.backend.model.AppUser;
import com.dairy.backend.model.Farmer;
import com.dairy.backend.repository.AppUserRepository;
import com.dairy.backend.repository.FarmerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;
//
//@RestController
//@RequestMapping("/signup/farmer")
//public class FarmerSignupController {
//
//    @Autowired
//    private AppUserRepository userRepository;
//
//    @Autowired
//    private PasswordEncoder passwordEncoder;
//
//    @PostMapping
//    public String signup(@RequestBody AppUser user) {
//        // Assign the farmer role
//        user.setRole("ROLE_FARMER");
//        // Encrypt the password before saving
//        user.setPassword(passwordEncoder.encode(user.getPassword()));
//        userRepository.save(user);
//        return "Farmer signed up successfully!";
//    }
//}
//@RestController
//@RequestMapping("/signup/farmer")
//public class FarmerSignupController {
//
//    @Autowired
//    private AppUserRepository userRepository;
//
//    @Autowired
//    private FarmerRepository farmerRepository;
//
//    @Autowired
//    private PasswordEncoder passwordEncoder;
//
//    @PostMapping
//    public String signup(@RequestBody FarmerSignupDTO signupRequest) {
//        // Create AppUser
//        AppUser user = new AppUser();
//        user.setName(signupRequest.getUsername());
//        user.setPassword(passwordEncoder.encode(signupRequest.getPassword()));
//        user.setRole("ROLE_FARMER");
//        userRepository.save(user);
//
//        // Create Farmer with Bank Details
//        Farmer farmer = new Farmer(signupRequest.getUsername());
//        farmer.setBankDetails(signupRequest.getBankDetails());
//        farmerRepository.save(farmer);
//
//        return "Farmer signed up successfully!";
//    }
//}