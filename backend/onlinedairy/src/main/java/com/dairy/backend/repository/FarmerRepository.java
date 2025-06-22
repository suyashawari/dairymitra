//package com.dairy.backend.repository;
//
//// FarmerRepository.java
//import com.dairy.backend.model.Farmer;
//import org.springframework.data.jpa.repository.JpaRepository;
//
//import java.util.Optional;
//
//public interface FarmerRepository extends JpaRepository<Farmer, Long> {
//
//    Optional<Farmer> findByName(String name);
//}
package com.dairy.backend.repository;

import com.dairy.backend.model.Farmer;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface FarmerRepository extends JpaRepository<Farmer, Long> {
    Optional<Farmer> findByEmail(String email);
}
