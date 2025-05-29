import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:health_tracker/utils/colors.dart'; // warna kustom

class ProgressStepDayPage extends StatelessWidget {
  // Dummy data untuk chart
  final List<BarChartGroupData> barData = [
    BarChartGroupData(
      x: 0,
      barRods: [
        BarChartRodData(
          toY: 150,
          color: blueColor,
          borderRadius: BorderRadius.circular(6),
        ),
      ],
    ),
    BarChartGroupData(
      x: 1,
      barRods: [
        BarChartRodData(
          toY: 60,
          color: blueColor,
          borderRadius: BorderRadius.circular(6),
        ),
      ],
    ),
    BarChartGroupData(
      x: 2,
      barRods: [
        BarChartRodData(
          toY: 10,
          color: blueColor,
          borderRadius: BorderRadius.circular(6),
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation Bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Row(
                children: [
                  Icon(Icons.chevron_left),
                  SizedBox(width: 12),
                  Text(
                    "Progress",
                    style: TextStyle(
                      fontFamily: "PoppinsSemiBold",
                      fontSize: 15,
                      color: fontBlackColor,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.menu),
                ],
              ),
            ),

            // Tabs Step dan Calorie
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: blueColor,
                          width: 3,
                        ),
                      ),
                    ),
                    padding: EdgeInsets.only(bottom: 6),
                    child: Text(
                      "Step",
                      style: TextStyle(
                        fontFamily: "PoppinsMedium",
                        fontSize: 16,
                        color: fontBlackColor,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    "Calorie",
                    style: TextStyle(
                      fontFamily: "PoppinsMedium",
                      fontSize: 16,
                      color: fontBlackColor,
                    ),
                  ),
                ),
              ],
            ),

            // Tanggal dan Total Step
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.arrow_left, size: 20),
                      SizedBox(width: 8),
                      Text(
                        "26 May",
                        style: TextStyle(
                          fontFamily: "PoppinsMedium",
                          fontSize: 14,
                          color: fontBlackColor,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_right, size: 20),
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "740",
                    style: TextStyle(
                      fontFamily: "PoppinsBold",
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: navyColor,
                    ),
                  ),
                ],
              ),
            ),

            // Step Chart
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: BarChart(
                      BarChartData(
                        barGroups: barData,
                        borderData: FlBorderData(show: false),
                        gridData: FlGridData(show: false),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) {
                                switch (value.toInt()) {
                                  case 0:
                                    return Text("06.00");
                                  case 1:
                                    return Text("09.00");
                                  case 2:
                                    return Text("12.00");
                                  default:
                                    return Text("");
                                }
                              },
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: true),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Bottom Navigation
            Container(
              decoration: BoxDecoration(
                border: Border(top: BorderSide(color: Colors.grey.shade300)),
              ),
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Icon(Icons.home, color: Colors.blue),
                  Icon(Icons.person_outline, color: Colors.grey),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
