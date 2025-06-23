//
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'dart:io';
// import 'package:onlinedairy/models/PUser.dart';
// import 'package:onlinedairy/models/milk_request.dart';
// import 'package:onlinedairy/services/EmployeeService.dart';
//
// class FarmerMilkRecordPage extends StatefulWidget {
//   final PUser farmer;
//
// const FarmerMilkRecordPage({super.key, required this.farmer});
//
//   @override
//   _FarmerMilkRecordPageState createState() => _FarmerMilkRecordPageState();
// }
//
// class _FarmerMilkRecordPageState extends State<FarmerMilkRecordPage> {
//   final EmployeeService _employeeService = EmployeeService();
//   List<MilkRequest> _milkRequests = [];
//   List<MilkRequest> _filteredRequests = [];
//   DateTime? _startDate;
//   DateTime? _endDate;
//   bool _isLoading = true;
//   int _id=1;
//
//   @override
//   void initState() {
//     super.initState();
//     _fetchMilkRequests();
//   }
//
//   Future<void> _fetchMilkRequests() async {
//     try {
//       final requests = await _employeeService.getMilkRequestsByFarmer(widget.farmer.email!);
//       setState(() {
//         _milkRequests = requests;
//         _filteredRequests = requests;
//         _isLoading = false;
//       });
//     } catch (e) {
//       setState(() => _isLoading = false);
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Error loading requests: $e')),
//       );
//     }
//   }
//
//   Future<void> _selectDate(BuildContext context, bool isStartDate) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(2000),
//       lastDate: DateTime.now(),
//     );
//     if (picked != null) {
//       setState(() {
//         if (isStartDate) {
//           _startDate = picked;
//         } else {
//           _endDate = picked;
//         }
//       });
//     }
//   }
//
//   void _filterRequests() {
//     if (_startDate == null || _endDate == null) return;
//
//     final start = DateTime(_startDate!.year, _startDate!.month, _startDate!.day);
//     final end = DateTime(_endDate!.year, _endDate!.month, _endDate!.day, 23, 59, 59);
//
//     setState(() {
//       _filteredRequests = _milkRequests.where((request) {
//         final requestDate = request.date!;
//         return requestDate.isAfter(start) && requestDate.isBefore(end);
//       }).toList();
//     });
//   }
//
//   Future<void> _generatePdf() async {
//     final pdf = pw.Document();
//     final headers = ['Sr.', 'Date', 'Liters', 'Fat%', 'Water%', 'Price/L', 'Total', 'Payment'];
//
//     pdf.addPage(
//       pw.Page(
//         build: (pw.Context context) {
//           return pw.TableHelper.fromTextArray(
//             headers: headers,
//             data: _filteredRequests
//                 .asMap()
//                 .entries
//                 .map((entry) => [
//               (entry.key + 1).toString(),
//               DateFormat('dd-MM-yyyy').format(entry.value.date!),
//               entry.value.liters.toString(),
//               entry.value.fatPercentage.toString(),
//               entry.value.waterContent.toString(),
//               entry.value.pricePerLiter.toString(),
//               entry.value.totalPrice.toString(),
//               entry.value.paymentMethod ?? 'N/A',
//             ])
//                 .toList(),
//           );
//         },
//       ),
//     );
//
//     // Example to save the PDF (uncomment and adjust as needed):
//     // final output = await getTemporaryDirectory();
//     // final file = File("${output.path}/milk_records.pdf");
//     // await file.writeAsBytes(await pdf.save());
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isMobile = MediaQuery.of(context).size.width < 750;
//     const primaryColor = Color(0xFF35F9D1);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Farmer Milk Records'),
//       ),
//       body: Container(
//         constraints: isMobile
//             ? null
//             : BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
//         padding: const EdgeInsets.all(16),
//         child: _isLoading
//             ? const Center(child: CircularProgressIndicator())
//             : SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               isMobile
//                   ? Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   _DatePickerField(
//                     label: 'Start Date',
//                     date: _startDate,
//                     onTap: () => _selectDate(context, true),
//                     isMobile: isMobile,
//                   ),
//                   const SizedBox(height: 10),
//                   _DatePickerField(
//                     label: 'End Date',
//                     date: _endDate,
//                     onTap: () => _selectDate(context, false),
//                     isMobile: isMobile,
//                   ),
//                   const SizedBox(height: 10),
//                   SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: primaryColor,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                         padding: EdgeInsets.symmetric(
//                           horizontal: isMobile ? 16 : 24,
//                           vertical: isMobile ? 12 : 16,
//                         ),
//                       ),
//                       onPressed: _filterRequests,
//                       child: Text(
//                         'Filter Records',
//                         style: TextStyle(
//                           fontSize: isMobile ? 14 : 16,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               )
//                   : Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: Row(
//                       children: [
//                         _DatePickerField(
//                           label: 'Start Date',
//                           date: _startDate,
//                           onTap: () => _selectDate(context, true),
//                           isMobile: isMobile,
//                         ),
//                         const SizedBox(width: 10),
//                         _DatePickerField(
//                           label: 'End Date',
//                           date: _endDate,
//                           onTap: () => _selectDate(context, false),
//                           isMobile: isMobile,
//                         ),
//                       ],
//                     ),
//                   ),
//                   const SizedBox(width: 10),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: primaryColor,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       padding: const EdgeInsets.symmetric(
//                           horizontal: 24, vertical: 16),
//                     ),
//                     onPressed: _filterRequests,
//                     child: const Text(
//                       'Filter Records',
//                       style: TextStyle(fontSize: 16),
//                     ),
//                   ),
//                 ],
//               ),
//               const SizedBox(height: 20),
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: _buildRecordsTable(isMobile),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildRecordsTable(bool isMobile) {
//     const primaryColor = Color(0xFF35F9D1);
//     if (_filteredRequests.isEmpty) {
//       return const Center(child: Text('No records found for the selected date range.'));
//     }
//     return DataTable(
//       border: TableBorder.all(color: primaryColor),
//       headingRowColor: WidgetStateProperty.resolveWith<Color?>(
//               (states) => primaryColor.withOpacity(0.1)),
//       columnSpacing: isMobile ? 10 : 30,
//       columns: [
//         _buildDataColumn('Sr.', isMobile),
//         _buildDataColumn('Date', isMobile),
//         _buildDataColumn('Liters', isMobile),
//         _buildDataColumn('Fat%', isMobile),
//         _buildDataColumn('Price/L', isMobile),
//         _buildDataColumn('Total', isMobile),
//         _buildDataColumn('Payment', isMobile),
//       ],
//       rows: _filteredRequests.asMap().entries.map((entry) {
//         final request = entry.value;
//         return DataRow(cells: [
//           DataCell(Text(
//             (entry.key + 1).toString(),
//             style: TextStyle(fontSize: isMobile ? 12 : 16),
//           )),
//           DataCell(Text(
//             DateFormat('dd-MM-yyyy').format(request.date!),
//             style: TextStyle(fontSize: isMobile ? 12 : 16),
//           )),
//           DataCell(Text(
//             request.liters.toString(),
//             style: TextStyle(fontSize: isMobile ? 12 : 16),
//           )),
//           DataCell(Text(
//             request.fatPercentage!.toStringAsFixed(1),
//             style: TextStyle(fontSize: isMobile ? 12 : 16),
//           )),
//           DataCell(Text(
//             '\₹${request.pricePerLiter?.toStringAsFixed(2) ?? ''}',
//             style: TextStyle(fontSize: isMobile ? 12 : 16),
//           )),
//           DataCell(Text(
//             '\₹${request.totalPrice?.toStringAsFixed(2) ?? ''}',
//             style: TextStyle(fontSize: isMobile ? 12 : 16),
//           )),
//           DataCell(Text(
//             request.paymentMethod ?? 'N/A',
//             style: TextStyle(fontSize: isMobile ? 12 : 16),
//           )),
//         ]);
//       }).toList(),
//     );
//   }
//
//   DataColumn _buildDataColumn(String label, bool isMobile) {
//     return DataColumn(
//       label: Text(
//         label,
//         style: TextStyle(
//           fontSize: isMobile ? 12 : 14,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//     );
//   }
// }
//
// class _DatePickerField extends StatelessWidget {
//   final String label;
//   final DateTime? date;
//   final VoidCallback onTap;
//   final bool isMobile;
//
//   const _DatePickerField({
//     required this.label,
//     required this.date,
//     required this.onTap,
//     required this.isMobile,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         padding: EdgeInsets.symmetric(
//           vertical: isMobile ? 8 : 12,
//           horizontal: isMobile ? 12 : 16,
//         ),
//         decoration: BoxDecoration(
//           border: Border.all(color: Colors.grey),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Text(
//               date != null
//                   ? DateFormat('dd/MM/yyyy').format(date!)
//                   : 'Select $label',
//               style: TextStyle(
//                 fontSize: isMobile ? 12 : 16,
//                 color: date != null ? Colors.black : Colors.grey,
//               ),
//             ),
//             Icon(
//               Icons.calendar_today,
//               size: isMobile ? 18 : 20,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:typed_data'; // For Uint8List
import 'package:printing/printing.dart'; // For Printing.layoutPdf
import 'package:onlinedairy/models/PUser.dart';
import 'package:onlinedairy/models/milk_request.dart';
import 'package:onlinedairy/services/EmployeeService.dart';

class FarmerMilkRecordPage extends StatefulWidget {
  final PUser farmer;

  const FarmerMilkRecordPage({super.key, required this.farmer});

  @override
  _FarmerMilkRecordPageState createState() => _FarmerMilkRecordPageState();
}

class _FarmerMilkRecordPageState extends State<FarmerMilkRecordPage> {
  final EmployeeService _employeeService = EmployeeService();
  List<MilkRequest> _milkRequests = [];
  List<MilkRequest> _filteredRequests = [];
  DateTime? _startDate;
  DateTime? _endDate;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMilkRequests();
  }

  Future<void> _fetchMilkRequests() async {
    try {
      final requests = await _employeeService.getMilkRequestsByFarmer(widget.farmer.email!);
      setState(() {
        _milkRequests = requests;
        _filteredRequests = requests;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error loading requests: $e')),
      );
    }
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  void _filterRequests() {
    if (_startDate == null || _endDate == null) return;

    final start = DateTime(_startDate!.year, _startDate!.month, _startDate!.day);
    final end = DateTime(_endDate!.year, _endDate!.month, _endDate!.day, 23, 59, 59);

    setState(() {
      _filteredRequests = _milkRequests.where((request) {
        final requestDate = request.date!;
        return requestDate.isAfter(start) && requestDate.isBefore(end);
      }).toList();
    });
  }

  /// Generates a PDF document containing the milk records table.
  Future<Uint8List> _generatePdf() async {
    final pdf = pw.Document();
    final headers = ['Sr.', 'Date', 'Liters', 'Fat%', 'Price/L', 'Total', 'Payment'];

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text('Farmer Milk Records', style: pw.TextStyle(fontSize: 20)),
              pw.SizedBox(height: 20),
              pw.Table.fromTextArray(
                headers: headers,
                data: _filteredRequests.asMap().entries.map((entry) => [
                  (entry.key + 1).toString(),
                  DateFormat('dd-MM-yyyy').format(entry.value.date!),
                  entry.value.liters.toString(),
                  entry.value.fatPercentage?.toStringAsFixed(1),
                  '${entry.value.pricePerLiter?.toStringAsFixed(2) ?? ''}',
                  '${entry.value.totalPrice?.toStringAsFixed(2) ?? ''}',
                  entry.value.paymentMethod ?? 'N/A',
                ]).toList(),
              ),
            ],
          );
        },
      ),
    );

    return pdf.save(); // Returns Future<Uint8List>
  }

  /// Triggers the print dialog with the generated PDF.
  Future<void> _printTable() async {
    final pdfBytes = await _generatePdf();
    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdfBytes,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 750;
    const primaryColor = Color(0xFF35F9D1);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Farmer Milk Records'),
        actions: [
          IconButton(
            icon: const Icon(Icons.print),
            onPressed: _printTable, // Calls the print function
            tooltip: 'Print Records',
          ),
        ],
      ),
      body: Container(
        constraints: isMobile
            ? null
            : BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
        padding: const EdgeInsets.all(16),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              isMobile
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _DatePickerField(
                    label: 'Start Date',
                    date: _startDate,
                    onTap: () => _selectDate(context, true),
                    isMobile: isMobile,
                  ),
                  const SizedBox(height: 10),
                  _DatePickerField(
                    label: 'End Date',
                    date: _endDate,
                    onTap: () => _selectDate(context, false),
                    isMobile: isMobile,
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: isMobile ? 16 : 24,
                          vertical: isMobile ? 12 : 16,
                        ),
                      ),
                      onPressed: _filterRequests,
                      child: Text(
                        'Filter Records',
                        style: TextStyle(
                          fontSize: isMobile ? 14 : 16,
                        ),
                      ),
                    ),
                  ),
                ],
              )
                  : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        _DatePickerField(
                          label: 'Start Date',
                          date: _startDate,
                          onTap: () => _selectDate(context, true),
                          isMobile: isMobile,
                        ),
                        const SizedBox(width: 10),
                        _DatePickerField(
                          label: 'End Date',
                          date: _endDate,
                          onTap: () => _selectDate(context, false),
                          isMobile: isMobile,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 16),
                    ),
                    onPressed: _filterRequests,
                    child: const Text(
                      'Filter Records',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: _buildRecordsTable(isMobile),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRecordsTable(bool isMobile) {
    const primaryColor = Color(0xFF35F9D1);
    if (_filteredRequests.isEmpty) {
      return const Center(child: Text('No records found for the selected date range.'));
    }
    return DataTable(
      border: TableBorder.all(color: primaryColor),
      headingRowColor: WidgetStateProperty.resolveWith<Color?>(
              (states) => primaryColor.withOpacity(0.1)),
      columnSpacing: isMobile ? 10 : 30,
      columns: [
        _buildDataColumn('Sr.', isMobile),
        _buildDataColumn('Date', isMobile),
        _buildDataColumn('Liters', isMobile),
        _buildDataColumn('Fat%', isMobile),
        _buildDataColumn('Price/L', isMobile),
        _buildDataColumn('Total', isMobile),
        _buildDataColumn('Payment', isMobile),
      ],
      rows: _filteredRequests.asMap().entries.map((entry) {
        final request = entry.value;
        return DataRow(cells: [
          DataCell(Text(
            (entry.key + 1).toString(),
            style: TextStyle(fontSize: isMobile ? 12 : 16),
          )),
          DataCell(Text(
            DateFormat('dd-MM-yyyy').format(request.date!),
            style: TextStyle(fontSize: isMobile ? 12 : 16),
          )),
          DataCell(Text(
            request.liters.toString(),
            style: TextStyle(fontSize: isMobile ? 12 : 16),
          )),
          DataCell(Text(
            request.fatPercentage!.toStringAsFixed(1),
            style: TextStyle(fontSize: isMobile ? 12 : 16),
          )),
          DataCell(Text(
            '${request.pricePerLiter?.toStringAsFixed(2) ?? ''}',
            style: TextStyle(fontSize: isMobile ? 12 : 16),
          )),
          DataCell(Text(
            '${request.totalPrice?.toStringAsFixed(2) ?? ''}',
            style: TextStyle(fontSize: isMobile ? 12 : 16),
          )),
          DataCell(Text(
            request.paymentMethod ?? 'N/A',
            style: TextStyle(fontSize: isMobile ? 12 : 16),
          )),
        ]);
      }).toList(),
    );
  }

  DataColumn _buildDataColumn(String label, bool isMobile) {
    return DataColumn(
      label: Text(
        label,
        style: TextStyle(
          fontSize: isMobile ? 12 : 14,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

class _DatePickerField extends StatelessWidget {
  final String label;
  final DateTime? date;
  final VoidCallback onTap;
  final bool isMobile;

  const _DatePickerField({
    required this.label,
    required this.date,
    required this.onTap,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: isMobile ? 8 : 12,
          horizontal: isMobile ? 12 : 16,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              date != null
                  ? DateFormat('dd/MM/yyyy').format(date!)
                  : 'Select $label',
              style: TextStyle(
                fontSize: isMobile ? 12 : 16,
                color: date != null ? Colors.black : Colors.grey,
              ),
            ),
            Icon(
              Icons.calendar_today,
              size: isMobile ? 18 : 20,
            ),
          ],
        ),
      ),
    );
  }
}
