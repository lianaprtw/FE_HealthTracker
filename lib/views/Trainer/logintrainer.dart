import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:health_tracker/views/Trainer/homepage_trainner.dart';
import 'package:health_tracker/views/Trainer/registertrainer.dart';
import 'package:health_tracker/views/Trainee/ForgetPass.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscurePassword = true;

  // Tambahkan controller untuk input
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Fungsi validasi untuk cek field sudah terisi atau belum
  bool get isFormValid {
    return emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }

  @override
  void initState() {
    super.initState();
    // Listener untuk update tombol secara real time
    emailController.addListener(() {
      setState(() {});
    });
    passwordController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 26),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  const Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      'Login Here!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w700,
                        fontSize: 28,
                        height: 1.2,
                        color: Color(0xFF4A4AFF),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Welcome back you’ve been\nmissed",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 14,
                        height: 1.3,
                        color: Color(0xFF8C8C8C),
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),

                  // Email Field
                  SizedBox(
                    width: 358,
                    height: 64,
                    child: TextField(
                      controller: emailController,
                      onChanged: (value) => setState(() {}),
                      decoration: InputDecoration(
                        hintText: "Enter your email",
                        filled: true,
                        fillColor: const Color(0xFFF4F4FF),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Password Field
                  SizedBox(
                    width: 358,
                    height: 64,
                    child: TextField(
                      controller: passwordController,
                      obscureText: _obscurePassword,
                      onChanged: (value) => setState(() {}),
                      decoration: InputDecoration(
                        hintText: "Enter your password",
                        filled: true,
                        fillColor: const Color(0xFFF4F4FF),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) =>
                                    const ForgetPasswordScreen(), // Ganti dengan nama file halaman forget password
                          ),
                        );
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: Text(
                          "Forget Your Password?",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 13,
                            color: Color(0xFF4A4AFF),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Sign In Button
                  SizedBox(
                    width: 357,
                    height: 60,
                    child: ElevatedButton(
                      onPressed:
                          isFormValid
                              ? () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => const HomepageTrainner(),
                                  ),
                                );
                              }
                              : null, // Jika form kosong, tombol disable
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            isFormValid
                                ? const Color(0xFF3742FA)
                                : const Color(0xFF3742FA).withOpacity(0.3),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 6,
                        shadowColor: Colors.blueAccent,
                      ),
                      child: const Text(
                        'Sign in',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Tombol Sign Up untuk navigasi ke RegisterPage
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account? ",
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Color(0xFF8C8C8C),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterPage(),
                            ),
                          );
                        },
                        child: const Text(
                          "Sign Up",
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF4A4AFF),
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ],
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
