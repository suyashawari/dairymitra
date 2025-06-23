// import 'package:flutter/material.dart';
//
// import '../../models/PUser.dart';
// import '../../utils/auth_helper.dart';
//
// class Employeedashboard extends StatefulWidget {
//
//   Employeedashboard({super.key});
//
//   @override
//   State<Employeedashboard> createState() => _EmployeedashboardState();
// }
//
// class _EmployeedashboardState extends State<Employeedashboard> {
//   final List<String> records = ["abhi","mahesh","suresh","parasana","omkar"];
//   PUser? user;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadUser();
//   }
//
//   Future<void> _loadUser() async {
//     final savedUser = await AuthHelper.getUser();
//     setState(() {
//       user = savedUser;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isMobileAppBar = screenWidth <= 600;
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor:Color(0xFF35F9D1),
//         toolbarHeight: 80,
//         title: Row(
//           children: [
//             CircleAvatar(
//               backgroundColor: Colors.white,
//               child: Icon(Icons.person, color:Color(0xFF35F9D1)),
//             ),
//             const SizedBox(width: 8.0),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text('Hello 👋',
//                       style: TextStyle(
//                           fontSize: isMobileAppBar ? 10 : 12)),
//                   Text(
//                     user!=null?'${user?.name!}':'Staff',
//                     style: TextStyle(
//                       fontSize: isMobileAppBar ? 16 : 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//         actions: [
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 12.0),
//             child: IconButton(icon: const Icon(Icons.menu), onPressed: () {
//
//               Navigator.pushNamed(context, '/settings');
//             }),
//           ),
//         ],
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           final isMobileBody = constraints.maxWidth <= 600;
//
//           if (!isMobileBody) {
//             int crossAxisCount = (constraints.maxWidth / 300).floor();
//             return GridView.builder(
//               padding: const EdgeInsets.all(16.0),
//               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: crossAxisCount,
//                 crossAxisSpacing: 16.0,
//                 mainAxisSpacing: 16.0,
//                 childAspectRatio: 1.5,
//               ),
//               itemCount: records.length,
//               itemBuilder: (context, index) {
//                 return RecordCard(
//                   farmername: records[index],
//                   isMobile: isMobileBody, onPressed: () { Navigator.pushNamed(context, '/add_milk_collection'); },
//                 );
//               },
//             );
//           } else {
//             return ListView.builder(
//               padding: const EdgeInsets.all(16.0),
//               itemCount: records.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.only(bottom: 16.0),
//                   child: RecordCard(
//                     farmername: records[index],
//                     isMobile: isMobileBody, onPressed: () {   Navigator.pushNamed(context, '/add_milk_collection'); },
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//       floatingActionButton: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             FloatingActionButton(
//               heroTag: 'uniqueTagForThisButton', // Add a unique tag
//               onPressed: () {
//                 Navigator.pushNamed(context, '/add_new_farmer');
//
//               },
//               backgroundColor: Color(0xFF35F9D1),
//               child: const Icon(Icons.add, color: Colors.black),
//             ),
//
//             FloatingActionButton(
//               heroTag: 'uniqueTagForThisButton2', // Add a unique tag
//               onPressed: () {
//                 Navigator.pushNamed(context, '/start_collecting_milk');
//               },
//               backgroundColor: Color(0xFF35F9D1),
//               child: const Icon(Icons.local_shipping, color: Colors.black),
//             ),
//
//           ],
//         ),
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//     );
//   }
// }
// class RecordCard extends StatelessWidget {
//   final String farmername;
//   final bool isMobile;
//   final VoidCallback onPressed;
//
//   const RecordCard({
//     super.key,
//     required this.farmername,
//     required this.isMobile,
//     required this.onPressed,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//
//     return Container(
//       width: isMobile ? double.infinity : 600, // Fixed width for larger screens
//       margin: const EdgeInsets.symmetric(vertical: 4.0),
//       child: ElevatedButton(
//         onPressed: onPressed,
//         style: ElevatedButton.styleFrom(
//           backgroundColor: Colors.green[50],
//           padding: const EdgeInsets.symmetric(vertical: 16.0),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8.0),
//           ),
//         ),
//         child: Text(
//           farmername,
//           style: TextStyle(
//             color: Colors.black,
//
//             fontSize: isMobile ? 14.0 : 16.0,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onlinedairy/services/EmployeeService.dart';

import '../../models/PUser.dart';
import '../../utils/auth_helper.dart';

class Employeedashboard extends StatefulWidget {
  Employeedashboard({super.key});

  @override
  State<Employeedashboard> createState() => _EmployeedashboardState();
}

class _EmployeedashboardState extends State<Employeedashboard> {
  List<PUser> farmers = [];
  PUser? user;
  bool isLoading = true;
  EmployeeService _employeeService=EmployeeService();

  @override
  void initState() {
    super.initState();
    _loadUser();
    _loadFarmers();
  }

  Future<void> _loadUser() async {
    final savedUser = await AuthHelper.getUser();
    setState(() {
      user = savedUser;
    });
  }

  Future<void> _loadFarmers() async {
    try {
      final fetchedFarmers = await _employeeService.getAllFarmers(); // Ensure this method is accessible
      setState(() {
        farmers = fetchedFarmers;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading farmers: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<bool> _showExitConfirmation() async {
    return await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Exit App'),
        content: const Text('Do you want to exit the app?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), // Stay in app
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true), // Exit app
            child: const Text('Yes'),
          ),
        ],
      ),
    ) ?? false; // Default to false if dialog is dismissed
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobileAppBar = screenWidth <= 600;

    return PopScope(
      canPop: false, // Prevents default back navigation
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return; // If already popped, do nothing
        final shouldExit = await _showExitConfirmation();
        if (shouldExit) {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xFF35F9D1),
          toolbarHeight: 80,
          title: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Color(0xFF35F9D1)),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Hello 👋',
                        style: TextStyle(
                            fontSize: isMobileAppBar ? 10 : 12)),
                    Text(
                      user != null ? '${user?.name}' : 'Staff',
                      style: TextStyle(
                        fontSize: isMobileAppBar ? 16 : 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Navigator.pushNamed(context, '/settings');
                  }),
            ),
          ],
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final isMobileBody = constraints.maxWidth <= 600;

            if (isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (farmers.isEmpty) {
              return const Center(child: Text('No farmers found.'));
            }

            if (!isMobileBody) {
              int crossAxisCount = (constraints.maxWidth / 300).floor();
              return GridView.builder(
                padding: const EdgeInsets.all(16.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 16.0,
                  mainAxisSpacing: 16.0,
                  childAspectRatio: 1.5,
                ),
                itemCount: farmers.length,
                itemBuilder: (context, index) {
                  return RecordCard(
                    farmername: farmers[index].name ?? 'No Name',
                    isMobile: isMobileBody,
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        '/add_milk_collection',
                        arguments: farmers[index],
                      );
                    },
                  );
                },
              );
            } else {
              return ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemCount: farmers.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: RecordCard(
                      farmername: farmers[index].name ?? 'No Name',
                      isMobile: isMobileBody,
                      onPressed: () {
                        Navigator.pushNamed(
                          context,
                          '/add_milk_collection',
                          arguments: farmers[index],
                        );

                      },
                    ),
                  );
                },
              );
            }
          },
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                heroTag: 'uniqueTagForThisButton',
                onPressed: () async {
                  final result = await Navigator.pushNamed(context, '/add_new_farmer');

                  // If farmer was added (result is true), refresh the list
                  if (result == true) {
                    await _loadFarmers(); // Refresh the farmer list
                  }
                },
                backgroundColor: Color(0xFF35F9D1),
                child: const Icon(Icons.add, color: Colors.black),
              ),
              FloatingActionButton(
                heroTag: 'uniqueTagForThisButton2',
                onPressed: () {
                  Navigator.pushNamed(context, '/start_collecting_milk');
                },
                backgroundColor: Color(0xFF35F9D1),
                child: const Icon(Icons.local_shipping, color: Colors.black),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}

class RecordCard extends StatelessWidget {
  final String farmername;
  final bool isMobile;
  final VoidCallback onPressed;

  const RecordCard({
    super.key,
    required this.farmername,
    required this.isMobile,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: isMobile ? double.infinity : 600,
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green[50],
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        child: Text(
          farmername,
          style: TextStyle(
            color: Colors.black,
            fontSize: isMobile ? 14.0 : 16.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}