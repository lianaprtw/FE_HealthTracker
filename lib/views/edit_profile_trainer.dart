import 'package:flutter/material.dart';

class EditProfileTrainerScreen extends StatefulWidget {
  const EditProfileTrainerScreen({super.key});

  @override
  State<EditProfileTrainerScreen> createState() =>
      _EditProfileTrainerScreenState();
}

class _EditProfileTrainerScreenState extends State<EditProfileTrainerScreen> {
  TextEditingController nameController = TextEditingController(text: "Bambang");
  TextEditingController usernameController = TextEditingController(
    text: "@bambang_fit",
  );
  TextEditingController ageController = TextEditingController(text: "28");
  TextEditingController specializationController = TextEditingController(
    text: "Fitness",
  );
  TextEditingController experienceController = TextEditingController(text: "5");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Trainer Profile'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Profile Picture
              Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage(
                      'assets/images/profile.png',
                    ), // Ganti dengan path gambar kamu
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue,
                      ),
                      child: IconButton(
                        icon: const Icon(Icons.edit, color: Colors.white),
                        onPressed: () {
                          // Tambahkan logika ganti foto di sini
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Name Field
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Username Field
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(
                  labelText: 'Username',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Age Field
              TextField(
                controller: ageController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Age',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Specialization Field
              TextField(
                controller: specializationController,
                decoration: const InputDecoration(
                  labelText: 'Specialization',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),

              // Experience Field
              TextField(
                controller: experienceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Experience (Years)',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 24),

              // Save Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Tambahkan logika save di sini
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Trainer profile updated!')),
                    );
                    Navigator.pop(context);
                  },
                  child: const Text('Save'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
