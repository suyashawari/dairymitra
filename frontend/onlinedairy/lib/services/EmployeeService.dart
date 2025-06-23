// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/services.dart';
// import 'package:onlinedairy/models/PUser.dart';
// import 'package:onlinedairy/models/milk_request.dart';
// import '../utils/auth_helper.dart';
//
// class EmployeeService {
//   static const String _assetsFarmersPath = 'assets/json/farmers.json';
//   static const String _assetsMilkRequestsPath = 'assets/json/milkrequest.json';
//   static const String _farmersFile = 'farmers.json';
//   static const String _milkRequestsFile = 'milkrequest.json';
//
//   /// Gets writable file path in system temp directory
//   Future<String> _getWritableFilePath(String fileName) async {
//     final dir = Directory.systemTemp;
//     return '${dir.path}/$fileName';
//   }
//
//   /// Gets File object for the given filename
//   Future<File> _getLocalFile(String fileName) async {
//     final path = await _getWritableFilePath(fileName);
//     return File(path);
//   }
//
//   /// Initializes JSON files from assets if they don't exist
//   Future<void> initialize({bool forceRefresh = false}) async {
//     try {
//       final farmersFile = await _getLocalFile(_farmersFile);
//       final milkRequestsFile = await _getLocalFile(_milkRequestsFile);
//
//       if (forceRefresh || !await farmersFile.exists()) {
//         final farmersData = await rootBundle.loadString(_assetsFarmersPath);
//         await farmersFile.writeAsString(farmersData);
//         print('Farmers file initialized from assets');
//       }
//
//       if (forceRefresh || !await milkRequestsFile.exists()) {
//         final milkRequestsData = await rootBundle.loadString(_assetsMilkRequestsPath);
//         await milkRequestsFile.writeAsString(milkRequestsData);
//         print('Milk requests file initialized from assets');
//       }
//     } catch (e) {
//       print('Error initializing files: $e');
//       // Create empty files as fallback
//       final farmersFile = await _getLocalFile(_farmersFile);
//       if (!await farmersFile.exists()) await farmersFile.writeAsString('[]');
//
//       final milkRequestsFile = await _getLocalFile(_milkRequestsFile);
//       if (!await milkRequestsFile.exists()) await milkRequestsFile.writeAsString('[]');
//     }
//   }
//
//   /// Forces refresh of files from assets
//   Future<void> forceRefreshFiles() async {
//     await initialize(forceRefresh: true);
//   }
//
//   /// Prints file paths for debugging
//   Future<void> printFilePaths() async {
//     try {
//       final farmersFile = await _getLocalFile(_farmersFile);
//       final milkFile = await _getLocalFile(_milkRequestsFile);
//       print('Farmers file path: ${farmersFile.path}');
//       print('Milk requests file path: ${milkFile.path}');
//     } catch (e) {
//       print('Error printing file paths: $e');
//     }
//   }
//
//   /// Gets all farmers from JSON file
//   Future<List<PUser>> getAllFarmers() async {
//     try {
//       final file = await _getLocalFile(_farmersFile);
//       final contents = await file.readAsString();
//       final List<dynamic> jsonList = jsonDecode(contents);
//       return jsonList.map((json) => PUser.fromJson(json)).toList();
//     } catch (e) {
//       print('Error reading farmers: $e');
//       return [];
//     }
//   }
//
//   /// Adds a new farmer to JSON file
//   Future<bool> addFarmer(PUser farmer) async {
//     try {
//       final file = await _getLocalFile(_farmersFile);
//       final List<PUser> farmers = await getAllFarmers();
//
//       if (farmer.id == null) {
//         final maxId = farmers.isEmpty ? 0 : farmers.map((f) => f.id ?? 0).reduce((a, b) => a > b ? a : b);
//         farmer.id = maxId + 1;
//       }
//
//       farmers.add(farmer);
//       await file.writeAsString(jsonEncode(farmers.map((f) => f.toJson()).toList()));
//       return true;
//     } catch (e) {
//       print('Error adding farmer: $e');
//       return false;
//     }
//   }
//
//   /// Updates an existing farmer
//   Future<bool> updateFarmer(PUser updatedFarmer) async {
//     try {
//       final file = await _getLocalFile(_farmersFile);
//       final List<PUser> farmers = await getAllFarmers();
//
//       final index = farmers.indexWhere((f) => f.id == updatedFarmer.id);
//       if (index != -1) {
//         farmers[index] = updatedFarmer;
//         await file.writeAsString(jsonEncode(farmers.map((f) => f.toJson()).toList()));
//         return true;
//       }
//       return false;
//     } catch (e) {
//       print('Error updating farmer: $e');
//       return false;
//     }
//   }
//
//   /// Deletes a farmer by ID
//   Future<bool> deleteFarmer(int farmerId) async {
//     try {
//       final file = await _getLocalFile(_farmersFile);
//       List<PUser> farmers = await getAllFarmers();
//       farmers.removeWhere((f) => f.id == farmerId);
//       await file.writeAsString(jsonEncode(farmers.map((f) => f.toJson()).toList()));
//       return true;
//     } catch (e) {
//       print('Error deleting farmer: $e');
//       return false;
//     }
//   }
//
//   /// Gets all milk requests from JSON file
//   Future<List<MilkRequest>> getAllMilkRequests() async {
//     try {
//       final file = await _getLocalFile(_milkRequestsFile);
//       final contents = await file.readAsString();
//       final List<dynamic> jsonList = jsonDecode(contents);
//       return jsonList.map((json) => MilkRequest.fromJson(json)).toList();
//     } catch (e) {
//       print('Error reading milk requests: $e');
//       return [];
//     }
//   }
//
//   /// Adds a new milk request
//   Future<bool> addMilkRequest(MilkRequest request) async {
//     try {
//       final file = await _getLocalFile(_milkRequestsFile);
//       final List<MilkRequest> requests = await getAllMilkRequests();
//       final currentUser = await AuthHelper.getUser();
//
//       if (currentUser != null && request.employee == null) {
//         request.employee = currentUser.name;
//       }
//
//       if (request.id == null) {
//         final maxId = requests.isEmpty ? 0 : requests.map((r) => r.id ?? 0).reduce((a, b) => a > b ? a : b);
//         request.id = maxId + 1;
//       }
//
//       if (request.date == null) {
//         request.date = DateTime.now();
//       }
//
//       if (request.totalPrice == null && request.liters != null && request.pricePerLiter != null) {
//         request.totalPrice = (request.liters! * request.pricePerLiter!).round() as double?;
//       }
//
//       requests.add(request);
//       await file.writeAsString(jsonEncode(requests.map((r) => r.toJson()).toList()));
//       return true;
//     } catch (e) {
//       print('Error adding milk request: $e');
//       return false;
//     }
//   }
// }
// //
// //
// // import 'dart:convert';
// // import 'dart:io';
// // import 'package:flutter/services.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'package:onlinedairy/models/PUser.dart';
// // import 'package:onlinedairy/models/milk_request.dart';
// // import '../utils/auth_helper.dart';
// //
// // class EmployeeService {
// //   static const String _assetsFarmersPath = 'assets/json/farmers.json';
// //   static const String _assetsMilkRequestsPath = 'assets/json/milkrequest.json';
// //   static const String _farmersFile = 'farmers.json';
// //   static const String _milkRequestsFile = 'milkrequest.json';
// //
// //   Future<File> _getLocalFile(String fileName) async {
// //     final directory = await getApplicationDocumentsDirectory();
// //     return File('${directory.path}/$fileName');
// //   }
// //
// //   Future<void> initialize({bool forceRefresh = false}) async {
// //     try {
// //       final farmersFile = await _getLocalFile(_farmersFile);
// //       final milkRequestsFile = await _getLocalFile(_milkRequestsFile);
// //
// //       if (forceRefresh || !await farmersFile.exists()) {
// //         try {
// //           final farmersData = await rootBundle.loadString(_assetsFarmersPath);
// //           await farmersFile.writeAsString(farmersData);
// //         } catch (e) {
// //           if (!await farmersFile.exists()) {
// //             await farmersFile.writeAsString('[]');
// //           }
// //         }
// //       }
// //
// //       if (forceRefresh || !await milkRequestsFile.exists()) {
// //         try {
// //           final milkRequestsData = await rootBundle.loadString(_assetsMilkRequestsPath);
// //           await milkRequestsFile.writeAsString(milkRequestsData);
// //         } catch (e) {
// //           if (!await milkRequestsFile.exists()) {
// //             await milkRequestsFile.writeAsString('[]');
// //           }
// //         }
// //       }
// //     } catch (e) {
// //       print('Error initializing files: $e');
// //     }
// //   }
// //
// //   // Farmer Operations
// //   Future<List<PUser>> getAllFarmers() async {
// //     try {
// //       final file = await _getLocalFile(_farmersFile);
// //       final contents = await file.readAsString();
// //       final List<dynamic> jsonList = jsonDecode(contents);
// //       return jsonList.map((json) => PUser.fromJson(json)).toList();
// //     } catch (e) {
// //       print('Error reading farmers: $e');
// //       return [];
// //     }
// //   }
// //
// //   Future<bool> addFarmer(PUser farmer) async {
// //     try {
// //       final file = await _getLocalFile(_farmersFile);
// //       final List<PUser> farmers = await getAllFarmers();
// //
// //       if (farmer.email == null || farmer.email!.isEmpty) {
// //         throw Exception('Farmer email is required');
// //       }
// //
// //       if (farmers.any((f) => f.email == farmer.email)) {
// //         print('Farmer with email ${farmer.email} already exists');
// //         return false;
// //       }
// //
// //       farmer.id ??= farmers.isEmpty ? 1 :
// //       farmers.map((f) => f.id ?? 0).reduce((a, b) => a > b ? a : b) + 1;
// //
// //       farmers.add(farmer);
// //       await file.writeAsString(jsonEncode(farmers.map((f) => f.toJson()).toList()));
// //       return true;
// //     } catch (e) {
// //       print('Error adding farmer: $e');
// //       return false;
// //     }
// //   }
// //
// //   // Milk Request Operations
// //   Future<List<MilkRequest>> getAllMilkRequests() async {
// //     try {
// //       final file = await _getLocalFile(_milkRequestsFile);
// //       final contents = await file.readAsString();
// //       final List<dynamic> jsonList = jsonDecode(contents);
// //       return jsonList.map((json) => MilkRequest.fromJson(json)).toList();
// //     } catch (e) {
// //       print('Error reading milk requests: $e');
// //       return [];
// //     }
// //   }
// //
// //   Future<bool> addMilkRequest(MilkRequest request) async {
// //     try {
// //       final file = await _getLocalFile(_milkRequestsFile);
// //       final List<MilkRequest> requests = await getAllMilkRequests();
// //       final currentUser = await AuthHelper.getUser();
// //
// //       // Validate required fields
// //       if (request.farmer == null || request.farmer!.id == null) {
// //         throw Exception('Farmer must be specified');
// //       }
// //
// //       // Auto-generate ID if missing
// //       request.id ??= requests.isEmpty ? 1 :
// //       requests.map((r) => r.id ?? 0).reduce((a, b) => a > b ? a : b) + 1;
// //
// //       // Set default values
// //       request.date ??= DateTime.now();
// //       request.employee = currentUser?.name;
// //
// //       // Calculate total price if possible
// //       if (request.totalPrice == null &&
// //           request.liters != null &&
// //           request.pricePerLiter != null) {
// //         request.totalPrice = (request.liters! * request.pricePerLiter!).toStringAsFixed(2);
// //       }
// //
// //       requests.add(request);
// //       await file.writeAsString(jsonEncode(requests.map((r) => r.toJson()).toList()));
// //       return true;
// //     } catch (e) {
// //       print('Error adding milk request: $e');
// //       return false;
// //     }
// //   }
// //
// //   Future<void> printFilePaths() async {
// //     try {
// //       final dir = await getApplicationDocumentsDirectory();
// //       print('Storage directory: ${dir.path}');
// //
// //       final farmersFile = await _getLocalFile(_farmersFile);
// //       final milkFile = await _getLocalFile(_milkRequestsFile);
// //       print('Farmers file: ${farmersFile.path}');
// //       print('Milk requests file: ${milkFile.path}');
// //     } catch (e) {
// //       print('Error printing file paths: $e');
// //     }
// //   }
// // }

import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:onlinedairy/models/PUser.dart';
import 'package:onlinedairy/models/milk_request.dart';
import '../utils/auth_helper.dart';

class EmployeeService {

  final String? _baseUrl = dotenv.env['API_KEY'];
  // static const String _baseUrl =
  //     'https://e71d-2409-40c2-3d-9907-686a-9744-1bbd-9620.ngrok-free.app'; // Replace with actual URL

  Future<List<PUser>> getAllFarmers() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/api/users/data/farmers'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => PUser.fromJson(json)).toList();
      }
      throw Exception('Failed to load farmers: ${response.statusCode}');
    } catch (e) {
      print('Error fetching farmers: $e');
      return [];
    }
  }
  Future<List<PUser>> getAllEmployees() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/api/users/data/employees'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => PUser.fromJson(json)).toList();
      }
      throw Exception('Failed to load farmers: ${response.statusCode}');
    } catch (e) {
      print('Error fetching farmers: $e');
      return [];
    }
  }

  Future<int> getNextFarmerId() async {
    try {
      List<PUser> farmers = await getAllFarmers();
      if (farmers.isEmpty) {
        return 1; // If no farmers exist, return 1 as the first ID
      }
      if (farmers.isEmpty) {
        return 1;
      }
      // Extract all IDs and find the maximum ID
      int maxId = farmers
          .map((farmer) => farmer.id ?? 0)
          .reduce((a, b) => a > b ? a : b);

      return maxId + 1;
    } catch (e) {
      print('Error fetching next farmer ID: $e');
      return -1; // Return -1 in case of error
    }
  }

  Future<bool> addFarmer(PUser farmer) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/api/users/auth/farmer'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(farmer.toJson()),
      );
      return response.statusCode == 201;
    } catch (e) {
      print('Error adding farmer: $e');
      return false;
    }
  }
  Future<bool> addEmployee(PUser farmer) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/api/users/auth/employee'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(farmer.toJson()),
      );
      return response.statusCode == 201;
    } catch (e) {
      print('Error adding farmer: $e');
      return false;
    }
  }

  Future<List<MilkRequest>> getAllMilkRequests() async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl/milk-requests/getall'),
      );
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => MilkRequest.fromJson(json)).toList();
      }
      throw Exception('Failed to load milk requests: ${response.statusCode}');
    } catch (e) {
      print('Error fetching milk requests: $e');
      return [];
    }
  }

  Future<bool> addMilkRequest(MilkRequest request) async {
    try {
      final currentUser = await AuthHelper.getUser();
      final Map<String, dynamic> requestData = request.toJson();

      // Add employee name from current user
      requestData['employee'] = currentUser?.name;

      final response = await http.post(
        Uri.parse('$_baseUrl/milk-requests/add'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestData),
      );

      return response.statusCode == 201;
    } catch (e) {
      print('Error adding milk request: $e');
      return false;
    }
  }

  Future<List<MilkRequest>> getMilkRequestsByFarmer(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/milk-requests/farmer'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => MilkRequest.fromJson(json)).toList();
      }
      throw Exception('Failed to load requests: ${response.statusCode}');
    } catch (e) {
      print('Error fetching farmer requests: $e');
      return [];
    }
  }
}
