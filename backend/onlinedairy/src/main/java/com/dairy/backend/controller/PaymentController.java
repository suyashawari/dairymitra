//package com.dairy.backend.controller;
//import com.dairy.backend.model.Payment;
//import com.dairy.backend.service.PaymentService;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.web.bind.annotation.*;
//
//import java.util.ArrayList;
//import java.util.List;
//
//@RestController
//@RequestMapping("/api/farmer")
//public class PaymentController {
//
//    @Autowired
//    private PaymentService paymentService;
//
//    // Retrieve all payments for a given farmer.
//    @GetMapping("/payments")
//    public ResponseEntity<List<Payment>> getPayments() {
//        String farmerName = paymentService.getAuthenticatedFarmer();
//        if (farmerName == null) {
//            System.out.println(farmerName);
//            return new ResponseEntity<>(new ArrayList<>(),HttpStatus.NOT_FOUND);
//        }
//      List<Payment> paymentList=  paymentService.findPaymentsByFarmer(farmerName);
//        System.out.println(paymentList.toString());
//        return new ResponseEntity<>(paymentList, HttpStatus.OK);
//    }
//
//}
//
