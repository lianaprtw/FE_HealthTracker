import 'package:flutter/material.dart';

class TraineeListPage extends StatelessWidget {
  const TraineeListPage({super.key});

  final List<Map<String, String>> trainees = const [
    {
      'name': 'Jaya',
      'gender': 'Male',
      'age': '21',
      'image': 'assets/images/avatar1.png',
    },
    {
      'name': 'Jerome',
      'gender': 'Male',
      'age': '22',
      'image': 'assets/images/avatar2.png',
    },
    {
      'name': 'Erika',
      'gender': 'Female',
      'age': '22',
      'image': 'assets/images/avatar3.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Trainee', style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: trainees.length,
        itemBuilder: (context, index) {
          final trainee = trainees[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blueAccent),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(trainee['image']!),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${trainee['gender']}, ${trainee['age']}y.o',
                          style: const TextStyle(color: Colors.grey),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          trainee['name']!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(Icons.arrow_forward_ios, size: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
