import 'package:flutter/material.dart';

// Asumsi ini adalah bagian dari project Flutter Anda di 'lib/views/water_tracker_screen.dart'

class WaterTrackerScreen extends StatefulWidget {
  const WaterTrackerScreen({super.key});

  @override
  State<WaterTrackerScreen> createState() => _WaterTrackerScreenState();
}

class _WaterTrackerScreenState extends State<WaterTrackerScreen> {
  // Data dummy untuk melacak asupan air
  final List<Map<String, dynamic>> _waterEntries = [
    {'time': '06:00 AM', 'amount': 200, 'isChecked': false},
    {'time': '07:00 AM', 'amount': 200, 'isChecked': false},
    {'time': '08:00 AM', 'amount': 200, 'isChecked': false},
    {'time': '09:00 AM', 'amount': 200, 'isChecked': false},
    // Anda bisa menambahkan entri lain sesuai kebutuhan
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white, // Latar belakang putih untuk app bar
        elevation: 0, // Tanpa bayangan
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
        title: const Text(
          'Add Water',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "PoppinsSemiBold",
          ),
        ),
        centerTitle: true, // Pusatkan judul
        actions: [
          TextButton(
            onPressed: () {
              // Aksi saat tombol Cancel ditekan
              Navigator.pop(context); // Biasanya kembali tanpa menyimpan
            },
            child: const Text(
              'Cancel',
              style: TextStyle(
                color: Color(0xFF3333FF), // Warna biru
                fontSize: 16,
                fontFamily: "Poppins",
              ),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16.0, 20.0, 16.0, 10.0), // Padding disesuaikan
            child: Text(
              'Today',
              style: TextStyle(
                fontSize: 22, // Ukuran font disesuaikan
                fontWeight: FontWeight.bold,
                fontFamily: "PoppinsSemiBold",
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: _waterEntries.length,
              itemBuilder: (context, index) {
                final entry = _waterEntries[index];
                return _buildWaterEntryCard(
                  time: entry['time'] as String,
                  amount: entry['amount'] as int,
                  isChecked: entry['isChecked'] as bool,
                  onChanged: (bool? value) {
                    setState(() {
                      _waterEntries[index]['isChecked'] = value!;
                    });
                  },
                );
              },
            ),
          ),
          // Tombol Save
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              height: 55, // Tinggi tombol Save
              child: ElevatedButton(
                onPressed: () {
                  // Aksi saat tombol Save ditekan
                  print('Tombol Save ditekan!');
                  // Ambil data yang diceklis dan lakukan penyimpanan atau pemrosesan
                  final savedEntries = _waterEntries.where((e) => e['isChecked'] == true).toList();
                  print('Entri yang disimpan: $savedEntries');

                  // Anda bisa meneruskan data ini kembali ke HomeContent
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3333FF), // Latar belakang biru
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15), // Sudut membulat
                  ),
                  elevation: 0, // Tanpa bayangan
                ),
                child: const Text(
                  'Save',
                  style: TextStyle(
                    color: Colors.white, // Teks putih
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: "PoppinsSemiBold",
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      // Bottom Navigation Bar (sesuai dengan HomePage)
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 0,
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: BottomNavigationBar(
          currentIndex: 0, // Set ke indeks Home agar tetap aktif
          onTap: (index) {
            // Anda bisa menangani navigasi di sini jika diperlukan,
            // atau cukup biarkan Home tetap aktif jika ini halaman internal.
            // Untuk navigasi antar tab utama, Anda mungkin ingin pop semua rute
            // lalu push rute ke HomePage dengan indeks yang sesuai.
            if (index == 0) { // Home
              Navigator.popUntil(context, (route) => route.isFirst); // Kembali ke root
            } else if (index == 1) { // Chat
                // Example: push to ChatPage if not already there
                // Navigator.push(context, MaterialPageRoute(builder: (context) => ChatPage()));
            } else if (index == 2) { // Profile
                // Example: push to ProfilePage if not already there
                // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home, size: 30), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.chat_bubble, size: 30), label: ''),
            BottomNavigationBarItem(icon: Icon(Icons.person, size: 30), label: ''),
          ],
          selectedItemColor: const Color.fromARGB(255, 57, 67, 255),
          unselectedItemColor: Colors.grey,
          backgroundColor: Colors.transparent,
          elevation: 0,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  Widget _buildWaterEntryCard({
    required String time,
    required int amount,
    required bool isChecked,
    required ValueChanged<bool?> onChanged,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 0, // Menghilangkan bayangan Card
      color: Colors.white, // Latar belakang putih untuk kartu
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            color: Colors.grey.shade300, // Border abu-abu muda
            width: 1.0,
          ),
        ),
        child: Row(
          children: [
            // Gambar gelas air
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.blue.shade50, // Latar belakang biru muda untuk ikon gelas
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Image.asset(
                'assets/images/water_glass.png', // Ganti dengan path gambar gelas Anda
                width: 40,
                height: 40,
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.local_drink, color: Color(0xFF3333FF), size: 40), // Fallback icon
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    time,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: "PoppinsSemiBold",
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '$amount ml',
                    style: const TextStyle(
                      fontSize: 16,
                      fontFamily: "Poppins",
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            Checkbox(
              value: isChecked,
              onChanged: onChanged,
              activeColor: const Color(0xFF3333FF), // Warna saat di-cek
              checkColor: Colors.white, // Warna tanda centang
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0),
              ),
              side: BorderSide(
                color: Colors.grey.shade400, // Warna border checkbox saat belum di-cek
                width: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}