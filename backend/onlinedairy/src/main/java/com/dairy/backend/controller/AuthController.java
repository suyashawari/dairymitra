////package com.dairy.backend.controller;
////import com.dairy.backend.dto.LoginRequest;
////import com.dairy.backend.service.AuthService;
////import com.dairy.backend.service.UnauthorizedException;
////import jakarta.servlet.http.HttpServletResponse;
////import org.springframework.http.HttpStatus;
////import org.springframework.http.ResponseEntity;
////import org.springframework.security.core.Authentication;
////import org.springframework.security.core.context.SecurityContextHolder;
////import org.springframework.web.bind.annotation.*;
////
////
////@RestController
////@RequestMapping("/api/auth")
////public class AuthController {
////
////    private final AuthService authService;
////
////    public AuthController(AuthService authService) {
////        this.authService = authService;
////    }
////
////    @PostMapping("/login")
////    public ResponseEntity<String> login(@RequestBody LoginRequest loginRequest) {
////        try {
////            Authentication authentication = authService.validateUser(
////                    loginRequest.getUsername(),
////                    loginRequest.getPassword()
////            );
////            SecurityContextHolder.getContext().setAuthentication(authentication);
////            return ResponseEntity.ok("Login successful. Authority: " + authentication.getAuthorities() +
////                    ", Username: " + authentication.getName());
////        } catch (RuntimeException e) {
////            return new ResponseEntity<>(e.getMessage(),HttpStatus.UNAUTHORIZED);
////        }
////    }
////
////    // Handle UnauthorizedException and return a proper JSON response
////    @ExceptionHandler(UnauthorizedException.class)
////    public ResponseEntity<String> handleUnauthorizedException(UnauthorizedException e) {
////        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("{\"error\": \"" + e.getMessage() + "\"}");
////    }
////}
//
//package com.dairy.backend.controller;
//
//import com.dairy.backend.dto.LoginRequest;
//import com.dairy.backend.dto.SignupRequest;
//import com.dairy.backend.service.AuthService;
//import com.dairy.backend.service.UnauthorizedException;
//import org.springframework.http.HttpStatus;
//import org.springframework.http.ResponseEntity;
//import org.springframework.security.core.Authentication;
//import org.springframework.security.core.context.SecurityContextHolder;
//import org.springframework.web.bind.annotation.*;
//
//@RestController
//@RequestMapping("/api/auth")
//public class AuthController {
//
//    private final AuthService authService;
//
//    public AuthController(AuthService authService) {
//        this.authService = authService;
//    }
//
//    @PostMapping("/signup")
//    public ResponseEntity<String> signup(@RequestBody SignupRequest signupRequest) {
//        try {
//            String message = authService.signup(signupRequest);
//            return ResponseEntity.ok(message);
//        } catch (RuntimeException e) {
//            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(e.getMessage());
//        }
//    }
//
//    @PostMapping("/login")
//    public ResponseEntity<String> login(@RequestBody LoginRequest loginRequest) {
//        try {
//            Authentication authentication = authService.validateUser(
//                    loginRequest.getUsername(),
//                    loginRequest.getPassword()
//            );
//            SecurityContextHolder.getContext().setAuthentication(authentication);
//            return ResponseEntity.ok("Login successful. Authority: " + authentication.getAuthorities() +
//                    ", Username: " + authentication.getName());
//        } catch (RuntimeException e) {
//            return new ResponseEntity<>(e.getMessage(), HttpStatus.UNAUTHORIZED);
//        }
//    }
//
//    @ExceptionHandler(UnauthorizedException.class)
//    public ResponseEntity<String> handleUnauthorizedException(UnauthorizedException e) {
//        return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
//                .body("{\"error\": \"" + e.getMessage() + "\"}");
//    }
//}
package com.dairy.backend.controller;

import com.dairy.backend.dto.LoginRequest;
import com.dairy.backend.service.AuthService;
import com.dairy.backend.service.UnauthorizedException;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/auth")
public class AuthController {

    private final AuthService authService;

    public AuthController(AuthService authService) {
        this.authService = authService;
    }

    @PostMapping("/login")
    public ResponseEntity<String> login(@RequestBody LoginRequest loginRequest) {
        try {
            Authentication authentication = authService.validateUser(
                    loginRequest.getUsername(),
                    loginRequest.getPassword()
            );
            SecurityContextHolder.getContext().setAuthentication(authentication);
            return ResponseEntity.ok("Login successful. Authority: " + authentication.getAuthorities() +
                    ", Username: " + authentication.getName());
        } catch (RuntimeException e) {
            return new ResponseEntity<>(e.getMessage(), HttpStatus.UNAUTHORIZED);
        }
    }

    @ExceptionHandler(UnauthorizedException.class)
    public ResponseEntity<String> handleUnauthorizedException(UnauthorizedException e) {
        return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                .body("{\"error\": \"" + e.getMessage() + "\"}");
    }
}
