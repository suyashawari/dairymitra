//package com.dairy.backend.service;
//
//import com.dairy.backend.model.AppUser;
//import com.dairy.backend.repository.AppUserRepository;
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.security.core.authority.SimpleGrantedAuthority;
//import org.springframework.security.core.userdetails.User;
//import org.springframework.security.core.userdetails.UserDetails;
//import org.springframework.security.core.userdetails.UserDetailsService;
//import org.springframework.security.core.userdetails.UsernameNotFoundException;
//import org.springframework.stereotype.Service;
//
//import java.util.Collections;
//
//
//@Service
//public class CustomUserDetailsService implements UserDetailsService {
//
//    @Autowired
//    private AppUserRepository userRepository;
//
//    @Override
//    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
//        AppUser appUser = userRepository.findByUsername(username);
//        if (appUser == null) {
//            throw new UsernameNotFoundException("User not found");
//        }
//        // Create a UserDetails object with username, encoded password, and role as a granted authority.
//        return new User(appUser.getUsername(), appUser.getPassword(),
//                Collections.singleton(new SimpleGrantedAuthority(appUser.getRole())));
//    }
//}


package com.dairy.backend.service;

import com.dairy.backend.model.AppUser;
import com.dairy.backend.model.Employee;
import com.dairy.backend.model.Farmer;
import com.dairy.backend.model.Manager;
import com.dairy.backend.repository.AppUserRepository;
import com.dairy.backend.repository.EmployeeRepository;
import com.dairy.backend.repository.FarmerRepository;
import com.dairy.backend.repository.ManagerRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.Collections;

@Service
public class CustomUserDetailsService implements UserDetailsService {

    @Autowired
    private AppUserRepository userRepository;

    @Autowired
    private FarmerRepository farmerRepository;

    @Autowired
    private ManagerRepository managerRepository;

    @Autowired
    private EmployeeRepository employeeRepository;

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        AppUser appUser = userRepository.findByName(username);
        if (appUser == null) {
            throw new UsernameNotFoundException("User not found");
        }

        // Optional: Load additional details based on role
        if (appUser.getRole().equalsIgnoreCase("ROLE_FARMER")) {
            // For example, load farmer details from FarmerRepository
            Farmer farmer = farmerRepository.findByEmail(appUser.getEmail())
                    .orElse(null);
            // You can later extend a custom UserDetails to include farmer-specific properties.
        } else if (appUser.getRole().equalsIgnoreCase("ROLE_MANAGER")) {
            Manager manager = managerRepository.findByEmail(appUser.getEmail())
                    .orElse(null);
            // Extend custom UserDetails for manager-specific details if required.
        } else if (appUser.getRole().equalsIgnoreCase("ROLE_EMPLOYEE")) {
            Employee employee = employeeRepository.findByEmail(appUser.getEmail())
                    .orElse(null);
            // Extend custom UserDetails for employee-specific details if required.
        }

        // Create a UserDetails object with username, password, and role as a granted authority.
        return new User(appUser.getEmail(), appUser.getPassword(),
                Collections.singleton(new SimpleGrantedAuthority(appUser.getRole())));
    }
}
