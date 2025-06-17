import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF6F6F6),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'About',
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'PoppinsSemiBold',
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 50),
            const Text(
              'Health Tracker',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3750F0),
                fontFamily: 'PoppinsSemiBold',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'We are an application that helps you monitor your daily health easily and practically. '
              'Our goal is to help you achieve a healthier life, one small step at a time.\n'
              'Thank you for using Health Tracker!',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'PoppinsRegular',
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 50),
            const Text(
              'Info',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'PoppinsRegular',
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 16),
            const InfoRow(title: 'Version', value: '1.8.1'),
            const InfoRow(title: 'Update on', value: 'June 2025'),
            const InfoRow(title: 'Released on', value: 'February 2025'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFFF6F6F6),
        selectedItemColor: const Color(0xFF3750F0),
        unselectedItemColor: Colors.grey,
        currentIndex: 0, // Ganti sesuai kebutuhan
        onTap: (index) {
          // Navigasi antar halaman
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_bubble, color: Color(0xFF3750F0)),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '',
          ),
        ],
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  final String title;
  final String value;

  const InfoRow({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Poppins',
            ),
          ),
          Text(
            value,
            style: const TextStyle(
              fontSize: 14,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
