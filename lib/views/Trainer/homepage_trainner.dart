import 'package:flutter/material.dart';
import 'package:health_tracker/views/Trainer/Profile_Trainner.dart';
import 'package:health_tracker/views/Trainee/user_Trainer.dart';
import 'package:health_tracker/views/Trainee/detail_trainee.dart';

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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
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
                "Health Tracker",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
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
                  // Tangani saat ikon notifikasi ditekan
                  print('Ikon notifikasi ditekan!');
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
