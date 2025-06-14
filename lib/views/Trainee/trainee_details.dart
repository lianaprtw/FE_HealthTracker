import 'package:flutter/material.dart';
import 'package:health_tracker/views/Trainee/chat_screen.dart'; // Pastikan path ini benar untuk halaman chat Anda

// Ubah dari StatelessWidget menjadi StatefulWidget
class TraineeDetailScreen extends StatefulWidget {
  final String name;

  const TraineeDetailScreen({super.key, required this.name});

  @override
  State<TraineeDetailScreen> createState() => _TraineeDetailScreenState();
}

class _TraineeDetailScreenState extends State<TraineeDetailScreen> {
  // Deklarasikan TextEditingController
  late TextEditingController _trainerNotesController;

  // Variabel untuk menyimpan catatan saat ini (nilai awal bisa dari data trainee)
  // Untuk demo, kita pakai nilai statis awal.
  String _currentTrainerNotes =
      "Hari ini ${'Bambang' == 'Bambang' ? 'Bambang' : 'Trainee ini'} mengalami peningkatan endurance. Disarankan tetap hidrasi dan tidur cukup.";

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller dengan catatan awal
    // Anda bisa mengganti ini dengan catatan yang diambil dari database untuk trainee tertentu
    _trainerNotesController = TextEditingController(text: _currentTrainerNotes);

    // Di sini Anda bisa menambahkan logika untuk memuat catatan sebenarnya
    // berdasarkan widget.name (nama trainee) dari database Anda.
    // Contoh: _loadTrainerNotes(widget.name);
  }

  @override
  void dispose() {
    // Penting: Buang controller saat widget tidak lagi digunakan untuk menghindari memory leak
    _trainerNotesController.dispose();
    super.dispose();
  }

  // Fungsi untuk mensimulasikan penyimpanan catatan
  void _saveTrainerNotes() {
    setState(() {
      _currentTrainerNotes = _trainerNotesController.text;
    });
    // TODO: IMPLEMENTASI NYATA: Kirim _currentTrainerNotes ini ke database/API Anda
    //       Misalnya: ApiService().saveTrainerNotes(widget.name, _currentTrainerNotes);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Catatan untuk ${widget.name} disimpan!'),
        duration: const Duration(seconds: 2),
      ),
    );
    FocusScope.of(context).unfocus(); // Menutup keyboard setelah simpan
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profil ${widget.name}"), // Gunakan widget.name
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.message),
            onPressed: () {
              // Navigasi ke halaman chat
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(recipientName: widget.name),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profil & tombol kirim pesan
            Row(
              children: [
                const CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.orange,
                  child: Icon(Icons.person, color: Colors.white, size: 32),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.name,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ), // Gunakan widget.name
                      const Text(
                        'Trainee',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Navigasi ke halaman chat
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => ChatScreen(recipientName: widget.name),
                      ),
                    );
                  },
                  child: const Text("Kirim Pesan"),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Progress Harian (Tetap sama)
            _buildInfoCard(
              Icons.directions_walk,
              "Langkah hari ini",
              "5.200 / 10.000",
            ),
            _buildInfoCard(Icons.local_drink, "Air minum", "5 dari 8 gelas"),
            _buildInfoCard(Icons.directions_run, "Aktivitas", "Lari - 3 km"),
            _buildInfoCard(
              Icons.local_fire_department,
              "Kalori terbakar",
              "280 kkal",
            ),

            const SizedBox(height: 24),
            const Text(
              "Jadwal Latihan Hari Ini",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            _buildScheduleItem("07.00", "Jogging (5 km)"),
            _buildScheduleItem("10.00", "Stretching"),
            _buildScheduleItem("14.00", "Latihan Beban"),

            const SizedBox(height: 24),
            const Text(
              "Catatan Trainer",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            // === BAGIAN YANG DIUBAH UNTUK EDIT CATATAN ===
            TextField(
              controller: _trainerNotesController,
              maxLines: 5, // Izinkan beberapa baris teks
              keyboardType:
                  TextInputType
                      .multiline, // Mengatur keyboard agar ada tombol "Enter"
              decoration: InputDecoration(
                hintText: "Tulis catatan trainer di sini...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none, // Menghilangkan border default
                ),
                filled: true,
                fillColor: Colors.grey[200], // Warna background field
                contentPadding: const EdgeInsets.all(16.0),
              ),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton.icon(
                onPressed: _saveTrainerNotes, // Panggil fungsi simpan
                icon: const Icon(Icons.save),
                label: const Text("Simpan Catatan"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Warna tombol simpan
                  foregroundColor: Colors.white, // Warna teks tombol
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            // ==============================================
          ],
        ),
      ),
    );
  }

  // Widget helper functions tetap sama
  Widget _buildInfoCard(IconData icon, String title, String value) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: Icon(icon, color: Colors.blue),
        title: Text(title),
        subtitle: Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildScheduleItem(String time, String activity) {
    return ListTile(
      leading: const Icon(Icons.access_time, color: Colors.grey),
      title: Text("$time  -  $activity"),
    );
  }
}
