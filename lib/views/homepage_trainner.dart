import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final Color blueColor = Color(0xFF3742FA);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: blueColor,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header bar
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "WHAT’S UP MAN !",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: blueColor,
                    ),
                  ),
                  Icon(Icons.notifications_none_rounded, size: 28),
                ],
              ),
              const SizedBox(height: 20),
              // Blue card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: blueColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    // Ilustrasi gambar
                    Image.asset(
                      'assets/calendar_illustration.png', // Pastikan kamu punya file ini
                      height: 80,
                    ),
                    const SizedBox(width: 12),
                    // Text
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your schedule\nfor today',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Show More',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Container(
                                width: 40,
                                height: 2,
                                color: Colors.white,
                              )
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              // Kamu bisa tambahkan konten lain di bawahnya
            ],
          ),
        ),
      ),
    );
  }
}
