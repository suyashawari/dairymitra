// // import 'package:flutter/material.dart';
// //
// // class TransactionHistoryPage extends StatelessWidget {
// //   final List<Map<String, String>> records = List.generate(8, (index) {
// //     return {
// //       'date': '23/03/2025',
// //       'milkPrice': '1000 /-',
// //       'payment': 'Clear By cash mode',
// //       'staffName': 'Mr. Suyash Awari',
// //     };
// //   });
// //
// //   TransactionHistoryPage({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final screenWidth = MediaQuery.of(context).size.width;
// //     final isMobileAppBar = screenWidth <= 600;
// //
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor:Color(0xFF35F9D1),
// //         toolbarHeight: 80,
// //         title: Text("Transaction History",
// //           style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.start,),
// //
// //       ),
// //       body: LayoutBuilder(
// //         builder: (context, constraints) {
// //           final isMobileBody = constraints.maxWidth <= 600;
// //
// //           if (!isMobileBody) {
// //             int crossAxisCount = (constraints.maxWidth / 300).floor();
// //             return GridView.builder(
// //               padding: const EdgeInsets.all(16.0),
// //               gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// //                 crossAxisCount: crossAxisCount,
// //                 crossAxisSpacing: 16.0,
// //                 mainAxisSpacing: 16.0,
// //                 childAspectRatio: 1.5,
// //               ),
// //               itemCount: records.length,
// //               itemBuilder: (context, index) {
// //                 return RecordCard(
// //                   record: records[index],
// //                   isMobile: isMobileBody,
// //                 );
// //               },
// //             );
// //           } else {
// //             return ListView.builder(
// //               padding: const EdgeInsets.all(16.0),
// //               itemCount: records.length,
// //               itemBuilder: (context, index) {
// //                 return Padding(
// //                   padding: const EdgeInsets.only(bottom: 16.0),
// //                   child: RecordCard(
// //                     record: records[index],
// //                     isMobile: isMobileBody,
// //                   ),
// //                 );
// //               },
// //             );
// //           }
// //         },
// //       ),
// //       floatingActionButton: Padding(
// //         padding: const EdgeInsets.all(20.0),
// //         child: Row(
// //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //           children: [
// //             FloatingActionButton(
// //               heroTag: 'uniqueTagForThisButton3',
// //               onPressed: () {},
// //               backgroundColor: Color(0xFF35F9D1),
// //               child: const Icon(Icons.receipt_long_sharp, color: Colors.black),
// //             ),
// //             FloatingActionButton(
// //               heroTag: 'uniqueTagForThisButton4',
// //               onPressed: () {},
// //               backgroundColor:Color(0xFF35F9D1),
// //               child: const Icon(Icons.local_shipping, color: Colors.black),
// //             ),
// //           ],
// //         ),
// //       ),
// //       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
// //     );
// //   }
// // }
// //
// // class RecordCard extends StatelessWidget {
// //   final Map<String, String> record;
// //   final bool isMobile;
// //
// //   const RecordCard({
// //     super.key,
// //     required this.record,
// //     required this.isMobile,
// //   });
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final labelFontSize = isMobile ? 12.0 : 14.0;
// //     final valueFontSize = isMobile ? 12.0 : 14.0;
// //
// //     return Card(
// //       elevation: 4.0,
// //       child: Padding(
// //         padding: const EdgeInsets.all(16.0),
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.start,
// //           children: [
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Flexible(
// //                   child: Text('Date:',
// //                       style: TextStyle(fontSize: labelFontSize)),
// //                 ),
// //                 Flexible(
// //                   child: Text(record['date']!,
// //                       style: TextStyle(
// //                         fontSize: valueFontSize,
// //                         fontWeight: FontWeight.bold,
// //                       )),
// //                 ),
// //               ],
// //             ),
// //             const SizedBox(height: 8.0),
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Flexible(
// //                   child: Text('Payment:',
// //                       style: TextStyle(fontSize: labelFontSize)),
// //                 ),
// //                 Flexible(
// //                   child: Text(record['payment']!,
// //                       style: TextStyle(
// //                           fontWeight: FontWeight.bold,
// //                           fontSize: valueFontSize)),
// //                 ),
// //               ],
// //             ),
// //             const SizedBox(height: 8.0),
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Flexible(
// //                   child: Text('Milk Total Price:',
// //                       style: TextStyle(fontSize: labelFontSize)),
// //                 ),
// //                 Flexible(
// //                   child: Text(record['milkPrice']!,
// //                       style: TextStyle(
// //                           fontSize: valueFontSize,
// //                           fontWeight: FontWeight.bold)),
// //                 ),
// //               ],
// //             ),
// //             const SizedBox(height: 8.0),
// //             Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //               children: [
// //                 Flexible(
// //                   child: Text('Staff Name:',
// //                       style: TextStyle(fontSize: labelFontSize)),
// //                 ),
// //                 Flexible(
// //                   child: Text(
// //                     record['staffName']!,
// //                     style: TextStyle(
// //                         fontSize: valueFontSize,
// //                         fontWeight: FontWeight.bold),
// //                     overflow: TextOverflow.ellipsis,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// import 'package:flutter/material.dart';
//
// class TransactionHistoryPage extends StatelessWidget {
//   final List<Map<String, String>> records = List.generate(8, (index) {
//     return {
//       'date': '23/03/2025',
//       'milkPrice': '1000 /-',
//       'payment': 'Clear By cash mode',
//       'staffName': 'Mr. Suyash Awari',
//     };
//   });
//
//   TransactionHistoryPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final isMobile = MediaQuery.of(context).size.width <= 600;
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF35F9D1),
//         toolbarHeight: 80,
//         title: Text(
//           "Transaction History",
//           style: TextStyle(
//             fontSize: isMobile ? 18 : 22,
//             color: Colors.black,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: isMobile ? _buildMobileList() : _buildDesktopGrid(),
//       ),
//     );
//   }
//
//   Widget _buildMobileList() {
//     return ListView.separated(
//       itemCount: records.length,
//       separatorBuilder: (context, index) => const SizedBox(height: 12),
//       itemBuilder: (context, index) {
//         return RecordCard(
//           record: records[index],
//           isMobile: true,
//         );
//       },
//     );
//   }
//
//   Widget _buildDesktopGrid() {
//     return GridView.builder(
//       gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
//         maxCrossAxisExtent: 400,
//         crossAxisSpacing: 16,
//         mainAxisSpacing: 16,
//         childAspectRatio: 1.8,
//       ),
//       itemCount: records.length,
//       itemBuilder: (context, index) {
//         return RecordCard(
//           record: records[index],
//           isMobile: false,
//         );
//       },
//     );
//   }
//
//
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
//     final theme = Theme.of(context);
//     final labelStyle = TextStyle(
//       fontSize: isMobile ? 12 : 14,
//       color: Colors.black,
//     );
//     final valueStyle = TextStyle(
//       fontSize: isMobile ? 12 : 14,
//       fontWeight: FontWeight.bold,
//       color: Colors.black,
//     );
//     final labelStyle2 = TextStyle(
//       fontSize: isMobile ? 12 : 14,
//       color: Colors.grey,
//     );
//     final valueStyle2 = TextStyle(
//       fontSize: isMobile ? 12 : 14,
//       fontWeight: FontWeight.normal,
//       color: Colors.grey,
//     );
//
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(isMobile ? 12 : 16),
//         child: Row(
//           children: [
//
//             const SizedBox(width: 16),
//
//             // Right side - Details
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _buildDetailRow('Date', record['date']!, labelStyle, valueStyle),
//                   const SizedBox(height: 8),
//                   _buildDetailRow('Payment', record['payment']!, labelStyle2, valueStyle2),
//
//                 ],
//               ),
//             ),
//             // Left side - Price
//             Text(
//               record['milkPrice']!,
//               style: valueStyle.copyWith(
//                 fontSize: isMobile ? 12 : 14,
//                 color: Colors.green.shade800,
//               ),
//             ),
//
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildDetailRow(String label, String value, TextStyle labelStyle, TextStyle valueStyle) {
//     return Row(
//       children: [
//         Text('$label: ', style: labelStyle),
//         Expanded(
//           child: Text(
//             value,
//             style: valueStyle,
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//       ],
//     );
//   }
// }




import 'package:flutter/material.dart';
import '../../models/milk_request.dart';
import '../../services/EmployeeService.dart';
import '../../utils/auth_helper.dart';

class TransactionHistoryPage extends StatefulWidget {
  const TransactionHistoryPage({super.key});

  @override
  State<TransactionHistoryPage> createState() => _TransactionHistoryPageState();
}

class _TransactionHistoryPageState extends State<TransactionHistoryPage> {
  // final EmployeeService _employeeService = EmployeeService();
  // List<MilkRequest> _transactions = [];
  // bool _isLoading = true;
  // String? _errorMessage;
  //
  // @override
  // void initState() {
  //   super.initState();
  //   _loadTransactions();
  // }
  //
  // Future<void> _loadTransactions() async {
  //   try {
  //     await _employeeService.initialize();
  //     final currentUser = await AuthHelper.getUser();
  //     final allRequests = await _employeeService.getAllMilkRequests();
  //
  //     setState(() {
  //       _transactions = allRequests.where((request) {
  //         return request.user?.id == currentUser?.id &&
  //             request.paymentMethod != null;
  //       }).toList();
  //       _isLoading = false;
  //     });
  //   } catch (e) {
  //     setState(() {
  //       _errorMessage = 'Failed to load transactions: ${e.toString()}';
  //       _isLoading = false;
  //     });
  //   }
  // }
  final EmployeeService _employeeService = EmployeeService();
  List<MilkRequest> _transactions = [];
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadTransactions();
  }

  Future<void> _loadTransactions() async {
    try {
      final user = await AuthHelper.getUser();
      if (user == null) throw Exception('User not logged in');

      final requests = await _employeeService.getMilkRequestsByFarmer(user.email!);

      setState(() {
        _transactions = requests.where((request) =>
        request.paymentMethod != null && request.paymentMethod!.isNotEmpty
        ).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load transactions: ${e.toString()}';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width <= 600;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF35F9D1),
        toolbarHeight: 80,
        title: Text(
          "Transaction History",
          style: TextStyle(
            fontSize: isMobile ? 18 : 22,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: _buildBodyContent(isMobile),
    );
  }

  Widget _buildBodyContent(bool isMobile) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            _errorMessage!,
            style: const TextStyle(color: Colors.red, fontSize: 16),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (_transactions.isEmpty) {
      return const Center(
        child: Text(
          'No transaction records found',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: isMobile ? _buildMobileList() : _buildDesktopGrid(),
    );
  }

  Widget _buildMobileList() {
    return ListView.separated(
      itemCount: _transactions.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        return RecordCard(
          record: _convertToRecord(_transactions[index]),
          isMobile: true,
        );
      },
    );
  }

  Widget _buildDesktopGrid() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 400,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.8,
      ),
      itemCount: _transactions.length,
      itemBuilder: (context, index) {
        return RecordCard(
          record: _convertToRecord(_transactions[index]),
          isMobile: false,
        );
      },
    );
  }

  Map<String, String> _convertToRecord(MilkRequest transaction) {
    final totalPrice = transaction.totalPrice ??
        (transaction.liters != null && transaction.pricePerLiter != null
            ? (transaction.liters! * transaction.pricePerLiter!).round()
            : 0);

    return {
      'date': _formatDate(transaction.date),
      'milkPrice': '₹$totalPrice',
      'payment': transaction.paymentMethod?.toUpperCase() ?? 'CASH',
      'staffName': transaction.employee ?? 'Staff',
    };
  }

  String _formatDate(DateTime? date) {
    if (date == null) return 'Date not available';
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
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
    final theme = Theme.of(context);
    final labelStyle = TextStyle(
      fontSize: isMobile ? 12 : 14,
      color: Colors.black,
    );
    final valueStyle = TextStyle(
      fontSize: isMobile ? 12 : 14,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
    final labelStyle2 = TextStyle(
      fontSize: isMobile ? 12 : 14,
      color: Colors.grey,
    );
    final valueStyle2 = TextStyle(
      fontSize: isMobile ? 12 : 14,
      fontWeight: FontWeight.normal,
      color: Colors.grey,
    );

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: EdgeInsets.all(isMobile ? 12 : 16),
        child: Row(
          children: [
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow('Date', record['date']!, labelStyle, valueStyle),
                  const SizedBox(height: 8),
                  _buildDetailRow('Payment', record['payment']!, labelStyle2, valueStyle2),
                  const SizedBox(height: 8),
                  _buildDetailRow('Staff', record['staffName']!, labelStyle2, valueStyle2),
                ],
              ),
            ),
            Text(
              record['milkPrice']!,
              style: valueStyle.copyWith(
                fontSize: isMobile ? 12 : 14,
                color: Colors.green.shade800,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, TextStyle labelStyle, TextStyle valueStyle) {
    return Row(
      children: [
        Text('$label: ', style: labelStyle),
        Expanded(
          child: Text(
            value,
            style: valueStyle,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}