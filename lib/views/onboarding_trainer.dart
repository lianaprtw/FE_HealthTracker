import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          // biar ga overflow
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Gambar dengan border hitam (371 x 428)
                  Container(
                    width: 371,
                    height: 428,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(
                        'assets/images/onboarding1.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  const SizedBox(height: 40), // jarak ke judul
                  // Judul
                  Text(
                    'Health Tracker',
                    style: TextStyle(
                      fontFamily: 'PoppinsSemiBold',
                      fontSize: 40,
                      fontWeight: FontWeight.w600, // SemiBold
                      color: Color(0xFF2F3CFF),
                    ),
                  ),

                  const SizedBox(height: 24), // jarak ke deskripsi
                  // Deskripsi
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Guide daily workouts and\nempower a healthier lifestyle.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'PoppinsRegular',
                        fontSize: 16,
                        fontWeight: FontWeight.w400, // Regular
                        color: Colors.black87,
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 64,
                  ), // jarak ke tombol, diganti dari 48
                  // Tombol Login
                  SizedBox(
                    width: 160,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/login');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2F3CFF),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                          fontFamily: 'PoppinsSemiBold',
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
