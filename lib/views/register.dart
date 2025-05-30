// Import library Flutter dan file warna kustom
import 'package:flutter/material.dart';
import 'package:health_tracker/utils/colors.dart';
import 'package:health_tracker/views/login.dart';

// Widget utama untuk halaman registrasi
class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  // Variabel boolean untuk menyembunyikan/menampilkan password
  bool isHide = true;
  bool isHideConfirm = true;

  // Menyimpan status validasi form
  bool isFormValid = false;

  // Controller untuk input field
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Menambahkan listener untuk mengupdate validasi form saat nilai input berubah
    nameController.addListener(_updateFormState);
    emailController.addListener(_updateFormState);
    passwordController.addListener(_updateFormState);
    confirmPasswordController.addListener(_updateFormState);
  }

  @override
  void dispose() {
    // Membersihkan controller saat widget dihapus dari widget tree
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // Method untuk memperbarui status validasi form
  void _updateFormState() {
    final valid = _validateFields();
    if (valid != isFormValid) {
      setState(() {
        isFormValid = valid;
      });
    }
  }

  // Fungsi untuk memeriksa apakah semua field sudah terisi dan password cocok
  bool _validateFields() {
    return nameController.text.isNotEmpty &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        passwordController.text == confirmPasswordController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Column(
                children: [
                  // Judul halaman
                  Text(
                    'Create an Account',
                    style: TextStyle(
                      fontFamily: "PoppinsSemiBold",
                      fontSize: 28,
                      color: blueColor,
                    ),
                  ),
                  const SizedBox(height: 10),
                  // Subjudul / deskripsi
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: Text(
                      'Welcome! Let’s get you started on your\na journey to better health',
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
                        _buildTextField("Full Name", nameController, false),
                        _buildTextField("Email", emailController, false),
                        _buildTextField("Password", passwordController, true),
                        _buildTextField("Confirm Password", confirmPasswordController, true),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Tombol Sign Up
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: GestureDetector(
                      onTap: () {
                        if (_validateFields()) {
                          // Jika valid, navigasi ke halaman beranda
                          Navigator.push(
                            context,
                             MaterialPageRoute(builder: (context) => LoginView()),
                             );
                        } else {
                          // Jika tidak valid, tampilkan pesan kesalahan
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Please fill all fields correctly"),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(vertical: 13.5),
                        decoration: BoxDecoration(
                          // Tombol aktif jika form valid
                          color: isFormValid ? blueColor : blueColor.withOpacity(0.28),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          "Sign Up",
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
                  const Spacer(),
                  // Navigasi ke halaman login jika sudah punya akun
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(
                            fontFamily: "PoppinsRegular",
                            color: grayColor,
                          ),
                        ),
                        const SizedBox(width: 5),
                        GestureDetector(
                          onTap: () {
                            // Kembali ke halaman login
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Sign In",
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
            ),
          ),
        ],
      ),
    );
  }

  // Widget reusable untuk membuat field input
  Widget _buildTextField(String label, TextEditingController controller, bool isPassword) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Label field
          Text(
            label,
            style: TextStyle(
              fontFamily: "PoppinsMedium",
              fontSize: 14,
              color: darkGrayColor,
            ),
          ),
          const SizedBox(height: 5),
          // TextFormField untuk input user
          TextFormField(
            onChanged: (v) {
              setState(() {});
            },
            controller: controller,
            // Menentukan apakah field ini password dan perlu disembunyikan
            obscureText: isPassword ? (label == "Confirm Password" ? isHideConfirm : isHide) : false,
            style: TextStyle(
              fontSize: 14,
              fontFamily: "PoppinsRegular",
            ),
            decoration: InputDecoration(
              // Tombol untuk toggle show/hide password
              suffixIcon: isPassword
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          if (label == "Confirm Password") {
                            isHideConfirm = !isHideConfirm;
                          } else {
                            isHide = !isHide;
                          }
                        });
                      },
                      icon: Icon(
                        (label == "Confirm Password" ? isHideConfirm : isHide)
                            ? Icons.remove_red_eye
                            : Icons.remove_red_eye_outlined,
                        size: 18,
                        color: grayColor,
                      ),
                    )
                  : null,
              contentPadding: const EdgeInsets.symmetric(vertical: 13.5, horizontal: 16),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(4)),
                borderSide: BorderSide.none,
              ),
              hintText: "Enter your $label",
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
    );
  }
}
