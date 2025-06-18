import 'package:flutter/material.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  bool isDeleting = false;

  List<Map<String, dynamic>> activities = [
    {
      'icon': Icons.fitness_center,
      'title': 'Jump Rope',
      'time': '15.00',
      'value': '00:30:00',
      'kcal': 283.1,
      'isDistance': false,
      'selected': false,
    },
    {
      'icon': Icons.directions_run,
      'title': 'Running',
      'time': '16.30',
      'value': '9.00 km',
      'kcal': 233.1,
      'isDistance': true,
      'selected': false,
    },
  ];

  void toggleDeleteMode() {
    setState(() {
      isDeleting = !isDeleting;
      if (!isDeleting) {
        for (var a in activities) {
          a['selected'] = false;
        }
      }
    });
  }

  void deleteSelected() {
    setState(() {
      activities.removeWhere((a) => a['selected']);
      isDeleting = false;
    });
  }

  double get totalCalories =>
      activities.fold(0.0, (sum, a) => sum + (a['kcal'] as double));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: false,
        title: const Text(
          'History', 
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontWeight: FontWeight.bold,
            fontFamily: "PoppinsSemiBold",)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(isDeleting ? Icons.check : Icons.delete,
                color: Colors.black),
            onPressed: () {
              if (isDeleting) {
                deleteSelected();
              } else {
                toggleDeleteMode();
              }
            },
          ),
          const SizedBox(width: 12),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 8),
            Text(
              totalCalories.toStringAsFixed(1),
              style: const TextStyle(
                  fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            const Text(
              'Total Calorie',
              style: TextStyle(
                fontSize: 13, 
                fontWeight: FontWeight.w500,
                fontFamily: "PoppinsMedium",
                color: Colors.grey),
            ),
            const SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '10 June (Today)',
                style: TextStyle(
                  fontSize: 12,
                  fontFamily: "PoppinsSemiBold",
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border:
                    Border.all(color: const Color(0xFF3742FA), width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  for (int i = 0; i < activities.length; i++) ...[
                    _buildActivityRow(
                      icon: activities[i]['icon'],
                      title: activities[i]['title'],
                      time: activities[i]['time'],
                      value: activities[i]['value'],
                      kcal: '${activities[i]['kcal']} Kcal',
                      isDistance: activities[i]['isDistance'],
                      showCheckbox: isDeleting,
                      checked: activities[i]['selected'],
                      onChanged: (val) {
                        setState(() {
                          activities[i]['selected'] = val!;
                        });
                      },
                    ),
                    if (i != activities.length - 1)
                      const SizedBox(height: 16),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActivityRow({
    required IconData icon,
    required String title,
    required String time,
    required String value,
    required String kcal,
    required bool isDistance,
    required bool showCheckbox,
    required bool checked,
    required ValueChanged<bool?> onChanged,
  }) {
    return Row(
      children: [
        if (showCheckbox)
          Checkbox(value: checked, onChanged: onChanged),
        if (!showCheckbox)
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: Colors.blue, size: 28),
          ),
        if (showCheckbox) const SizedBox(width: 4) else const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: 'PoppinsMedium',
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(value, 
              style: const TextStyle(
                fontSize: 14,
                fontFamily: 'PoppinsMedium',)),
              Text(
                kcal,
                style: const TextStyle(
                  fontSize: 12, 
                  fontFamily: 'PoppinsMedium',
                  color: Colors.grey),
              ),
            ],
          ),
        ),
        Text(time, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
