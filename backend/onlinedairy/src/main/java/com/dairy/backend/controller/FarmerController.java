//package com.dairy.backend.controller;
//
//import com.dairy.backend.model.Farmer;
//import com.dairy.backend.model.MilkRequest;
//import com.dairy.backend.service.FarmerService;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.*;
//
//import java.util.List;
//import java.util.Map;
//
//@RestController
//@RequestMapping("/api/farmer")
//public class FarmerController {
//
//    @Autowired
//    private FarmerService farmerService;
//
//    @GetMapping("/dashboard")
//    public ResponseEntity<String> farmerDashboard() {
//        return ResponseEntity.ok("Welcome Farmer!");
//    }
//
//    /**
//     * 🥛 Submit a new milk request
//     */
//    @PostMapping("/requests")
//    public ResponseEntity<MilkRequest> submitRequest(@RequestBody MilkRequest request) {
//        MilkRequest savedRequest = farmerService.submitMilkRequest(request);
//        System.out.println(savedRequest.toString());
//        return ResponseEntity.ok(savedRequest);
//    }
//
//    /**
//     * 📋 Get all milk requests of the authenticated farmer
//     */
//    @GetMapping("/requests")
//    public ResponseEntity<List<MilkRequest>> getRequests() {
//        List<MilkRequest> requests = farmerService.getMilkRequestsByFarmer();
//        System.out.println(requests.toString());
//        return ResponseEntity.ok(requests);
//    }
////    @GetMapping("/requests")
////    public ResponseEntity<String> getRequests() {
////     return new ResponseEntity<>("hello", HttpStatus.OK);
////    }
//
//    /**
//     * 💳 Update farmer's bank details
//     */
//    @PostMapping("/update-bank-details")
//    public ResponseEntity<Farmer> updateBankDetails(@RequestBody Map<String, String> bankDetails) {
//        Farmer updatedFarmer = farmerService.updateBankDetails(bankDetails);
//        return ResponseEntity.ok(updatedFarmer);
//    }
//
//    /**
//     * 🏦 Get the bank details of the authenticated farmer
//     */
//    @GetMapping("/bank-details")
//    public ResponseEntity<Map<String, String>> getBankDetails() {
//        Map<String, String> bankDetails = farmerService.getBankDetails();
//        return ResponseEntity.ok(bankDetails);
//    }
//
//    /**
//     * 💰 Get total wallet balance
//     */
//    @GetMapping("/wallet")
//    public ResponseEntity<Double> getWalletBalance() {
//
//        double balance = farmerService.getTotalWalletMoney();
//        System.out.println(balance);
//        return ResponseEntity.ok(balance);
//    }
//}
