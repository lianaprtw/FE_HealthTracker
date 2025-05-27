import 'package:flutter/material.dart'; // Mengimpor pustaka UI Flutter
import 'package:health_tracker/utils/colors.dart'; // Mengimpor warna-warna kustom
import 'package:health_tracker/views/home.dart';
import 'package:health_tracker/views/homepage_trainner.dart';
import 'package:health_tracker/views/register.dart'; // Mengimpor halaman Register

// Widget login yang bersifat Stateful karena akan ada perubahan pada UI (misal toggle password)
class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isHide = true; // Variabel untuk menyembunyikan/memperlihatkan password

  // Controller untuk input email dan password
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 120.0), // Jarak dari atas
              child: Column(
                children: [
                  // Teks Judul Halaman
                  Text(
                    'Login Here!',
                    style: TextStyle(
                      fontFamily: "PoppinsSemiBold",
                      fontSize: 30,
                      color: blueColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Teks subjudul
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 32),
                    child: Text(
                      'Welcome back you’ve been missed',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: "PoppinsMedium",
                        fontSize: 16,
                        color: grayColor,
                      ),
                    ),
                  ),
                  // Form input
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Label Email
                        Text(
                          "Email",
                          style: TextStyle(
                            fontFamily: "PoppinsRegular",
                            fontSize: 14,
                            color: grayColor,
                          ),
                        ),
                        const SizedBox(height: 5),
                        // Input Email
                        TextFormField(
                          onChanged: (v) {
                            setState(() {}); // Trigger rebuild saat isi berubah
                          },
                          controller: emailController,
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "PoppinsRegular",
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 13.5, horizontal: 16),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
                            hintText: "Enter your email",
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontFamily: "PoppinsExtraLight",
                              color: grayColor,
                            ),
                            filled: true,
                            fillColor: youngBlueColor,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(color: blueColor, width: 2.0),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Label Password
                        Text(
                          "Password",
                          style: TextStyle(
                            fontFamily: "PoppinsRegular",
                            fontSize: 14,
                            color: grayColor,
                          ),
                        ),
                        const SizedBox(height: 5),
                        // Input Password
                        TextFormField(
                          onChanged: (v) {
                            setState(() {});
                          },
                          controller: passwordController,
                          obscureText: isHide, // Menyembunyikan password saat diketik
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: "PoppinsRegular",
                          ),
                          decoration: InputDecoration(
                            // Tombol icon untuk toggle password visibility
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isHide = !isHide; // Toggle sembunyi/tampilkan password
                                  });
                                },
                                icon: Icon(
                                  isHide
                                      ? Icons.remove_red_eye
                                      : Icons.remove_red_eye_outlined,
                                  size: 18,
                                  color: grayColor,
                                )),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 13.5, horizontal: 16),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(4)),
                                borderSide: const BorderSide(width: 0, style: BorderStyle.none)),
                            hintText: "Enter your password",
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontFamily: "PoppinsExtraLight",
                              color: grayColor,
                            ),
                            filled: true,
                            fillColor: youngBlueColor,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4)),
                              borderSide: BorderSide(color: blueColor, width: 2.0),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 80), // Jarak antara form dan tombol login
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GestureDetector(
                      onTap: () {
                        // Validasi input tidak kosong
                        if (emailController.text != "" &&
                            passwordController.text != "") {
                          // Jika valid, arahkan ke halaman home
                          Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => HomePage()));
                        } else {
                          // Jika tidak valid, tampilkan snackbar
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Please fill all fields"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 13.5),
                        decoration: BoxDecoration(
                          // Mengatur warna tombol tergantung apakah field terisi atau tidak
                          color: emailController.text != "" &&
                                  passwordController.text != ""
                              ? blueColor
                              : blueColor.withOpacity(0.28),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "Sign In",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: whiteColor,
                            fontFamily: "PoppinsSemiBold",
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Komponen Google Sign-In (dikomentari)
                  /*
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          Expanded(child: Divider(color: grayColor, thickness: 1)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              "or",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "PoppinsMedium",
                                color: grayColor,
                              ),
                            ),
                          ),
                          Expanded(child: Divider(color: grayColor, thickness: 1)),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 13.5),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: grayColor,
                          ),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/images/google.png",
                              width: 21,
                              height: 21,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: Text(
                                "Sign In with Google",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: "PoppinsSemiBold",
                                  fontSize: 20,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  */
                ],
              ),
            ),
          ),
          // Navigasi ke halaman register
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Don't have an account?",
                  style: TextStyle(
                    fontFamily: "PoppinsRegular",
                    color: grayColor,
                  ),
                ),
                const SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    // Arahkan ke halaman register
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterView()));
                  },
                  child: Text(
                    "Sign Up Now",
                    style: TextStyle(
                      fontFamily: "PoppinsSemiBold",
                      color: blueColor,
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
