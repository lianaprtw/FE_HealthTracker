// Import pustaka Flutter utama untuk membangun UI
import 'package:flutter/material.dart';
// Import file warna kustom dari proyek
import 'package:health_tracker/utils/colors.dart';
// Import halaman kalender
import 'package:health_tracker/views/calender.dart';
// Import tampilan home page
import 'package:health_tracker/views/home.dart';
// Import tampilan yang menentukan screen mana yang dibuka pertama kali
import 'package:health_tracker/views/which_screen.dart';

// import 'package:http/http.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hilangkan banner 'debug'
      title: 'Health Tracker', // Judul aplikasi
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: whiteColor),
        useMaterial3: true,
      ),
      home: WhichScreen(), // Halaman pertama yang ditampilkan
      routes: {
        'homePage': (context) => const HomePage(),
        'calendarPage':
            (context) => const CalendarPage(
              username: 'guest', // Placeholder data (nanti bisa diubah dinamis)
              age: 0, // Placeholder data
            ),
      },
    );
  }
}
