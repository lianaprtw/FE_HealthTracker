import 'package:flutter/material.dart';
import 'package:health_tracker/views/Trainee/home.dart';

class AddTrainerPage extends StatefulWidget {
  const AddTrainerPage({super.key});

  @override
  State<AddTrainerPage> createState() => _AddTrainerPageState();
}

class _AddTrainerPageState extends State<AddTrainerPage> {
  String? selectedTrainer;

  final List<String> trainerList = [
    'mici',
    'michael',
    'Jesica',
    'Bagas',
    'Metthew',
  ];

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF3742FA);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        title: const Text(
          'Add Trainer', // Judul dalam bahasa Indonesia
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
            fontFamily: 'PoppinsSemiBold',
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: primaryColor),
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: selectedTrainer,
                  hint: const Text(
                    'Choose Trainer', // Hint text dalam bahasa Indonesia
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontFamily: 'PoppinsMedium',
                    ),
                  ),
                  isExpanded: true,
                  // Mengubah ikon menjadi panah bawah
                  icon: const Icon(Icons.arrow_drop_down, color: primaryColor),
                  items: trainerList.map((trainer) {
                    return DropdownMenuItem<String>(
                      value: trainer,
                      child: Row(
                        children: [
                          const Icon(Icons.person, color: primaryColor),
                          const SizedBox(width: 12),
                          Text(
                            trainer,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'PoppinsMedium', // Menerapkan gaya font
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedTrainer = value;
                    });
                  },
                  // Mengatur warna dropdown menjadi putih agar sesuai dengan gambar
                  dropdownColor: Colors.white,
                ),
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: selectedTrainer == null
                  ? null
                  : () {
                      // Menangani logika penyimpanan
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Trainer $selectedTrainer Selected!'), // Pesan SnackBar dalam bahasa Indonesia
                        ),
                      );
                      // Navigasi ke file/halaman lain (contoh: HomePage)
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                        ),
                      );
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    selectedTrainer == null ? Colors.grey : primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                minimumSize: const Size.fromHeight(50),
              ),
              child: const Text(
                'Save', // Teks tombol dalam bahasa Indonesia
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: 'PoppinsBold', 
                  color: Colors.white),
              ),
            ),
          ],
        ),
      ),
      // Menambahkan bilah navigasi bawah sederhana untuk meniru gambar
      // bottomNavigationBar: BottomAppBar(
      //   color: Colors.white,
      //   child: Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceAround,
      //     children: [
      //       IconButton(
      //         icon: Icon(Icons.home, color: primaryColor),
      //         onPressed: () {
      //           // Tangani penekanan tombol home
      //         },
      //       ),
      //       IconButton(
      //         icon: Icon(Icons.chat_bubble, color: primaryColor),
      //         onPressed: () {
      //           // Tangani penekanan tombol chat
      //         },
      //       ),
      //       IconButton(
      //         icon: Icon(Icons.person, color: Colors.grey), // Abu-abu untuk yang terpilih
      //         onPressed: () {
      //           // Tangani penekanan tombol profil
      //         },
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
