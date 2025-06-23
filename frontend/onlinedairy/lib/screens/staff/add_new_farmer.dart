import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:onlinedairy/services/EmployeeService.dart';

import '../../models/PUser.dart';

class AddNewFarmerScreen extends StatefulWidget {
  const AddNewFarmerScreen({super.key});

  @override
  State<AddNewFarmerScreen> createState() => _AddNewFarmerScreenState();
}

class _AddNewFarmerScreenState extends State<AddNewFarmerScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _bankNameController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();
  final TextEditingController _ifscController = TextEditingController();
  final EmployeeService _employeeService = EmployeeService();
  // Define the new color
  final Color primaryColor = const Color(0xFF35F9D1);

  // For toggling password visibility
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _fullNameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _addressController.dispose();
    _bankNameController.dispose();
    _accountNumberController.dispose();
    _ifscController.dispose();
    super.dispose();
  }

  DeviceType getDeviceType() {
    final mediaQueryData = MediaQuery.of(context);
    final width = mediaQueryData.size.width;

    if (width < 600) {
      return DeviceType.mobile;
    } else if (width < 1200) {
      return DeviceType.tablet;
    } else {
      return DeviceType.desktop;
    }
  }

  double getTitleFontSize() {
    switch (getDeviceType()) {
      case DeviceType.mobile:
        return 14;
      case DeviceType.tablet:
        return 22;
      case DeviceType.desktop:
        return 26;
    }
  }

  double getLabelFontSize() {
    switch (getDeviceType()) {
      case DeviceType.mobile:
        return 16;
      case DeviceType.tablet:
        return 18;
      case DeviceType.desktop:
        return 20;
    }
  }

  double getButtonFontSize() {
    switch (getDeviceType()) {
      case DeviceType.mobile:
        return 18;
      case DeviceType.tablet:
        return 20;
      case DeviceType.desktop:
        return 22;
    }
  }

  EdgeInsets getScreenPadding() {
    switch (getDeviceType()) {
      case DeviceType.mobile:
        return const EdgeInsets.all(16.0);
      case DeviceType.tablet:
        return const EdgeInsets.symmetric(horizontal: 80.0, vertical: 20.0);
      case DeviceType.desktop:
        return const EdgeInsets.symmetric(horizontal: 200.0, vertical: 30.0);
    }
  }

  double? getMaxFormWidth() {
    switch (getDeviceType()) {
      case DeviceType.mobile:
        return null;
      case DeviceType.tablet:
        return 600;
      case DeviceType.desktop:
        return 800;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Farmer Information'),
        centerTitle: true,
        backgroundColor: primaryColor,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            padding: getScreenPadding(),
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: getMaxFormWidth() ?? double.infinity,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Personal Details Section
                      Text(
                        'Personal Details',
                        style: TextStyle(
                          fontSize: getTitleFontSize(),
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(height: 15),
                      _buildTextField('Enter Full Name', _fullNameController),
                      const SizedBox(height: 10),
                      // _buildTextField(
                      //   'Mobile Number',
                      //   _mobileController,
                      //   keyboardType: TextInputType.phone,
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Please enter a valid mobile number';
                      //     }
                      //     // Remove an optional +91 prefix if present
                      //     String trimmed = value.trim();
                      //     if (trimmed.startsWith('+91')) {
                      //       trimmed = trimmed.substring(3).trim();
                      //     }
                      //     if (!RegExp(r'^[0-9]{10}$').hasMatch(trimmed)) {
                      //       return 'Please enter a valid 10-digit mobile number';
                      //     }
                      //     return null;
                      //   },
                      //   initialValue: '', // Remove any preset text
                      // ),
                      _buildTextField(
                        'Mobile Number',
                        _mobileController,
                        keyboardType: TextInputType.phone,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter mobile number';
                          }
                          // Remove all non-digit characters
                          final cleanedNumber = value.replaceAll(
                            RegExp(r'[^0-9]'),
                            '',
                          );
                          if (cleanedNumber.length != 10) {
                            return 'Enter valid 10-digit mobile number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      _buildTextField(
                        'Email',
                        _emailController,
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !RegExp(
                                r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}$',
                              ).hasMatch(value.trim())) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      _buildTextField(
                        'Password',
                        _passwordController,
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password';
                          }
                          // Password must have at least 8 characters, one uppercase, one lowercase, one digit and one special character (including #)
                          if (!RegExp(
                            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&#])[A-Za-z\d@$!%*?&#]{8,}$',
                          ).hasMatch(value)) {
                            return 'Password must be at least 8 characters long and include uppercase, lowercase, digit and special character';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      _buildTextField(
                        'Confirm Password',
                        _confirmPasswordController,
                        isPassword: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      _buildTextField(
                        'Address',
                        _addressController,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 20),

                      // Bank Details Section
                      Text(
                        'Bank Details',
                        style: TextStyle(
                          fontSize: getTitleFontSize(),
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                      ),
                      const SizedBox(height: 15),
                      _buildTextField(
                        'Enter the Bank Name',
                        _bankNameController,
                      ),
                      const SizedBox(height: 10),
                      _buildTextField(
                        'Enter the Account Number',
                        _accountNumberController,
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !RegExp(r'^\d{11,16}$').hasMatch(value.trim())) {
                            return 'Enter a valid account number (11-16 digits)';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      _buildTextField(
                        'Enter the IFSC Number',
                        _ifscController,
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !RegExp(
                                r'^[A-Za-z]{4}0[A-Za-z0-9]{6}$',
                              ).hasMatch(value.trim())) {
                            return 'Enter a valid IFSC code';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 30),

                      // Submit Button
                      ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          padding: EdgeInsets.symmetric(
                            vertical:
                                getDeviceType() == DeviceType.mobile ? 15 : 18,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                        child: Text(
                          'Add Farmer',
                          style: TextStyle(
                            fontSize: getButtonFontSize(),
                            color: Colors.white,
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
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType keyboardType = TextInputType.text,
    bool isPassword = false,
    int maxLines = 1,
    String? initialValue,
    String? Function(String?)? validator,
  }) {
    if (initialValue != null) {
      controller.text = initialValue;
    }

    return Focus(
      onFocusChange: (hasFocus) {
        setState(() {}); // Trigger rebuild on focus change
      },
      child: Builder(
        builder: (context) {
          return TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              labelStyle: TextStyle(
                fontSize: getLabelFontSize(),
                color: Colors.grey,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 15,
                vertical: getDeviceType() == DeviceType.mobile ? 12 : 16,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.grey, width: 0.3),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black, width: 1.0),
              ),
              border: const OutlineInputBorder(),
              suffixIcon:
                  isPassword
                      ? IconButton(
                        icon: Icon(
                          label == 'Password'
                              ? (_obscurePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility)
                              : (_obscureConfirmPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                        ),
                        onPressed: () {
                          setState(() {
                            if (label == 'Password') {
                              _obscurePassword = !_obscurePassword;
                            } else {
                              _obscureConfirmPassword =
                                  !_obscureConfirmPassword;
                            }
                          });
                        },
                      )
                      : null,
            ),
            style: TextStyle(fontSize: getLabelFontSize()),
            keyboardType: keyboardType,
            obscureText:
                isPassword
                    ? (label == 'Password'
                        ? _obscurePassword
                        : _obscureConfirmPassword)
                    : false,
            maxLines: maxLines,
            validator:
                validator ??
                (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter $label';
                  }
                  return null;
                },
          );
        },
      ),
    );
  }

  // void _submitForm() {
  //   if (_formKey.currentState!.validate()) {
  //     Map<String, dynamic> formData = {
  //       'fullName': _fullNameController.text.trim(),
  //       'mobile': _mobileController.text.trim(),
  //       'email': _emailController.text.trim(),
  //       // Do not include the password openly in JSON; it is masked for display purposes.
  //       'password': _passwordController.text.trim(),
  //       'address': _addressController.text.trim(),
  //       'bankDetails': {
  //         'bankName': _bankNameController.text.trim(),
  //         'accountNumber': _accountNumberController.text.trim(),
  //         'ifsc': _ifscController.text.trim(),
  //       },
  //     };
  //
  //     String jsonData = const JsonEncoder.withIndent('  ').convert(formData);
  //
  //     showDialog(
  //       context: context,
  //       builder: (context) {
  //         return AlertDialog(
  //           title: const Text('Staff Data in JSON'),
  //           content: SingleChildScrollView(
  //             child: Text(jsonData),
  //           ),
  //           actions: [
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: const Text('Close'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

  Future<void> _submitForm() async {
    // Validate all form fields
    if (!_formKey.currentState!.validate()) {
      return; // Don't proceed if validation fails
    }

    try {
      // 1. Create BankDetails object
      final bankDetails = BankDetails(
        accountHolder: _fullNameController.text.trim(),
        accountNumber: _accountNumberController.text.trim(),
        ifscCode: _ifscController.text.trim(),
      );
      // 2. Create PUser object (with proper validation)
      final newFarmer = PUser(

        name: _fullNameController.text.trim(),
        email: _emailController.text.trim(),
        phoneNumber: _mobileController.text.trim(),
        address: _addressController.text.trim(),
        password: _passwordController.text.trim(),
        role: 'farmer',
        bankDetails: bankDetails,
      );

      // 3. Show loading indicator
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 10),
              Text('Adding farmer...'),
            ],
          ),
          duration: Duration(minutes: 1), // Long duration to allow operation
        ),
      );
      print(newFarmer.toJson().toString());
      // 4. Call addFarmer
      final bool isSuccess = await _employeeService.addFarmer(newFarmer);

      // 5. Hide loading indicator
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      // 6. Handle result
      if (isSuccess) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('✅ Farmer added successfully!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.of(context).pop(true); // Close form with success status
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('❌ Failed to add farmer'),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('⚠️ Error: ${e.toString()}'),
          backgroundColor: Colors.orange,
          duration: Duration(seconds: 3),
        ),
      );
    }
  }

  Future<bool> _addFarmer() async {
    Map<String, dynamic> formData = {
      'name': _fullNameController.text.trim(), // Matches PUser.name
      'phoneNumber': _mobileController.text.trim(), // Matches PUser.phoneNumber
      'email': _emailController.text.trim(), // Matches PUser.email
      'passward':
          _passwordController.text.trim(), // Matches PUser.passward (typo)
      'address': _addressController.text.trim(), // Matches PUser.address
      'bankDetails': {
        'accountHolder':
            _fullNameController.text.trim(), // Bank account holder name
        'accountNumber': _accountNumberController.text.trim(),
        'ifscCode': _ifscController.text.trim(), // Matches BankDetails.ifscCode
      },
    };
    // 1. Extract bank details
    final bankDetails = BankDetails(
      accountHolder:
          _fullNameController.text
              .trim(), // Assuming account holder is the farmer's name
      accountNumber: _accountNumberController.text.trim(),
      ifscCode: _ifscController.text.trim(),
    );

    // 2. Create a PUser object
    final newFarmer = PUser(
      name: formData['fullName'],
      email: formData['email'],
      phoneNumber: formData['mobile'],
      address: formData['address'],
      password:
          formData['password'], // Note: Typo in PUser class ('passward' instead of 'password')
      role: 'farmer', // Assuming role is required
      bankDetails: bankDetails,
    );
    print(newFarmer);
    // 3. Call addFarmer
    final success = await _employeeService.addFarmer(newFarmer);
    return success;
  }
}

enum DeviceType { mobile, tablet, desktop }
