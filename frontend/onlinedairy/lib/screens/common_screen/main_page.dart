// //
// // import 'package:flutter/material.dart';
// //
// // class MainPage extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     double screenWidth = MediaQuery.of(context).size.width;
// //
// //     return Scaffold(
// //       body: LayoutBuilder(
// //         builder: (context, constraints) {
// //           double fontSize = screenWidth < 600
// //               ? 16 // Mobile font size
// //               : screenWidth < 1024
// //               ? 20 // Tablet font size
// //               : 24; // Desktop font size
// //
// //           double buttonWidth = screenWidth < 600
// //               ? screenWidth * 0.8 // Mobile: 80% of screen width
// //               : screenWidth * 0.4; // Tablet/Desktop: 40% of screen width
// //
// //           return Container(
// //             width: double.infinity,
// //             height: double.infinity,
// //             decoration: BoxDecoration(
// //               image: DecorationImage(
// //                 image: AssetImage('assets/images/Background.png'),
// //                 fit: screenWidth < 300 ? BoxFit.cover : BoxFit.fill,
// //               ),
// //             ),
// //             child: Center(
// //               child: SingleChildScrollView(
// //                 child: ConstrainedBox(
// //                   constraints: BoxConstraints(
// //                     minHeight: constraints.maxHeight,
// //                   ),
// //                   child: IntrinsicHeight(
// //                     child: Column(
// //                       mainAxisAlignment: MainAxisAlignment.center,
// //                       children: [
// //                         _buildUserButton('Farmer', Icons.agriculture, buttonWidth, fontSize, () {}),
// //                         const SizedBox(height: 20),
// //                         _buildUserButton('Staff', Icons.people, buttonWidth, fontSize, () {}),
// //                         const SizedBox(height: 20),
// //                         _buildUserButton('Manager', Icons.manage_accounts, buttonWidth, fontSize, () {}),
// //                       ],
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// //
// //   Widget _buildUserButton(
// //       String title, IconData icon, double width, double fontSize, VoidCallback onPressed) {
// //     return SizedBox(
// //       width: width,
// //       child: ElevatedButton(
// //         onPressed: onPressed,
// //         style: ElevatedButton.styleFrom(
// //           backgroundColor: Colors.white,
// //           foregroundColor: Colors.blue.shade800,
// //           padding: const EdgeInsets.symmetric(vertical: 16),
// //           shape: RoundedRectangleBorder(
// //             borderRadius: BorderRadius.circular(12),
// //           ),
// //         ),
// //         child: Row(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Expanded(
// //                 flex: 2,
// //                 child: Icon(icon, size: fontSize + 2)),
// //             const SizedBox(width: 10),
// //             Expanded(
// //               flex: 10,
// //               child: Center(
// //                 child: Text(
// //                   title,
// //                   style: TextStyle(
// //                     fontSize: fontSize,
// //                     fontWeight: FontWeight.bold,
// //                   ),
// //                   overflow: TextOverflow.ellipsis, // Prevents text overflow
// //                   maxLines: 1, // Ensures text stays in one line
// //                   softWrap: false,
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// // //
// // // import 'package:flutter/material.dart';
// // //
// // // class MainPage extends StatelessWidget {
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     double screenWidth = MediaQuery.of(context).size.width;
// // //     double screenHeight = MediaQuery.of(context).size.height;
// // //
// // //     return Scaffold(
// // //       body: LayoutBuilder(
// // //         builder: (context, constraints) {
// // //           double fontSize = screenWidth < 600
// // //               ? 16 // Mobile font size
// // //               : screenWidth < 1024
// // //               ? 20 // Tablet font size
// // //               : 24; // Desktop font size
// // //
// // //           double buttonWidth = screenWidth < 600
// // //               ? screenWidth * 0.9 // Mobile: 90% of screen width
// // //               : screenWidth * 0.5; // Tablet/Desktop: 50% of screen width
// // //
// // //           return Container(
// // //             width: double.infinity,
// // //             height: double.infinity,
// // //             decoration: BoxDecoration(
// // //               image: DecorationImage(
// // //                 image: AssetImage('assets/images/Background.png'),
// // //                 fit: BoxFit.cover, // Ensures proper fitting
// // //               ),
// // //             ),
// // //             child: Center(
// // //               child: SingleChildScrollView(
// // //                 child: Column(
// // //                   mainAxisAlignment: MainAxisAlignment.center,
// // //                   children: [
// // //                     _buildUserButton('Farmer', Icons.agriculture, buttonWidth, fontSize, () {}),
// // //                     const SizedBox(height: 20),
// // //                     _buildUserButton('Staff', Icons.people, buttonWidth, fontSize, () {}),
// // //                     const SizedBox(height: 20),
// // //                     _buildUserButton('Manager', Icons.manage_accounts, buttonWidth, fontSize, () {}),
// // //                   ],
// // //                 ),
// // //               ),
// // //             ),
// // //           );
// // //         },
// // //       ),
// // //     );
// // //   }
// // //
// // //   Widget _buildUserButton(
// // //       String title, IconData icon, double width, double fontSize, VoidCallback onPressed) {
// // //     return SizedBox(
// // //       width: width,
// // //       child: ElevatedButton(
// // //         onPressed: onPressed,
// // //         style: ElevatedButton.styleFrom(
// // //           backgroundColor: Colors.white,
// // //           foregroundColor: Colors.blue.shade800,
// // //           padding: EdgeInsets.symmetric(vertical: fontSize), // Scales button size
// // //           shape: RoundedRectangleBorder(
// // //             borderRadius: BorderRadius.circular(12),
// // //           ),
// // //         ),
// // //         child: Row(
// // //           mainAxisAlignment: MainAxisAlignment.center,
// // //           children: [
// // //             Icon(icon, size: fontSize + 4),
// // //             const SizedBox(width: 10),
// // //             Text(
// // //               title,
// // //               style: TextStyle(
// // //                 fontSize: fontSize,
// // //                 fontWeight: FontWeight.bold,
// // //               ),
// // //               overflow: TextOverflow.ellipsis,
// // //               maxLines: 1,
// // //             ),
// // //           ],
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }
// import 'package:flutter/material.dart';
//
// class MainPage extends StatelessWidget {
//   const MainPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           double fontSize = screenWidth < 600
//               ? 16 // Mobile font size
//               : screenWidth < 1024
//               ? 20 // Tablet font size
//               : 24; // Desktop font size
//
//           double buttonWidth = screenWidth < 600
//               ? screenWidth * 0.8 // Mobile: 80% of screen width
//               : screenWidth * 0.4; // Tablet/Desktop: 40% of screen width
//
//           return Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: BoxDecoration(
//               image: DecorationImage(
//                 image: const AssetImage('assets/images/Background.png'),
//                 fit: screenWidth < 300 ? BoxFit.cover : BoxFit.fill,
//               ),
//             ),
//             child: Center(
//               child: SingleChildScrollView(
//                 child: ConstrainedBox(
//                   constraints: BoxConstraints(
//                     minHeight: constraints.maxHeight,
//                   ),
//                   child: IntrinsicHeight(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         _buildUserButton(
//                           'Farmer',
//                           Icons.agriculture,
//                           buttonWidth,
//                           fontSize,
//                               () => Navigator.pushNamed(context, '/login'),
//                         ),
//                         const SizedBox(height: 20),
//                         _buildUserButton(
//                           'Staff',
//                           Icons.people,
//                           buttonWidth,
//                           fontSize,
//                               () => Navigator.pushNamed(context, '/login'),
//                         ),
//                         const SizedBox(height: 20),
//                         _buildUserButton(
//                           'Manager',
//                           Icons.manage_accounts,
//                           buttonWidth,
//                           fontSize,
//                               () => Navigator.pushNamed(context, '/login'),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget _buildUserButton(
//       String title, IconData icon, double width, double fontSize, VoidCallback onPressed) {
//     return SizedBox(
//       width: width,
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.white,
//           foregroundColor: Colors.blue.shade800,
//           padding: const EdgeInsets.symmetric(vertical: 16),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Expanded(
//               flex: 2,
//               child: Icon(icon, size: fontSize + 2),
//             ),
//             const SizedBox(width: 10),
//             Expanded(
//               flex: 10,
//               child: Center(
//                 child: Text(
//                   title,
//                   style: TextStyle(
//                     fontSize: fontSize,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   overflow: TextOverflow.ellipsis,
//                   maxLines: 1,
//                   softWrap: false,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double fontSize = screenWidth < 600
              ? 16 // Mobile font size
              : screenWidth < 1024
              ? 20 // Tablet font size
              : 24; // Desktop font size

          double buttonWidth = screenWidth < 600
              ? screenWidth * 0.8 // Mobile: 80% of screen width
              : screenWidth * 0.4; // Tablet/Desktop: 40% of screen width

          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/images/Background.png'),
                fit: screenWidth < 300 ? BoxFit.cover : BoxFit.fill,
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildUserButton(
                          'Farmer',
                          Icons.agriculture,
                          buttonWidth,
                          fontSize,
                              () => Navigator.pushNamed(context, '/login'),
                        ),
                        const SizedBox(height: 20),
                        _buildUserButton(
                          'Staff',
                          Icons.people,
                          buttonWidth,
                          fontSize,
                              () => Navigator.pushNamed(context, '/login'),
                        ),
                        const SizedBox(height: 20),
                        _buildUserButton(
                          'Manager',
                          Icons.manage_accounts,
                          buttonWidth,
                          fontSize,
                              () => Navigator.pushNamed(context, '/login'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildUserButton(
      String title, IconData icon, double width, double fontSize, VoidCallback onPressed) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.blue.shade800,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center, // Center horizontally
          children: [
            Icon(icon, size: fontSize + 2),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
            ),
          ],
        ),
      ),
    );
  }
}