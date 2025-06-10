import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Definisi warna kustom yang digunakan dalam aplikasi.
const Color blueColor = Color(0xFF3D5AFE); // Warna biru utama untuk elemen UI.
const Color darkBlueColor = Color(
  0xFF152B78,
); // Warna biru tua untuk teks dan ikon.
const Color lightBlueColor = Color(
  0xFFE8EDFF,
); // Warna biru muda untuk latar belakang input.

/// [DailyActivityScreen] adalah StatefulWidget yang menampilkan dan mengelola daftar aktivitas harian.
/// Ini memungkinkan pengguna untuk melihat, menambah, mengedit, dan menghapus aktivitas.
class DailyActivityScreen extends StatefulWidget {
  const DailyActivityScreen({super.key});

  @override
  State<DailyActivityScreen> createState() => _DailyActivityScreenState();
}

/// State untuk [DailyActivityScreen].
/// Mengelola daftar aktivitas dan logika untuk interaksi pengguna.
class _DailyActivityScreenState extends State<DailyActivityScreen> {
  /// Daftar aktivitas harian yang akan ditampilkan.
  /// Diinisialisasi dengan beberapa data contoh.
  final List<Activity> activities = [
    Activity(
      date: 'Sunday, 1 June 2025',
      activity: 'Running',
      time: '05.00–06.00',
      location: 'Guwang Jogging Track',
      trainer: '', // Trainer kosong jika tidak ada.
    ),
    Activity(
      date: 'Sunday, 1 June 2025',
      activity: 'Boxing',
      time: '07.00–08.00',
      location: 'Guwang Jogging Track',
      trainer: 'Bli Bagus Rejuna Tiang',
    ),
  ];

  /// Mengembalikan [IconData] yang sesuai berdasarkan jenis aktivitas.
  /// Digunakan untuk menampilkan ikon yang relevan pada setiap kartu aktivitas.
  IconData getIconForActivity(String activity) {
    switch (activity.toLowerCase()) {
      case 'Running':
        return Icons.directions_run;
      case 'Boxing':
        return Icons.sports_mma;
      case 'Cycling':
        return Icons.directions_bike;
      case 'Swimming':
        return Icons.pool;
      case 'Yoga':
        return Icons.self_improvement;
      default:
        return Icons
            .fitness_center; // Ikon default jika aktivitas tidak dikenal.
    }
  }

  /// Menampilkan dialog untuk menambahkan atau mengedit aktivitas.
  /// [activityToEdit]: Objek [Activity] yang akan diedit (null jika menambahkan aktivitas baru).
  /// [editIndex]: Indeks aktivitas dalam daftar jika sedang dalam mode edit (null jika menambahkan).
  void _showActivityDialog({Activity? activityToEdit, int? editIndex}) {
    // Inisialisasi TextEditingController dengan data aktivitas yang akan diedit, jika ada.
    final dateController = TextEditingController(
      text: activityToEdit?.date ?? '',
    );
    final timeController = TextEditingController(
      text: activityToEdit?.time ?? '',
    );
    final activityController = TextEditingController(
      text: activityToEdit?.activity ?? '',
    );
    final placeController = TextEditingController(
      text: activityToEdit?.location ?? '',
    );
    final trainerController = TextEditingController(
      text: activityToEdit?.trainer ?? '',
    );

    DateTime? selectedDate;
    TimeOfDay? selectedStartTime;
    TimeOfDay? selectedEndTime;

    // Inisialisasi tanggal dan waktu jika sedang dalam mode edit.
    if (activityToEdit != null) {
      try {
        // Mencoba mengurai tanggal dari string aktivitas yang ada.
        selectedDate = DateFormat(
          'EEEE, d MMMM yyyy',
        ).parse(activityToEdit.date);
        final timeParts = activityToEdit.time.split('–');
        if (timeParts.length == 2) {
          // final startTimeString = timeParts[0].replaceAll('.', ':');
          // final endTimeString = timeParts[1].replaceAll('.', ':');
        }
      } catch (e) {
        // Tangani kesalahan parsing jika format tanggal/waktu tidak sesuai.
        print('Error parsing date or time for editing: $e');
      }
    }

    // Menampilkan dialog menggunakan `showDialog`.
    // `StatefulBuilder` digunakan agar dialog dapat memperbarui UI-nya sendiri (misalnya, status tombol "Add"/"Update").
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            // Fungsi untuk menambahkan listener ke setiap TextEditingController.
            // Listener ini akan memanggil `setStateDialog` setiap kali teks berubah,
            // memastikan validasi form diperbarui secara real-time.
            void addListeners() {
              dateController.addListener(() => setStateDialog(() {}));
              timeController.addListener(() => setStateDialog(() {}));
              activityController.addListener(() => setStateDialog(() {}));
              placeController.addListener(() => setStateDialog(() {}));
              trainerController.addListener(() => setStateDialog(() {}));
            }

            // Fungsi untuk menghapus listener. Penting untuk mencegah memory leaks
            // dan memastikan controller tidak memanggil `setStateDialog` setelah dialog ditutup.
            void removeListeners() {
              dateController.removeListener(() => setStateDialog(() {}));
              timeController.removeListener(() => setStateDialog(() {}));
              activityController.removeListener(() => setStateDialog(() {}));
              placeController.removeListener(() => setStateDialog(() {}));
              trainerController.removeListener(() => setStateDialog(() {}));
            }

            // Menambahkan listener setelah frame pertama selesai dibangun.
            // Ini memastikan listener ditambahkan hanya sekali.
            WidgetsBinding.instance.addPostFrameCallback((_) {
              addListeners();
            });

            /// Mengecek apakah semua field wajib (tanggal, waktu, aktivitas, tempat) sudah terisi.
            /// Digunakan untuk mengaktifkan/menonaktifkan tombol "Add"/"Update".
            bool isFormValid() {
              return dateController.text.isNotEmpty &&
                  timeController.text.isNotEmpty &&
                  activityController.text.isNotEmpty &&
                  placeController.text.isNotEmpty;
            }

            /// Menampilkan pemilih tanggal (date picker).
            /// Mengupdate `selectedDate` dan `dateController.text` setelah tanggal dipilih.
            Future<void> pickDate() async {
              final now = DateTime.now();
              final date = await showDatePicker(
                context: context,
                initialDate:
                    selectedDate ??
                    now, // Tanggal awal adalah tanggal terpilih atau tanggal saat ini.
                firstDate: DateTime(2000), // Batas tanggal paling awal.
                lastDate: DateTime(2100), // Batas tanggal paling akhir.
              );
              if (date != null) {
                selectedDate = date;
                // Memformat tanggal ke string yang sesuai (contoh: "Sunday, 1 June 2025").
                dateController.text = DateFormat(
                  'EEEE, d MMMM yyyy',
                ).format(date);
                setStateDialog(() {}); // Perbarui UI dialog.
              }
            }

            /// Menampilkan pemilih rentang waktu (time picker untuk start dan end time).
            /// Mengupdate `selectedStartTime`, `selectedEndTime`, dan `timeController.text`.
            Future<void> pickTimeRange() async {
              final start = await showTimePicker(
                context: context,
                initialTime:
                    selectedStartTime ??
                    const TimeOfDay(hour: 6, minute: 0), // Waktu awal default.
              );
              if (start != null) {
                selectedStartTime = start;
                final end = await showTimePicker(
                  context: context,
                  initialTime:
                      selectedEndTime ??
                      TimeOfDay(
                        hour: start.hour + 1,
                        minute: start.minute,
                      ), // Waktu akhir default 1 jam setelah waktu mulai.
                );
                if (end != null) {
                  selectedEndTime = end;
                  // Memformat waktu ke format "HH.mm–HH.mm" (contoh: "05.00–06.00").
                  final startFormatted = start
                      .format(context)
                      .replaceAll(':', '.');
                  final endFormatted = end.format(context).replaceAll(':', '.');
                  timeController.text = '$startFormatted–$endFormatted';
                  setStateDialog(() {}); // Perbarui UI dialog.
                }
              }
            }

            // Struktur UI untuk dialog "Create Your Daily Activity" atau "Edit Your Daily Activity".
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                width:
                    MediaQuery.of(context).size.width *
                    0.85, // Lebar dialog relatif terhadap lebar layar.
                padding: const EdgeInsets.all(24),
                child: SingleChildScrollView(
                  // Memungkinkan konten dapat discroll jika terlalu panjang.
                  child: Column(
                    mainAxisSize:
                        MainAxisSize
                            .min, // Mengambil ruang minimal yang dibutuhkan.
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          // Teks judul dialog bergantung pada mode (tambah atau edit).
                          activityToEdit == null
                              ? 'Create Your Daily Activity'
                              : 'Edit Your Daily Activity',
                          style: const TextStyle(
                            color: blueColor,
                            fontFamily: 'PoppinsSemiBold',
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Bagian input untuk Tanggal.
                      const Text(
                        'Date',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'PoppinsMedium',
                          color: darkBlueColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      // GestureDetector dan AbsorbPointer memungkinkan `TextField` untuk memicu pemilih tanggal
                      // saat disentuh, tetapi mencegah keyboard muncul.
                      GestureDetector(
                        onTap: pickDate,
                        child: AbsorbPointer(
                          child: TextField(
                            controller: dateController,
                            decoration: _inputDecoration(''),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Bagian input untuk Waktu.
                      const Text(
                        'Time',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'PoppinsMedium',
                          color: darkBlueColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      GestureDetector(
                        onTap: pickTimeRange,
                        child: AbsorbPointer(
                          child: TextField(
                            controller: timeController,
                            decoration: _inputDecoration(''),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Bagian input untuk Aktivitas.
                      const Text(
                        'Activity',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'PoppinsMedium',
                          color: darkBlueColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        controller: activityController,
                        decoration: _inputDecoration(''),
                      ),
                      const SizedBox(height: 16),
                      // Bagian input untuk Tempat.
                      const Text(
                        'Place',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'PoppinsMedium',
                          color: darkBlueColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        controller: placeController,
                        decoration: _inputDecoration(''),
                      ),
                      const SizedBox(height: 16),
                      // Bagian input untuk Trainer (opsional).
                      const Text(
                        'Trainer',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily: 'PoppinsMedium',
                          color: darkBlueColor,
                        ),
                      ),
                      const SizedBox(height: 6),
                      TextField(
                        controller: trainerController,
                        decoration: _inputDecoration(''),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width:
                            double
                                .infinity, // Tombol mengisi seluruh lebar yang tersedia.
                        child: ElevatedButton(
                          // Tombol aktif hanya jika `isFormValid()` bernilai true.
                          onPressed:
                              isFormValid()
                                  ? () {
                                    // Membuat objek [Activity] baru dari input pengguna.
                                    final newActivity = Activity(
                                      date: dateController.text,
                                      activity: activityController.text,
                                      time: timeController.text,
                                      location: placeController.text,
                                      trainer: trainerController.text,
                                    );

                                    // Memperbarui state daftar aktivitas di [DailyActivityScreen].
                                    setState(() {
                                      if (editIndex != null) {
                                        // Jika mode edit, perbarui aktivitas yang sudah ada pada indeks tertentu.
                                        activities[editIndex] = newActivity;
                                      } else {
                                        // Jika mode tambah, tambahkan aktivitas baru ke daftar.
                                        activities.add(newActivity);
                                      }
                                    });

                                    // Hapus listener sebelum menutup dialog untuk menghindari memory leaks.
                                    removeListeners();
                                    Navigator.pop(context); // Tutup dialog.
                                  }
                                  : null, // Jika form tidak valid, tombol nonaktif.
                          style: ElevatedButton.styleFrom(
                            backgroundColor:
                                blueColor, // Warna latar belakang tombol.
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: Text(
                            // Teks tombol berubah antara "Add" dan "Update" sesuai mode.
                            activityToEdit == null ? 'Add' : 'Update',
                            style: const TextStyle(
                              fontFamily: 'PoppinsSemiBold',
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    ).then((_) {
      // Pastikan semua TextEditingController dibuang setelah dialog ditutup
      // untuk mencegah memory leaks, terlepas dari bagaimana dialog ditutup.
      dateController.dispose();
      timeController.dispose();
      activityController.dispose();
      placeController.dispose();
      trainerController.dispose();
    });
  }

  /// Menampilkan dialog konfirmasi sebelum menghapus aktivitas.
  /// [index]: Indeks aktivitas yang akan dihapus dari daftar.
  void _showDeleteConfirmation(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('Do you want to delete this activity?'),
          actions: [
            TextButton(
              onPressed:
                  () => Navigator.pop(context), // Tutup dialog tanpa menghapus.
              child: const Text(
                'Cancel',
                style: TextStyle(
                  fontFamily: 'PoppinsSemiBold',
                  color: Colors.grey, // Warna teks abu-abu untuk tombol batal.
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  activities.removeAt(index); // Hapus aktivitas dari daftar.
                });
                Navigator.pop(context); // Tutup dialog setelah menghapus.
              },
              child: const Text(
                'Yes',
                style: TextStyle(
                  fontFamily: 'PoppinsSemiBold',
                  color: blueColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Fungsi pembantu statis untuk membuat dekorasi input TextField yang konsisten.
  /// [hint]: Teks placeholder untuk input.
  static InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: lightBlueColor, // Menggunakan warna biru muda kustom.
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none, // Tanpa garis tepi.
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Daily Activity",
          style: TextStyle(
            fontFamily: 'PoppinsSemiBold',
            fontSize: 20,
            color: Color(0xFF000000), // Warna teks judul AppBar.
          ),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black, // Warna teks dan ikon di AppBar.
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount:
            activities
                .length, // Jumlah item adalah jumlah aktivitas dalam daftar.
        itemBuilder: (context, index) {
          final activity = activities[index];
          // Membangun [ActivityCard] untuk setiap aktivitas dalam daftar.
          return ActivityCard(
            activity: activity,
            icon: getIconForActivity(
              activity.activity,
            ), // Mendapatkan ikon berdasarkan jenis aktivitas.
            onEdit: () {
              _showActivityDialog(
                activityToEdit: activity,
                editIndex: index,
              ); // Memanggil dialog edit.
            },
            onDelete: () {
              _showDeleteConfirmation(
                index,
              ); // Memanggil dialog konfirmasi hapus.
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed:
            () =>
                _showActivityDialog(), // Tombol untuk menambah aktivitas baru.
        backgroundColor: blueColor,
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: blueColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: '',
          ), // Item navigasi Home.
          BottomNavigationBarItem(
            icon: Icon(Icons.person_rounded),
            label: '',
          ), // Item navigasi Profile.
        ],
      ),
    );
  }
}

/// [ActivityCard] adalah StatelessWidget yang menampilkan detail satu aktivitas.
/// Ini dirancang sebagai kartu individual dalam daftar aktivitas.
class ActivityCard extends StatelessWidget {
  final Activity activity; // Data aktivitas yang akan ditampilkan.
  final IconData icon; // Ikon yang sesuai dengan jenis aktivitas.
  final VoidCallback? onEdit; // Callback ketika tombol edit ditekan.
  final VoidCallback? onDelete; // Callback ketika tombol delete ditekan.

  const ActivityCard({
    super.key,
    required this.activity,
    required this.icon,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(
        bottom: 16,
      ), // Margin bawah untuk memisahkan kartu.
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ), // Bentuk kartu dengan sudut membulat.
      elevation: 2, // Efek bayangan kartu.
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Mengatur konten rata kiri.
              children: [
                // Baris informasi tanggal.
                _buildInfoRow(
                  icon: Icons.calendar_today,
                  iconColor: darkBlueColor,
                  content: activity.date,
                  contentStyle: const TextStyle(
                    color: darkBlueColor,
                    fontFamily: 'PoppinsMedium',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                // Baris informasi aktivitas dan waktu.
                _buildInfoRow(
                  icon: icon, // Ikon dinamis berdasarkan jenis aktivitas.
                  iconColor: darkBlueColor, // Warna ikon aktivitas.
                  content: activity.activity,
                  contentStyle: const TextStyle(
                    fontFamily: 'PoppinsMedium',
                    color: darkBlueColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  subContent:
                      activity.time, // Waktu aktivitas sebagai sub-konten.
                ),
                const SizedBox(height: 12),
                // Baris informasi lokasi.
                _buildInfoRow(
                  icon: Icons.location_on,
                  iconColor: darkBlueColor, // Warna ikon lokasi.
                  content: activity.location,
                  contentStyle: const TextStyle(
                    color: darkBlueColor,
                    fontFamily: 'PoppinsMedium',
                    fontWeight: FontWeight.w500,
                  ),
                ),
                // Baris informasi trainer (hanya ditampilkan jika ada).
                if (activity.trainer != null &&
                    activity.trainer!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    icon: Icons.person,
                    iconColor: darkBlueColor, // Warna ikon trainer.
                    content: 'Trainer: ${activity.trainer}',
                    contentStyle: const TextStyle(
                      color: darkBlueColor,
                      fontFamily: 'PoppinsMedium',
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
          // Tombol opsi (edit/hapus) yang muncul di pojok kanan atas kartu.
          Positioned(
            top: 8,
            right: 8,
            child: PopupMenuButton<String>(
              icon: const Icon(
                Icons.more_vert,
                color: darkBlueColor,
              ), // Ikon tiga titik vertikal.
              onSelected: (value) {
                if (value == 'edit' && onEdit != null) {
                  onEdit!(); // Memanggil callback edit jika dipilih "Edit".
                } else if (value == 'delete' && onDelete != null) {
                  onDelete!(); // Memanggil callback delete jika dipilih "Delete".
                }
              },
              itemBuilder:
                  (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Text('Edit'),
                    ), // Opsi Edit.
                    const PopupMenuItem(
                      value: 'delete',
                      child: Text('Delete'),
                    ), // Opsi Delete.
                  ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required Color iconColor,
    required String content,
    TextStyle? contentStyle,
    String? subContent,
  }) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.start, // Mengatur konten rata atas.
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Icon(icon, size: 20, color: iconColor), // Ikon.
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                content,
                style:
                    contentStyle ??
                    const TextStyle(color: darkBlueColor), // Teks utama.
              ),
              if (subContent != null) ...[
                const SizedBox(height: 4),
                Text(
                  subContent,
                  style: const TextStyle(
                    color: darkBlueColor,
                  ), // Teks sub-konten.
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

/// Model data untuk merepresentasikan satu aktivitas harian.
/// Berisi properti seperti tanggal, aktivitas, waktu, lokasi, dan trainer.
class Activity {
  final String date; // Tanggal aktivitas.
  final String activity; // Nama aktivitas.
  final String time; // Rentang waktu aktivitas.
  final String location; // Lokasi aktivitas.
  final String? trainer; // Nama trainer (bisa null jika tidak ada trainer).

  Activity({
    required this.date,
    required this.activity,
    required this.time,
    required this.location,
    this.trainer,
  });
}
