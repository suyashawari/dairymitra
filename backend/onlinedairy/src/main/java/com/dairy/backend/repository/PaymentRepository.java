////package com.dairy.backend.repository;
////
////import com.dairy.backend.model.Payment;
////import org.springframework.data.jpa.repository.JpaRepository;
////import java.util.List;
////
////public interface PaymentRepository extends JpaRepository<Payment, Long> {
////    List<Payment> findByFarmerName(String farmerName);
////    List<Payment> findByFarmerNameOrderByPaymentDateDesc(String farmerName);
////}
//package com.dairy.backend.repository;
//
//import com.dairy.backend.model.Payment;
//import org.springframework.data.jpa.repository.JpaRepository;
//import org.springframework.stereotype.Repository;
//
//import java.util.List;
//
//@Repository
//public interface PaymentRepository extends JpaRepository<Payment, Long> {
//    List<Payment> findByFarmerEmailOrderByPaymentDateDesc(String email);
//}
//


package com.dairy.backend.repository;

import com.dairy.backend.model.Payment;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import java.util.List;

@Repository
public interface PaymentRepository extends JpaRepository<Payment, Long> {
    List<Payment> findByFarmerName(String farmerName);
    List<Payment> findByFarmerNameOrderByPaymentDateDesc(String farmerName);

}
