//package com.dairy.backend.controller;
//import com.dairy.backend.model.MilkRequest;
//import com.dairy.backend.service.EmployeeService;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.*;
//
//import java.util.List;
//
//@RestController
//@RequestMapping("/api/employee")
//public class EmployeeController {
//
//    @Autowired
//    private EmployeeService employeeService;
//
//
//    @GetMapping("/dashboard")
//    public String employeeDashboard() {
//        return "Welcome Employee!";
//    }
//    // Endpoint to get all pending requests
//    @GetMapping("/requests/pending")
//    public List<MilkRequest> getPendingRequests() {
//        return employeeService.getPendingRequests();
//    }
//
//    // Endpoint to approve a request
//    @PostMapping("/requests/{id}/approve")
//    public MilkRequest approveRequest(@PathVariable Long id) throws Exception {
//        return employeeService.approveRequest(id);
//    }
//
//    // Endpoint to reject a request
//    @PostMapping("/requests/{id}/reject")
//    public MilkRequest rejectRequest(@PathVariable Long id) throws Exception {
//        return employeeService.rejectRequest(id);
//    }
//
//
//    @PostMapping("/milk-request")
//    public ResponseEntity<MilkRequest> addMilkRequest(@RequestBody MilkRequest milkRequest) {
//        MilkRequest createdRequest = employeeService.addMilkRequest(milkRequest);
//        return ResponseEntity.ok(createdRequest);
//    }
//}
