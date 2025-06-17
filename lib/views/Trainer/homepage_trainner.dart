import 'package:flutter/material.dart';
import 'package:health_tracker/views/Trainer/Profile_Trainner.dart';
import 'package:health_tracker/views/Trainee/user_Trainer.dart';
import 'package:health_tracker/views/Trainee/detail_trainee.dart';
import 'package:health_tracker/views/Trainee/notification.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Chat Page Content Here',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class HomepageTrainner extends StatefulWidget {
  const HomepageTrainner({super.key});

  @override
  State<HomepageTrainner> createState() => _HomePageState();
}

class _HomePageState extends State<HomepageTrainner> {
  int _selectedIndex = 0;

  // Define the primary color here
  static const Color primaryColor = Color(0xFF3742FA);

  // Daftar halaman/layar yang sesuai dengan item bottom navigation bar
  final List<Widget> _pages = [
    const HomePageContent(), // Halaman Home dengan semua kartu
    const ChatPage(), // Placeholder untuk Halaman Chat
    const ProfileTrainner(), // Halaman Profil
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(child: _pages[_selectedIndex]),
      // FAB (Chat)
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _selectedIndex = 1; // Pindah ke halaman Chat
          });
        },
        backgroundColor: const Color(0xFF3333FF),
        elevation: 0,
        shape: const CircleBorder(),
        child: const Icon(Icons.chat_bubble, color: Colors.white),
      ),

      // Lokasi FAB
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      // Bottom App Bar dengan FAB
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
                color:
                    _selectedIndex == 0 ? const Color(0xFF3333FF) : Colors.grey,
                onPressed: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
              ),
              const SizedBox(width: 40), // Ruang untuk FAB di tengah
              IconButton(
                icon: const Icon(Icons.person),
                color:
                    _selectedIndex == 2 ? const Color(0xFF3333FF) : Colors.grey,
                onPressed: () {
                  setState(() {
                    _selectedIndex = 2;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  const HomePageContent({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF3742FA);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Health Tracker',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: "PoppinsSemiBold", 
                  color: Color(0xFF3742FA),
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () {
                  // Navigasi ke halaman notifikasi
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (context) =>
                              const NotificationPage(), // Ganti dengan halaman notifikasi yang sesuai
                    ),
                  );
                },
              ),
            ],
          ),

          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('images/avatar.jpg'),
                ),
                SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Enno Lerebulan",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Female, 23 y.o",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Height: 155cm",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text("Weight: 50kg", style: TextStyle(color: Colors.white)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Container(
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(
                  32,
                ), // Sudut kanan bawah lebih besar
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Your Trainee",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    const TraineeListPage(), // Ganti sesuai halaman tujuan
                          ),
                        );
                      },
                      child: const Text(
                        "Show more >",
                        style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildTraineeCard(context, "Bambang"),
                const SizedBox(height: 12),
                _buildTraineeCard(context, "Sukijan"),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildTraineeCard(BuildContext context, String name) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (context) =>
                    const TraineeDetailPage(), // Ganti dengan halaman detail trainee
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('images/avatar.jpg'),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
