import 'package:flutter/material.dart';
// import 'package:health_tracker/utils/colors.dart';
import 'package:health_tracker/views/Trainee/home.dart';
import 'package:health_tracker/views/which_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Health Tracker',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF6F6F6),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFF6F6F6),
          brightness: Brightness.light,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.white, // warna latar belakang bottom bar
          selectedItemColor: Color(0xFF3742FA), // warna ikon/teks aktif
          unselectedItemColor: Colors.grey, // warna ikon/teks tidak aktif
          elevation: 10, // opsional: menambahkan bayangan
        ),
      ),
      home: WhichScreen(),
      routes: {'homePage': (context) => const HomePage()},
    );
  }
}
