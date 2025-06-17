import 'package:flutter/material.dart';
import 'package:health_tracker/views/Trainer/aboutTrainer.dart';
import 'package:health_tracker/views/Trainer/logintrainer.dart';
import 'package:health_tracker/views/Trainer/update_profile.dart';

// Import CustomBottomNavigationBar Anda jika ada di file terpisah
// import 'package:health_tracker/widgets/custom_bottom_nav_bar.dart'; // Sesuaikan path ini

class ProfileTrainner extends StatefulWidget {
  const ProfileTrainner({super.key});

  @override
  State<ProfileTrainner> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfileTrainner> {
  // Fungsi baru untuk menampilkan pilihan bahasa
  void _showLanguageSelectionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor:
          Colors.transparent, // Untuk sudut membulat di latar belakang putih
      builder: (BuildContext bc) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0),
            ),
          ),
          child: Wrap(
            // Wrap untuk menyusun pilihan bahasa
            children: <Widget>[
              // Judul opsional jika diperlukan
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Select Language',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: "PoppinsSemiBold",
                  ),
                ),
              ),
              ListTile(
                title: const Text(
                  'English',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Poppins",
                    color: Colors.black, // Warna teks English
                  ),
                ),
                onTap: () {
                  print('English selected');
                  // Logika untuk mengubah bahasa ke English
                  Navigator.pop(context); // Tutup bottom sheet
                },
              ),
              const Divider(height: 1, color: Colors.grey), // Garis pemisah
              ListTile(
                title: const Text(
                  'Indonesia',
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: "Poppins",
                    color: Color(
                      0xFF3333FF,
                    ), // Warna biru untuk Indonesia, sesuai desain
                  ),
                ),
                onTap: () {
                  print('Indonesia selected');
                  // Logika untuk mengubah bahasa ke Indonesia
                  Navigator.pop(context); // Tutup bottom sheet
                },
              ),
              const SizedBox(height: 20), // Spasi di bagian bawah
            ],
          ),
        );
      },
    );
  }

  // Dialog untuk Sign Out (menggantikan alert())
  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            'Sign Out',
            style: TextStyle(
              fontFamily: "PoppinsSemiBold",
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Are you sure you want to sign out?',
            style: TextStyle(fontFamily: "Poppins"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Tutup dialog
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.grey, fontFamily: "Poppins"),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
                // Tambahkan logika sign out Anda di sini
                print('User Signed Out!');
                // Biasanya navigasi ke halaman login:
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ), // Ganti dengan halaman login Anda
                  (Route<dynamic> route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF3333), // Warna merah
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Sign Out',
                style: TextStyle(color: Colors.white, fontFamily: "Poppins"),
              ),
            ),
          ],
        );
      },
    );
  }

  // Dialog untuk Delete Account (menggantikan alert())
  void _showDeleteAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          title: const Text(
            'Delete Account',
            style: TextStyle(
              fontFamily: "PoppinsSemiBold",
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'Are you sure you want to delete your account? This action cannot be undone.',
            style: TextStyle(fontFamily: "Poppins"),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Tutup dialog
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.grey, fontFamily: "Poppins"),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Tutup dialog
                // Tambahkan logika delete account Anda di sini
                print('User Account Deleted!');
                // Biasanya navigasi ke halaman login atau halaman onboarding:
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginPage(),
                  ), // Ganti dengan halaman login Anda
                  (Route<dynamic> route) => false,
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFF3333), // Warna merah
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Delete',
                style: TextStyle(color: Colors.white, fontFamily: "Poppins"),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF3333FF); // Warna biru utama
    const Color redColor = Color(
      0xFFFF3333,
    ); // Warna merah untuk tombol hapus/sign out

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading:
            false, // Mencegah Flutter menambahkan tombol kembali secara otomatis
        backgroundColor: const Color(0xFFF7F7F7), // Background abu-abu muda
        elevation: 0, // Tanpa bayangan
        toolbarHeight: 80.0, // Sesuaikan tinggi sesuai desain
        title: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 0.0,
          ), // Tanpa padding horizontal di sini
          child: Row(
            mainAxisAlignment:
                MainAxisAlignment.spaceBetween, // Mendistribusikan ruang
            children: [
              // Teks "Health Tracker" di kiri
              const Text(
                'Health Tracker',
                style: TextStyle(
                  color: Color(0xFF3333FF), // Warna biru dari desain
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: "PoppinsSemiBold", // Asumsi gaya ini
                ),
              ),
              // Ikon bel notifikasi di kanan
              IconButton(
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.black,
                  size: 30,
                ),
                onPressed: () {
                  // Tangani saat ikon notifikasi ditekan
                  print('Ikon notifikasi ditekan di halaman Trainer Profile!');
                },
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          // Menggunakan SingleChildScrollView agar konten bisa digulir
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 24), // Spacer di atas avatar
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 140,
                      height: 131,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: primaryColor, width: 4.0),
                      ),
                      child: const CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/images/woman meditates under a rainbow.png',
                        ),
                        backgroundColor: Colors.white,
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const TrainerProfileEditPage(), // Ganti dengan halaman target kamu
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Enno Lerebulan',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 18, // Ukuran font disesuaikan
                  fontFamily: 'PoppinsSemiBold',
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 32), // Spacer sebelum opsi profil
              ProfileOption(
                icon: Icons.language,
                title: 'Language',
                iconColor: primaryColor, // Warna ikon biru
                borderColor: Colors.grey.shade300, // Border abu-abu muda
                arrowColor: Colors.black,
                onTap: () {
                  // Panggil fungsi untuk menampilkan pilihan bahasa
                  _showLanguageSelectionSheet(context);
                },
              ),
              const SizedBox(height: 16),
              ProfileOption(
                icon: Icons.info_outline,
                title: 'About Us',
                iconColor: primaryColor,
                borderColor: Colors.grey.shade300,
                arrowColor: Colors.black,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const AboutPageTrainer()),
                  );
                },
              ),
              // BAGIAN "HELP" TELAH DIHAPUS SESUAI PERMINTAAN
              // const SizedBox(height: 16),
              // ProfileOption(
              //   icon: Icons.help_outline,
              //   title: 'Help',
              //   iconColor: primaryColor,
              //   borderColor: Colors.grey.shade300,
              //   arrowColor: Colors.black,
              //   onTap: () {
              //     print('Help option tapped');
              //     // Navigasi ke halaman Help
              //   },
              // ),
              const SizedBox(
                height: 32,
              ), // Spacer sebelum tombol Delete Account
              SizedBox(
                width: double.infinity,
                height: 55, // Tinggi tombol
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Logika untuk menampilkan dialog konfirmasi delete account
                    _showDeleteAccountDialog(context);
                  },
                  icon: const Icon(
                    Icons.delete_outline, // Ikon tempat sampah
                    color: redColor, // Warna ikon merah
                    size: 24,
                  ),
                  label: const Text(
                    'Delete account',
                    style: TextStyle(
                      color: redColor, // Warna teks merah
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: "PoppinsSemiBold",
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white, // Latar belakang putih
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // Sudut membulat
                      side: const BorderSide(
                        color: redColor,
                        width: 1.5,
                      ), // Border merah
                    ),
                    elevation: 0, // Tanpa bayangan
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(height: 16), // Spacer antara tombol
              SizedBox(
                width: double.infinity,
                height: 55, // Tinggi tombol
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Logika untuk menampilkan dialog konfirmasi sign out
                    _showSignOutDialog(context);
                  },
                  icon: const Icon(
                    Icons.logout_outlined, // Ikon keluar
                    color: Colors.white, // Warna ikon putih
                    size: 24,
                  ),
                  label: const Text(
                    'Sign Out',
                    style: TextStyle(
                      color: Colors.white, // Warna teks putih
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      fontFamily: "PoppinsSemiBold",
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: redColor, // Latar belakang merah
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // Sudut membulat
                    ),
                    elevation: 0, // Tanpa bayangan
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              const SizedBox(height: 24), // Spacer di bagian bawah
            ],
          ),
        ),
      ),
    );
  }
}

// Widget ProfileOption yang telah diubah
class ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color iconColor;
  final Color borderColor;
  final Color arrowColor;
  final VoidCallback? onTap; // Menambahkan callback onTap

  const ProfileOption({
    super.key,
    required this.icon,
    required this.title,
    required this.iconColor,
    required this.borderColor,
    required this.arrowColor,
    this.onTap, // onTap bisa null jika tidak ada aksi
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Menggunakan GestureDetector untuk membuat seluruh area bisa diklik
      onTap: onTap,
      child: Container(
        height: 55, // Menyesuaikan tinggi
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white, // Latar belakang putih
          border: Border.all(color: borderColor, width: 1.5),
          borderRadius: BorderRadius.circular(15), // Sudut membulat
        ),
        child: Row(
          children: [
            Icon(icon, size: 24, color: iconColor), // Ukuran ikon disesuaikan
            const SizedBox(width: 16), // Spasi disesuaikan
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'PoppinsSemiBold',
                  color: Colors.black,
                ),
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: arrowColor,
              size: 24,
            ), // Ukuran ikon panah
          ],
        ),
      ),
    );
  }
}