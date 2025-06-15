import 'package:flutter/material.dart';
import 'package:health_tracker/views/Trainee/home.dart';

class AddTrainerPage extends StatefulWidget {
  const AddTrainerPage({super.key});

  @override
  State<AddTrainerPage> createState() => _AddTrainerPageState();
}

class _AddTrainerPageState extends State<AddTrainerPage> {
  String? selectedTrainer;

  final List<String> trainerList = [
    'Bambang',
    'Coki',
    'Jesica',
    'Rani',
    'Sutelo',
  ];

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF3742FA);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text('Add Trainer', style: TextStyle(color: Colors.black)),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: primaryColor),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedTrainer,
                  hint: const Text('Choose Trainer'),
                  isExpanded: true,
                  icon: const Icon(Icons.arrow_drop_up, color: primaryColor),
                  items:
                      trainerList.map((trainer) {
                        return DropdownMenuItem<String>(
                          value: trainer,
                          child: Row(
                            children: [
                              const Icon(Icons.person, color: primaryColor),
                              const SizedBox(width: 12),
                              Text(trainer),
                            ],
                          ),
                        );
                      }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedTrainer = value;
                    });
                  },
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed:
                  selectedTrainer == null
                      ? null
                      : () {
                        // Handle save logic
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Trainer $selectedTrainer selected!'),
                          ),
                        );
                        // Navigate to another file/page (example: HomePage)
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomePage(),
                          ),
                        );
                      },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    selectedTrainer == null ? Colors.grey : primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text(
                'Save',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
