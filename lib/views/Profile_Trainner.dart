import 'package:flutter/material.dart';
import 'package:health_tracker/views/homepage_trainner.dart';
import 'package:health_tracker/views/logintrainer.dart';

class ProfilePage extends StatelessWidget {
  final Color primaryColor = Color(0xFF3742FA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 1, // Aktif di ikon profile
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomepageTrainner()),
            );
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Text(
              "Profile",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            // Avatar
            CircleAvatar(
              radius: 50,
              backgroundColor: primaryColor,
              child: CircleAvatar(
                radius: 47,
                backgroundImage: AssetImage(
                  'images/avatar.jpg',
                ), // Ganti sesuai asset kamu
              ),
            ),
            const SizedBox(height: 12),
            Text(
              "Bambang",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 32),

            // Language
            _buildMenuItem(
              icon: Icons.language,
              text: 'Language',
              onTap: () {},
              color: primaryColor,
            ),
            const SizedBox(height: 16),

            // About Us
            _buildMenuItem(
              icon: Icons.info_outline,
              text: 'About Us',
              onTap: () {},
              color: primaryColor,
            ),
            const SizedBox(height: 32),

            // Sign Out Button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()),
                  ); // Aksi logout
                },
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text(
                  'Sign Out',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      primaryColor, // pastikan primaryColor = Color(0xFF3742FA)
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  elevation: 4,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(color: color),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(icon, color: Colors.black),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: Colors.black,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
