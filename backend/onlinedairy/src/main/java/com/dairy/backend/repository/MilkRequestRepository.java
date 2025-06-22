//package com.dairy.backend.repository;
//import com.dairy.backend.model.MilkRequest;
//import org.springframework.data.jpa.repository.JpaRepository;
//import java.util.List;
//
//public interface MilkRequestRepository extends JpaRepository<MilkRequest, Long> {
//    List<MilkRequest> findByFarmerName(String farmerName);
//
//    List<MilkRequest> findByStatus(String status);
//}
package com.dairy.backend.repository;

import com.dairy.backend.model.MilkRequest;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MilkRequestRepository extends JpaRepository<MilkRequest, Long> {
    // Example: Find all milk requests with a given status (e.g., "SUCCESSFUL")
    List<MilkRequest> findByStatus(String status);

    // Example: Find all requests for a specific farmer (assuming a relationship exists)
    List<MilkRequest> findByFarmerId(Long farmerId);
    List<MilkRequest> findByFarmerEmail(String email);

    // Existing method to find by status.
}
