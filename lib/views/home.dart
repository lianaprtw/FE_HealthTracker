import 'package:flutter/material.dart';
import 'package:health_tracker/views/daily_activity_screen.dart'; // Asumsi file ini ada
import 'package:health_tracker/views/progressStepDay.dart'; // Asumsi file ini ada
import 'package:health_tracker/views/profile.dart'; // Asumsi file ini ada
import 'package:health_tracker/views/water_tracker.dart'; // <--- IMPORT HALAMAN BARU INI

// Placeholder untuk halaman chat
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

// Main entry point of the application
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Tracker App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Poppins", // Pastikan Anda memiliki font Poppins di assets atau dari Google Fonts
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: const Color(0xFFF7F7F7), // Background yang konsisten
      ),
      home: const HomePage(),
      debugShowCheckedModeBanner: false, // Hilangkan banner debug
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

  // Daftar halaman/layar yang sesuai dengan item bottom navigation bar
  final List<Widget> _pages = [
    const HomeContent(), // Halaman Home dengan semua kartu
    const ChatPage(), // Placeholder untuk Halaman Chat
    const ProfilePage(), // Halaman Profil
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false, // Mencegah Flutter menambahkan tombol kembali secara otomatis
        backgroundColor: const Color(0xFFF7F7F7), // Background abu-abu muda
        elevation: 0, // Tanpa bayangan
        toolbarHeight: 80.0, // Sesuaikan tinggi sesuai desain
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0.0), // Tanpa padding horizontal di sini
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // Mendistribusikan ruang
            children: [
              // Teks "Health Tracker" di kiri
              const Text(
                'Health Tracker',
                style: TextStyle(
                  color: Color(0xFF3333FF), // Warna biru dari desain
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: "PoppinsSemiBold", // Asumsi gaya ini
                ),
              ),
              // Ikon bel notifikasi di kanan
              IconButton(
                icon: const Icon(Icons.notifications, color: Colors.black, size: 30),
                onPressed: () {
                  // Tangani saat ikon notifikasi ditekan
                  print('Ikon notifikasi ditekan!');
                },
              ),
            ],
          ),
        ),
      ),
      body: _pages[_selectedIndex], // Menampilkan halaman yang dipilih
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Latar belakang putih untuk container bottom nav bar
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1), // Bayangan lembut
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, -5), // Bayangan di bagian atas
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home, size: 30), label: ''), // Ikon Home
            BottomNavigationBarItem(icon: Icon(Icons.chat_bubble, size: 30), label: ''), // Ikon Chat
            BottomNavigationBarItem(icon: Icon(Icons.person, size: 30), label: ''), // Ikon Profil
          ],
          selectedItemColor: const Color.fromARGB(255, 57, 67, 255), // Warna item yang dipilih
          unselectedItemColor: Colors.grey, // Warna item yang tidak dipilih
          backgroundColor: Colors.transparent, // Transparan untuk menampilkan warna container
          elevation: 0, // Hilangkan elevasi default BottomNavigationBar
          showSelectedLabels: false, // Sembunyikan label
          showUnselectedLabels: false, // Sembunyikan label
          type: BottomNavigationBarType.fixed, // Pastikan ikon tidak bergeser
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
  double _waterDrank = 200; // Air yang sudah diminum
  final double _waterTarget = 2000; // Target air harian

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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
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
                    color: Colors.white70, // Putih yang sedikit lebih terang
                    fontSize: 13,
                    fontFamily: "Poppins",
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Height: 155cm',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 10,
                    fontFamily: "Poppins",
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Weight: 50kg',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 10,
                    fontFamily: "Poppins",
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

  Widget _buildYourTrainerCard() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: const Color(0xFF3333FF), // Background biru
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        // Gunakan Column utama untuk menumpuk elemen
        crossAxisAlignment: CrossAxisAlignment.start, // Sejajarkan konten kolom ke kiri
        children: [
          // Teks "Your Trainer" di pojok kiri atas
          const Text(
            'Your Trainer',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20, // Mungkin sedikit lebih besar dari sebelumnya
              fontWeight: FontWeight.bold,
              fontFamily: "PoppinsSemiBold",
            ),
          ),

          const SizedBox(
              height: 15), // Spasi antara "Your Trainer" dan baris di bawahnya

          // Baris untuk ikon dan detail trainer
          Row(
            children: [
              // Ikon Pengguna
              const CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  color: Color(0xFF3333FF), // Warna biru
                  size: 40,
                ),
              ),

              const SizedBox(width: 15), // Spasi antara ikon dan detail trainer

              // Detail Trainer (akan mengambil sisa ruang)
              Expanded(
                child: Column(
                  // Column untuk menumpuk detail trainer secara vertikal
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Sejajarkan teks ke kiri
                  children: const [
                    Text(
                      'Bambang Suherman',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "PoppinsSemiBold",
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Male, 27y.o',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontFamily: "Poppins",
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Specialist : Trainner Gym',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDailyActivityCard() {
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
                  print('View history pressed!');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          DailyActivityScreen(), // Navigate to DailyActivityScreen
                    ),
                  );
                },
                child: const Text(
                  'view history',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontFamily: "Poppins",
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
            width: double.infinity, // Make button fill width
            child: ElevatedButton(
              onPressed: () {
                print('Add New pressed!');
                // Implement navigation or dialog for adding new activity
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // White background
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50), // Rounded corners
                ),
              ),
              child: const Text(
                'Add New',
                style: TextStyle(
                  color: Color(0xFF3333FF), // Blue text
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
            color: Colors.white70,
            fontSize: 14,
            fontFamily: "Poppins",
          ),
        ),
      ],
    );
  }

  Widget _buildWaterTrackerCard() {
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
              border: Border.all(
                color: const Color(0xFF3333FF),
                width: 2.0,
              ),
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
                  // Gunakan state _waterDrank dari HomeContent
                  '${_waterDrank.round()}/${_waterTarget.round()} ml',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "PoppinsSemiBold",
                  ),
                ),
                const Text(
                  'Water Tracker',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                    fontFamily: "Poppins",
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          // Drink Button
          ElevatedButton(
            onPressed: () {
              // Navigasi ke halaman WaterTrackerScreen yang baru
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  WaterTrackerScreen(),
                ),
              ).then((_) {
                // Opsional: Jika Anda ingin memperbarui _waterDrank setelah kembali dari halaman WaterTrackerScreen
                // Anda perlu meneruskan data kembali dari WaterTrackerScreen atau menggunakan state management.
                // Untuk kesederhanaan, saya akan asumsikan _waterDrank di halaman ini akan diperbarui
                // ketika pengguna kembali dan halaman ini dibangun ulang, atau Anda bisa secara eksplisit
                // mengambil data terbaru jika disimpan secara persisten.
                // setState(() {
                //   // Logika untuk mengambil data _waterDrank terbaru
                // });
              });
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

  @override // <--- PASTIKAN ANNOTATION @override ADA DI SINI
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0), // Padding di sekitar konten utama
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Sejajarkan children ke awal (kiri)
        children: [
          // Removed "Holla, Enno!" greeting
          // const Text(
          //   'Holla, Enno!',
          //   style: TextStyle(
          //     fontFamily: "PoppinsSemiBold",
          //     fontSize: 25,
          //     fontWeight: FontWeight.w600,
          //     color: Color.fromARGB(219, 21, 42, 120),
          //   ),
          // ),
          // If you want a top space where the greeting used to be, you can uncomment this:
          // const SizedBox(height: 20), // Spacer

          // User Profile Card (dibuat ulang dari desain detail sebelumnya)
          _buildUserProfileCard(),
          const SizedBox(height: 20), // Spacer

          // Your Trainer Card (dibuat ulang dari desain detail sebelumnya)
          _buildYourTrainerCard(),
          const SizedBox(height: 20), // Spacer

          // Daily Activity Card (dibuat ulang dari desain detail sebelumnya)
          _buildDailyActivityCard(),
          const SizedBox(height: 20), // Spacer

          // Water Tracker Card (dibuat ulang dari desain detail sebelumnya, diintegrasikan dengan state)
          _buildWaterTrackerCard(),
        ],
      ),
    );
  }
}