import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:health_tracker/utils/colors.dart';
import 'package:health_tracker/views/home.dart';

class ProgressStepDayPage extends StatefulWidget {
  @override
  _ProgressStepDayPageState createState() => _ProgressStepDayPageState();
}

class _ProgressStepDayPageState extends State<ProgressStepDayPage> {
  String selectedView = 'Day';
  String selectedTab = 'Step'; // 'Step' atau 'Calorie'
  DateTime selectedDate = DateTime(2025, 5, 26);

  // Data contoh untuk Step
  final Map<String, List<double>> dayStepsData = {
    '2025-05-26': [150, 60, 10],
    '2025-05-27': [100, 90, 70],
  };

  final Map<String, List<double>> weekStepsData = {
    '2025-05-26': [200, 180, 100, 150, 90, 130, 170],
    '2025-06-02': [220, 160, 120, 140, 110, 100, 190],
  };

  // Data contoh untuk Calorie
  final Map<String, List<double>> dayCalorieData = {
    '2025-05-26': [80, 50, 50],
    '2025-05-27': [70, 40, 60],
  };

  final Map<String, List<double>> weekCalorieData = {
    '2025-05-26': [300, 280, 200, 250, 190, 230, 270],
    '2025-06-02': [320, 260, 220, 240, 210, 200, 290],
  };

  List<BarChartGroupData> getBarData() {
    List<double> data;
    if (selectedTab == 'Step') {
      if (selectedView == 'Day') {
        data = dayStepsData[_formatDate(selectedDate)] ?? [0, 0, 0];
      } else {
        data = weekStepsData[_formatDate(selectedDate)] ?? [0, 0, 0, 0, 0, 0, 0];
      }
    } else {
      if (selectedView == 'Day') {
        data = dayCalorieData[_formatDate(selectedDate)] ?? [0, 0, 0];
      } else {
        data = weekCalorieData[_formatDate(selectedDate)] ?? [0, 0, 0, 0, 0, 0, 0];
      }
    }

    return List.generate(data.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: data[index],
            color: blueColor,
            borderRadius: BorderRadius.circular(6),
            width: 24,
          ),
        ],
      );
    });
  }

  String _formatDate(DateTime date) {
    return "${date.year.toString().padLeft(4, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.day.toString().padLeft(2, '0')}";
  }

  String _formatDisplayDate(DateTime date) {
    return "${date.day} ${_monthName(date.month)}";
  }

  String _monthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }

    int getTotalStepsOrCalorie() {
      List<double>? data;

      Map<String, List<double>> dataMap;
      if (selectedTab == 'Step') {
        dataMap = selectedView == 'Day' ? dayStepsData : weekStepsData;
      } else {
        dataMap = selectedView == 'Day' ? dayCalorieData : weekCalorieData;
      }

      data = dataMap[_formatDate(selectedDate)];

      // Kalau data null atau semua 0, pakai data pertama yang ada di map supaya total gak 0
      if (data == null || data.every((element) => element == 0)) {
        if (dataMap.isNotEmpty) {
          data = dataMap.values.first;
          // Optional kalau mau sync tanggal juga, uncomment:
          // selectedDate = DateTime.parse(dataMap.keys.first);
        } else {
          data = selectedView == 'Day'
              ? [0, 0, 0]
              : [0, 0, 0, 0, 0, 0, 0];
        }
      }

  return data.fold(0, (prev, element) => prev + element.toInt());
}

  Widget getBottomTitles(double value) {
    if (selectedView == 'Day') {
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
    } else {
      switch (value.toInt()) {
        case 0:
          return Text("Mon");
        case 1:
          return Text("Tue");
        case 2:
          return Text("Wed");
        case 3:
          return Text("Thu");
        case 4:
          return Text("Fri");
        case 5:
          return Text("Sat");
        case 6:
          return Text("Sun");
        default:
          return Text("");
      }
    }
  }

  double getMaxY() {
    List<double> data;
    if (selectedTab == 'Step') {
      data = selectedView == 'Day'
          ? (dayStepsData[_formatDate(selectedDate)] ?? [0, 0, 0])
          : (weekStepsData[_formatDate(selectedDate)] ?? [0, 0, 0, 0, 0, 0, 0]);
    } else {
      data = selectedView == 'Day'
          ? (dayCalorieData[_formatDate(selectedDate)] ?? [0, 0, 0])
          : (weekCalorieData[_formatDate(selectedDate)] ?? [0, 0, 0, 0, 0, 0, 0]);
    }
    final maxValue = data.reduce((a, b) => a > b ? a : b);
    final baseInterval = selectedView == 'Day' ? 100 : 200;
    return (((maxValue / baseInterval).ceil() + 1) * baseInterval).toDouble();
  }

  int getYInterval() {
    return selectedView == 'Day' ? 100 : 200;
  }

  @override
  Widget build(BuildContext context) {
    final barData = getBarData();
    final total = getTotalStepsOrCalorie();
    final maxY = getMaxY();
    final yInterval = getYInterval();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.chevron_left),
                    onPressed: () {
                      Navigator.pop(context, MaterialPageRoute(builder: (context) => HomePage()));
                    },
                  ),
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
                  PopupMenuButton<String>(
                    icon: Icon(Icons.menu, color: Colors.black),
                    color: Colors.white, // background popup putih
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    onSelected: (value) {
                      setState(() {
                        selectedView = value;
                      });
                    },
                    itemBuilder: (BuildContext context) {
                      return ['Day', 'Week'].map((option) {
                        final isSelected = selectedView == option;
                        return PopupMenuItem<String>(
                          value: option,
                          // Container untuk background berwarna saat selected
                          child: Container(
                            decoration: BoxDecoration(
                              color: isSelected ? blueColor : Colors.transparent,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            child: Row(
                              children: [
                                Icon(
                                  option == 'Day' ? Icons.calendar_today : Icons.view_week,
                                  color: isSelected ? Colors.white : Colors.black,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  option,
                                  style: TextStyle(
                                    color: isSelected ? Colors.white : Colors.black,
                                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList();
                    },
                  ),
                ],
              ),
            ),

            // Tabs Step dan Calorie
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedTab = 'Step';
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: selectedTab == 'Step'
                          ? Border(bottom: BorderSide(color: blueColor, width: 3))
                          : null,
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
                SizedBox(width: 75),
                TextButton(
                  onPressed: () {
                    setState(() {
                      selectedTab = 'Calorie';
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: selectedTab == 'Calorie'
                          ? Border(bottom: BorderSide(color: blueColor, width: 3))
                          : null,
                    ),
                    padding: EdgeInsets.only(bottom: 6),
                    child: Text(
                      "Calorie",
                      style: TextStyle(
                        fontFamily: "PoppinsMedium",
                        fontSize: 16,
                        color: fontBlackColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Tanggal & Total
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDate = selectedView == 'Day'
                                ? selectedDate.subtract(Duration(days: 1))
                                : selectedDate.subtract(Duration(days: 7));
                          });
                        },
                        child: Icon(Icons.arrow_left, size: 20),
                      ),
                      SizedBox(width: 10),
                      Text(
                        selectedView == 'Day'
                            ? _formatDisplayDate(selectedDate)
                            : "${_formatDisplayDate(selectedDate)} - ${_formatDisplayDate(selectedDate.add(Duration(days: 6)))}",
                        style: TextStyle(
                          fontFamily: "PoppinsMedium",
                          fontSize: 14,
                          color: fontBlackColor,
                        ),
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedDate = selectedView == 'Day'
                                ? selectedDate.add(Duration(days: 1))
                                : selectedDate.add(Duration(days: 7));
                          });
                        },
                        child: Icon(Icons.arrow_right, size: 20),
                      ),
                    ],
                  ),
                  SizedBox(height: 18),
                  Text(
                    "Total",
                    style: TextStyle(
                      fontFamily: "PoppinsMedium",
                      fontSize: 14,
                      color: fontBlackColor,
                    ),
                  ),
                  SizedBox(height: 12),
                  Text(
                    selectedTab == 'Step' ? "$total" : "$total kcal",
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

            // Chart
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: BarChart(
                      BarChartData(
                        maxY: maxY,
                        minY: 0,
                        groupsSpace: 12,
                        barGroups: barData,
                        borderData: FlBorderData(show: false),
                        gridData: FlGridData(show: false),
                        titlesData: FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: (value, meta) => getBottomTitles(value),
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: yInterval.toDouble(),
                              getTitlesWidget: (value, meta) {
                                if (value == 0) return Container();
                                return Text(
                                  value.toInt().toString(),
                                  style: TextStyle(fontSize: 12, color: Colors.grey),
                                );
                              },
                            ),
                          ),
                          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: 0,
        selectedItemColor: blueColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          // Handle navigation here
        },
      ),
    );
  }
}
