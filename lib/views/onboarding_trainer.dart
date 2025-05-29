import 'package:flutter/material.dart';
import 'package:health_tracker/views/logintrainer.dart';
import 'package:health_tracker/views/registertrainer.dart';

// Warna default jika belum didefinisikan
const Color grayColor = Colors.grey;
const Color blueColor = Color(0xFF2F3CFF);

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 32.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // Gambar Onboarding
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

                  const SizedBox(height: 40),

                  // Judul
                  const Text(
                    'Health Tracker',
                    style: TextStyle(
                      fontFamily: 'PoppinsSemiBold',
                      fontSize: 40,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF2F3CFF),
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Deskripsi
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    child: Text(
                      'Guide daily workouts and\nempower a healthier lifestyle.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'PoppinsRegular',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black87,
                      ),
                    ),
                  ),

                  const SizedBox(height: 48),

                  // Tombol Login dan Sign Up dalam satu baris
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Tombol Login
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black87,
                              shadowColor: Colors.grey.shade400,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: const BorderSide(color: Colors.black12),
                              ),
                              overlayColor: MaterialStateProperty.resolveWith<
                                Color?
                              >((Set<MaterialState> states) {
                                if (states.contains(MaterialState.pressed)) {
                                  return Colors.grey[300]; // Saat ditekan
                                }
                                return null;
                              }),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 14),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  fontFamily: 'PoppinsSemiBold',
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 20),

                        // Tombol Sign Up
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const RegisterPage(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: blueColor,
                              shadowColor: Colors.grey.shade400,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: const BorderSide(color: blueColor),
                              ),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(vertical: 14),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontFamily: 'PoppinsSemiBold',
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
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
