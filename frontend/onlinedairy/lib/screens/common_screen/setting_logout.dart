
import 'package:flutter/material.dart';
import 'package:onlinedairy/models/PUser.dart';
import '../../utils/auth_helper.dart';

class SettingsLogoutPage extends StatefulWidget {
  const SettingsLogoutPage({super.key});

  @override
  State<SettingsLogoutPage> createState() => _SettingsLogoutPageState();
}

class _SettingsLogoutPageState extends State<SettingsLogoutPage> {
  bool _showLogoutDialog = false;
  bool notificationEnabled = false;
  bool _isManager = false; // New variable to track if the user is a manager

  // Responsive font sizes
  double _getFontSize(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return 16; // Mobile
    if (width < 1024) return 18; // Tablet
    return 20; // Desktop
  }

  // Responsive width constraints
  double _getContainerWidth(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return width * 0.9; // Mobile
    if (width < 924) return width * 0.7; // Tablet
    return width * 0.5; // Desktop
  }

  @override
  void initState() {
    super.initState();
    _checkUserRole();
  }

  // Check user role using AuthHelper.getUser()
  Future<void> _checkUserRole() async {
    PUser? user = await AuthHelper.getUser();
    if (user != null && user.role == "ROLE_MANAGER") {
      setState(() {
        _isManager = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final fontSize = _getFontSize(context);
    final containerWidth = _getContainerWidth(context);
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(fontSize: fontSize + 2),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: const Color(0xFF35F9D1),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.all(isMobile ? 16 : 24),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
              child: isMobile
                  ? _buildSettingsList(context, fontSize)
                  : Center(
                child: Container(
                  width: containerWidth,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.withOpacity(0.3),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: _buildSettingsList(context, fontSize),
                ),
              ),
            ),
          ),
          if (_showLogoutDialog) _buildLogoutDialog(context, fontSize, containerWidth),
        ],
      ),
    );
  }

  Widget _buildSettingsList(BuildContext context, double fontSize) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),
        // If manager, show Employee Analysis button instead of notification toggle
        _isManager
            ? _buildListTile('Employee Analysis', Icons.analytics, fontSize, () {
          // Add your navigation or action for Employee Analysis here
          Navigator.pushNamed(context, '/analysispage');
        })
            : _buildResponsiveSwitchTile(context, fontSize),
        _buildListTile('Feedback', Icons.wallet_outlined, fontSize, () {
          _showFeedbackFormSheet(context);
        }),
        _buildListTile('Security', Icons.security_sharp, fontSize, () {}),
        const Divider(),
        _buildLogoutTile(context, fontSize),
      ],
    );
  }

  Widget _buildResponsiveSwitchTile(BuildContext context, double fontSize) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          child: SwitchListTile(
            title: Text(
              'Notification',
              style: TextStyle(fontSize: fontSize),
              overflow: TextOverflow.ellipsis,
            ),
            value: notificationEnabled,
            onChanged: (value) => setState(() => notificationEnabled = value),
            controlAffinity: ListTileControlAffinity.trailing,
            secondary: Icon(Icons.notifications, size: fontSize + 4),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10),
          ),
        );
      },
    );
  }

  Widget _buildListTile(String title, IconData icon, double fontSize, VoidCallback onTap) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontSize: fontSize),
        overflow: TextOverflow.ellipsis,
      ),
      leading: Icon(icon, size: fontSize + 4),
      onTap: onTap,
    );
  }

  Widget _buildLogoutTile(BuildContext context, double fontSize) {
    return ListTile(
      title: Text(
        'Logout',
        style: TextStyle(color: Colors.red, fontSize: fontSize),
      ),
      leading: Icon(Icons.logout, color: Colors.red, size: fontSize + 4),
      onTap: () => setState(() => _showLogoutDialog = true),
    );
  }

  Widget _buildLogoutDialog(BuildContext context, double fontSize, double width) {
    return GestureDetector(
      onTap: () => setState(() => _showLogoutDialog = false),
      child: Container(
        color: Colors.black54,
        child: Center(
          child: GestureDetector(
            onTap: () {},
            child: Container(
              width: width,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Logout Confirmation',
                    style: TextStyle(
                      fontSize: fontSize + 2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Are you sure you want to log out?',
                    style: TextStyle(fontSize: fontSize),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  _buildDialogButtons(context, fontSize),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDialogButtons(BuildContext context, double fontSize) {
    final isMobile = MediaQuery.of(context).size.width < 600;
    return isMobile
        ? Column(
      children: [
        _buildLogoutButton(context, fontSize),
        const SizedBox(height: 12),
        _buildCancelButton(context, fontSize),
      ],
    )
        : Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildLogoutButton(context, fontSize),
        _buildCancelButton(context, fontSize),
      ],
    );
  }

  Widget _buildLogoutButton(BuildContext context, double fontSize) {
    return ElevatedButton(
      onPressed: () async {
        PUser? user = await AuthHelper.getUser();
        if (user != null) AuthHelper.addPastUser(user);
        await AuthHelper.clearUser(); // Clear user data
        Navigator.pushNamedAndRemoveUntil(context, '/main', (route) => false);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        padding: EdgeInsets.symmetric(
          horizontal: fontSize * 1.5,
          vertical: fontSize,
        ),
      ),
      child: Text(
        'Yes Logout',
        style: TextStyle(color: Colors.white, fontSize: fontSize),
      ),
    );
  }

  Widget _buildCancelButton(BuildContext context, double fontSize) {
    return TextButton(
      onPressed: () => setState(() => _showLogoutDialog = false),
      child: Text(
        'Cancel',
        style: TextStyle(fontSize: fontSize),
      ),
    );
  }

  void _showFeedbackFormSheet(BuildContext context) {
    int _selectedRating = 0;

    // Device-specific sizing
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Fixed sizes based on device type
    final bool isMobile = screenWidth < 600;
    final bool isTablet = screenWidth >= 600 && screenWidth < 900;

    final double titleFontSize = isMobile ? 18.0 : (isTablet ? 20.0 : 24.0);
    final double inputFontSize = isMobile ? 16.0 : (isTablet ? 18.0 : 22.0);
    final double buttonFontSize = isMobile ? 16.0 : (isTablet ? 18.0 : 22.0);
    final double starSize = isMobile ? 30.0 : (isTablet ? 36.0 : 42.0);

    // Responsive container width and height limit
    final double containerWidth = isMobile
        ? screenWidth * 0.9
        : (isTablet ? screenWidth * 0.7 : 600.0);
    final double containerHeight = screenHeight * 0.2; // Limited height

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return FractionallySizedBox(
              heightFactor: 0.5, // Adjust for smaller height
              child: Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 16.0,
                  left: 16.0,
                  right: 16.0,
                  top: 16.0,
                ),
                child: Center(
                  child: SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height * 0.5,
                      ),
                      child: Container(
                        width: containerWidth,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Title
                            Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Text(
                                'Feedback Form',
                                style: TextStyle(
                                  fontSize: titleFontSize,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            // Feedback Field
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: TextFormField(
                                style: TextStyle(fontSize: inputFontSize),
                                maxLines: 2,
                                maxLength: 300,
                                decoration: InputDecoration(
                                  labelText: 'Your Feedback',
                                  labelStyle: TextStyle(fontSize: inputFontSize),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 16.0,
                                    vertical: 8.0,
                                  ),
                                ),
                              ),
                            ),
                            // Star Rating
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 6.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(5, (index) {
                                  return IconButton(
                                    icon: Icon(
                                      index < _selectedRating
                                          ? Icons.star
                                          : Icons.star_border,
                                      color: index < _selectedRating
                                          ? Colors.yellow[700]
                                          : Colors.grey,
                                      size: starSize - 4,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _selectedRating = index + 1;
                                      });
                                    },
                                    padding: const EdgeInsets.symmetric(horizontal: 2.0),
                                  );
                                }),
                              ),
                            ),
                            // Submit Button
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 4.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF35F9D1),
                                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12.0),
                                  ),
                                  minimumSize: const Size.fromHeight(40),
                                ),
                                child: Text(
                                  'Submit',
                                  style: TextStyle(fontSize: buttonFontSize, color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
