package com.dairy.backend.controller;

import com.dairy.backend.model.AppUser;
import com.dairy.backend.repository.AppUserRepository;
import com.dairy.backend.service.AuthService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.*;

//@RestController
//@RequestMapping("/signup/employee")
//public class EmployeeSignupController {
//
//    @Autowired
//    private AppUserRepository userRepository;
//
//    @Autowired
//    private PasswordEncoder passwordEncoder;
//
//    @PostMapping
//    public String signup(@RequestBody AppUser user) {
//        user.setRole("ROLE_EMPLOYEE");
//        user.setPassword(passwordEncoder.encode(user.getPassword()));
//        userRepository.save(user);
//        return "Employee signed up successfully!";
//    }
//
//}
//@RestController
//@RequestMapping("/signup/employee")
//public class EmployeeSignupController {
//
//    private final AuthService authService;
//
//    public EmployeeSignupController(AuthService authService) {
//        this.authService = authService;
//    }
//
//    @PostMapping
//    public String signup(@RequestBody AppUser user) {
//        return authService.signup(user);
//    }
//}