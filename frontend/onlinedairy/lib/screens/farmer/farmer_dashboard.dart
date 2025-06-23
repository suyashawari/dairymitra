//
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import '../../models/PUser.dart';
// import '../../models/milk_request.dart';
// import '../../services/EmployeeService.dart';
// import '../../utils/auth_helper.dart';
//
// class FarmerDashboardPage extends StatefulWidget {
//   const FarmerDashboardPage({super.key});
//
//   @override
//   State<FarmerDashboardPage> createState() => _FarmerDashboardPageState();
// }
//
// class _FarmerDashboardPageState extends State<FarmerDashboardPage> with SingleTickerProviderStateMixin {
//   PUser? user;
//   final EmployeeService _employeeService = EmployeeService();
//   List<MilkRequest> milkRequests = [];
//   bool _isLoading = true;
//   String? _errorMessage;
//
//   @override
//   void initState() {
//     super.initState();
//     _initializeData();
//   }
//
//   Future<void> _initializeData() async {
//     try {
//       await _loadUser();
//       if (user != null) {
//         await _loadMilkRequests();
//       }
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'Failed to load data: ${e.toString()}';
//         _isLoading = false;
//       });
//     }
//   }
//
//   Future<void> _loadUser() async {
//     try {
//       final savedUser = await AuthHelper.getUser();
//       setState(() {
//         user = savedUser;
//         if (user == null) throw Exception('User not logged in');
//       });
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'User loading failed: ${e.toString()}';
//         _isLoading = false;
//       });
//     }
//   }
//
//   Future<void> _loadMilkRequests() async {
//     try {
//       final requests = await _employeeService.getMilkRequestsByFarmer(user!.email!);
//       setState(() {
//         milkRequests = requests.reversed.toList();
//         _isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _errorMessage = 'Failed to load milk requests: ${e.toString()}';
//         _isLoading = false;
//       });
//     }
//   }
//   Future<bool> _showExitConfirmation() async {
//     return await showDialog<bool>(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text('Exit App'),
//         content: const Text('Do you want to exit the app?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(false), // Stay in app
//             child: const Text('No'),
//           ),
//           TextButton(
//             onPressed: () => Navigator.of(context).pop(true), // Exit app
//             child: const Text('Yes'),
//           ),
//         ],
//       ),
//     ) ?? false; // Default to false if dialog is dismissed
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isMobileAppBar = screenWidth <= 600;
//
//     return PopScope(
//       canPop: false, // Prevents default back navigation
//       onPopInvokedWithResult: (didPop, result) async {
//         if (didPop) return; // If already popped, do nothing
//         final shouldExit = await _showExitConfirmation();
//         if (shouldExit) {
//           SystemNavigator.pop();
//         }
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           automaticallyImplyLeading: false,
//           backgroundColor: const Color(0xFF35F9D1),
//           toolbarHeight: 80,
//           title: Row(
//             children: [
//               CircleAvatar(
//                 backgroundColor: Colors.white,
//                 child: Icon(Icons.person, color: const Color(0xFF35F9D1)),
//               ),
//               const SizedBox(width: 8.0),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text('Hello 👋',
//                         style: TextStyle(fontSize: isMobileAppBar ? 10 : 12)),
//                     Text(
//                       user != null ? '${user?.name}' : 'Manager',
//                       style: TextStyle(
//                         fontSize: isMobileAppBar ? 16 : 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           actions: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 12.0),
//               child: IconButton(
//                   icon: const Icon(Icons.menu),
//                   onPressed: () {
//                     Navigator.pushNamed(context, '/settings');
//                   }),
//             ),
//           ],
//         ),
//         body: _buildBodyContent(isMobileAppBar),
//         floatingActionButton: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               FloatingActionButton(
//                 heroTag: 'uniqueTagForThisButton',
//                 onPressed: () {
//                   Navigator.pushNamed(context, '/transaction_history');
//                 },
//                 backgroundColor: const Color(0xFF35F9D1),
//                 child: const Icon(Icons.receipt_long_sharp, color: Colors.black),
//               ),
//               FloatingActionButton(
//                 heroTag: 'uniqueTagForThisButton2',
//                 onPressed: _showMilkCollectionSheet,
//                 backgroundColor: const Color(0xFF35F9D1),
//                 child: const Icon(Icons.local_shipping, color: Colors.black),
//               ),
//             ],
//           ),
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       ),
//     );
//   }
//
//   Widget _buildBodyContent(bool isMobileAppBar) {
//     if (_isLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }
//
//     if (_errorMessage != null) {
//       return Center(
//         child: Padding(
//           padding: const EdgeInsets.all(20.0),
//           child: Text(
//             _errorMessage!,
//             style: TextStyle(
//               color: Colors.red,
//               fontSize: isMobileAppBar ? 14 : 16,
//             ),
//             textAlign: TextAlign.center,
//           ),
//         ),
//       );
//     }
//
//     if (milkRequests.isEmpty) {
//       return const Center(
//         child: Text(
//           'No milk requests found for your account',
//           style: TextStyle(fontSize: 16),
//         ),
//       );
//     }
//
//     return RefreshIndicator(
//       onRefresh: _loadMilkRequests,
//       child: LayoutBuilder(
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
//               itemCount: milkRequests.length,
//               itemBuilder: (context, index) {
//                 return RecordCard(
//                   record: _convertMilkRequestToRecord(milkRequests[index]),
//                   isMobile: isMobileBody,
//                 );
//               },
//             );
//           } else {
//             return ListView.builder(
//               padding: const EdgeInsets.all(16.0),
//               itemCount: milkRequests.length,
//               itemBuilder: (context, index) {
//                 return Padding(
//                   padding: const EdgeInsets.only(bottom: 16.0),
//                   child: RecordCard(
//                     record: _convertMilkRequestToRecord(milkRequests[index]),
//                     isMobile: isMobileBody,
//                   ),
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }
//
//   Map<String, String> _convertMilkRequestToRecord(MilkRequest request) {
//     try {
//       final totalPrice = request.totalPrice ??
//           (request.liters != null && request.pricePerLiter != null
//               ? (request.liters! * request.pricePerLiter!).round()
//               : 0);
//
//       return {
//
//         'date': _formatDate(request.date),
//         'milkPrice': '₹$totalPrice',
//         'payment': request.paymentMethod?.toUpperCase() ?? 'CASH',
//         'staffName': request.employee ?? 'Staff',
//       };
//     } catch (e) {
//       print('Error converting milk request: $e');
//       return {
//         'date': 'Error',
//         'milkPrice': 'N/A',
//         'payment': 'Error',
//         'staffName': 'Error',
//       };
//     }
//   }
//
//   String _formatDate(DateTime? date) {
//     if (date == null) return 'Date not available';
//     return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
//   }
//
//   void _showMilkCollectionSheet() {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(
//           top: Radius.circular(20.0),
//         ),
//       ),
//       builder: (context) {
//         return Padding(
//           padding: EdgeInsets.only(
//             bottom: MediaQuery.of(context).viewInsets.bottom,
//           ),
//           child: SingleChildScrollView(
//             child: Container(
//               padding: const EdgeInsets.all(20.0),
//               child: const TrackingUI(),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
//
// class RecordCard extends StatelessWidget {
//   final Map<String, String> record;
//   final bool isMobile;
//
//   const RecordCard({
//     super.key,
//     required this.record,
//     required this.isMobile,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final labelFontSize = isMobile ? 12.0 : 14.0;
//     final valueFontSize = isMobile ? 12.0 : 14.0;
//
//     return Card(
//       elevation: 4.0,
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             _buildRow('Date:', record['date']!, labelFontSize, valueFontSize),
//             const SizedBox(height: 8.0),
//             _buildRow('Payment:', record['payment']!, labelFontSize, valueFontSize),
//             const SizedBox(height: 8.0),
//             _buildRow('Milk Total Price:', record['milkPrice']!, labelFontSize, valueFontSize),
//             const SizedBox(height: 8.0),
//             _buildRow('Staff Name:', record['staffName']!, labelFontSize, valueFontSize),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildRow(String label, String value, double labelFontSize, double valueFontSize) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Flexible(
//           child: Text(label,
//               style: TextStyle(fontSize: labelFontSize, color: Colors.grey[600])),
//         ),
//         Flexible(
//           child: Text(
//             value,
//             style: TextStyle(
//               fontSize: valueFontSize,
//               fontWeight: FontWeight.bold,
//               color: Colors.grey[800],
//             ),
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// // Updated Tracking UI Widget with Overflow Fix
// class TrackingUI extends StatefulWidget {
//   const TrackingUI({super.key});
//
//   @override
//   _TrackingUIState createState() => _TrackingUIState();
// }
//
// class _TrackingUIState extends State<TrackingUI> with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _progressAnimation;
//   int currentStep = 2; // Example: Set to 2 for "Milk Collected" (0-based index)
//
//   late List<Map<String, String>> trackingSteps;
//
//   @override
//   void initState() {
//     super.initState();
//
//     // Dynamically generate dates based on current day (March 31, 2025)
//     final now = DateTime.now();
//     trackingSteps = [
//       {
//         'status': 'Truck Dispatched',
//         'date': _formatDate(now.subtract(const Duration(days: 3))),
//       },
//       {
//         'status': 'Truck Arrived',
//         'date': _formatDate(now.subtract(const Duration(days: 1))),
//       },
//       {
//         'status': 'Milk Collected',
//         'date': _formatDate(now),
//       },
//     ];
//
//     _controller = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     );
//     _progressAnimation = Tween<double>(
//       begin: 0.0,
//       end: currentStep / (trackingSteps.length - 1),
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut))
//       ..addListener(() {
//         setState(() {});
//       });
//     _controller.forward();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   String _formatDate(DateTime date) {
//     return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         const Text(
//           'Track Your Milk Parcel',
//           style: TextStyle(
//             fontSize: 20,
//             fontWeight: FontWeight.bold,
//             color: Color(0xFF35F9D1),
//           ),
//           textAlign: TextAlign.center,
//         ),
//         const SizedBox(height: 20),
//         SizedBox(
//           height: 120,
//           child: LayoutBuilder(
//             builder: (context, constraints) {
//               final totalWidth = constraints.maxWidth - 80; // Account for padding
//               final stepWidth = totalWidth / (trackingSteps.length - 1);
//
//               return Stack(
//                 children: [
//                   // Background Line
//                   Positioned(
//                     top: 20,
//                     left: 40,
//                     width: totalWidth,
//                     child: Container(
//                       height: 4,
//                       color: Colors.grey[300],
//                     ),
//                   ),
//                   // Animated Progress Line
//                   Positioned(
//                     top: 20,
//                     left: 40,
//                     child: Container(
//                       height: 4,
//                       width: stepWidth * currentStep * _progressAnimation.value,
//                       color: const Color(0xFF35F9D1),
//                     ),
//                   ),
//                   // Tracking Steps with Flexible to prevent overflow
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: List.generate(trackingSteps.length, (index) {
//                       bool isCompleted = index <= currentStep;
//                       return Flexible(
//                         child: ConstrainedBox(
//                           constraints: BoxConstraints(maxWidth: stepWidth),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               CircleAvatar(
//                                 radius: 20,
//                                 backgroundColor: isCompleted
//                                     ? const Color(0xFF35F9D1)
//                                     : Colors.grey[300],
//                                 child: Icon(
//                                   isCompleted ? Icons.check : Icons.circle,
//                                   color: isCompleted ? Colors.black : Colors.grey[600],
//                                   size: 20,
//                                 ),
//                               ),
//                               const SizedBox(height: 8),
//                               Text(
//                                 trackingSteps[index]['status']!,
//                                 style: TextStyle(
//                                   fontSize: 12,
//                                   fontWeight: isCompleted ? FontWeight.bold : FontWeight.normal,
//                                   color: isCompleted ? Colors.black : Colors.grey[600],
//                                 ),
//                                 textAlign: TextAlign.center,
//                                 maxLines: 2,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               Text(
//                                 trackingSteps[index]['date']!,
//                                 style: const TextStyle(
//                                   fontSize: 10,
//                                   color: Colors.grey,
//                                 ),
//                                 textAlign: TextAlign.center,
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     }),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ),
//         const SizedBox(height: 20),
//         ElevatedButton(
//           style: ElevatedButton.styleFrom(
//             backgroundColor: const Color(0xFF35F9D1),
//             padding: const EdgeInsets.symmetric(vertical: 15),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//           ),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: const Text(
//             'Close',
//             style: TextStyle(
//               fontSize: 16,
//               color: Colors.black,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../models/PUser.dart';
import '../../models/milk_request.dart';
import '../../services/EmployeeService.dart';
import '../../utils/auth_helper.dart';

class FarmerDashboardPage extends StatefulWidget {
  const FarmerDashboardPage({super.key});

  @override
  State<FarmerDashboardPage> createState() => _FarmerDashboardPageState();
}

class _FarmerDashboardPageState extends State<FarmerDashboardPage> with SingleTickerProviderStateMixin {
  PUser? user;
  final EmployeeService _employeeService = EmployeeService();
  List<MilkRequest> milkRequests = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    try {
      await _loadUser();
      if (user != null) {
        await _loadMilkRequests();

      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load data: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  Future<void> _loadUser() async {
    try {
      final savedUser = await AuthHelper.getUser();
      setState(() {
        user = savedUser;
        if (user == null) throw Exception('User not logged in');
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'User loading failed: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  Future<void> _loadMilkRequests() async {
    try {
      final requests = await _employeeService.getMilkRequestsByFarmer(user!.email!);
      setState(() {
        milkRequests = requests.reversed.toList();
        print('Loaded ${milkRequests.first.toString()} milk requests');
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load milk requests: ${e.toString()}';
        _isLoading = false;
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
          backgroundColor: const Color(0xFF35F9D1),
          toolbarHeight: 80,
          title: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: const Color(0xFF35F9D1)),
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Hello 👋',
                        style: TextStyle(fontSize: isMobileAppBar ? 10 : 12)),
                    Text(
                      user != null ? '${user?.name}' : 'Farmer',
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
        body: _buildBodyContent(isMobileAppBar),
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FloatingActionButton(
                heroTag: 'uniqueTagForThisButton',
                onPressed: () {
                  Navigator.pushNamed(context, '/transaction_history');
                },
                backgroundColor: const Color(0xFF35F9D1),
                child: const Icon(Icons.receipt_long_sharp, color: Colors.black),
              ),
              FloatingActionButton(
                heroTag: 'uniqueTagForThisButton2',
                onPressed: _showMilkCollectionSheet,
                backgroundColor: const Color(0xFF35F9D1),
                child: const Icon(Icons.local_shipping, color: Colors.black),
              ),
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Widget _buildBodyContent(bool isMobileAppBar) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            _errorMessage!,
            style: TextStyle(
              color: Colors.red,
              fontSize: isMobileAppBar ? 14 : 16,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (milkRequests.isEmpty) {
      return const Center(
        child: Text(
          'No milk requests found for your account',
          style: TextStyle(fontSize: 16),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadMilkRequests,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isMobileBody = constraints.maxWidth <= 600;

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
              itemCount: milkRequests.length,
              itemBuilder: (context, index) {
                return RecordCard(
                  record: _convertMilkRequestToRecord(milkRequests[index]),
                  isMobile: isMobileBody,
                );
              },
            );
          } else {
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: milkRequests.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: RecordCard(
                    record: _convertMilkRequestToRecord(milkRequests[index]),
                    isMobile: isMobileBody,
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Map<String, String> _convertMilkRequestToRecord(MilkRequest request) {
    try {
      final totalPrice = request.totalPrice ??
          (request.liters != null && request.pricePerLiter != null
              ? (request.liters! * request.pricePerLiter!).round()
              : 0);

      return {
        'date': _formatDate(request.date),
        'time': _formatTime(request.date), // Time in 12-hour AM/PM format
        'milkPrice': '₹$totalPrice',
        'payment': request.paymentMethod?.toUpperCase() ?? 'CASH',
        'staffName': request.employee ?? 'Staff',
      };
    } catch (e) {
      print('Error converting milk request: $e');
      return {
        'date': 'Error',
        'time': 'Error',
        'milkPrice': 'N/A',
        'payment': 'Error',
        'staffName': 'Error',
      };
    }
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Date not available';
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  String _formatTime(DateTime? date) {
    if (date == null) return 'Time not available';
    int hour = date.hour;
    String period = hour >= 12 ? 'PM' : 'AM';
    hour = hour % 12;
    if (hour == 0) hour = 12; // Convert 0 to 12 for midnight/noon
    return '${hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')} $period';
  }

  void _showMilkCollectionSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: const TrackingUI(),
            ),
          ),
        );
      },
    );
  }
}

class RecordCard extends StatelessWidget {
  final Map<String, String> record;
  final bool isMobile;

  const RecordCard({
    super.key,
    required this.record,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    final labelFontSize = isMobile ? 12.0 : 14.0;
    final valueFontSize = isMobile ? 12.0 : 14.0;

    return Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildRow('Date:', record['date']!, labelFontSize, valueFontSize),
            const SizedBox(height: 8.0),
            _buildRow('Time:', record['time']!, labelFontSize, valueFontSize),
            const SizedBox(height: 8.0),
            _buildRow('Payment:', record['payment']!, labelFontSize, valueFontSize),
            const SizedBox(height: 8.0),
            _buildRow('Milk Total Price:', record['milkPrice']!, labelFontSize, valueFontSize),
            const SizedBox(height: 8.0),
            _buildRow('Staff Name:', record['staffName']!, labelFontSize, valueFontSize),
          ],
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, double labelFontSize, double valueFontSize) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(label,
              style: TextStyle(fontSize: labelFontSize, color: Colors.grey[600])),
        ),
        Flexible(
          child: Text(
            value,
            style: TextStyle(
              fontSize: valueFontSize,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}

// Updated Tracking UI Widget with Overflow Fix
class TrackingUI extends StatefulWidget {
  const TrackingUI({super.key});

  @override
  _TrackingUIState createState() => _TrackingUIState();
}

class _TrackingUIState extends State<TrackingUI> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;
  int currentStep = 2; // Example: Set to 2 for "Milk Collected" (0-based index)

  late List<Map<String, String>> trackingSteps;

  @override
  void initState() {
    super.initState();

    // Dynamically generate dates based on current day (April 1, 2025)
    final now = DateTime.now();
    trackingSteps = [
      {
        'status': 'Truck Dispatched',
        'date': _formatDate(now.subtract(const Duration(days: 3))),
      },
      {
        'status': 'Truck Arrived',
        'date': _formatDate(now.subtract(const Duration(days: 1))),
      },
      {
        'status': 'Milk Collected',
        'date': _formatDate(now),
      },
    ];

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: currentStep / (trackingSteps.length - 1),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'Track Your Milk Parcel',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF35F9D1),
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 120,
          child: LayoutBuilder(
            builder: (context, constraints) {
              final totalWidth = constraints.maxWidth - 80; // Account for padding
              final stepWidth = totalWidth / (trackingSteps.length - 1);

              return Stack(
                children: [
                  // Background Line
                  Positioned(
                    top: 20,
                    left: 40,
                    width: totalWidth,
                    child: Container(
                      height: 4,
                      color: Colors.grey[300],
                    ),
                  ),
                  // Animated Progress Line
                  Positioned(
                    top: 20,
                    left: 40,
                    child: Container(
                      height: 4,
                      width: stepWidth * currentStep * _progressAnimation.value,
                      color: const Color(0xFF35F9D1),
                    ),
                  ),
                  // Tracking Steps with Flexible to prevent overflow
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(trackingSteps.length, (index) {
                      bool isCompleted = index <= currentStep;
                      return Flexible(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: stepWidth),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: isCompleted
                                    ? const Color(0xFF35F9D1)
                                    : Colors.grey[300],
                                child: Icon(
                                  isCompleted ? Icons.check : Icons.circle,
                                  color: isCompleted ? Colors.black : Colors.grey[600],
                                  size: 20,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                trackingSteps[index]['status']!,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: isCompleted ? FontWeight.bold : FontWeight.normal,
                                  color: isCompleted ? Colors.black : Colors.grey[600],
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                trackingSteps[index]['date']!,
                                style: const TextStyle(
                                  fontSize: 10,
                                  color: Colors.grey,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF35F9D1),
            padding: const EdgeInsets.symmetric(vertical: 15),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'Close',
            style: TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}