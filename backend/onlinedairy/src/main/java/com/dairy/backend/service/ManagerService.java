//package com.dairy.backend.service;
//
//import com.dairy.backend.model.MilkRequest;
//import com.dairy.backend.repository.MilkRequestRepository;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Service;
//
//import java.util.List;
//
//@Service
//public class ManagerService {
//
//    @Autowired
//    private MilkRequestRepository milkRequestRepository;
//
//    // For simplicity, a manager can get an overview report of milk requests
//    public List<MilkRequest> getAllMilkRequests() {
//        return milkRequestRepository.findAll();
//    }
//
//    // Additional reporting methods (e.g., employee performance, quality trends) can be added here.
//}

package com.dairy.backend.service;

import com.dairy.backend.model.Employee;
import com.dairy.backend.model.Farmer;
import com.dairy.backend.repository.EmployeeRepository;
import com.dairy.backend.repository.FarmerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ManagerService {

    @Autowired
    private EmployeeRepository employeeRepository;

    @Autowired
    private FarmerRepository farmerRepository;

    /**
     * Retrieve all employees.
     *
     * @return a list of all Employee entities.
     */
    public List<Employee> getAllEmployees() {
        return employeeRepository.findAll();
    }

    /**
     * Retrieve all farmers.
     *
     * @return a list of all Farmer entities.
     */
    public List<Farmer> getAllFarmers() {
        return farmerRepository.findAll();
    }
}
