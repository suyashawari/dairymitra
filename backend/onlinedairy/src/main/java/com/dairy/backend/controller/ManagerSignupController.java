//package com.dairy.backend.controller;
//import com.dairy.backend.model.AppUser;
//import com.dairy.backend.repository.AppUserRepository;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.security.crypto.password.PasswordEncoder;
//import org.springframework.web.bind.annotation.*;
//
//@RestController
//@RequestMapping("/signup/manager")
//public class ManagerSignupController {
//
//    @Autowired
//    private AppUserRepository userRepository;
//
//    @Autowired
//    private PasswordEncoder passwordEncoder;
//
//    @PostMapping
//    public String signup(@RequestBody AppUser user) {
//        user.setRole("ROLE_MANAGER");
//        user.setPassword(passwordEncoder.encode(user.getPassword()));
//        userRepository.save(user);
//        return "Manager signed up successfully!";
//    }
//}
