//package com.dairy.backend.service;
//
//import com.dairy.backend.exception.FarmerNotFoundException;
//import com.dairy.backend.model.Farmer;
//import com.dairy.backend.model.MilkRequest;
//import com.dairy.backend.model.Payment;
//import com.dairy.backend.model.TransactionType;
//import com.dairy.backend.repository.FarmerRepository;
//import com.dairy.backend.repository.PaymentRepository;
//import jakarta.transaction.Transactional;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.security.core.context.SecurityContextHolder;
//import org.springframework.security.core.userdetails.UserDetails;
//import org.springframework.stereotype.Service;
//
//import java.time.LocalDateTime;
//import java.util.List;
//
//@Service
//public class PaymentService {
//
//    @Autowired
//    private PaymentRepository paymentRepository;
//
//    @Autowired
//    private FarmerRepository farmerRepository;
//
//    // Create a payment record when an employee approves the milk request
////    @Transactional
////    public Payment createPayment(MilkRequest request) {
////        double amount = request.getLiters() * request.getPricePerLiter();
////
////        // Update Farmer's Wallet Money
////        Farmer farmer = farmerRepository.findByName(request.getFarmerName())
////                .orElseThrow(() -> new RuntimeException("Farmer not found"));
////
////        farmer.setWalletMoney(farmer.getWalletMoney() + amount);
////        farmerRepository.save(farmer);
////
////        // Create and Save Payment Record
////        Payment payment = new Payment();
////        payment.setMilkRequestId(request.getId());
////        payment.setFarmerName(request.getFarmerName());
////        payment.setAmount(amount);
////        payment.setPaymentDate(LocalDateTime.now());
////        payment.setTransactionType(TransactionType.CREDIT); // Mark as CREDIT
////
////        return paymentRepository.save(payment);
////    }
//
//    @Transactional
//    public Payment createPayment(MilkRequest request) {
//        // Get the farmer directly from the request
//        Farmer farmer = request.getFarmer();
//
//        // Calculate payment amount
//        double amount = request.getLiters() * request.getPricePerLiter();
//
//        // Update farmer's wallet
//        farmer.setWalletMoney(farmer.getWalletMoney() + amount);
//        farmerRepository.save(farmer);
//
//        // Create payment record
//        Payment payment = new Payment();
//        payment.setMilkRequestId(request.getId());
//        payment.setFarmerName(farmer.getName()); // Optional: Keep farmer name for reporting
//        payment.setAmount(amount);
//        payment.setTransactionType(TransactionType.CREDIT);
//        payment.setPaymentDate(LocalDateTime.now());
//        return paymentRepository.save(payment);
//    }
//
//    // Retrieve all payments for a farmer
//    public List<Payment> findPaymentsByFarmer(String farmerName) {
//        return paymentRepository.findByFarmerName(farmerName);
//    }
//
//    // Get the total wallet balance of a farmer
//    public double getFarmerWalletBalance(String farmerName) {
//        Farmer farmer = farmerRepository.findByName(farmerName)
//                .orElseThrow(() -> new RuntimeException("Farmer not found"));
//        return farmer.getWalletMoney();
//    }
//
//    // Debit money from farmer's wallet (Only if bank details exist)
////    @Transactional
//    public Payment debitMoney(String farmerName, double amount) {
//        Farmer farmer = farmerRepository.findByName(farmerName)
//                .orElseThrow(() -> new RuntimeException("Farmer not found"));
//
//        // Validate if bank details exist
//        if (farmer.getBankDetails() == null || !farmer.getBankDetails().containsKey("accountNumber")) {
//            throw new UnauthorizedException("Bank details missing. Add your bank details before withdrawal.");
//        }
//
//        if (farmer.getWalletMoney() < amount) {
//            throw new RuntimeException("Insufficient balance in wallet.");
//        }
//
//        // Deduct money from wallet
//        farmer.setWalletMoney(farmer.getWalletMoney() - amount);
//        farmerRepository.save(farmer);
//
//        // Record DEBIT transaction
//        Payment debitTransaction = new Payment();
//        debitTransaction.setFarmerName(farmerName);
//        debitTransaction.setAmount(amount);
//        debitTransaction.setPaymentDate(LocalDateTime.now());
//        debitTransaction.setTransactionType(TransactionType.DEBIT); // Mark as DEBIT
//
//        return paymentRepository.save(debitTransaction);
//    }
//
//    // Get all transactions (Credits & Debits) sorted by date
//    public List<Payment> getAllTransactions(String farmerName) {
//        return paymentRepository.findByFarmerNameOrderByPaymentDateDesc(farmerName);
//    }
//    public String getAuthenticatedFarmer() {
//        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//        if (principal instanceof UserDetails) {
//            return ((UserDetails) principal).getUsername();
//        } else {
//            throw new RuntimeException("Authentication error: No valid farmer found.");
//        }
//    }
//
//}

package com.dairy.backend.service;

import com.dairy.backend.model.BankDetails;
import com.dairy.backend.model.Farmer;
import com.dairy.backend.model.MilkRequest;
import com.dairy.backend.model.Payment;
import com.dairy.backend.model.TransactionType;
import com.dairy.backend.repository.FarmerRepository;
import com.dairy.backend.repository.PaymentRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class PaymentService {

    @Autowired
    private PaymentRepository paymentRepository;

    @Autowired
    private FarmerRepository farmerRepository;

    /**
     * Create a payment record for a milk request.
     * The payment amount is calculated from the milk request's liters and price per liter.
     * The farmer's wallet is credited with the amount, and a Payment record is created.
     */
    @Transactional
    public Payment createPayment(MilkRequest request) {
        // Get the farmer directly from the milk request
        Farmer farmer = request.getFarmer();

        // Calculate payment amount
        double amount = request.getLiters() * request.getPricePerLiter();

        // Update farmer's wallet
        farmer.setWalletMoney(farmer.getWalletMoney() + amount);
        farmerRepository.save(farmer);

        // Create payment record
        Payment payment = new Payment();
        payment.setMilkRequestId(request.getId());
        payment.setFarmerName(farmer.getName()); // Optional: Keep farmer name for reporting
        payment.setAmount(amount);
        payment.setTransactionType(TransactionType.CREDIT);
        payment.setPaymentDate(LocalDateTime.now());
        return paymentRepository.save(payment);
    }

    /**
     * Retrieve all payments for a farmer, sorted by payment date in descending order.
     * @param farmerEmail the email of the farmer.
     */
    public List<Payment> findPaymentsByFarmer(String farmerEmail) {
        return paymentRepository.findByFarmerNameOrderByPaymentDateDesc(farmerEmail);
    }

    /**
     * Get the total wallet balance for a farmer.
     * @param farmerEmail the email of the farmer.
     */
    public double getFarmerWalletBalance(String farmerEmail) {
        Farmer farmer = farmerRepository.findByEmail(farmerEmail)
                .orElseThrow(() -> new RuntimeException("Farmer not found"));
        return farmer.getWalletMoney();
    }

    /**
     * Debit money from the farmer's wallet (only if bank details exist).
     * @param farmerEmail the email of the farmer.
     * @param amount the amount to withdraw.
     */
    @Transactional
    public Payment debitMoney(String farmerEmail, double amount) {
        Farmer farmer = farmerRepository.findByEmail(farmerEmail)
                .orElseThrow(() -> new RuntimeException("Farmer not found"));

        // Ensure bank details are present using the embedded BankDetails object
        BankDetails bankDetails = farmer.getBankDetails();
        if (bankDetails == null || bankDetails.getAccountNumber() == null || bankDetails.getAccountNumber().isEmpty()) {
            throw new UnauthorizedException("Bank details missing. Add your bank details before withdrawal.");
        }

        if (farmer.getWalletMoney() < amount) {
            throw new RuntimeException("Insufficient balance in wallet.");
        }

        // Deduct money from wallet
        farmer.setWalletMoney(farmer.getWalletMoney() - amount);
        farmerRepository.save(farmer);

        // Record DEBIT transaction
        Payment debitTransaction = new Payment();
        debitTransaction.setFarmerName(farmer.getName());
        debitTransaction.setAmount(amount);
        debitTransaction.setPaymentDate(LocalDateTime.now());
        debitTransaction.setTransactionType(TransactionType.DEBIT);

        return paymentRepository.save(debitTransaction);
    }

    /**
     * Retrieve all transactions (credits and debits) for the authenticated farmer.
     */

        public List<Payment> getAllTransactions() {
            String email = getAuthenticatedFarmerEmail();
            return paymentRepository.findByFarmerNameOrderByPaymentDateDesc(email);

    }
    private String getAuthenticatedFarmerEmail() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof UserDetails) {
            return ((UserDetails) principal).getUsername();
        } else {
            throw new RuntimeException("Authentication error: No valid farmer found.");
        }
    }


    /**
     * Helper method to get the authenticated farmer's email from the security context.
     */
    public String getAuthenticatedFarmer() {
        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        if (principal instanceof UserDetails) {
            return ((UserDetails) principal).getUsername();
        } else {
            throw new RuntimeException("Authentication error: No valid farmer found.");
        }
    }
}
