import 'package:flutter/material.dart';
import 'package:health_tracker/views/Trainee/beratscreen.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GenderSelectionScreen(),
    ),
  );
}

class GenderSelectionScreen extends StatefulWidget {
  const GenderSelectionScreen({super.key});

  @override
  State<GenderSelectionScreen> createState() => _GenderSelectionScreenState();
}

class _GenderSelectionScreenState extends State<GenderSelectionScreen> {
  String? selectedGender;

  // Widget pembantu ini membangun kartu pilihan gender individual.
  Widget _buildGenderCard(String gender, IconData iconData) {
    final isSelected = selectedGender == gender;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedGender = gender;
        });
      },
      child: Container(
        width: 150,
        height: 160,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(2, 2),
            ),
          ],
          // Terapkan border saat kartu dipilih.
          // Warna diubah agar sesuai dengan border ungu di desain Anda.
          border: isSelected
              ? Border.all(color: const Color(0xFF7A28F2), width: 2)
              : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Warna ikon diatur secara eksplisit ke ungu dari desain Anda.
            Icon(iconData, size: 55, color: const Color(0xFF7A28F2)),
            const SizedBox(height: 10),
            Text(
              gender,
              style: const TextStyle(
                fontFamily: "PoppinsBold",
                fontSize: 18, // Ukuran font disesuaikan dengan desain Anda.
                fontWeight: FontWeight.normal,
                color: Colors.black, // Pastikan teks berwarna hitam untuk kontras.
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9), // Warna latar belakang dari desain Anda.
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gaya teks judul disesuaikan dengan desain Anda.
              const Text(
                'Choose Your Gender',
                style: TextStyle(
                  fontSize: 38, // Ukuran font sedikit diperbesar agar sesuai dengan penekanan desain.
                  fontFamily: "PoppinsBold",
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3333FF), // Warna biru yang khas dari desain Anda.
                ),
              ),
              const SizedBox(height: 8),
              // Gaya teks subjudul.
              const Text(
                'for calorie calculation',
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: "PoppinsMedium",
                  fontSize: 16, // Ukuran font sedikit diperbesar.
                ),
              ),
              const SizedBox(height: 180), // Jarak yang diperbesar sesuai desain.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Untuk ikon wanita, gambar di desain Anda menunjukkan simbol wanita yang khas.
                  // Karena Icons.female Flutter adalah ikon orang yang lebih umum,
                  // kita bisa menggunakan ikon kustom atau memastikan yang sekarang dapat diterima.
                  // Untuk kecocokan yang lebih dekat dengan desain, Anda mungkin mempertimbangkan untuk menggunakan aset SVG
                  // atau ikon font kustom jika tersedia. Untuk saat ini, kita akan tetap menggunakan `Icons.female`
                  // dan `Icons.male` karena umum. Jika simbol yang tepat sangat penting,
                  // Anda perlu mengimpornya sebagai aset.
                  _buildGenderCard('Female', Icons.female), // Menggunakan ikon wanita bawaan Flutter.
                  _buildGenderCard('Male', Icons.male),     // Menggunakan ikon pria bawaan Flutter.
                ],
              ),
              const Spacer(), // Mendorong konten ke atas dan tombol ke bawah.
              SizedBox(
                width: double.infinity, // Memastikan tombol menempati seluruh lebar yang tersedia.
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigasi ke WeightScreen setelah pemilihan gender.
                    // Ini menggunakan `pushReplacement` untuk mencegah kembali ke pemilihan gender.
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WeightScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3742FA), // Warna latar belakang tombol dari desain Anda.
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Sudut membulat untuk tombol.
                    ),
                    elevation: 6, // Menambahkan bayangan halus.
                    shadowColor: Colors.blueAccent, // Warna bayangan.
                  ),
                  child: const Text(
                    'Next', // Teks tombol dalam bahasa Indonesia.
                    style: TextStyle(
                      fontFamily: 'PoppinsBold',
                      fontWeight: FontWeight.w600, // Berat font untuk teks tombol.
                      fontSize: 18,
                      color: Colors.white, // Warna teks untuk tombol.
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
