

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/PUser.dart';

class AuthHelper {
  static const String _userKey = "user_data";
  static const String _pastUsersKey = "past_users";

  static Future<void> saveUser(PUser user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(user.toJson()));
  }

  static Future<PUser?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userData = prefs.getString(_userKey);
    if (userData == null) return null;
    return PUser.fromJson(jsonDecode(userData));
  }

  static Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(_userKey);
  }

  static Future<void> checkAuthentication(BuildContext context) async {
    final loggedIn = await isLoggedIn();
    if (!loggedIn) {
      Navigator.pushReplacementNamed(context, '/main');
      return;
    }

    final user = await getUser();
    if (user == null || user.role == null) {
      await clearUser();
      Navigator.pushReplacementNamed(context, '/main');
      return;
    }

    switch (user.role) {
      case "ROLE_FARMER":
        Navigator.pushReplacementNamed(context, '/farmer_dashboard');
        break;
      case "ROLE_EMPLOYEE":
        Navigator.pushReplacementNamed(context, '/staff_dashboard');
        break;
      case "ROLE_MANAGER":
        Navigator.pushReplacementNamed(context, '/manager_dashboard');
        break;
      default:
        await clearUser();
        Navigator.pushReplacementNamed(context, '/main');
    }
  }

  // static Future<void> addPastUser(PUser user) async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final pastUsersData = prefs.getStringList(_pastUsersKey) ?? [];
  //
  //   if (!pastUsersData.any((u) => PUser.fromJson(jsonDecode(u)).email == user.email)) {
  //     pastUsersData.add(jsonEncode(user.toJson()));
  //     await prefs.setStringList(_pastUsersKey, pastUsersData);
  //   }
  // }
  static Future<void> addPastUser(PUser user) async {
    final prefs = await SharedPreferences.getInstance();
    final pastUsersData = prefs.getStringList(_pastUsersKey) ?? [];
    bool userExists = false;

    for (int i = 0; i < pastUsersData.length; i++) {
      final currentUser = PUser.fromJson(jsonDecode(pastUsersData[i]));
      if (currentUser.email == user.email) {
        userExists = true;
        // If the password is different, update it.
        if (currentUser.password != user.password) {
          currentUser.password = user.password;
          pastUsersData[i] = jsonEncode(currentUser.toJson());
        }
        break; // We found the user, no need to continue.
      }
    }

    // If no user exists with that email, add the new user.
    if (!userExists) {
      pastUsersData.add(jsonEncode(user.toJson()));
    }

    await prefs.setStringList(_pastUsersKey, pastUsersData);
  }


  static Future<List<PUser>> getPastUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final pastUsersData = prefs.getStringList(_pastUsersKey) ?? [];
    return pastUsersData.map((u) => PUser.fromJson(jsonDecode(u))).toList();
  }
}