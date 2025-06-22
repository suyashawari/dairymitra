//package com.dairy.backend.service;
//import com.dairy.backend.model.MilkRequest;
//import com.dairy.backend.repository.MilkRequestRepository;
//import jakarta.transaction.Transactional;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//
//import java.util.List;
//import java.util.Optional;
//
//@Service
//public class EmployeeService {
//
//    @Autowired
//    private MilkRequestRepository milkRequestRepository;
//
//    @Autowired
//    private PaymentService paymentService;
//
//    // Get all pending milk requests for verification.
//    public List<MilkRequest> getPendingRequests() {
//        return milkRequestRepository.findByStatus("PENDING");
//    }
//
//    // Approve a milk request and create a corresponding payment.
//
////    public MilkRequest approveRequest(Long id) throws Exception {
////        Optional<MilkRequest> opt = milkRequestRepository.findById(id);
////        if (opt.isPresent()) {
////
////            System.out.println(opt.toString());
////            MilkRequest request = opt.get();
////            request.setStatus("APPROVED");
////            MilkRequest updated = milkRequestRepository.save(request);
////
////            // Create payment for the approved request.
////            paymentService.createPayment(updated);
////            return updated;
////        } else {
////            System.out.println(opt.toString());
////            throw new Exception("Request not found");
////        }
////    }
////@Transactional
//@Transactional
//public MilkRequest approveRequest(Long id) throws Exception {
//    Optional<MilkRequest> opt = milkRequestRepository.findById(id);
//    if (!opt.isPresent()) {
//        throw new Exception("Request not found");
//    }
//
//    MilkRequest request = opt.get();
//    if (request.getFarmer() == null) {
//        throw new Exception("Milk request has no associated farmer");
//    }
//
//    request.setStatus("APPROVED");
//    MilkRequest updated = milkRequestRepository.save(request);
//
//    // Trigger payment creation
//    paymentService.createPayment(updated);
//
//    return updated;
//}
//
//
//    // Reject a milk request.
//    public MilkRequest rejectRequest(Long id) throws Exception {
//        Optional<MilkRequest> opt = milkRequestRepository.findById(id);
//        if (opt.isPresent()) {
//            MilkRequest request = opt.get();
//            request.setStatus("REJECTED");
//            return milkRequestRepository.save(request);
//        } else {
//            throw new Exception("Request not found");
//        }
//    }
//
//    public MilkRequest addMilkRequest(MilkRequest milkRequest) {
//        // If needed, perform validations, calculations (using PriceCalculator), etc.
//        // For instance, calculate totalPrice if not already done:
//        if (milkRequest.getTotalPrice() <= 0) {
//            double calculatedPrice = milkRequest.getLiters() * milkRequest.getPricePerLiter();
//            milkRequest.setTotalPrice(calculatedPrice);
//        }
//        // Save and return the milk request
//        return milkRequestRepository.save(milkRequest);
//    }
//}

package com.dairy.backend.service;

import com.dairy.backend.model.MilkRequest;
import com.dairy.backend.model.Farmer;
import com.dairy.backend.repository.MilkRequestRepository;
import com.dairy.backend.repository.FarmerRepository;
import jakarta.transaction.Transactional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;


@Service
public class EmployeeService {

    @Autowired
    private MilkRequestRepository milkRequestRepository;

    @Autowired
    private FarmerRepository farmerRepository;

    @Autowired
    private PaymentService paymentService;

    /**
     * Retrieves all milk requests with status "PENDING".
     */
    public List<MilkRequest> getPendingRequests() {
        return milkRequestRepository.findByStatus("PENDING");
    }

    /**
     * Approves a milk request by its ID.
     * Verifies that the request exists and has an associated farmer before updating the status to "APPROVED".
     * Triggers payment creation for the approved request.
     *
     * @param id the ID of the milk request to approve.
     * @return the updated MilkRequest.
     * @throws Exception if the request is not found or if it has no associated farmer.
     */
    @Transactional
    public MilkRequest approveRequest(Long id) throws Exception {
        Optional<MilkRequest> opt = milkRequestRepository.findById(id);
        if (!opt.isPresent()) {
            throw new Exception("Request not found");
        }
        MilkRequest request = opt.get();
        if (request.getFarmer() == null) {
            throw new Exception("Milk request has no associated farmer");
        }
        // For approval, we assume the employee has already entered the milk request.
        request.setStatus("APPROVED");
        MilkRequest updated = milkRequestRepository.save(request);
        paymentService.createPayment(updated);
        return updated;
    }

    /**
     * Rejects a milk request by its ID.
     *
     * @param id the ID of the milk request to reject.
     * @return the updated MilkRequest.
     * @throws Exception if the request is not found.
     */
    public MilkRequest rejectRequest(Long id) throws Exception {
        Optional<MilkRequest> opt = milkRequestRepository.findById(id);
        if (opt.isPresent()) {
            MilkRequest request = opt.get();
            request.setStatus("REJECTED");
            return milkRequestRepository.save(request);
        } else {
            throw new Exception("Request not found");
        }
    }

    /**
     * Creates a new milk request.
     * Validates required fields and sets the employee name from the currently logged-in user.
     * Calculates the total price if not provided.
     *
     * @param milkRequest the MilkRequest object to create.
     * @return the saved MilkRequest.
     * @throws Exception if any required property is missing or invalid.
     */
    public MilkRequest createMilkRequest(MilkRequest milkRequest) throws Exception {
        // Validate required fields for the milk request.
        if (milkRequest.getDate() == null) {
            throw new Exception("Date is required");
        }
        if (milkRequest.getLiters() <= 0) {
            throw new Exception("Liters must be greater than zero");
        }
        if (milkRequest.getFatPercentage() <= 0) {
            throw new Exception("Fat percentage must be greater than zero");
        }
        if (milkRequest.getProteinPercentage() <= 0) {
            throw new Exception("Protein percentage must be greater than zero");
        }
        if (milkRequest.getWaterContent() <= 0) {
            throw new Exception("Water content must be greater than zero");
        }
        if (milkRequest.getPricePerLiter() <= 0) {
            throw new Exception("Price per liter must be greater than zero");
        }
        if (milkRequest.getPaymentMethod() == null || milkRequest.getPaymentMethod().isEmpty()) {
            throw new Exception("Payment method is required");
        }
        if (milkRequest.getFarmer() == null) {
            throw new Exception("Associated farmer is required");
        }
        // Validate the farmer details using the updated Farmer model.
        Farmer farmer = milkRequest.getFarmer();
        if (farmer.getId() == null) {
            throw new Exception("Farmer must have a valid ID");
        }
        // Additional optional validations can be added here for farmer's email, name, etc.

        // Set the employee name from the currently logged-in user.
        String employeeName = SecurityContextHolder.getContext().getAuthentication().getName();
        milkRequest.setEmployee(employeeName);

        // Calculate totalPrice if not provided.
        if (milkRequest.getTotalPrice() <= 0) {
            double calculatedPrice = milkRequest.getLiters() * milkRequest.getPricePerLiter();
            milkRequest.setTotalPrice(calculatedPrice);
        }

        // Save and return the milk request.
        // The MilkRequest entity's @PrePersist will mark the status as "SUCCESSFUL" if an employee is set.
        return milkRequestRepository.save(milkRequest);
    }

    /**
     * Retrieves all farmers from the database.
     *
     * @return a list of all Farmer entities.
     */
    public List<Farmer> getAllFarmers() {
        return farmerRepository.findAll();
    }
}
