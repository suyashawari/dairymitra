import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/PUser.dart';
import '../../utils/auth_helper.dart';

enum DeviceType { mobile, tablet, desktop }

DeviceType getDeviceType(BuildContext context) {
  double width = MediaQuery.of(context).size.width;
  if (width < 600) return DeviceType.mobile;
  if (width < 1200) return DeviceType.tablet;
  return DeviceType.desktop;
}

class ManagerDashboard extends StatefulWidget {
  const ManagerDashboard({super.key});

  @override
  State<ManagerDashboard> createState() => _ManagerDashboardState();
}

class _ManagerDashboardState extends State<ManagerDashboard> {

  PUser? user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final savedUser = await AuthHelper.getUser();
    setState(() {
      user = savedUser;
    });
  }
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

  double getTitleFontSize(DeviceType deviceType) {
    switch (deviceType) {
      case DeviceType.mobile:
        return 20.0;
      case DeviceType.tablet:
        return 26.0;
      case DeviceType.desktop:
        return 32.0;
    }
  }

  double getButtonFontSize(DeviceType deviceType) {
    switch (deviceType) {
      case DeviceType.mobile:
        return 18.0;
      case DeviceType.tablet:
        return 20.0;
      case DeviceType.desktop:
        return 24.0;
    }
  }

  double getContentMaxWidth(DeviceType deviceType, double availableWidth) {
    if (deviceType == DeviceType.mobile) {
      return availableWidth;
    } else if (deviceType == DeviceType.tablet) {
      return 600;
    } else {
      return 800;
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
    DeviceType deviceType = getDeviceType(context);
    double appBarHeight = getAppBarHeight(deviceType);
    double titleFontSize = getTitleFontSize(deviceType);
    double buttonFontSize = getButtonFontSize(deviceType);
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
        // Responsive AppBar using PreferredSize
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(appBarHeight),
          child: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor:Color(0xFF35F9D1),
            toolbarHeight: 80,
            title: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, color:Color(0xFF35F9D1)),
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
                        user!=null?'${user?.name!}':'Manager',
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
                child: IconButton(icon: const Icon(Icons.menu), onPressed: () {

                  Navigator.pushNamed(context, '/settings');
                }),
              ),
            ],
          ),
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            double maxContentWidth = getContentMaxWidth(deviceType, constraints.maxWidth);
            return SingleChildScrollView(
              child: Center(
                child: SizedBox(

                  child: Padding(

                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // First Button: Farmer Data
                        SizedBox(
                          width: deviceType == DeviceType.mobile ? double.infinity : maxContentWidth,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // Navigate to Farmer Data

                              Navigator.pushNamed(context, '/farmer_data');
                            },
                            icon: const Icon(Icons.people,color: Colors.black),
                            label: Text(
                              'Farmer Data',
                              style: TextStyle(fontSize: buttonFontSize,color: Colors.black),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Second Button: Staff Data
                        SizedBox(
                          width: deviceType == DeviceType.mobile ? double.infinity : maxContentWidth,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              // Navigate to Staff Data

                              Navigator.pushNamed(context, '/staff_data');
                            },
                            icon: const Icon(Icons.group,color: Colors.black),
                            label: Text(
                              'Staff Data',
                              style: TextStyle(fontSize: buttonFontSize,color: Colors.black),
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: FloatingActionButton(
            onPressed: () {
            Navigator.pushNamed(context, '/add_staff');
            },
            backgroundColor:Color(0xFF35F9D1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(Icons.add,color: Colors.white,)
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
