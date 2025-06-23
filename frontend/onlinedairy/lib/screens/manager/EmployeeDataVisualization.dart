
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

import '../../models/milk_request.dart';
import '../../services/EmployeeService.dart'; // Import for MethodChannel

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});
  @override
  _ChartPageState createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {

  Future<List<Map<String, dynamic>>> _getEmployeeRequestData() async {
    final employeeService = EmployeeService();
    try {
      List<MilkRequest> requests = await employeeService.getAllMilkRequests();

      Map<String, int> employeeCounts = {};
      for (var request in requests) {
        print(request.toJson());
        String? employee = request.employee;
        if (employee != null) {
          String normalized = employee.toLowerCase();
          employeeCounts[normalized] = (employeeCounts[normalized] ?? 0) + 1;
        }
      }

      // Rest of the original processing remains the same...
      List<Map<String, dynamic>> employeeData = employeeCounts.entries
          .map((entry) => {'employee': entry.key, 'count': entry.value})
          .toList()
        ..sort((a, b) => (b['count'] as int).compareTo(a['count'] as int));

      final int maxCount = employeeData.isNotEmpty ? employeeData.first['count'] as int : 1;

      // Color gradient function remains the same
      Color getBarColor(int count, int maxCount) {
        double fraction = count / maxCount;
        if (fraction <= 0.5) {
          return Color.lerp(Colors.red, Colors.yellow, fraction / 0.5)!;
        } else {
          return Color.lerp(Colors.yellow, Colors.green, (fraction - 0.5) / 0.5)!;
        }
      }

      for (var data in employeeData) {
        data['color'] = getBarColor(data['count'] as int, maxCount);
      }

      return employeeData;
    } catch (e) {
      print('Error fetching milk requests: $e');
      return []; // Return empty list on error
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;
    double barWidth = isMobile ? 20.0 : 40.0;
    double bottomTextSize = isMobile ? 12 : 16;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Employee Visualized data'),
        backgroundColor: Color(0xFF35F9D1),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _getEmployeeRequestData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading data'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No employee data found', style: TextStyle(fontSize: 18, color: Colors.grey)));
          } else {
            List<Map<String, dynamic>> employeeData = snapshot.data!;
            List<BarChartGroupData> barGroups = employeeData.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> data = entry.value;
              return BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: (data['count'] as int).toDouble(),
                    color: data['color'] as Color,
                    width: barWidth,
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(2)),
                  ),
                ],
              );
            }).toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Legend
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: const [
                      LegendItem(color: Colors.green, text: 'High'),
                      LegendItem(color: Colors.yellow, text: 'Medium'),
                      LegendItem(color: Colors.red, text: 'Low'),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: BarChart(
                      BarChartData(
                        alignment: BarChartAlignment.spaceAround,
                        minY: 0,
                        maxY: employeeData.isNotEmpty ? ((employeeData.first['count'] as int) + 1).toDouble() : 6,
                        gridData: FlGridData(show: false),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              interval: 1,
                              getTitlesWidget: (value, meta) {
                                return Text(
                                  value.toInt().toString(),
                                  style: const TextStyle(color: Colors.black, fontSize: 12),
                                );
                              },
                            ),
                          ),
                          // bottomTitles: AxisTitles(
                          //   sideTitles: SideTitles(
                          //     showTitles: true,
                          //     reservedSize: 40,
                          //     getTitlesWidget: (value, meta) {
                          //       int index = value.toInt();
                          //       if (index >= 0 && index < employeeData.length) {
                          //         return Text(
                          //           employeeData[index]['employee'],
                          //           style: TextStyle(color: Colors.black, fontSize: bottomTextSize), overflow: TextOverflow.clip,
                          //         );
                          //       }
                          //       return const Text('');
                          //     },
                          //   ),
                          // ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 30,
                              getTitlesWidget: (value, meta) {
                                int index = value.toInt();
                                return Text(
                                  '${index + 1}', // Show ID numbers instead of names
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: bottomTextSize * 0.8,
                                  ),
                                );
                              },
                            ),
                          ),
                          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                        barGroups: barGroups,
                        borderData: FlBorderData(
                          show: true,
                          border: const Border(
                            left: BorderSide(color: Colors.black, width: 1),
                            bottom: BorderSide(color: Colors.black, width: 1),
                          ),
                        ),
                        barTouchData: BarTouchData(enabled: false),
                      ),
                      duration: const Duration(milliseconds: 800),
                      curve: Curves.easeInOut,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Wrap(
                    spacing: 20,
                    runSpacing: 10,
                    children: employeeData.asMap().entries.map((entry) {
                      final index = entry.key;
                      final data = entry.value;
                      return Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 16,
                            height: 16,
                            color: data['color'],
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${index + 1}. ${data['employee']}', // Show "1. John"
                            style: TextStyle(
                              fontSize: bottomTextSize * 0.9,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

class LegendItem extends StatelessWidget {
  final Color color;
  final String text;
  const LegendItem({Key? key, required this.color, required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(width: 16, height: 16, color: color),
        const SizedBox(width: 4),
        Text(text, style: const TextStyle(fontSize: 14)),
      ],
    );
  }
}
