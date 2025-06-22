package com.dairy.backend.service;//package com.dairy.backend.service;//package com.dairy.backend.service;
////
////import com.dairy.backend.dto.FarmerSignupDTO;
////import com.dairy.backend.model.AppUser;
////import com.dairy.backend.repository.AppUserRepository;
////import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
////import org.springframework.security.core.Authentication;
////import org.springframework.security.core.GrantedAuthority;
////import org.springframework.security.core.authority.SimpleGrantedAuthority;
////import org.springframework.security.crypto.password.PasswordEncoder;
////import org.springframework.stereotype.Service;
////
////import java.util.Collections;
////import java.util.List;
//////
//////@Service
//////public class AuthService {
//////
//////    private final AppUserRepository userRepository;
//////    private final PasswordEncoder passwordEncoder;
//////
//////    public AuthService(AppUserRepository userRepository, PasswordEncoder passwordEncoder) {
//////        this.userRepository = userRepository;
//////        this.passwordEncoder = passwordEncoder;
//////    }
//////
//////
//////    public String signup(AppUser user, String role) {
//////        AppUser existingUser = userRepository.findByUsername(user.getUsername());
//////        if (existingUser != null) {
//////            throw new RuntimeException("User already exists");
//////        }
//////        user.setRole(role);
//////        user.setPassword(passwordEncoder.encode(user.getPassword()));
//////        userRepository.save(user);
//////        return role + " signed up successfully!";
//////    }
//////
//////    public Authentication validateUser(String username, String password) {
//////        AppUser user = userRepository.findByUsername(username);
//////        if (user == null) {
//////            throw new RuntimeException("User not found");
//////        }
//////        if (!passwordEncoder.matches(password, user.getPassword())) {
//////            throw new RuntimeException("Incorrect password");
//////        }
//////        List<GrantedAuthority> authorities = Collections.singletonList(
//////                new SimpleGrantedAuthority(user.getRole())
//////        );
//////        return new UsernamePasswordAuthenticationToken(username, password, authorities);
//////    }
//////}
////
//
//import com.dairy.backend.model.AppUser;
//import com.dairy.backend.model.Employee;
//import com.dairy.backend.model.Farmer;
//import com.dairy.backend.model.Manager;
//import com.dairy.backend.repository.AppUserRepository;
//import com.dairy.backend.repository.EmployeeRepository;
//import com.dairy.backend.repository.FarmerRepository;
//import com.dairy.backend.repository.ManagerRepository;
//import org.springframework.security.crypto.password.PasswordEncoder;
//import org.springframework.stereotype.Service;
//

import com.dairy.backend.model.AppUser;
import com.dairy.backend.model.Employee;
import com.dairy.backend.model.Farmer;
import com.dairy.backend.model.Manager;
import com.dairy.backend.repository.AppUserRepository;
import com.dairy.backend.repository.EmployeeRepository;
import com.dairy.backend.repository.FarmerRepository;
import com.dairy.backend.repository.ManagerRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

////// ... existing imports ...
////import com.dairy.backend.model.Farmer;
////import com.dairy.backend.repository.FarmerRepository;
////
////@Service
////public class AuthService {
////
////    private final AppUserRepository userRepository;
////    private final PasswordEncoder passwordEncoder;
////    private final FarmerRepository farmerRepository; // Added
////
////    public AuthService(AppUserRepository userRepository, PasswordEncoder passwordEncoder, FarmerRepository farmerRepository) {
////        this.userRepository = userRepository;
////        this.passwordEncoder = passwordEncoder;
////        this.farmerRepository = farmerRepository; // Added
////    }
////
////    public String signup(AppUser user, String role) {
////        AppUser existingUser = userRepository.findByUsername(user.getUsername());
////        if (existingUser != null) {
////            throw new RuntimeException("User already exists");
////        }
////        user.setRole(role);
////        user.setPassword(passwordEncoder.encode(user.getPassword()));
////        userRepository.save(user);
////
////        if ("FARMER".equalsIgnoreCase(role)) {
////            Farmer farmer = new Farmer(user.getUsername());
////            farmerRepository.save(farmer);
////        }
////
////        return role + " signed up successfully!";
////    }
////    public Authentication validateUser(String username, String password) {
////        AppUser user = userRepository.findByUsername(username);
////        if (user == null) {
////            throw new RuntimeException("User not found");
////        }
////        if (!passwordEncoder.matches(password, user.getPassword())) {
////            throw new RuntimeException("Incorrect password");
////        }
////        List<GrantedAuthority> authorities = Collections.singletonList(
////                new SimpleGrantedAuthority(user.getRole())
////        );
////        return new UsernamePasswordAuthenticationToken(username, password, authorities);
////    }
////    public String signupFarmerWithDetails(FarmerSignupDTO signupRequest) {
////        AppUser existingUser = userRepository.findByUsername(signupRequest.getUsername());
////        if (existingUser != null) {
////            throw new RuntimeException("User already exists");
////        }
////
////        // Create AppUser
////        AppUser user = new AppUser();
////        user.setUsername(signupRequest.getUsername());
////        user.setPassword(passwordEncoder.encode(signupRequest.getPassword()));
////        user.setRole("ROLE_FARMER");
////        userRepository.save(user);
////
////        // Create Farmer with Bank Details
////        Farmer farmer = new Farmer(signupRequest.getUsername());
////        farmer.setBankDetails(signupRequest.getBankDetails());
////        farmerRepository.save(farmer);
////
////        return "Farmer signed up successfully!";
////    }
////    // ... rest of the code ...
////}
//@Service
//public class AuthService {
//    private final AppUserRepository userRepository;
//    private final PasswordEncoder passwordEncoder;
//    private final FarmerRepository farmerRepository;
//    private final ManagerRepository managerRepository;// Added
//    private final EmployeeRepository employeeRepository;
//    public AuthService(AppUserRepository userRepository, PasswordEncoder passwordEncoder, FarmerRepository farmerRepository, ManagerRepository managerRepository1, EmployeeRepository employeeRepository) {
//        this.userRepository = userRepository;
//        this.passwordEncoder = passwordEncoder;
//        this.farmerRepository = farmerRepository;
//        // Added
//        this.managerRepository = managerRepository1;
//        this.employeeRepository = employeeRepository;
//    }
//
//    public String signup(AppUser user, String role) {
//        // Common logic for all roles
//        AppUser existingUser = userRepository.findByName(user.getName());
//        if (existingUser != null) {
//            throw new RuntimeException("User already exists");
//        }
//        user.setRole(role);
//        user.setPassword(passwordEncoder.encode(user.getPassword()));
//        userRepository.save(user);
//
//        // Branching based on role
//        if ("ROLE_FARMER".equalsIgnoreCase(role)) {
//            signupFarmer(user);
//        } else if ("ROLE_MANAGER".equalsIgnoreCase(role)) {
//            signupManager(user);
//        } else if ("ROLE_EMPLOYEE".equalsIgnoreCase(role)) {
//            signupEmployee(user);
//        }
//        return role + " signed up successfully!";
//    }
//
//    private void signupFarmer(AppUser user) {
//        Farmer farmer = new Farmer();
//        farmer.setName(user.getName());
//        // Additional logic for farmers
//        farmerRepository.save(farmer);
//    }
//
//    private void signupManager(AppUser user) {
//        Manager manager = new Manager();
//        manager.setName(user.getName());
//        // Additional logic for managers
//        managerRepository.save(manager);
//    }
//
//    private void signupEmployee(AppUser user) {
//        Employee employee = new Employee();
//        employee.setName(user.getName());
//        // Additional logic for employees
//        employeeRepository.save(employee);
//    }
//}

import com.dairy.backend.dto.SignupRequest;
import com.dairy.backend.model.AppUser;
import com.dairy.backend.model.Employee;
import com.dairy.backend.model.Farmer;
import com.dairy.backend.model.Manager;
import com.dairy.backend.repository.AppUserRepository;
import com.dairy.backend.repository.EmployeeRepository;
import com.dairy.backend.repository.FarmerRepository;
import com.dairy.backend.repository.ManagerRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import java.util.Collections;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;

@Service
public class AuthService {

    private final AppUserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final FarmerRepository farmerRepository;
    private final ManagerRepository managerRepository;
    private final EmployeeRepository employeeRepository;

    public AuthService(AppUserRepository userRepository, PasswordEncoder passwordEncoder,
                       FarmerRepository farmerRepository, ManagerRepository managerRepository,
                       EmployeeRepository employeeRepository) {
        this.userRepository = userRepository;
        this.passwordEncoder = passwordEncoder;
        this.farmerRepository = farmerRepository;
        this.managerRepository = managerRepository;
        this.employeeRepository = employeeRepository;
    }

    /**
     * Signs up a new user with all details provided in the SignupRequest DTO.
     */
    public String signup(SignupRequest signupRequest) {
        // Check if a user already exists by name or email (modify this as needed)
        AppUser existingUser = userRepository.findByName(signupRequest.getName());
        if (existingUser != null) {
            throw new RuntimeException("User already exists");
        }

        // Create and populate the AppUser
        AppUser user = new AppUser();
        user.setName(signupRequest.getName());
        user.setEmail(signupRequest.getEmail());
        user.setPhoneNumber(signupRequest.getPhoneNumber());
        user.setAddress(signupRequest.getAddress());
        user.setPassword(passwordEncoder.encode(signupRequest.getPassword()));
        user.setRole(signupRequest.getRole());
        user.setBankDetails(signupRequest.getBankDetails());
        userRepository.save(user);

        // Create additional domain record based on role
        if ("ROLE_FARMER".equalsIgnoreCase(signupRequest.getRole())) {
            Farmer farmer = new Farmer();
            farmer.setName(signupRequest.getName());
            farmer.setEmail(signupRequest.getEmail());
            farmer.setPhoneNumber(signupRequest.getPhoneNumber());
            farmer.setAddress(signupRequest.getAddress());
            farmer.setPassword(user.getPassword());
            farmer.setRole(signupRequest.getRole());
            farmer.setBankDetails(signupRequest.getBankDetails());
            farmerRepository.save(farmer);
        } else if ("ROLE_MANAGER".equalsIgnoreCase(signupRequest.getRole())) {
            Manager manager = new Manager();
            manager.setName(signupRequest.getName());
            manager.setEmail(signupRequest.getEmail());
            manager.setPhoneNumber(signupRequest.getPhoneNumber());
            manager.setAddress(signupRequest.getAddress());
            manager.setPassword(user.getPassword());
            manager.setRole(signupRequest.getRole());
            manager.setBankDetails(signupRequest.getBankDetails());
            managerRepository.save(manager);
        } else if ("ROLE_EMPLOYEE".equalsIgnoreCase(signupRequest.getRole())) {
            Employee employee = new Employee();
            employee.setName(signupRequest.getName());
            // Set additional employee details if needed
            employeeRepository.save(employee);
        }

        return signupRequest.getRole() + " signed up successfully!";
    }

    /**
     * Validates user credentials and returns an Authentication token.
     */
    public Authentication validateUser(String username, String password) {
        AppUser user = userRepository.findByEmail(username);
        if (user == null) {
            throw new RuntimeException("User not found");
        }
        if (!passwordEncoder.matches(password, user.getPassword())) {
            throw new RuntimeException("Incorrect password");
        }
        GrantedAuthority authority = new SimpleGrantedAuthority(user.getRole());
        return new UsernamePasswordAuthenticationToken(username, password, Collections.singleton(authority));
    }
}
