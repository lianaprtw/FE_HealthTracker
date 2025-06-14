import 'package:flutter/material.dart';
import 'package:health_tracker/views/Trainee/ForgetPass.dart';

class TrainerProfileEditPage extends StatefulWidget {
  const TrainerProfileEditPage({super.key});

  @override
  State<TrainerProfileEditPage> createState() => _TrainerProfileEditPageState();
}

class _TrainerProfileEditPageState extends State<TrainerProfileEditPage> {
  bool _obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    const blueColor = Color(0xFF3742FA);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text('Profil', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: const Icon(Icons.save_alt, color: blueColor),
            onPressed: () {
              // Menampilkan snackbar popup
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Data berhasil diperbarui"),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 2),
                ),
              );
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                'images/profile_avatar.png',
              ), // Ganti sesuai path kamu
              backgroundColor: Colors.grey,
            ),
            const SizedBox(height: 20),
            _buildTextField(label: "Email", initialValue: "bambang@gmail.com"),
            _buildTextField(label: "Name", initialValue: "Bambang"),
            _buildTextField(label: "Gender", initialValue: "Male"),
            _buildTextField(label: "Specialist", initialValue: "Gym"),
            TextFormField(
              obscureText: _obscurePassword,
              decoration: InputDecoration(
                labelText: 'Password',
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: blueColor),
                ),
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerLeft,
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              const ForgetPasswordScreen(), // Ganti dengan nama file halaman forget password
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Text(
                    "Do You Want Change your Password ?",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 13,
                      color: Color(0xFF4A4AFF),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {
          // Navigasi ke halaman lain
        },
        selectedItemColor: blueColor,
        unselectedItemColor: Colors.grey,
        showSelectedLabels: false,
        showUnselectedLabels: false,
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

  Widget _buildTextField({
    required String label,
    required String initialValue,
  }) {
    const blueColor = Color(0xFF3742FA);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: blueColor),
          ),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}
