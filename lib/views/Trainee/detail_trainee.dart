import 'package:flutter/material.dart';

class TraineeDetailPage extends StatelessWidget {
  const TraineeDetailPage({super.key});

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
        actions: [
          IconButton(
            icon: const Icon(Icons.send, color: primaryColor),
            onPressed: () {
              // Tambahkan logika kirim data jika diperlukan
            },
          ),
        ],
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
                child: const CircleAvatar(
                  backgroundImage: AssetImage('images/avatar.jpg'),
                  backgroundColor: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 24),
            const FieldLabel(label: 'Name'),
            const FieldInput(value: 'Jaya Sanjaya'),
            const FieldLabel(label: 'Gender'),
            const FieldInput(value: 'Male'),
            const FieldLabel(label: 'Age'),
            const FieldInput(value: '21 Years Old'),
            const FieldLabel(label: 'Height'),
            const FieldInput(value: '179 cm'),
            const FieldLabel(label: 'Weight'),
            const FieldInput(value: '75 kg'),
            const FieldLabel(label: 'Exercise choices'),
            const FieldInput(value: 'Aerobic'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble_outline),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}

// Widget untuk label
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

// Widget untuk input readonly
class FieldInput extends StatelessWidget {
  final String value;
  const FieldInput({required this.value, super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF3742FA);

    return TextFormField(
      initialValue: value,
      readOnly: true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 12,
        ),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
