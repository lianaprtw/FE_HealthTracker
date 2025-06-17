import 'package:flutter/material.dart';

class TraineeDetailPage extends StatelessWidget {
  final Map<String, String> trainee;

  const TraineeDetailPage({super.key, required this.trainee});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF3742FA);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Detail Trainee',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Center(
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: primaryColor, width: 4),
                ),
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                    trainee['image'] ?? 'images/default_avatar.jpg',
                  ), // Default image if not found
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const FieldLabel(label: 'Name'),
            FieldInput(value: trainee['name'] ?? 'Unknown'),
            const FieldLabel(label: 'Gender'),
            FieldInput(value: trainee['gender'] ?? 'Unknown'),
            const FieldLabel(label: 'Age'),
            FieldInput(value: '${trainee['age'] ?? 'N/A'} Years Old'),
            const FieldLabel(label: 'Height'),
            FieldInput(value: trainee['height'] ?? 'N/A'),
            const FieldLabel(label: 'Weight'),
            FieldInput(value: trainee['weight'] ?? 'N/A'),
            const FieldLabel(label: 'Exercise choices'),
            FieldInput(value: trainee['exercise'] ?? 'Aerobic'),
          ],
        ),
      ),
    );
  }
}

class FieldLabel extends StatelessWidget {
  final String label;
  const FieldLabel({required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6, top: 12),
      child: Text(label, style: const TextStyle(fontSize: 14)),
    );
  }
}

class FieldInput extends StatelessWidget {
  final String value;
  const FieldInput({required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF3742FA);

    return TextFormField(
      initialValue: value,
      enabled: false, // Supaya tidak bisa diedit
      style: const TextStyle(fontSize: 16, color: Colors.black),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 12,
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
