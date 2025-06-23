//
//
// import 'package:flutter/material.dart';
//
// class SplashScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//     double screenHeight = MediaQuery.of(context).size.height;
//
//     // Font size scaling
//     double fontSize = screenWidth < 600
//         ? 20 // Mobile
//         : screenWidth < 1024
//         ? 28 // Tablet
//         : 36; // Desktop
//
//     double buttonFontSize = screenWidth < 600 ? 16 : 20;
//
//     // Container width control
//     double containerWidth = screenWidth < 600
//         ? double.infinity // Full width on mobile
//         : screenWidth * 0.6; // Bounded width on larger screens
//
//     return Scaffold(
//       body: Stack(
//         children: [
//           // Background Image (Ensures it resizes properly)
//           Positioned.fill(
//             child: FractionallySizedBox(
//               widthFactor: 1,
//               heightFactor: 1,
//               child: Image.asset(
//                 'assets/images/Splash_image.png',
//                 fit:screenWidth < 300 ? BoxFit.cover : BoxFit.fill, // Ensures the image fills the space
//               ),
//             ),
//           ),
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 SizedBox(
//                   width: screenWidth * 0.8, // Prevents overflow
//                   child: Text(
//                     'WELCOME',
//                     style: TextStyle(
//                       fontSize: fontSize,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.black,
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 SizedBox(height: 20),
//                 SizedBox(
//                   width: screenWidth * 0.8, // Prevents overflow
//                   child: Text(
//                     'DIGITAL',
//                     style: TextStyle(
//                       fontSize: fontSize + 4,
//                       fontWeight: FontWeight.bold,
//                       color: Color.fromARGB(255, 18, 228, 134),
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 SizedBox(
//                   width: screenWidth * 0.8, // Prevents overflow
//                   child: Text(
//                     'DAIRY',
//                     style: TextStyle(
//                       fontSize: fontSize + 4,
//                       fontWeight: FontWeight.bold,
//                       color: Color.fromARGB(255, 18, 228, 134),
//                     ),
//                     overflow: TextOverflow.ellipsis,
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//                 SizedBox(height: 40),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 18.0),
//                   child: SizedBox(
//                     width: screenWidth < 600
//                         ? double.infinity // Full width on mobile
//                         : screenWidth * 0.4, // Bounded width on larger screens
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Add navigation logic
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Color(0xFF35F9D1), // New button color
//                         foregroundColor: Colors.white,
//                         padding: EdgeInsets.symmetric(
//                           horizontal: 20, // Adjusted padding
//                           vertical: 18,  // Adjusted padding for better spacing
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(4), // Less rounded corners
//                         ),
//                       ),
//                       child: Text(
//                         'Get Started',
//                         style: TextStyle(fontSize: buttonFontSize),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ),
//                 ),
//
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'dart:async';
import 'package:flutter/material.dart';

import '../../utils/auth_helper.dart';// Import the authentication helper

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Timer(Duration(seconds: 5), () => AuthHelper.checkAuthentication(context));
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Font size scaling
    double fontSize = screenWidth < 600
        ? 20 // Mobile
        : screenWidth < 1024
        ? 28 // Tablet
        : 36; // Desktop

    double buttonFontSize = screenWidth < 600 ? 16 : 20;

    // Container width control
    double containerWidth = screenWidth < 600
        ? double.infinity // Full width on mobile
        : screenWidth * 0.6; // Bounded width on larger screens

    return Scaffold(
      body: Stack(
        children: [
          // Background Image (Ensures it resizes properly)
          Positioned.fill(
            child: FractionallySizedBox(
              widthFactor: 1,
              heightFactor: 1,
              child: Image.asset(
                'assets/images/Splash_image.png',
                fit: screenWidth < 300 ? BoxFit.cover : BoxFit.fill, // Ensures the image fills the space
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: screenWidth * 0.8,
                  // height: screenWidth * 0.8,// Prevents overflow
                  child: Text(
                    'WELCOME',
                    style: TextStyle(
                      fontSize: fontSize+8,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: screenWidth * 0.8, // Prevents overflow
                  child: Column(
                    children: [
                      Text(
                        'DIGITAL\nDAIRY',
                        style: TextStyle(
                          fontSize: fontSize + 8,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 18, 228, 134),
                        ),
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 40),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: SizedBox(
                          width: screenWidth < 600
                              ? double.infinity // Full width on mobile
                              : screenWidth * 0.4, // Bounded width on larger screens
                          child: ElevatedButton(
                            onPressed: () {
                              AuthHelper.checkAuthentication(context);
                              // AuthHelper.checkAuthentication(context);// Navigate based on login status
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF35F9D1), // New button color
                              foregroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                horizontal: 20, // Adjusted padding
                                vertical: 18, // Adjusted padding for better spacing
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4), // Less rounded corners
                              ),
                            ),
                            child: Text(
                              'Get Started',
                              style: TextStyle(fontSize: buttonFontSize ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // SizedBox(
                //   width: screenWidth * 0.8, // Prevents overflow
                //   child: Text(
                //     'DAIRY',
                //     style: TextStyle(
                //       fontSize: fontSize + 4,
                //       fontWeight: FontWeight.bold,
                //       color: Color.fromARGB(255, 18, 228, 134),
                //     ),
                //     overflow: TextOverflow.ellipsis,
                //     textAlign: TextAlign.center,
                //   ),
                // ),
                SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: SizedBox(
                    width: screenWidth < 600
                        ? double.infinity // Full width on mobile
                        : screenWidth * 0.4, // Bounded width on larger screens

                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
