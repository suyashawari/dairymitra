////package com.dairy.backend.service;
////
////import com.dairy.backend.model.Farmer;
////import com.dairy.backend.model.MilkRequest;
////import com.dairy.backend.model.Payment;
////import com.dairy.backend.model.TransactionType;
////import com.dairy.backend.repository.FarmerRepository;
////import com.dairy.backend.repository.MilkRequestRepository;
////import com.dairy.backend.repository.PaymentRepository;
////import com.dairy.backend.util.PriceCalculator;
////import jakarta.transaction.Transactional;
////import org.springframework.beans.factory.annotation.Autowired;
////import org.springframework.security.core.context.SecurityContextHolder;
////import org.springframework.security.core.userdetails.UserDetails;
////import org.springframework.stereotype.Service;
////
////import java.time.LocalDateTime;
////import java.util.List;
////import java.util.Map;
////
////@Service
////public class FarmerService {
////
////    @Autowired
////    private FarmerRepository farmerRepository;
////
////    @Autowired
////    private MilkRequestRepository milkRequestRepository;
////
////    @Autowired
////    private PaymentRepository paymentRepository;
////
////    private static final double BASE_PRICE = 20.0;
////
////    /**
////     * 🥛 Submit a new milk request
////     */
////    public MilkRequest submitMilkRequest(MilkRequest request) {
////        // Get authenticated farmer
////        Farmer farmer = getFarmer(); // From security context
////
////        // Link the request to the farmer
////        request.setFarmer(farmer);
////        request.setStatus("PENDING");
////
////        // Calculate price
////        double pricePerLiter = PriceCalculator.calculatePrice(request.getFatPercentage(), BASE_PRICE);
////        request.setPricePerLiter(pricePerLiter);
////
////        return milkRequestRepository.save(request);
////    }
////
////    /**
////     * 📝 Retrieve all milk requests submitted by the authenticated farmer
////     */
////    public List<MilkRequest> getMilkRequestsByFarmer() {
////        return milkRequestRepository.findByFarmerName(getAuthenticatedFarmer());
////    }
////
////    /**
////     * 💰 Get total money in farmer's wallet
////     */
////    public double getTotalWalletMoney() {
////        return getFarmer().getWalletMoney();
////    }
////
////    /**
////     * 🔄 Approve a milk request and credit money to the farmer's wallet
////     */
//////    @Transactional
////    public Payment approveMilkRequestAndCreditPayment(MilkRequest request) {
////        if (!request.getStatus().equalsIgnoreCase("PENDING")) {
////            throw new RuntimeException("Only pending requests can be approved.");
////        }
////
////        double amount = request.getLiters() * request.getPricePerLiter();
////        request.setStatus("APPROVED");
////        milkRequestRepository.save(request);
////
////        Farmer farmer = getFarmer();
////        farmer.setWalletMoney(farmer.getWalletMoney() + amount);
////        farmerRepository.save(farmer);
////
////        Payment payment = new Payment();
////        payment.setMilkRequestId(request.getId());
////        payment.setFarmerName(farmer.getName());
////        payment.setAmount(amount);
////        payment.setPaymentDate(LocalDateTime.now());
////        payment.setTransactionType(TransactionType.CREDIT);
////
////        return paymentRepository.save(payment);
////    }
////
////    /**
////     * 🏦 Debit money from wallet (requires bank details)
////     */
//////    @Transactional
////    public Payment debitMoney(double amount) {
////        Farmer farmer = getFarmer();
////
////        // Ensure bank details are present
////        Map<String, String> bankDetails = farmer.getBankDetails();
////        if (bankDetails == null || !bankDetails.containsKey("accountNumber")) {
////            throw new RuntimeException("Bank details missing. Please add your bank details before withdrawing.");
////        }
////
////        if (farmer.getWalletMoney() < amount) {
////            throw new RuntimeException("Insufficient balance in wallet.");
////        }
////
////        farmer.setWalletMoney(farmer.getWalletMoney() - amount);
////        farmerRepository.save(farmer);
////
////        Payment debitTransaction = new Payment();
////        debitTransaction.setFarmerName(farmer.getName());
////        debitTransaction.setAmount(amount);
////        debitTransaction.setPaymentDate(LocalDateTime.now());
////        debitTransaction.setTransactionType(TransactionType.DEBIT);
////
////        return paymentRepository.save(debitTransaction);
////    }
////
////    /**
////     * 📜 Get all transactions (credits & debits) sorted by date
////     */
////    public List<Payment> getAllTransactions() {
////        return paymentRepository.findByFarmerNameOrderByPaymentDateDesc(getAuthenticatedFarmer());
////    }
////
////    /**
////     * 💳 Update farmer's bank details
////     */
//////    @Transactional
////    public Farmer updateBankDetails(Map<String, String> bankDetails) {
////        Farmer farmer = getFarmer();
////        farmer.setBankDetails(bankDetails);
////        return farmerRepository.save(farmer);
////    }
////
////    /**
////     * 🏦 Retrieve bank details of authenticated farmer
////     */
////    public Map<String, String> getBankDetails() {
////        return getFarmer().getBankDetails();
////    }
////
////    /**
////     * 🔑 Get authenticated farmer's username
////     */
////    private String getAuthenticatedFarmer() {
////        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
////        if (principal instanceof UserDetails) {
////            return ((UserDetails) principal).getUsername();
////        } else {
////            throw new RuntimeException("Authentication error: No valid farmer found.");
////        }
////    }
////
////    /**
////     * 🔍 Get the authenticated farmer's full details
////     */
////    private Farmer getFarmer() {
////        return farmerRepository.findByName(getAuthenticatedFarmer())
////                .orElseThrow(() -> new RuntimeException("Farmer not found"+ getAuthenticatedFarmer()));
////    }
////}
//
//
//
//package com.dairy.backend.service;
//
//import com.dairy.backend.model.BankDetails;
//import com.dairy.backend.model.Farmer;
//import com.dairy.backend.model.MilkRequest;
//import com.dairy.backend.model.Payment;
//import com.dairy.backend.repository.FarmerRepository;
//import com.dairy.backend.repository.MilkRequestRepository;
//import com.dairy.backend.repository.PaymentRepository;
//import com.dairy.backend.util.PriceCalculator;
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
//public class FarmerService {
//
//    @Autowired
//    private FarmerRepository farmerRepository;
//
//    @Autowired
//    private MilkRequestRepository milkRequestRepository;
//
//    @Autowired
//    private PaymentRepository paymentRepository;
//
//    private static final double BASE_PRICE = 20.0;
//
//    /**
//     * 🥛 Submit a new milk request by the authenticated farmer.
//     * The request is linked to the farmer (retrieved by email),
//     * marked as "PENDING", and its price per liter is calculated.
//     */
//    public MilkRequest submitMilkRequest(MilkRequest request) throws Exception {
//        // Get authenticated farmer
//        Farmer farmer = getFarmer(); // uses email from security context
//
//        // Link the request to the farmer and mark as pending
//        request.setFarmer(farmer);
//        request.setStatus("PENDING");
//
//        // Calculate price per liter based on fat percentage and base price
//        double pricePerLiter = PriceCalculator.calculatePrice(request.getFatPercentage(), BASE_PRICE);
//        request.setPricePerLiter(pricePerLiter);
//
//        // Optionally calculate total price if not provided
//        if (request.getTotalPrice() <= 0) {
//            double calculatedPrice = request.getLiters() * pricePerLiter;
//            request.setTotalPrice(calculatedPrice);
//        }
//
//        return milkRequestRepository.save(request);
//    }
//
//    /**
//     * Retrieve all milk requests submitted by the authenticated farmer,
//     * filtering by the farmer's email.
//     */
//    public List<MilkRequest> getMilkRequestsByFarmer() {
//        String email = getAuthenticatedFarmerEmail();
//        return milkRequestRepository.findByFarmerEmail(email);
//    }
//
//    /**
//     * Get total money in the farmer's wallet.
//     */
//    public double getTotalWalletMoney() {
//        return getFarmer().getWalletMoney();
//    }
//
//    /**
//     * Debit money from wallet (requires bank details to be present).
//     */
//    @Transactional
//    public Payment debitMoney(double amount) {
//        Farmer farmer = getFarmer();
//
//        // Ensure bank details are present using the embedded BankDetails object
//        BankDetails bankDetails = farmer.getBankDetails();
//        if (bankDetails == null || bankDetails.getIfscCode() == null || bankDetails.getIfscCode().isEmpty()) {
//            throw new RuntimeException("Bank details missing. Please add your bank details before withdrawing.");
//        }
//
//        if (farmer.getWalletMoney() < amount) {
//            throw new RuntimeException("Insufficient balance in wallet.");
//        }
//
//        farmer.setWalletMoney(farmer.getWalletMoney() - amount);
//        farmerRepository.save(farmer);
//
//        Payment debitTransaction = new Payment();
//        debitTransaction.setFarmerName(farmer.getName());
//        debitTransaction.setAmount(amount);
//        debitTransaction.setPaymentDate(LocalDateTime.now());
//        debitTransaction.setTransactionType(null); // Set to TransactionType.DEBIT if defined
//
//        return paymentRepository.save(debitTransaction);
//    }
//
//    /**
//     * Retrieve all transactions (both credits and debits) sorted by date (most recent first)
//     * for the authenticated farmer.
//     */
//    public List<Payment> getAllTransactions() {
//        String email = getAuthenticatedFarmerEmail();
//        return paymentRepository.findByFarmerEmailOrderByPaymentDateDesc(email);
//    }
//
//    /**
//     * Update the authenticated farmer's bank details.
//     */
//    @Transactional
//    public Farmer updateBankDetails(BankDetails bankDetails) {
//        Farmer farmer = getFarmer();
//        farmer.setBankDetails(bankDetails);
//        return farmerRepository.save(farmer);
//    }
//
//    /**
//     * Retrieve the authenticated farmer's bank details.
//     */
//    public BankDetails getBankDetails() {
//        return getFarmer().getBankDetails();
//    }
//
//    /**
//     * Helper method to get the authenticated farmer's email.
//     */
//    private String getAuthenticatedFarmerEmail() {
//        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
//        if (principal instanceof UserDetails) {
//            // assuming username is the email
//            return ((UserDetails) principal).getUsername();
//        } else {
//            throw new RuntimeException("Authentication error: No valid farmer found.");
//        }
//    }
//
//    /**
//     * Helper method to get the authenticated Farmer's full details using email.
//     */
//    private Farmer getFarmer() {
//        String email = getAuthenticatedFarmerEmail();
//        return farmerRepository.findByEmail(email)
//                .orElseThrow(() -> new RuntimeException("Farmer not found: " + email));
//    }
//}
