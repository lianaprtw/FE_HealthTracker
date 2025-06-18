import 'package:flutter/material.dart';
import 'package:health_tracker/views/Trainee/chat_screen.dart'; // Pastikan ini benar
import 'package:health_tracker/views/Trainee/daily_activity_screen.dart';
import 'package:health_tracker/views/Trainee/history.dart';
import 'package:health_tracker/views/Trainee/notification.dart';
import 'package:health_tracker/views/Trainee/profile.dart';
import 'package:health_tracker/views/Trainee/water_tracker.dart';
// import 'package:health_tracker/views/Trainer/addTrainer.dart';

// Placeholder untuk halaman chat (tetap gunakan ini sebagai tab jika ChatScreen detail)
class ChatPage extends StatelessWidget {
  const ChatPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Halaman Chat (tab ini tidak lagi membawa ke Chat Screen utama)',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// HomePage utama (Stateful) yang mengelola BottomNavigationBar
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const ChatPage(), // Gunakan ChatPage sebagai tab untuk 'Chat' di bottom bar
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFF7F7F7),
        elevation: 0,
        toolbarHeight: 80.0,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Health Tracker',
                style: TextStyle(
                  color: Color(0xFF3333FF),
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: "PoppinsSemiBold",
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NotificationPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: _pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // INI ADALAH PERUBAHAN UTAMA: Navigasi ke ChatScreen sebagai halaman baru
          // Ini akan menumpuk ChatScreen di atas HomePage
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ChatScreen(recipientName: 'Trainer Anda'),
            ),
          );
          // Hapus setState(_selectedIndex = 1); karena kita tidak lagi beralih tab.
        },
        backgroundColor: const Color(0xFF3333FF),
        elevation: 0,
        shape: const CircleBorder(),
        child: const Icon(Icons.chat_bubble, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
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
                onPressed: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
              ),
              const SizedBox(width: 40),
              IconButton(
                icon: const Icon(Icons.person),
                color: _selectedIndex == 2 ? const Color(0xFF3333FF) : Colors.grey,
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

// Konten tab Home, berisi semua kartu
class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  // Pindahkan state water tracker ke HomeContent agar bisa diperbarui di halaman ini
  List<Map<String, dynamic>> _waterEntries = []; // Use a list to store entries
  final double _waterTarget = 2000; // Daily water target

  @override
  void initState() {
    super.initState();
    _loadInitialWaterData(); // Load any previously saved water data if applicable
  }

  // A method to simulate loading initial water data (e.g., from local storage)
  void _loadInitialWaterData() {
    // In a real app, you would load this from SharedPreferences or a database.
    // For now, let's start with an empty list.
    setState(() {
      _waterEntries = [];
    });
  }

  // Function to calculate total water drank from _waterEntries
  int _getTotalWaterDrank() {
    return _waterEntries.fold<int>(0, (sum, entry) => sum + (entry['amount'] as int));
  }

  // --- Helper Methods untuk membangun kartu individu ---

  Widget _buildUserProfileCard() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: const Color(0xFF3333FF), // Background biru
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // Sejajarkan item ke atas
        children: [
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enno Lerebulan',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "PoppinsSemiBold",
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Female, 23y.o',
                  style: TextStyle(
                    color: Colors.white, // Putih yang sedikit lebih terang
                    fontSize: 14,
                    fontFamily: "PoppinsMedium",
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Height: 155cm',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: "PoppinsRegular",
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Weight: 50kg',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: "PoppinsRegular",
                  ),
                ),
              ],
            ),
          ),
          // Gambar Pengguna (Placeholder untuk model 3D, sesuaikan path jika aset lokal)
          SizedBox(
            width: 190, // Sesuaikan lebar sesuai kebutuhan
            height: 119, // Sesuaikan tinggi sesuai kebutuhan
            child: Image.asset(
              "assets/images/close up of businesswoman in red suit waving hello.png", // Gunakan path aset lokal Anda
              fit: BoxFit.cover,
              // errorBuilder: (context, error, stackTrace) =>
              //     const Icon(Icons.person, color: Colors.white, size: 80), // Fallback
            ),
          ),
        ],
      ),
    );
  }

  // Widget _buildYourTrainerCard(BuildContext context) {
  //   return GestureDetector(
  //     onTap: () {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(builder: (_) => const AddTrainerPage()),
  //       );
  //     },
  //     child: Container(
  //       padding: const EdgeInsets.all(20.0),
  //       decoration: BoxDecoration(
  //         color: const Color(0xFF3333FF), // Background biru
  //         borderRadius: BorderRadius.circular(20.0),
  //       ),
  //       child: Column(
  //         mainAxisSize: MainAxisSize.min,
  //         children: [
  //           const Text(
  //             'Please add your Trainner', // Teks di atas tombol
  //             style: TextStyle(
  //               color: Colors.white,
  //               fontSize: 16,
  //               fontWeight: FontWeight.w600,
  //               fontFamily: "PoppinsSemiBold",
  //             ),
  //           ),
  //           const SizedBox(height: 16), // Spasi antara teks dan tombol
  //           Container(
  //             padding: const EdgeInsets.symmetric(vertical: 10),
  //             width: double.infinity,
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(30),
  //             ),
  //             child: const Center(
  //               child: Text(
  //                 "Add New",
  //                 style: TextStyle(
  //                   color: Color(0xFF3333FF),
  //                   fontWeight: FontWeight.w600,
  //                   fontFamily: "PoppinsSemiBold",
  //                   fontSize: 15,
  //                 ),
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  Widget _buildDailyActivityCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: const Color(0xFF3333FF), // Blue background
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Daily Activity',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  fontFamily: "PoppinsSemiBold",
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HistoryScreen(),
                    ),
                  );
                },
                child: const Text(
                  'view history',
                  style: TextStyle(
                    color: Color(0xFFFFEAA7),
                    fontSize: 16,
                    fontFamily: "PoppinsMedium",
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildActivityItem(Icons.flash_on, '500', 'Calorie'),
              _buildActivityItem(Icons.location_on, '0,2 Km', 'Distance'),
              _buildActivityItem(Icons.timer, '15:10', 'Minutes'),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddDailyActivityScreen(),
                  ),
                ).then((_) {
                  // Optional: If you want to update the display after returning from DailyActivityScreen
                  // You can use setState() to update the displayed data.
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              child: const Text(
                'Add New',
                style: TextStyle(
                  color: Color(0xFF3333FF),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: "PoppinsSemiBold",
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper for Daily Activity items (Calorie, Distance, Minutes)
  Widget _buildActivityItem(IconData icon, String value, String label) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 35),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: "PoppinsSemiBold",
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontFamily: "PoppinsSemiBold",
          ),
        ),
      ],
    );
  }

  Widget _buildWaterTrackerCard() {
    // Calculate total water drank dynamically
    final int totalWaterDrank = _getTotalWaterDrank();

    return Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: const Color(0xFF3333FF), // Blue background
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Row(
        children: [
          // Water Glass Icon with border
          Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: const Color(0xFF3333FF), width: 2.0),
            ),
            child: const Icon(
              Icons.local_drink, // Water drop icon
              color: Color(0xFF3333FF),
              size: 30,
            ),
          ),
          const SizedBox(width: 15),
          // Text information
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  // Use totalWaterDrank from the calculated value
                  '${totalWaterDrank}ml / ${_waterTarget.round()} ml',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "PoppinsSemiBold",
                  ),
                ),
                const Text(
                  'Water Tracker',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontFamily: "PoppinsRegular",
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          // Drink Button
          ElevatedButton(
            onPressed: () async {
              // Navigate to WaterTrackerScreen and await the result
              final updatedEntries = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WaterTrackerScreen(
                    initialWaterEntries: _waterEntries, // Pass current entries
                  ),
                ),
              );

              // If updatedEntries is not null, update the state
              if (updatedEntries != null && updatedEntries is List<Map<String, dynamic>>) {
                setState(() {
                  _waterEntries = updatedEntries;
                });
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              elevation: 0, // No shadow for the button
            ),
            child: const Text(
              'Drink',
              style: TextStyle(
                color: Color(0xFF3333FF),
                fontWeight: FontWeight.bold,
                fontFamily: "PoppinsSemiBold",
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

 @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildUserProfileCard(),
          const SizedBox(height: 20), // Hanya satu spacer di sini
          // _buildYourTrainerCard(context), // Ini tetap dikomentari
          _buildDailyActivityCard(context), // Langsung ke card berikutnya
          const SizedBox(height: 20), // Spacer
          _buildWaterTrackerCard(),
        ],
      ),
    );
  }
}