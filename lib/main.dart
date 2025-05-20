// Import pustaka Flutter utama untuk membangun UI
import 'package:flutter/material.dart';

// Import file warna kustom dari proyek
import 'package:health_tracker/utils/colors.dart';

// Import tampilan onboarding (halaman pertama yang ditampilkan saat app dibuka)
import 'package:health_tracker/views/onboarding.dart';

// Import package untuk native splash screen (layar pembuka saat aplikasi loading)
import 'package:flutter_native_splash/flutter_native_splash.dart';

// Fungsi utama yang dijalankan pertama kali saat aplikasi dimulai
void main() {
  runApp(const MyApp()); // Menjalankan aplikasi dengan widget MyApp sebagai root
}

// Widget utama aplikasi (root widget)
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Menghilangkan banner 'debug' di pojok kanan atas
      title: 'Health Tracker', // Judul aplikasi
      theme: ThemeData(
        // Menetapkan skema warna aplikasi berdasarkan warna utama (seedColor)
        colorScheme: ColorScheme.fromSeed(seedColor: whiteColor),
        useMaterial3: true, // Mengaktifkan fitur desain Material 3
      ),
      home: const OnboardingView(), // Menentukan tampilan awal aplikasi saat dibuka
    );
  }
}
 