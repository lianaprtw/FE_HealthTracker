import 'package:flutter/material.dart';
import 'package:health_tracker/views/Trainee/home.dart';
// import 'package:health_tracker/views/Trainee/chat_screen.dart';
import 'package:health_tracker/views/Trainee/profile.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  int _selectedIndex = 1; // FAB Chat default aktif

  final List<String> notifications = const [
    "Congratulations! You have completed 20 workouts this week.",
    "Your nutrition is very low, Here is a tip to improve it.",
    "You’re just closer to achieve your goals!",
    "You’re just closer to achieve your goals!",
    "Your watch is connected successfully",
  ];

  void _navigateTo(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ChatPage()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const ProfilePage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Notification",
          style: TextStyle(
            fontFamily: 'PoppinsSemiBold',
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: IconButton(
              icon: const Icon(Icons.notifications, color: Colors.black, size: 30),
              onPressed: () {
                // Sudah berada di halaman notif
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFF3333FF), // Solid 1 warna
                    ),
                    child: Text(
                      notifications[index],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontFamily: 'PoppinsMedium',
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 50.0),
            child: ElevatedButton(
              onPressed: () {
                // Tambahkan logika clear notifikasi di sini
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF3333FF),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: const Text(
                "Clear all",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontFamily: 'PoppinsSemiBold',
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateTo(1),
        backgroundColor: const Color(0xFF3333FF),
        elevation: 0,
        shape: const CircleBorder(),
        child: const Icon(Icons.chat_bubble, color: Colors.white),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.home),
                color: _selectedIndex == 0 ? const Color(0xFF3333FF) : Colors.grey,
                onPressed: () => _navigateTo(0),
              ),
              const SizedBox(width: 40), // Ruang untuk FAB
              IconButton(
                icon: const Icon(Icons.person),
                color: _selectedIndex == 2 ? const Color(0xFF3333FF) : Colors.grey,
                onPressed: () => _navigateTo(2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
