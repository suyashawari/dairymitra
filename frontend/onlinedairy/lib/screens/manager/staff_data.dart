//
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:onlinedairy/models/PUser.dart';
// import 'package:onlinedairy/services/EmployeeService.dart';
//
// import '../common_screen/UserInformationpage.dart';
//
// enum DeviceType {
//   mobile,
//   tablet,
//   desktop,
// }
//
// DeviceType getDeviceType(BuildContext context) {
//   double width = MediaQuery.of(context).size.width;
//   if (width < 600) return DeviceType.mobile;
//   if (width < 1200) return DeviceType.tablet;
//   return DeviceType.desktop;
// }
//
// class StaffDataPage extends StatefulWidget {
//   const StaffDataPage({super.key});
//
//   @override
//   State<StaffDataPage> createState() => _StaffDataPageState();
// }
//
// class _StaffDataPageState extends State<StaffDataPage> {
//   final EmployeeService _employeeService = EmployeeService();
//   List<PUser> _farmers = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchFarmers();
//   }
//
//   Future<void> _fetchFarmers() async {
//     try {
//       List<PUser> fetchedFarmers = await _employeeService.getAllEmployees();
//       setState(() {
//         _farmers = fetchedFarmers;
//       });
//     } catch (e) {
//       print('Error fetching farmers: $e');
//     }
//   }
//
//   // Return AppBar height based on device type.
//   double getAppBarHeight(DeviceType deviceType) {
//     switch (deviceType) {
//       case DeviceType.mobile:
//         return 56.0;
//       case DeviceType.tablet:
//         return 72.0;
//       case DeviceType.desktop:
//         return 80.0;
//     }
//   }
//
//   // Return title font size based on device type.
//   double getTitleFontSize(DeviceType deviceType) {
//     switch (deviceType) {
//       case DeviceType.mobile:
//         return 20;
//       case DeviceType.tablet:
//         return 26;
//       case DeviceType.desktop:
//         return 32;
//     }
//   }
//
//   // Return general font size for list items.
//   double getItemFontSize(DeviceType deviceType) {
//     switch (deviceType) {
//       case DeviceType.mobile:
//         return 16;
//       case DeviceType.tablet:
//         return 20;
//       case DeviceType.desktop:
//         return 24;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     DeviceType deviceType = getDeviceType(context);
//     double appBarHeight = getAppBarHeight(deviceType);
//     double titleFontSize = getTitleFontSize(deviceType);
//     double itemFontSize = getItemFontSize(deviceType);
//
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(appBarHeight),
//         child: AppBar(
//           backgroundColor: const Color(0xFF35F9D1),
//           title: Text(
//             'Staff Data',
//             style: TextStyle(fontSize: titleFontSize),
//           ),
//           centerTitle: true,
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back, size: titleFontSize * 0.8),
//             onPressed: () => Navigator.pop(context),
//           ),
//         ),
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           // On mobile, content spans the entire width.
//           // On tablet and desktop, use a max width for content and center it.
//           double maxContentWidth;
//           if (deviceType == DeviceType.mobile) {
//             maxContentWidth = constraints.maxWidth;
//           } else if (deviceType == DeviceType.tablet) {
//             maxContentWidth = 600;
//           } else {
//             maxContentWidth = 800;
//           }
//           return SingleChildScrollView(
//             child: Center(
//               child: Container(
//                 width: maxContentWidth,
//                 padding: const EdgeInsets.all(16.0),
//                 child: RefreshIndicator(
//                   onRefresh: _fetchFarmers,
//                   child: _farmers.isNotEmpty
//                       ? ListView.separated(
//                     shrinkWrap: true,
//                     physics: const AlwaysScrollableScrollPhysics(),
//                     itemCount: _farmers.length,
//                     separatorBuilder: (context, index) =>
//                     const SizedBox(height: 8),
//                     itemBuilder: (context, index) => _buildFarmerItem(
//                       "EMP.${(index+1)}",
//                       _farmers[index].name ?? 'No Name',
//                       itemFontSize,
//                       _farmers[index],
//                     ),
//                   )
//                       : ListView(
//                     shrinkWrap: true,
//                     physics: const AlwaysScrollableScrollPhysics(),
//                     children: const [
//                       Center(child: Text('No farmers found')),
//                     ],
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
//   Widget _buildFarmerItem(String id, String name, double fontSize, PUser user) {
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => UserInformationPage(staff: user),
//           ),
//         );
//       },
//       splashColor: Colors.grey.withOpacity(0.3),
//       borderRadius: BorderRadius.circular(4),
//       child: Container(
//         alignment: Alignment.center,
//         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//         decoration: BoxDecoration(
//           color: const Color.fromARGB(255, 178, 233, 211),
//           borderRadius: BorderRadius.circular(4),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Text(
//               id,
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
//             ),
//             const SizedBox(width: 10), // Adjust spacing
//             Expanded(  // Ensures name does not exceed available space
//               child: Text(
//                 name,
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 1,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
// }
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:onlinedairy/models/PUser.dart';
// import 'package:onlinedairy/services/EmployeeService.dart';
//
// import '../common_screen/UserInformationpage.dart';
//
// enum DeviceType {
//   mobile,
//   tablet,
//   desktop,
// }
//
// DeviceType getDeviceType(BuildContext context) {
//   double width = MediaQuery.of(context).size.width;
//   if (width < 600) return DeviceType.mobile;
//   if (width < 1200) return DeviceType.tablet;
//   return DeviceType.desktop;
// }
//
// class FarmerDataPage extends StatefulWidget {
//   const FarmerDataPage({super.key});
//
//   @override
//   State<FarmerDataPage> createState() => _FarmerDataPageState();
// }
//
// class _FarmerDataPageState extends State<FarmerDataPage> {
//   final EmployeeService _employeeService = EmployeeService();
//   List<PUser> _farmers = [];
//   bool _isLoading = true;
//   String? _errorMessage;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchFarmers();
//   }
//
//   Future<void> _fetchFarmers() async {
//     setState(() {
//       _isLoading = true;
//       _errorMessage = null;
//     });
//     try {
//       List<PUser> fetchedFarmers = await _employeeService.getAllFarmers();
//       setState(() {
//         _farmers = fetchedFarmers;
//         _isLoading = false;
//       });
//     } catch (e) {
//       setState(() {
//         _isLoading = false;
//         _errorMessage = e.toString();
//       });
//       print('Error fetching farmers: $e');
//     }
//   }
//
//   // Return AppBar height based on device type.
//   double getAppBarHeight(DeviceType deviceType) {
//     switch (deviceType) {
//       case DeviceType.mobile:
//         return 56.0;
//       case DeviceType.tablet:
//         return 72.0;
//       case DeviceType.desktop:
//         return 80.0;
//     }
//   }
//
//   // Return title font size based on device type.
//   double getTitleFontSize(DeviceType deviceType) {
//     switch (deviceType) {
//       case DeviceType.mobile:
//         return 20;
//       case DeviceType.tablet:
//         return 26;
//       case DeviceType.desktop:
//         return 32;
//     }
//   }
//
//   // Return general font size for list items.
//   double getItemFontSize(DeviceType deviceType) {
//     switch (deviceType) {
//       case DeviceType.mobile:
//         return 16;
//       case DeviceType.tablet:
//         return 20;
//       case DeviceType.desktop:
//         return 24;
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     DeviceType deviceType = getDeviceType(context);
//     double appBarHeight = getAppBarHeight(deviceType);
//     double titleFontSize = getTitleFontSize(deviceType);
//     double itemFontSize = getItemFontSize(deviceType);
//
//     return Scaffold(
//       appBar: PreferredSize(
//         preferredSize: Size.fromHeight(appBarHeight),
//         child: AppBar(
//           backgroundColor: const Color(0xFF35F9D1),
//           title: Text(
//             'Farmer Data',
//             style: TextStyle(fontSize: titleFontSize),
//           ),
//           centerTitle: true,
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back, size: titleFontSize * 0.8),
//             onPressed: () => Navigator.pop(context),
//           ),
//         ),
//       ),
//       body: LayoutBuilder(
//         builder: (context, constraints) {
//           // On mobile, content spans the entire width.
//           // On tablet and desktop, use a max width for content and center it.
//           double maxContentWidth;
//           if (deviceType == DeviceType.mobile) {
//             maxContentWidth = constraints.maxWidth;
//           } else if (deviceType == DeviceType.tablet) {
//             maxContentWidth = 600;
//           } else {
//             maxContentWidth = 800;
//           }
//           return SingleChildScrollView(
//             child: Center(
//               child: Container(
//                 width: maxContentWidth,
//                 padding: const EdgeInsets.all(16.0),
//                 child: RefreshIndicator(
//                   onRefresh: _fetchFarmers,
//                   child: _isLoading
//                       ? SizedBox(
//                     height: MediaQuery.of(context).size.height * 0.5,
//                     child: const Center(
//                       child: CircularProgressIndicator(),
//                     ),
//                   )
//                       : _errorMessage != null
//                       ? ListView(
//                     shrinkWrap: true,
//                     physics: const AlwaysScrollableScrollPhysics(),
//                     children: [
//                       Center(
//                         child: Text(
//                           _errorMessage!,
//                           style: const TextStyle(color: Colors.red),
//                         ),
//                       ),
//                     ],
//                   )
//                       : _farmers.isNotEmpty
//                       ? ListView.separated(
//                     shrinkWrap: true,
//                     physics: const AlwaysScrollableScrollPhysics(),
//                     itemCount: _farmers.length,
//                     separatorBuilder: (context, index) =>
//                     const SizedBox(height: 8),
//                     itemBuilder: (context, index) => _buildFarmerItem(
//                       "FAR.${(index + 1)}",
//                       _farmers[index].name ?? 'No Name',
//                       itemFontSize,
//                       _farmers[index],
//                     ),
//                   )
//                       : ListView(
//                     shrinkWrap: true,
//                     physics: const AlwaysScrollableScrollPhysics(),
//                     children: const [
//                       Center(child: Text('No farmers found')),
//                     ],
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
//   Widget _buildFarmerItem(String id, String name, double fontSize, PUser user) {
//     return InkWell(
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => UserInformationPage(staff: user),
//           ),
//         );
//       },
//       splashColor: Colors.grey.withOpacity(0.3),
//       borderRadius: BorderRadius.circular(4),
//       child: Container(
//         alignment: Alignment.center,
//         padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//         decoration: BoxDecoration(
//           color: const Color.fromARGB(255, 178, 233, 211),
//           borderRadius: BorderRadius.circular(4),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Text(
//               id,
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
//             ),
//             const SizedBox(width: 10),
//             Expanded(
//               child: Text(
//                 name,
//                 style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
//                 overflow: TextOverflow.ellipsis,
//                 maxLines: 1,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:onlinedairy/models/PUser.dart';
import 'package:onlinedairy/services/EmployeeService.dart';
import '../common_screen/UserInformationpage.dart';

// Enum to define device types
enum DeviceType {
  mobile,
  tablet,
  desktop,
}

// Function to determine device type based on screen width
DeviceType getDeviceType(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  if (width < 600) return DeviceType.mobile;
  if (width < 1200) return DeviceType.tablet;
  return DeviceType.desktop;
}

class StaffDataPage extends StatefulWidget {
  const StaffDataPage({super.key});

  @override
  State<StaffDataPage> createState() => _FarmerDataPageState();
}

class _FarmerDataPageState extends State<StaffDataPage> {
  // Service instance to fetch farmer data
  final EmployeeService _employeeService = EmployeeService();
  List<PUser> _farmers = []; // List to store farmers
  bool _isLoading = true;    // Loading state
  String? _errorMessage;     // Error message if fetching fails

  @override
  void initState() {
    super.initState();
    _fetchFarmers(); // Fetch farmers when widget initializes
  }

  // Method to fetch farmers from the service
  Future<void> _fetchFarmers() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });
    try {
      List<PUser> fetchedFarmers = await _employeeService.getAllEmployees();
      setState(() {
        _farmers = fetchedFarmers;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString();
      });
      print('Error fetching Staff: $e');
    }
  }

  // Return AppBar height based on device type
  double getAppBarHeight(DeviceType deviceType) {
    switch (deviceType) {
      case DeviceType.mobile:
        return 56.0;
      case DeviceType.tablet:
        return 72.0;
      case DeviceType.desktop:
        return 80.0;
    }
  }

  // Return title font size based on device type
  double getTitleFontSize(DeviceType deviceType) {
    switch (deviceType) {
      case DeviceType.mobile:
        return 20;
      case DeviceType.tablet:
        return 26;
      case DeviceType.desktop:
        return 32;
    }
  }

  // Return font size for list items based on device type
  double getItemFontSize(DeviceType deviceType) {
    switch (deviceType) {
      case DeviceType.mobile:
        return 16;
      case DeviceType.tablet:
        return 20;
      case DeviceType.desktop:
        return 24;
    }
  }

  @override
  Widget build(BuildContext context) {
    // Determine device type and sizes based on it
    DeviceType deviceType = getDeviceType(context);
    double appBarHeight = getAppBarHeight(deviceType);
    double titleFontSize = getTitleFontSize(deviceType);
    double itemFontSize = getItemFontSize(deviceType);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(appBarHeight),
        child: AppBar(
          backgroundColor: const Color(0xFF35F9D1),
          title: Text(
            'Staff Data',
            style: TextStyle(fontSize: titleFontSize),
          ),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, size: titleFontSize * 0.8),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Set maximum content width based on device type
          double maxContentWidth;
          if (deviceType == DeviceType.mobile) {
            maxContentWidth = constraints.maxWidth;
          } else if (deviceType == DeviceType.tablet) {
            maxContentWidth = 600;
          } else {
            maxContentWidth = 800;
          }
          return Center(
            child: Container(
              width: maxContentWidth,
              padding: const EdgeInsets.all(16.0),
              child: RefreshIndicator(
                onRefresh: _fetchFarmers, // Refresh the list on pull
                child: ListView(
                  children: [
                    if (_isLoading)
                      Container(
                        height: constraints.maxHeight - 32, // Adjust for padding
                        child: const Center(child: CircularProgressIndicator()),
                      )
                    else if (_errorMessage != null)
                      Container(
                        height: constraints.maxHeight - 32,
                        child: Center(
                          child: Text(
                            _errorMessage!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      )
                    else if (_farmers.isEmpty)
                        Container(
                          height: constraints.maxHeight - 32,
                          child: const Center(child: Text('No Staff found')),
                        )
                      else
                        ..._farmers.asMap().entries.map((entry) {
                          int index = entry.key;
                          PUser farmer = entry.value;
                          return _buildFarmerItem(
                            "EMP.${(index + 1)}",
                            farmer.name ?? 'No Name',
                            itemFontSize,
                            farmer,
                          );
                        }).toList(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Method to build each farmer item in the list
  Widget _buildFarmerItem(String id, String name, double fontSize, PUser user) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => UserInformationPage(staff: user),
          ),
        );
      },
      splashColor: Colors.grey.withOpacity(0.3),
      borderRadius: BorderRadius.circular(4),
      child: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 178, 233, 211),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              id,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}