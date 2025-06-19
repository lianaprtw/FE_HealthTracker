import 'package:flutter/material.dart';
// import 'package:health_tracker/views/Trainee/mainpage.dart'; // Uncomment if you need this import

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  // Hapus 'const' agar daftar dapat dimodifikasi
  final List<String> notifications = [
    "Congratulations! You have completed 20 workouts this week.",
    "Your nutrition is very low, Here is a tip to improve it.",
    "You are just closer to achieve your goals!",
    "Youa re just closer to achieve your goals!",
    "Your watch is connected successfully",
  ];

  // void _navigateTo(int index) {
  //   // Navigasi ke MainPage dan hapus semua halaman sebelumnya
  //   Navigator.pushAndRemoveUntil(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => MainPage(initialIndex: index),
  //     ),
  //     (route) => false,
  //   );
  // }

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
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Expanded(
            child: notifications.isEmpty
                ? const Center(
                    child: Text(
                      "No notifications yet.",
                      style: TextStyle(
                        fontFamily: 'PoppinsMedium',
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: notifications.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color(0xFF3333FF),
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
                // Tambahkan aksi hapus semua notifikasi
                setState(() {
                  notifications.clear(); // Ini akan mengosongkan daftar notifikasi
                });
                // Tampilkan SnackBar untuk konfirmasi
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("All notifications cleared!"),
                    duration: Duration(seconds: 2),
                  ),
                );
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
    );
  }
}