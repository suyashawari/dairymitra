import 'package:flutter/material.dart';
import '../../models/PUser.dart';
import '../manager/FarmerMilkRecordPage.dart';

class UserInformationPage extends StatelessWidget {
  final PUser staff;

  const UserInformationPage({super.key, required this.staff});

  double _getTitleSize(double width) {
    if (width > 1200) return 28; // Desktop
    if (width > 600) return 24;   // Tablet
    return 20;                    // Mobile
  }

  double _getTextSize(double width) {
    if (width > 1200) return 18;
    if (width > 600) return 16;
    return 14;
  }

  double _getContainerWidth(double width) {
    if (width > 1200) return width * 0.9;
    if (width > 600) return 600;
    return width * 0.95;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Personal Details",
          style: TextStyle(fontSize: _getTitleSize(screenWidth)),
        ),
        backgroundColor: Color(0xFF35F9D1), // Optional: Customize AppBar color
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Container(
            width: _getContainerWidth(screenWidth),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow("Full Name", staff.name, screenWidth),
                const SizedBox(height: 15),
                _buildDetailRow("Email", staff.email, screenWidth),
                const SizedBox(height: 15),
                _buildDetailRow("Phone", staff.phoneNumber, screenWidth),
                const SizedBox(height: 15),
                _buildDetailRow("Address", staff.address, screenWidth),
                const SizedBox(height: 15),
                _buildDetailRow("Role", staff.role, screenWidth),

                if (staff.bankDetails != null) ...[
                  const SizedBox(height: 25),
                  Text(
                    "Bank Details",
                    style: TextStyle(
                      fontSize: _getTitleSize(screenWidth) * 0.9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  _buildDetailRow(
                    "Account Holder",
                    staff.bankDetails?.accountHolder ?? "N/A",
                    screenWidth,
                  ),
                  const SizedBox(height: 10),
                  _buildDetailRow(
                    "Account Number",
                    staff.bankDetails?.accountNumber ?? "N/A",
                    screenWidth,
                  ),
                  const SizedBox(height: 10),
                  _buildDetailRow(
                    "IFSC Code",
                    staff.bankDetails?.ifscCode ?? "N/A",
                    screenWidth,
                  ),

                ],
              ],
            ),
          ),
        ),
      ),
      floatingActionButton:staff.role == "ROLE_FARMER"?FloatingActionButton(
        backgroundColor: const Color(0xFF35F9D1),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FarmerMilkRecordPage(farmer: staff),
            ),
          );
        },
        child: const Icon(Icons.assignment, color: Colors.black),
      ):null ,
    );
  }

  Widget _buildDetailRow(String label, String? value, double screenWidth) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: Text(
            "$label:",
            style: TextStyle(
              fontSize: _getTextSize(screenWidth),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          flex: 3,
          child: Text(
            value ?? "N/A",
            style: TextStyle(
              fontSize: _getTextSize(screenWidth),
              color: Colors.grey[700],
            ),
          ),
        ),
      ],
    );
  }
}
