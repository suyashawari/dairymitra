
import 'package:flutter/material.dart'; // Import the authentication helper
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onlinedairy/screens/farmer/trancsactionhistorypage.dart';
import 'package:onlinedairy/screens/manager/EmployeeDataVisualization.dart';
import 'screens/common_screen/splash_screen.dart';
import 'screens/common_screen/login.dart';
import 'screens/common_screen/main_page.dart';
import 'screens/common_screen/setting_logout.dart';

import 'screens/farmer/farmer_dashboard.dart';
import 'screens/farmer/truck_track.dart';

import 'screens/staff/staff_dashboard.dart';
import 'screens/staff/add_milk_collection.dart';
import 'screens/staff/add_new_farmer.dart';
import 'screens/staff/collecting_milk.dart';

import 'screens/manager/manager_dashboard.dart';
import 'screens/manager/farmer_data.dart';
import 'screens/manager/staff_data.dart';
import 'screens/manager/add_staff.dart';
Future main() async {
  // Ensure that the binding is initialized
  WidgetsFlutterBinding.ensureInitialized();
  // Load the .env file
  await dotenv.load(fileName: ".env");
  runApp( MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: _buildTheme(context),
      debugShowCheckedModeBanner: false,
      title: 'Dairy Management',
      initialRoute: '/', // Splash Screen first
      routes: {
        // Common Screens
        '/': (context) => SplashScreen(),
        '/main': (context) => MainPage(),
        '/login': (context) => LoginPage(),
        // '/settings': (context) => SettingsLogoutPage(),
        '/settings': (context) => const SettingsLogoutPage(),

        // Farmer Screens
        '/farmer_dashboard': (context) => FarmerDashboardPage(),
        // '/truck_track': (context) => TruckTrackScreen(),
        '/transaction_history': (context) => TransactionHistoryPage(),

        // Staff Screens
        '/staff_dashboard': (context) => Employeedashboard(),
        '/add_milk_collection': (context) => MilkCollectionPage(),
        '/add_new_farmer': (context) => AddNewFarmerScreen(),
        '/start_collecting_milk': (context) => StartMilkCollectingPage(),

        // Manager Screens
        '/manager_dashboard': (context) => ManagerDashboard(),
        '/farmer_data': (context) => FarmerDataPage(),
        '/staff_data': (context) => StaffDataPage(),
        '/add_staff': (context) => AddNewStaffScreen(),
        '/analysispage': (context) =>ChartPage()
      },
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
            builder: (context) => const Scaffold(
              body: Center(child: Text('Route not found')),
            ));
      },
    );
  }
  ThemeData _buildTheme(BuildContext context) {
    return ThemeData(
      primaryColor: const Color(0xFF35F9D1),
      scaffoldBackgroundColor: const Color(0xFFEFF9FF),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: _getResponsiveFontSize(context, 28.0, 50.0, 60.0),
          fontWeight: FontWeight.bold,
          color: const Color(0xFF35F9D1),
        ),
        displayMedium: TextStyle(
          fontSize: _getResponsiveFontSize(context, 21.0, 40.0, 48.0),
          fontWeight: FontWeight.bold,
          color: const Color(0xFF35F9D1),
        ),
        titleMedium: TextStyle(
          fontSize: _getResponsiveFontSize(context, 14.0, 24.0, 28.0),
          color: const Color(0xFF616161),
        ),
        labelLarge: TextStyle(
          fontSize: _getResponsiveFontSize(context, 14.0, 22.0, 26.0),
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
  static double _getResponsiveFontSize(
      BuildContext context, double mobile, double tablet, double desktop) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return mobile;
    if (width < 900) return tablet;
    return desktop;
  }
}


//
// import 'package:flutter/material.dart';
// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter HTTP Request',
//       theme: ThemeData.dark(), // Dark theme for better UI
//       home: ApiRequestScreen(),
//     );
//   }
// }
//
// class ApiRequestScreen extends StatefulWidget {
//   @override
//   _ApiRequestScreenState createState() => _ApiRequestScreenState();
// }
//
// class _ApiRequestScreenState extends State<ApiRequestScreen> {
//   String? responseText;
//   bool isLoading = false;
//   String? errorText;
//
//   Future<void> fetchData() async {
//     setState(() {
//       isLoading = true;
//       responseText = null;
//       errorText = null;
//     });
//
//     try {
//       final uri = Uri.parse('https://7fd9-183-87-238-170.ngrok-free.app/api/users/data/hello'); // Ensure HTTP is allowed on all platforms
//       final response = await http.get(uri);
//
//       if (response.statusCode == 200) {
//         setState(() {
//           responseText = utf8.decode(response.bodyBytes);
//         });
//       } else {
//         setState(() {
//           errorText = "Error: ${response.statusCode} - ${response.reasonPhrase}";
//         });
//       }
//     } catch (e) {
//       setState(() {
//         errorText = "Request failed: $e";
//       });
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     fetchData(); // Fetch data when screen loads
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("API Request Example")),
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               if (isLoading)
//                 CircularProgressIndicator()
//               else if (errorText != null)
//                 Text(errorText!, style: TextStyle(color: Colors.red, fontSize: 16))
//               else if (responseText != null)
//                   Text(responseText!, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: fetchData,
//                 child: Text("Fetch Again"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
