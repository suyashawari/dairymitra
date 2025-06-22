//package com.dairy.backend.repository;
//// ManagerRepository.java
//import com.dairy.backend.model.Manager;
//import org.springframework.data.jpa.repository.JpaRepository;
//
//public interface ManagerRepository extends JpaRepository<Manager, Long> {
//}

package com.dairy.backend.repository;

import com.dairy.backend.model.Manager;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface ManagerRepository extends JpaRepository<Manager, Long> {
    Optional<Manager> findByEmail(String email);
}
