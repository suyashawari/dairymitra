

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onlinedairy/models/PUser.dart';
import 'package:onlinedairy/services/login_service.dart';
import 'package:onlinedairy/utils/auth_helper.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();

  static double _getResponsiveFontSize(
      BuildContext context, double mobile, double tablet, double desktop) {
    final width = MediaQuery.of(context).size.width;
    if (width < 600) return mobile;
    if (width < 900) return tablet;
    return desktop;
  }
}

class _LoginPageState extends State<LoginPage> {

  static const platform = MethodChannel('secureScreen');
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    _enableSecureScreen();
  }
  Future<void> _enableSecureScreen() async {
    try {
      await platform.invokeMethod('enableSecureScreen');
    } on PlatformException catch (e) {
      debugPrint("Failed to enable secure screen: ${e.message}");
    }
  }

  Future<void> _disableSecureScreen() async {
    try {
      await platform.invokeMethod('disableSecureScreen');
    } on PlatformException catch (e) {
      debugPrint("Failed to disable secure screen: ${e.message}");
    }
  }

  @override
  void dispose() {

    _disableSecureScreen();
  // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const LoginScreen(),
    );
  }

  ThemeData _buildTheme(BuildContext context) {
    return ThemeData(
      primaryColor: const Color(0xFF35F9D1),
      scaffoldBackgroundColor: const Color(0xFFEFF9FF),
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: LoginPage._getResponsiveFontSize(context, 28.0, 50.0, 60.0),
          fontWeight: FontWeight.bold,
          color: const Color(0xFF35F9D1),
        ),
        displayMedium: TextStyle(
          fontSize: LoginPage._getResponsiveFontSize(context, 21.0, 40.0, 48.0),
          fontWeight: FontWeight.bold,
          color: const Color(0xFF35F9D1),
        ),
        titleMedium: TextStyle(
          fontSize: LoginPage._getResponsiveFontSize(context, 14.0, 24.0, 28.0),
          color: const Color(0xFF616161),
        ),
        labelLarge: TextStyle(
            fontSize: LoginPage._getResponsiveFontSize(context, 14.0, 22.0, 26.0),
            color: Colors.white,
            fontWeight: FontWeight.bold),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;
  final LoginService _loginService = LoginService();

  @override
  void initState() {
    super.initState();
    _checkPastUsers(); // Check for past users when the page starts
  }

  Future<void> _checkPastUsers() async {
    await Future.delayed(const Duration(seconds: 1)); // 1-second delay
    final pastUsers = await AuthHelper.getPastUsers();
    if (pastUsers.isNotEmpty && mounted) {
      _showPastUsersSheet(pastUsers); // Show modal if list is not empty
    }
  }

  void _showPastUsersSheet(List<PUser> pastUsers) {
    bool isMobile = MediaQuery.of(context).size.width < 600;
    double fontSize = isMobile ? 14 : 20;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.0)),
      ),
      backgroundColor: Colors.white,
      elevation: 8, // Subtle shadow for depth
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Text(
                'Pick Your Account!',
                style: TextStyle(
                  fontSize: isMobile?16:20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],

                ),
              ),
              const SizedBox(height: 16),
              // User List
              Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: pastUsers.length,
                  itemBuilder: (context, index) {
                    final user = pastUsers[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Card(
                        elevation: 3,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: ListTile(
                          // Avatar with gradient
                          leading: CircleAvatar(
                            radius: 24,
                            backgroundColor: Colors.transparent,
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.blueAccent, Colors.lightBlue],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.person,
                                color: Colors.white,
                                size: isMobile?16:20,
                              ),
                            ),
                          ),
                          // Email and subtitle
                          title: Text(
                            user.email ?? 'Unknown Email',
                            style: TextStyle(

                              fontSize: isMobile?16:20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          subtitle: Text(
                            'Tap to sign in!',
                            style: TextStyle(
                              fontSize: isMobile?16:20,

                              color: Colors.grey,
                            ),
                          ),
                          // Tap action with ripple effect
                          onTap: () {
                            setState(() {
                              _emailController.text = user.email ?? '';
                              _passwordController.text = user.password ?? '';
                            });
                            Navigator.pop(context); // Smooth close
                            _login(); // Trigger login
                          },
                          tileColor: Colors.grey[50], // Light background
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16.0,
                            vertical: 8.0,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _login() async {
    setState(() => _isLoading = true);
    final email = _emailController.text.trim();
    final password = _passwordController.text.trim();

    try {
      print("Attempting login with email: $email");
      final user = await _loginService.login(email, password);

      if (user != null) {
        print("Login successful for ${user.email} with role ${user.role}");
        await AuthHelper.addPastUser(user); // Save to past users
        _navigateToDashboard(user.role ?? 'default');
      } else {
        print("Login failed - invalid credentials");
        _showError("Invalid email or password");
      }
    } catch (e) {
      print("Login error: $e");
      _showError("An error occurred during login");
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  void _navigateToDashboard(String role) {
    switch (role.toUpperCase()) {
      case 'ROLE_FARMER':
        Navigator.pushReplacementNamed(context, '/farmer_dashboard');
        break;
      case 'ROLE_EMPLOYEE':
        Navigator.pushReplacementNamed(context, '/staff_dashboard');
        break;
      case 'ROLE_MANAGER':
        Navigator.pushReplacementNamed(context, '/manager_dashboard');
        break;
      default:
        Navigator.pushReplacementNamed(context, '/home');
        break;
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 20.0 : 80.0),
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Digital Dairy',
                      style: Theme.of(context).textTheme.displayLarge),
                  const SizedBox(height: 20),
                  Text('Login',
                      style: Theme.of(context).textTheme.displayMedium),
                  const SizedBox(height: 40),
                  _buildTextField(
                    controller: _emailController,
                    label: 'Email',
                    icon: Icons.email,
                    obscureText: false,
                  ),
                  const SizedBox(height: 20),
                  _buildTextField(
                    controller: _passwordController,
                    label: 'Password',
                    icon: Icons.lock,
                    obscureText: true, // Overridden by _obscurePassword
                  ),
                  const SizedBox(height: 40),
                  _buildLoginButton(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    required bool obscureText,
  }) {
    bool isPasswordField = label.toLowerCase() == 'password';
    return TextField(
      controller: controller,
      obscureText: isPasswordField ? _obscurePassword : obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Theme.of(context).primaryColor),
        suffixIcon: isPasswordField
            ? IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
            color: Theme.of(context).primaryColor,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _login,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
        ),
        child: _isLoading
            ? const CircularProgressIndicator(color: Colors.white)
            : Text('Login', style: Theme.of(context).textTheme.labelLarge),
      ),
    );
  }
}