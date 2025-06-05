import 'package:flutter/material.dart'; // Import komponen UI Material Design
import 'package:health_tracker/utils/colors.dart'; // Import file warna custom
import 'package:health_tracker/views/login.dart'; // Import halaman login
import 'package:health_tracker/views/register.dart'; // Import halaman register

// Widget onboarding yang bisa berubah state (StatefulWidget)
class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final PageController pageController =
      PageController(); // Controller untuk navigasi page (jika multi-page)
  int currentPage = 0; // Menyimpan indeks halaman saat ini

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Struktur dasar tampilan
      body: Column(
        // Menyusun elemen secara vertikal
        children: [
          Image.asset("assets/images/onboarding1.png"), // Gambar onboarding
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0), // Padding luar
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0), // Jarak bawah
                  child: const Text(
                    "Health Tracker", // Judul utama
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF3742FA),
                      fontFamily: "PoppinsSemiBold",
                      fontSize: 40,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                  ), // Padding kiri kanan
                  child: Text(
                    "Create daily targets and achieve\na balanced lifestyle", // Deskripsi onboarding
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF000000),
                      fontFamily: "PoppinsRegular",
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Spacer(), // Mengisi ruang kosong antara konten dan tombol
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 32,
            ), // Padding tombol
            child: Row(
              mainAxisAlignment:
                  MainAxisAlignment
                      .spaceBetween, // Menyusun tombol sejajar dan terpisah
              children: [
                Expanded(
                  // Tombol Login mengisi setengah layar
                  child: GestureDetector(
                    onTap: () {
                      // Navigasi ke halaman Login saat tombol ditekan
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginView()),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 13.5,
                      ), // Tinggi tombol
                      decoration: BoxDecoration(
                        color: blueColor, // Warna background tombol
                        borderRadius: BorderRadius.circular(
                          4,
                        ), // Sudut tombol melengkung
                      ),
                      child: Text(
                        "Login", // Teks tombol
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: whiteColor, // Warna teks
                          fontFamily: "PoppinsSemiBold",
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16), // Spasi antara tombol Login dan Register
                Expanded(
                  // Tombol Register mengisi setengah layar
                  child: GestureDetector(
                    onTap: () {
                      // Navigasi ke halaman Register saat tombol ditekan
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterView()),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 13.5,
                      ), // Tinggi tombol
                      decoration: BoxDecoration(
                        color: whiteColor, // Warna background putih
                        borderRadius: BorderRadius.circular(
                          4,
                        ), // Sudut melengkung
                      ),
                      child: Text(
                        "Register", // Teks tombol
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: blueColor, // Warna teks biru
                          fontFamily: "PoppinsSemiBold",
                          fontSize: 20,
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
    );
  }
}
