import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:onlinedairy/models/PUser.dart';
import 'package:onlinedairy/models/milk_request.dart';
import '../utils/auth_helper.dart';

class DairyService {
  final String? _baseUrl = dotenv.env['API_KEY'];
  // static const String _baseUrl = 'https://api-dairy.onlinedairy.co';

  Future<List<PUser>> getAllFarmers() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/api/farmers/all'));
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
      final response = await http.get(Uri.parse('$_baseUrl/api/employees/all'));
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => PUser.fromJson(json)).toList();
      }
      throw Exception('Failed to load employees: ${response.statusCode}');
    } catch (e) {
      print('Error fetching employees: $e');
      return [];
    }
  }

  Future<bool> addFarmer(PUser farmer) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/api/farmers/add'),
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
      final response = await http.get(Uri.parse('$_baseUrl/api/milk/all'));
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
      requestData['employee'] = currentUser?.name;

      final response = await http.post(
        Uri.parse('$_baseUrl/api/milk/add'),
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
        Uri.parse('$_baseUrl/api/milk/by-farmer'),
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