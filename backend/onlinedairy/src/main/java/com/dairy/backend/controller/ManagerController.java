//package com.dairy.backend.controller;
//import com.dairy.backend.model.MilkRequest;
//import com.dairy.backend.service.ManagerService;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.web.bind.annotation.*;
//
//import java.util.List;
//
//@RestController
//@RequestMapping("/api/manager")
//public class ManagerController {
//
//    @Autowired
//    private ManagerService managerService;
//    @GetMapping("/dashboard")
//    public String managerDashboard() {
//        return "Welcome Manager!";
//    }
//    // Endpoint for a manager to get all milk requests (for reporting purposes)
//    @GetMapping("/requests")
//    public List<MilkRequest> getAllRequests() {
//        return managerService.getAllMilkRequests();
//    }
//}
