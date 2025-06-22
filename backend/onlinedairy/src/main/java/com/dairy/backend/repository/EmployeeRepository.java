//package com.dairy.backend.repository;
//// EmployeeRepository.java
//import com.dairy.backend.model.Employee;
//import org.springframework.data.jpa.repository.JpaRepository;
//
//public interface EmployeeRepository extends JpaRepository<Employee, Long> {
//}
package com.dairy.backend.repository;

import com.dairy.backend.model.Employee;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface EmployeeRepository extends JpaRepository<Employee, Long> {
    Optional<Employee> findByEmail(String email);
}
