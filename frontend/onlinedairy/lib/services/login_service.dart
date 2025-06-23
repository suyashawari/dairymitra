// import 'dart:convert';
// import 'package:flutter/services.dart';
// import 'package:onlinedairy/models/PUser.dart';
// import '../utils/auth_helper.dart';
// import 'EmployeeService.dart';
// //
// class LoginService {
//   static const String _farmersPath = 'assets/json/farmers.json';
//   static const String _employeesPath = 'assets/json/employee.json';
//   static const String _managersPath = 'assets/json/manager.json';
//
//   /// Login function to authenticate user
//   Future<PUser?> login(String email, String password) async {
//     try {
//       final user = await _fetchUser(email, password);
//       if (user == null) {
//         print("No user found with matching credentials");
//         return null;
//       }
//
//       await AuthHelper.saveUser(user);
//       print("User ${user.email} logged in successfully with role ${user.role}");
//       return user;
//     } catch (e) {
//       print("Login error: $e");
//       return null;
//     }
//   }
//
//   // Future<PUser?> _fetchUser(String email, String password) async {
//   //   final allUsers = await Future.wait([
//   //     _loadUsers(_farmersPath),
//   //     _loadUsers(_employeesPath),
//   //     _loadUsers(_managersPath),
//   //   ]).then((lists) => lists.expand((list) => list).toList());
//   //
//   //   // Use try-catch to handle "no matching element" error
//   //   try {
//   //     return allUsers.firstWhere(
//   //           (user) => user.email == email && user.password == password,
//   //     );
//   //   } on StateError {
//   //     return null; // No user found
//   //   }
//   // }
//   Future<PUser?> _fetchUser(String email, String password) async {
//     final allUsers = await Future.wait([
//       _loadUsers(_farmersPath),
//       _loadUsers(_employeesPath),
//       _loadUsers(_managersPath),
//     ]).then((lists) => lists.expand((list) => list).toList());
//
//     // Print all loaded users for debugging
//     print("=== All loaded users ===");
//     for (var user in allUsers) {
//       print("User: ${user.email}, Role: ${user.role}, Password: ${user.password}");
//     }
//
//     try {
//       final foundUser = allUsers.firstWhere(
//             (user) {
//           print("Checking user: ${user.email} with password ${user.password}");
//           return user.email == email && user.password == password;
//         },
//       );
//       print("Found matching user: ${foundUser.email}");
//       return foundUser;
//     } on StateError {
//       print("No matching user found for email: $email");
//       return null;
//     }
//   }
//
//   /// Load users from a given JSON file path
//   Future<List<PUser>> _loadUsers(String path) async {
//     try {
//       final String jsonString = await rootBundle.loadString(path);
//       final List<dynamic> jsonList = jsonDecode(jsonString);
//       return jsonList.map((json) => PUser.fromJson(json)).toList();
//     } catch (e) {
//       print("Error loading users from $path: $e");
//       return [];
//     }
//   }
//
//   /// Navigate user based on role
//   void _navigateToDashboard(String role) {
//     // Implement navigation logic (for example, using Navigator)
//     print("Navigating to dashboard for role: $role");
//   }
//
//   /// Show an error message
//   void _showError(String message) {
//     // Implement error handling (for example, showing a snackbar or alert)
//     print("Error: $message");
//   }
// }
//
// // import 'dart:convert';
// // import 'package:flutter/services.dart';
// // import 'package:onlinedairy/models/PUser.dart';
// // import '../utils/auth_helper.dart';
// //
// // class LoginService {
// //   static const String _employeesPath = 'assets/json/employee.json';
// //   static const String _managersPath = 'assets/json/manager.json';
// //   final EmployeeService _employeeService = EmployeeService();
// //
// //   Future<PUser?> login(String email, String password) async {
// //     try {
// //       // Initialize data sources
// //       await _employeeService.initialize();
// //
// //       // Load all potential users
// //       final farmers = await _loadFarmers();
// //       final employees = await _loadAssetUsers(_employeesPath);
// //       final managers = await _loadAssetUsers(_managersPath);
// //
// //       // Combine and validate users
// //       final allUsers = _combineUsers(farmers, employees, managers);
// //       return _authenticateUser(allUsers, email.trim(), password);
// //     } catch (e) {
// //       print('Login error: $e');
// //       return null;
// //     }
// //   }
// //
// //   Future<List<PUser>> _loadFarmers() async {
// //     try {
// //       return await _employeeService.getAllFarmers();
// //     } catch (e) {
// //       print('Error loading farmers: $e');
// //       return [];
// //     }
// //   }
// //
// //   Future<List<PUser>> _loadAssetUsers(String path) async {
// //     try {
// //       final jsonString = await rootBundle.loadString(path);
// //       final List<dynamic> jsonList = jsonDecode(jsonString);
// //
// //       return jsonList.map((json) {
// //         try {
// //           return PUser.fromJson(json);
// //         } catch (e) {
// //           print('Error parsing user from JSON: $e\nJSON: $json');
// //           return PUser();
// //         }
// //       }).where((user) => user.email != null).toList();
// //     } catch (e) {
// //       print("Error loading users from $path: $e");
// //       return [];
// //     }
// //   }
// //
// //   List<PUser> _combineUsers(List<PUser> farmers, List<PUser> employees, List<PUser> managers) {
// //     final allUsers = [...farmers, ...employees, ...managers];
// //     _validateUserList(allUsers);
// //     return allUsers;
// //   }
// //
// //   void _validateUserList(List<PUser> users) {
// //     for (final user in users) {
// //       if (user.email == null || user.email!.isEmpty) {
// //         print('Warning: User with missing email found (ID: ${user.id})');
// //       }
// //       if (user.password == null || user.password!.isEmpty) {
// //         print('Warning: User with missing password found (Email: ${user.email})');
// //       }
// //     }
// //   }
// //
// //   Future<PUser?> _authenticateUser(List<PUser> users, String email, String password) async {
// //     try {
// //       final cleanEmail = email.toLowerCase();
// //
// //       final foundUser = users.firstWhere(
// //             (user) => user.email?.toLowerCase() == cleanEmail &&
// //             user.password == password,
// //         orElse: () => PUser(),
// //       );
// //
// //       if (foundUser.email == null) {
// //         print('Authentication failed for email: $email');
// //         return null;
// //       }
// //
// //       await AuthHelper.saveUser(foundUser);
// //       print('Successful login: ${foundUser.email} (${foundUser.role})');
// //       return foundUser;
// //     } on StateError catch (e) {
// //       print('Authentication error: $e');
// //       return null;
// //     }
// //   }
// // }


import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:onlinedairy/models/PUser.dart';
import '../utils/auth_helper.dart';

class LoginService {
  // static const String _baseUrl = 'https://e71d-2409-40c2-3d-9907-686a-9744-1bbd-9620.ngrok-free.app'; // Replace with your actual URL

  final String? _baseUrl = dotenv.env['API_KEY'];
  Future<PUser?> login(String email, String password) async {
    try {
      final url = Uri.parse('$_baseUrl/api/users/auth/login');
      final headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      };
      final body = jsonEncode({'email': email, 'password': password});

      // Debug prints to verify request parameters
      print("Sending POST request to $url");
      print("Headers: $headers");
      print("Body: $body");

      final response = await http.post(url, headers: headers, body: body);

      // Debug response details
      print("Response status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        // Check if the response contains an 'id' field to confirm it's a valid user object.
        if (data != null && data.containsKey("id")) {
          final user = PUser.fromJson(data);
          await AuthHelper.saveUser(user);
          print("Login successful for ${user.email} with role ${user.role}");
          return user;
        } else {
          print("Login failed: Unexpected response format.");
          _showError("Login unsuccessful. Unexpected response format.");
        }
      } else if (response.statusCode == 401) {
        _showError("Invalid email or password.");
      } else {
        _showError("Login failed with status code: ${response.statusCode}");
      }
      return null;
    } catch (e) {
      _showError("Connection error: $e");
      print("Login error: $e");
      return null;
    }
  }

  void _showError(String message) {
    print("Login Error: $message");
    // Optionally, implement additional error UI handling here.
  }
}
