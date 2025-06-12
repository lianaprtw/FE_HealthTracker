import 'package:flutter/material.dart';

void main() => runApp(WaterTrackerApp());

class WaterTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WaterTrackerPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WaterTrackerPage extends StatefulWidget {
  @override
  _WaterTrackerPageState createState() => _WaterTrackerPageState();
}

class _WaterTrackerPageState extends State<WaterTrackerPage> {
  // Definisikan warna biru yang konsisten untuk aplikasi, serupa dengan gambar.
  final Color appBlueColor = const Color(0xFF3742FA);

  double totalWater = 200; // Nilai awal, misalnya 200ml sudah dikonsumsi
  double selectedAmount = 500; // Jumlah yang dipilih secara default untuk slider pop-up

  void _showDrinkPopup() {
    print("Membuka popup minum..."); // Debugging: Konfirmasi pemanggilan fungsi popup
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          // Bentuk untuk dialog itu sendiri
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Center(
            child: Text(
              "Berapa Banyak yang Anda Minum?", // Judul popup
              style: TextStyle(
                fontWeight: FontWeight.bold, // Buat judul tebal
                color: appBlueColor, // Gunakan warna biru aplikasi untuk judul
              ),
            ),
          ),
          content: StatefulBuilder( // Gunakan StatefulBuilder untuk memperbarui nilai slider di dalam AlertDialog
            builder: (BuildContext context, StateSetter setStatePopup) {
              return Column(
                mainAxisSize: MainAxisSize.min, // Buat kolom hanya mengambil ruang yang diperlukan
                children: [
                  Text(
                    // Tampilkan jumlah yang dipilih dengan garis bawah dan teks tebal
                    "${selectedAmount.toInt()} ml",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline, // Tambahkan garis bawah seperti pada gambar
                      color: appBlueColor, // Gunakan warna biru aplikasi
                    ),
                  ),
                  SizedBox(height: 20), // Spasi di bawah teks jumlah
                  Slider(
                    value: selectedAmount,
                    min: 0,
                    max: 2000,
                    divisions: 20, // Bagi menjadi 20 segmen untuk langkah yang lebih halus (masing-masing 100ml)
                    label: "${selectedAmount.toInt()} ml", // Label yang ditampilkan saat menyeret
                    activeColor: appBlueColor, // Warna bagian aktif slider
                    inactiveColor: appBlueColor.withOpacity(0.3), // Warna bagian tidak aktif
                    thumbColor: appBlueColor, // Warna thumb slider
                    onChanged: (value) {
                      setStatePopup(() { // Gunakan setStatePopup untuk memperbarui status dialog
                        selectedAmount = value;
                        print("Nilai slider berubah menjadi: ${selectedAmount.toInt()} ml"); // Debugging: Konfirmasi perubahan slider
                      });
                    },
                  ),
                  SizedBox(height: 30), // Spasi sebelum tombol
                  ElevatedButton(
                    onPressed: () {
                      print("Tombol 'Tambah' ditekan."); // Debugging: Konfirmasi tombol ditekan
                      setState(() { // Perbarui status halaman utama
                        totalWater += selectedAmount;
                        print("Total air setelah penambahan: ${totalWater.toInt()} ml"); // Debugging: Konfirmasi total air
                      });
                      Navigator.of(context).pop(); // Tutup popup
                      print("Popup ditutup."); // Debugging: Konfirmasi popup ditutup
                    },
                    child: Text(
                      "Tambah", // Teks tombol "Add"
                      style: TextStyle(fontSize: 18), // Teks sedikit lebih besar untuk tombol
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: appBlueColor, // Gunakan warna biru aplikasi untuk tombol
                      foregroundColor: Colors.white, // Teks putih pada tombol biru
                      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 15), // Padding lebih besar
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12), // Sudut membulat untuk tombol
                      ),
                      elevation: 5, // Tambahkan bayangan tipis
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Pelacak Air", // Judul AppBar
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: appBlueColor, // Warna AppBar agar sesuai tema
        elevation: 0, // Hapus bayangan di bawah AppBar
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Tampilkan progres air saat ini
            Text(
              "${totalWater.toInt()}/2000 ml",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: appBlueColor),
            ),
            SizedBox(height: 50), // Spasi yang diperbesar
            // Tombol untuk membuka popup minum
            ElevatedButton(
              onPressed: _showDrinkPopup,
              child: Text(
                "Minum", // Teks tombol "Drink"
                style: TextStyle(fontSize: 20),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: appBlueColor, // Warna tombol agar sesuai tema
                foregroundColor: Colors.white, // Teks putih pada tombol
                padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20), // Padding lebih besar untuk tombol yang menonjol
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Sudut lebih membulat
                ),
                elevation: 8, // Bayangan lebih menonjol
              ),
            ),
          ],
        ),
      ),
    );
  }
}
