//
// import 'dart:convert';
// import 'dart:ffi';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:intl/intl.dart';
// import 'package:onlinedairy/models/PUser.dart';
// import 'package:onlinedairy/services/EmployeeService.dart';
//
// import '../../models/milk_request.dart';
// import '../../utils/auth_helper.dart';
//
// class MilkCollectionPage extends StatefulWidget {
//   const MilkCollectionPage({super.key});
//
//   @override
//   _MilkCollectionPageState createState() => _MilkCollectionPageState();
// }
//
// class _MilkCollectionPageState extends State<MilkCollectionPage> {
//   DateTime? _selectedDate;
//   String? _selectedPaymentMode = 'Cash on Milk Collection';
//   bool _isConfirmed = false;
//   double _totalPrice = 0.00;
//
//   // Changed to double
//
//   final TextEditingController _literController = TextEditingController();
//   final TextEditingController _rateController = TextEditingController();
//   final TextEditingController _fatController = TextEditingController();
//   final TextEditingController _snfController = TextEditingController();
//   final TextEditingController _cnrController = TextEditingController();
//   EmployeeService _employeeService = EmployeeService();
//   PUser? farmer;
//
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     final args = ModalRoute.of(context)?.settings.arguments;
//     if (args is PUser) {
//       farmer = args;
//     }
//   }
//
//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? pickedDate = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime.now(),
//     );
//
//     if (pickedDate != null) {
//       setState(() {
//         _selectedDate = pickedDate;
//         _calculateTotalPrice();
//       });
//     }
//   }
//
//
//   void _calculateTotalPrice() {
//     final liter = double.tryParse(_literController.text) ?? 0;
//     final rate = double.tryParse(_rateController.text) ?? 0;
//     final fat = double.tryParse(_fatController.text) ?? 0;
//     final snf = double.tryParse(_snfController.text) ?? 0;
//     final cnr = double.tryParse(_cnrController.text) ?? 1.0; // Default to 1.0 if empty or invalid
//
//     setState(() {
//       final calculatedPrice = (liter * rate) * (fat / 50) * (snf / 20) * cnr;
//       _totalPrice = double.parse(calculatedPrice.toStringAsFixed(2));
//     });
//   }
//
//   void _submitForm() async {
//     if (_selectedDate == null ||
//         _literController.text.isEmpty ||
//         _rateController.text.isEmpty ||
//         _fatController.text.isEmpty ||
//         _snfController.text.isEmpty ||
//         _cnrController.text.isEmpty ||
//         !_isConfirmed) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Please fill all fields correctly')),
//       );
//       return;
//     }
//
//     final currentUser = await AuthHelper.getUser();
//       final employeeEmail = currentUser?.email;
//
//       final milkRequest = MilkRequest(
//         date: _selectedDate,
//         liters: double.tryParse(_literController.text),
//         fatPercentage: double.tryParse(_fatController.text),
//         proteinPercentage: double.tryParse(_snfController.text),
//         waterContent: double.tryParse(_cnrController.text),
//         pricePerLiter: double.tryParse(_rateController.text),
//         totalPrice: _totalPrice,
//         paymentMethod: _selectedPaymentMode,
//         user: farmer,
//         employee: employeeEmail, // New field added here
//       );
//     print(milkRequest.toJson());
//     bool success = await _employeeService.addMilkRequest(milkRequest);
//
//     if (success) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Milk request added successfully')),
//       );
//       Navigator.pop(context);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Failed to add milk request')),
//       );
//     }
//   }
//   // Future<void> _submitForm() async {
//   //   if (_selectedDate == null ||
//   //       _literController.text.isEmpty ||
//   //       _rateController.text.isEmpty ||
//   //       _fatController.text.isEmpty ||
//   //       _snfController.text.isEmpty ||
//   //       _cnrController.text.isEmpty ||
//   //       !_isConfirmed) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       const SnackBar(content: Text('Please fill all fields correctly')),
//   //     );
//   //     return;
//   //   }
//   //
//   //   // Build the MilkRequest object from the form fields.
//   //   final currentUser = await AuthHelper.getUser();
//   //   final employeeEmail = currentUser?.email;
//   //
//   //   final milkRequest = MilkRequest(
//   //     id: 1,
//   //     date: _selectedDate,
//   //     liters: double.tryParse(_literController.text),
//   //     fatPercentage: double.tryParse(_fatController.text),
//   //     proteinPercentage: double.tryParse(_snfController.text),
//   //     waterContent: double.tryParse(_cnrController.text),
//   //     pricePerLiter: double.tryParse(_rateController.text),
//   //     totalPrice: _totalPrice,
//   //     paymentMethod: _selectedPaymentMode,
//   //     user: farmer,
//   //     employee: employeeEmail, // New field added here
//   //   );
//   //
//   //   // Convert the MilkRequest object to JSON format.
//   //   final jsonData = jsonEncode(milkRequest.toJson());
//   //
//   //   // Show a dialog displaying the JSON data.
//   //   await showDialog(
//   //     context: context,
//   //     builder: (BuildContext context) {
//   //       return AlertDialog(
//   //         title: const Text("Confirm Milk Request Data"),
//   //         content: SingleChildScrollView(
//   //           child: Text(
//   //             jsonData,
//   //             style: const TextStyle(fontFamily: 'Courier'),
//   //           ),
//   //         ),
//   //         actions: [
//   //           TextButton(
//   //             onPressed: () {
//   //               print(jsonData);
//   //               Navigator.of(context).pop(); // Cancel: close the dialog.
//   //             },
//   //             child: const Text("Cancel"),
//   //           ),
//   //           ElevatedButton(
//   //             onPressed: () {
//   //               Navigator.of(context).pop(); // Close the dialog.
//   //               _processSubmission(milkRequest);
//   //             },
//   //             child: const Text("OK"),
//   //           ),
//   //         ],
//   //       );
//   //     },
//   //   );
//   // }
//
// // This helper method handles the actual submission of the milk request.
//   Future<void> _processSubmission(MilkRequest milkRequest) async {
//     bool success = await _employeeService.addMilkRequest(milkRequest);
//
//     if (success) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Milk request added successfully')),
//       );
//       Navigator.pop(context);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Failed to add milk request')),
//       );
//     }
//   }
//
//
//   Widget _buildNumberField(String label, TextEditingController controller) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: TextInputType.number,
//       inputFormatters: [
//         FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
//       ],
//       style: const TextStyle(fontWeight: FontWeight.bold),
//       decoration: InputDecoration(
//         labelText: label,
//         labelStyle: const TextStyle(color: Colors.grey),
//         border: const OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.grey, width: 0.1),
//         ),
//         focusedBorder: const OutlineInputBorder(
//           borderSide: BorderSide(color: Colors.grey, width: 1),
//         ),
//       ),
//       onChanged: (_) => _calculateTotalPrice(),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final isMobile = screenWidth < 600;
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF35F9D1),
//         title: Text(
//           'Add Milk Collection for' + (farmer != null ? ' - ${farmer!.name}' : ''),
//           style: Theme.of(context).textTheme.titleLarge?.copyWith(
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//             fontSize: isMobile ? 16 : 24,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(isMobile ? 16 : 24),
//         child:
//             isMobile
//                 ? Column(
//                   children: [
//                     // Display farmer details at the top.
//                     if (farmer != null)
//                       Container(
//                         padding: const EdgeInsets.all(8),
//                         decoration: BoxDecoration(
//                           color: Colors.grey.shade200,
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         child: Row(
//                           children: [
//                             const Icon(Icons.person, color: Colors.black),
//                             const SizedBox(width: 8),
//                             Text(
//                               farmer!.name ?? 'No Name',
//                               style: const TextStyle(
//                                 fontSize: 16,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     const SizedBox(height: 20),
//                     // Date Picker
//                     InkWell(
//                       onTap: () => _selectDate(context),
//                       child: InputDecorator(
//                         decoration: InputDecoration(
//                           labelText: 'Collection Date',
//                           suffixIcon: const Icon(Icons.calendar_today),
//                           border: const OutlineInputBorder(),
//                           labelStyle: const TextStyle(color: Color(0xFF35F9D1)),
//                         ),
//                         child: Text(
//                           _selectedDate != null
//                               ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
//                               : 'Select Date',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color:
//                                 _selectedDate != null
//                                     ? Colors.black
//                                     : const Color(0xFF35F9D1),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     // Liter & Rate Row
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.only(right: 8),
//                             child: _buildNumberField('Liter', _literController),
//                           ),
//                         ),
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 8),
//                             child: _buildNumberField(
//                               'Rate/Liter',
//                               _rateController,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//                     // Quality Parameters
//                     Row(
//                       children: [
//                         Expanded(
//                           child: _buildNumberField('FAT', _fatController),
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: _buildNumberField('SNF', _snfController),
//                         ),
//                         const SizedBox(width: 16),
//                         Expanded(
//                           child: _buildNumberField('CNR', _cnrController),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//                     // Total Price
//                     Container(
//                       padding: const EdgeInsets.symmetric(
//                         vertical: 12,
//                         horizontal: 24,
//                       ),
//                       decoration: BoxDecoration(
//                         color: const Color(0xFF35F9D1),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Text(
//                         'Total Price: $_totalPrice /-',
//                         style: TextStyle(
//                           fontSize: isMobile ? 16 : 24,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     // Payment Mode
//                     InputDecorator(
//                       decoration: InputDecoration(
//                         labelText: 'Payment Mode',
//                         border: const OutlineInputBorder(),
//                         labelStyle: const TextStyle(color: Color(0xFF35F9D1)),
//                       ),
//                       child: DropdownButtonHideUnderline(
//                         child: DropdownButton<String>(
//                           value: _selectedPaymentMode,
//                           isExpanded: true,
//                           onChanged: (String? newValue) {
//                             if (newValue != null) {
//                               setState(() => _selectedPaymentMode = newValue);
//                             }
//                           },
//                           items: const [
//                             DropdownMenuItem(
//                               value: 'Cash on Milk Collection',
//                               child: Text(
//                                 'Cash on Milk Collection',
//                                 style: TextStyle(fontSize: 14),
//                               ),
//                             ),
//                             DropdownMenuItem(
//                               value: 'Online on Milk Collection',
//                               child: Text(
//                                 'Online on Milk Collection',
//                                 style: TextStyle(fontSize: 14),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     // Confirmation Checkbox
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text(
//                           'Confirm Collection',
//                           style: TextStyle(fontSize: 16),
//                         ),
//                         Checkbox(
//                           value: _isConfirmed,
//                           onChanged: (bool? newValue) {
//                             if (newValue != null) {
//                               setState(() => _isConfirmed = newValue);
//                             }
//                           },
//                           activeColor: const Color(0xFF35F9D1),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(4),
//                             side: BorderSide(
//                               color:
//                                   _isConfirmed
//                                       ? const Color(0xFF35F9D1)
//                                       : Colors.grey,
//                               width: 1.5,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 24),
//                     // Submit Button
//                     SizedBox(
//                       width: isMobile ? double.infinity : screenWidth * 0.6,
//                       child: ElevatedButton(
//                         onPressed: _submitForm,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFF35F9D1),
//                           padding: const EdgeInsets.symmetric(vertical: 16),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Text(
//                               'Add Collection',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 color: Colors.black,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                             Icon(Icons.water_drop_outlined),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 )
//                 : // Tablet/Desktop layout: similar structure..
//             Center(
//               child: SizedBox(
//                 width: screenWidth*0.7,
//                 child: Column(
//                   children: [
//                     if (farmer != null)
//                               Container(
//                                 padding: const EdgeInsets.all(8),
//                                 decoration: BoxDecoration(
//                                   color: Colors.grey.shade200,
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 child: Row(
//                                   children: [
//                                     const Icon(Icons.person, color: Colors.black),
//                                     const SizedBox(width: 8),
//                                     Text(
//                                       farmer!.name ?? 'No Name',
//                                       style: const TextStyle(
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold,
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                             const SizedBox(height: 20),
//                     // Date Picker
//                     InkWell(
//                       onTap: () => _selectDate(context),
//                       child: InputDecorator(
//                         decoration: InputDecoration(
//                           labelText: 'Collection Date',
//                           suffixIcon: const Icon(Icons.calendar_today),
//                           border: const OutlineInputBorder(),
//                           labelStyle: const TextStyle(color: Color(0xFF35F9D1)),
//                         ),
//                         child: Text(
//                           _selectedDate != null
//                               ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
//                               : 'Select Date',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: _selectedDate != null
//                                 ? Colors.black
//                                 : const Color(0xFF35F9D1),
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//
//                     // Liter & Rate Row
//                     Row(
//                       children: [
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.only(right: 8),
//                             child: _buildNumberField('Liter', _literController),
//                           ),
//                         ),
//                         Expanded(
//                           child: Padding(
//                             padding: const EdgeInsets.only(left: 8),
//                             child: _buildNumberField('Rate/Liter', _rateController),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 16),
//
//                     // Quality Parameters
//
//                     Row(
//                       children: [
//                         Expanded(child: _buildNumberField('FAT', _fatController)),
//                         const SizedBox(width: 16),
//                         Expanded(child: _buildNumberField('SNF', _snfController)),
//                         const SizedBox(width: 16),
//                         Expanded(child: _buildNumberField('CNR', _cnrController)),
//                       ],
//                     ),
//                     const SizedBox(height: 20),
//
//                     // Total Price
//                     Container(
//                       padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
//                       decoration: BoxDecoration(
//                         color: const Color(0xFF35F9D1),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Text(
//                         'Total Price: $_totalPrice /-',
//                         style: TextStyle(
//                           fontSize: isMobile ? 16 : 24,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//
//                     // Payment Mode
//                     InputDecorator(
//                       decoration: InputDecoration(
//                         labelText: 'Payment Mode',
//                         border: const OutlineInputBorder(),
//                         labelStyle: const TextStyle(color: Color(0xFF35F9D1)),
//                       ),
//                       child: DropdownButtonHideUnderline(
//                         child: DropdownButton<String>(
//                           value: _selectedPaymentMode,
//                           isExpanded: true,
//                           onChanged: (String? newValue) {
//                             if (newValue != null) {
//                               setState(() => _selectedPaymentMode = newValue);
//                             }
//                           },
//                           items: const [
//                             DropdownMenuItem(
//                               value: 'Cash on Milk Collection',
//                               child: Text('Cash on Milk Collection',style: TextStyle(fontSize: 18),),
//                             ),
//                             DropdownMenuItem(
//                               value: 'Online on Milk Collection',
//                               child: Text('Online on Milk Collection',style: TextStyle(fontSize: 18),),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//
//                     // Confirmation Checkbox
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         const Text('Confirm Collection',
//                             style: TextStyle(fontSize: 16)),
//                         Checkbox(
//                           value: _isConfirmed,
//                           onChanged: (bool? newValue) {
//                             if (newValue != null) {
//                               setState(() => _isConfirmed = newValue);
//                             }
//                           },
//                           activeColor: const Color(0xFF35F9D1),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(4),
//                             side: BorderSide(
//                               color: _isConfirmed
//                                   ? const Color(0xFF35F9D1)
//                                   : Colors.grey,
//                               width: 1.5,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(height: 24),
//
//                     // Submit Button
//                     SizedBox(
//                       width: isMobile ? double.infinity : screenWidth * 0.6,
//                       child: ElevatedButton(
//                         onPressed: _submitForm,
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFF35F9D1),
//                           padding: const EdgeInsets.symmetric(vertical: 16),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                         ),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             const Text(
//                               'Add Collection',
//                               style: TextStyle(
//                                   fontSize: 18,
//                                   color: Colors.black,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                             Icon(Icons.water_drop_outlined)
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             )
//       ),
//     );
//   }
// }


import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:onlinedairy/models/PUser.dart';
import 'package:onlinedairy/services/EmployeeService.dart';
import '../../models/milk_request.dart';
import '../../utils/auth_helper.dart';

class MilkCollectionPage extends StatefulWidget {
  const MilkCollectionPage({super.key});

  @override
  _MilkCollectionPageState createState() => _MilkCollectionPageState();
}

class _MilkCollectionPageState extends State<MilkCollectionPage> {
  DateTime? _selectedDate;
  String? _selectedPaymentMode = 'Cash';
  bool _isConfirmed = false;
  double _totalPrice = 0.00;
  bool _isTimeSelected = false; // Added to track time selection

  final TextEditingController _literController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _fatController = TextEditingController();
  final TextEditingController _snfController = TextEditingController();
  final TextEditingController _cnrController = TextEditingController();
  EmployeeService _employeeService = EmployeeService();
  PUser? farmer;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is PUser) {
      farmer = args;
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _isTimeSelected = false; // Reset time selection when date changes
        _calculateTotalPrice();
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select date first')),
      );
      return;
    }

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (pickedTime != null) {
      setState(() {
        _selectedDate = DateTime(
          _selectedDate!.year,
          _selectedDate!.month,
          _selectedDate!.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        _isTimeSelected = true; // Mark time as selected
      });
    }
  }

  void _calculateTotalPrice() {
    final liter = double.tryParse(_literController.text) ?? 0;
    final rate = double.tryParse(_rateController.text) ?? 0;
    final fat = double.tryParse(_fatController.text) ?? 0;
    final snf = double.tryParse(_snfController.text) ?? 0;
    final cnr = double.tryParse(_cnrController.text) ?? 1.0;

    setState(() {
      final calculatedPrice = (liter * rate) * (fat / 50) * (snf / 20) * cnr;
      _totalPrice = double.parse(calculatedPrice.toStringAsFixed(2));
    });
  }

  void _submitForm() async {
    if (_selectedDate == null ||
        !_isTimeSelected || // Added to ensure time is selected
        _literController.text.isEmpty ||
        _rateController.text.isEmpty ||
        _fatController.text.isEmpty ||
        _snfController.text.isEmpty ||
        _cnrController.text.isEmpty ||
        !_isConfirmed) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields correctly')),
      );
      return;
    }

    final currentUser = await AuthHelper.getUser();
    final employeeEmail = currentUser?.email;

    final milkRequest = MilkRequest(
      date: _selectedDate,
      liters: double.tryParse(_literController.text),
      fatPercentage: double.tryParse(_fatController.text),
      proteinPercentage: double.tryParse(_snfController.text),
      waterContent: double.tryParse(_cnrController.text),
      pricePerLiter: double.tryParse(_rateController.text),
      totalPrice: _totalPrice,
      paymentMethod: _selectedPaymentMode,
      user: farmer,
      employee: employeeEmail,
    );
    print(milkRequest.toJson());
    bool success = await _employeeService.addMilkRequest(milkRequest);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Milk request added successfully')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add milk request')),
      );
    }
  }

  Widget _buildNumberField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.number,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
      ],
      style: const TextStyle(fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.grey),
        border: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 0.1),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      onChanged: (_) => _calculateTotalPrice(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    // Define Date Picker
    final datePicker = InkWell(
      onTap: () => _selectDate(context),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Collection Date',
          suffixIcon: const Icon(Icons.calendar_today),
          border: const OutlineInputBorder(),
          labelStyle: const TextStyle(color: Color(0xFF35F9D1)),
        ),
        child: Text(
          _selectedDate != null
              ? DateFormat('dd/MM/yyyy').format(_selectedDate!)
              : 'Select Date',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _selectedDate != null ? Colors.black : const Color(0xFF35F9D1),
          ),
        ),
      ),
    );

    // Define Time Picker
    final timePicker = InkWell(
      onTap: () => _selectTime(context),
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: 'Collection Time',
          suffixIcon: const Icon(Icons.access_time),
          border: const OutlineInputBorder(),
          labelStyle: const TextStyle(color: Color(0xFF35F9D1)),
        ),
        child: Text(
          _selectedDate != null && _isTimeSelected
              ? TimeOfDay.fromDateTime(_selectedDate!).format(context)
              : 'Select Time',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: _selectedDate != null && _isTimeSelected
                ? Colors.black
                : const Color(0xFF35F9D1),
          ),
        ),
      ),
    );

    // Combine Date and Time Pickers Responsively
    final dateTimePicker = isMobile
        ? Column(
      children: [
        datePicker,
        const SizedBox(height: 16),
        timePicker,
      ],
    )
        : Row(
      children: [
        Expanded(child: datePicker),
        const SizedBox(width: 16),
        Expanded(child: timePicker),
      ],
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF35F9D1),
        title: Text(
          'Add Milk Collection for' + (farmer != null ? ' - ${farmer!.name}' : ''),
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: isMobile ? 16 : 24,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(isMobile ? 16 : 24),
        child: isMobile
            ? Column(
          children: [
            if (farmer != null)
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.person, color: Colors.black),
                    const SizedBox(width: 8),
                    Text(
                      farmer!.name ?? 'No Name',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 20),
            dateTimePicker, // Replaced original date picker
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: _buildNumberField('Liter', _literController),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: _buildNumberField('Rate/Liter', _rateController),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(child: _buildNumberField('FAT', _fatController)),
                const SizedBox(width: 16),
                Expanded(child: _buildNumberField('SNF', _snfController)),
                const SizedBox(width: 16),
                Expanded(child: _buildNumberField('CNR', _cnrController)),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              decoration: BoxDecoration(
                color: const Color(0xFF35F9D1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Total Price: $_totalPrice /-',
                style: TextStyle(
                  fontSize: isMobile ? 16 : 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            InputDecorator(
              decoration: InputDecoration(
                labelText: 'Payment Mode',
                border: const OutlineInputBorder(),
                labelStyle: const TextStyle(color: Color(0xFF35F9D1)),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedPaymentMode,
                  isExpanded: true,
                  onChanged: (String? newValue) {
                    if (newValue != null) {
                      setState(() => _selectedPaymentMode = newValue);
                    }
                  },
                  items: const [
                    DropdownMenuItem(
                      value: 'Cash',
                      child: Text('Cash', style: TextStyle(fontSize: 14)),
                    ),
                    DropdownMenuItem(
                      value: 'Online',
                      child: Text('Online', style: TextStyle(fontSize: 14)),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Confirm Collection', style: TextStyle(fontSize: 16)),
                Checkbox(
                  value: _isConfirmed,
                  onChanged: (bool? newValue) {
                    if (newValue != null) {
                      setState(() => _isConfirmed = newValue);
                    }
                  },
                  activeColor: const Color(0xFF35F9D1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                    side: BorderSide(
                      color: _isConfirmed ? const Color(0xFF35F9D1) : Colors.grey,
                      width: 1.5,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: isMobile ? double.infinity : screenWidth * 0.6,
              child: ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF35F9D1),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Add Collection',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Icon(Icons.water_drop_outlined),
                  ],
                ),
              ),
            ),
          ],
        )
            : Center(
          child: SizedBox(
            width: screenWidth * 0.7,
            child: Column(
              children: [
                if (farmer != null)
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.person, color: Colors.black),
                        const SizedBox(width: 8),
                        Text(
                          farmer!.name ?? 'No Name',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                const SizedBox(height: 20),
                dateTimePicker, // Replaced original date picker
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: _buildNumberField('Liter', _literController),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: _buildNumberField('Rate/Liter', _rateController),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(child: _buildNumberField('FAT', _fatController)),
                    const SizedBox(width: 16),
                    Expanded(child: _buildNumberField('SNF', _snfController)),
                    const SizedBox(width: 16),
                    Expanded(child: _buildNumberField('CNR', _cnrController)),
                  ],
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  decoration: BoxDecoration(
                    color: const Color(0xFF35F9D1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Total Price: $_totalPrice /-',
                    style: TextStyle(
                      fontSize: isMobile ? 16 : 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                InputDecorator(
                  decoration: InputDecoration(
                    labelText: 'Payment Mode',
                    border: const OutlineInputBorder(),
                    labelStyle: const TextStyle(color: Color(0xFF35F9D1)),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedPaymentMode,
                      isExpanded: true,
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() => _selectedPaymentMode = newValue);
                        }
                      },
                      items: const [
                        DropdownMenuItem(
                          value: 'Cash',
                          child: Text('Cash', style: TextStyle(fontSize: 18)),
                        ),
                        DropdownMenuItem(
                          value: 'Online',
                          child: Text('Online', style: TextStyle(fontSize: 18)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Confirm Collection', style: TextStyle(fontSize: 16)),
                    Checkbox(
                      value: _isConfirmed,
                      onChanged: (bool? newValue) {
                        if (newValue != null) {
                          setState(() => _isConfirmed = newValue);
                        }
                      },
                      activeColor: const Color(0xFF35F9D1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                        side: BorderSide(
                          color: _isConfirmed ? const Color(0xFF35F9D1) : Colors.grey,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: isMobile ? double.infinity : screenWidth * 0.6,
                  child: ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF35F9D1),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Add Collection',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Icon(Icons.water_drop_outlined),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}