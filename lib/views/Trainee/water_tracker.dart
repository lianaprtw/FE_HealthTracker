import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WaterTrackerScreen extends StatefulWidget {
  // The onSave callback is still useful if you have other side effects,
  // but for returning data, Navigator.pop is primary.
  final Function(List<Map<String, dynamic>> waterEntries)? onSave;
  final List<Map<String, dynamic>> initialWaterEntries;


  const WaterTrackerScreen({
    super.key,
    this.onSave,
    this.initialWaterEntries = const [], // Default to empty list
  });

  @override
  State<WaterTrackerScreen> createState() => _WaterTrackerScreenState();
}

class _WaterTrackerScreenState extends State<WaterTrackerScreen> {
  // Initialize with initialWaterEntries
  late List<Map<String, dynamic>> _waterEntries;

  final TextEditingController _timeController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _waterEntries = List.from(widget.initialWaterEntries); // Copy the list
  }

  @override
  void dispose() {
    _timeController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  // fungsi untuk menampilkan time picker
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      // builder: (BuildContext context, Widget? child) {
      //   return MediaQuery(
      //     data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
      //     child: child ?? const SizedBox.shrink(),
      //   );
      // },
    );

    if (picked != null) {
      // Format waktu menjadi HH:MM AM/PM
      final now = DateTime.now();
      final DateTime selectedTime = DateTime(
        now.year,
        now.month,
        now.day,
        picked.hour,
        picked.minute,
      );
      //update text dengan waktu yang diformat
      _timeController.text = DateFormat('hh:mm a').format(selectedTime);
    }
  }

  void _showAddWaterDialog() {
    _timeController.clear();
    _amountController.clear();

    // untuk mendapatkan waktu saat ini
    final now = DateTime.now();
    // Format waktu menjadi HH:MM AM/PM
    final formattedTime = DateFormat('hh:mm s').format(now);
    // set teks controller dengan waktu yang diformat
    _timeController.text = formattedTime;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: const Color(0xFF3742FA),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: Text(
                    'Add Water',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PoppinsSemiBold',
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Divider(color: Colors.white),
                const SizedBox(height: 15),
                const Text(
                  'Time Drank',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'PoppinsSemiBold',
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: _timeController,
                  // membuat text field hanya menerima input waktu
                  readOnly: true,
                  onTap: () => _selectTime(context),
                  decoration: InputDecoration(
                    hintText: 'e.g., 08:00 AM',
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Amount (ml)',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Poppins',
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 5),
                TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'e.g., 250',
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF3742FA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size(100, 40),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(fontFamily: 'PoppinsSemiBold'),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: const Color(0xFF3742FA),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        minimumSize: const Size(100, 40),
                      ),
                      onPressed: () {
                        final time = _timeController.text.trim();
                        final amount =
                            int.tryParse(_amountController.text.trim());

                        if (time.isEmpty || amount == null || amount <= 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("Please enter a valid time and amount."),
                              backgroundColor: Colors.redAccent,
                            ),
                          );
                          return;
                        }

                        setState(() {
                          _waterEntries.add({
                            'time': time,
                            'amount': amount,
                          });
                        });
                        Navigator.pop(context); // Close the dialog
                      },
                      child: const Text(
                        'Add',
                        style: TextStyle(fontFamily: 'PoppinsSemiBold'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _saveAndReturn() {
    // If a callback is provided, use it
    widget.onSave?.call(_waterEntries);
    // Always return the updated list of entries when popping
    Navigator.pop(context, _waterEntries);
  }

  // Function to remove a water entry
  void _removeWaterEntry(int index) {
    setState(() {
      _waterEntries.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F8FF),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context, _waterEntries), // Return entries on back press
        ),
        title: const Text(
          'Add Water',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontFamily: "PoppinsSemiBold",
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Color(0xFF3742FA)),
            onPressed: _showAddWaterDialog,
            ),
          //   TextButton(
          //     onPressed: () => Navigator.pop(context,_waterEntries),
          //     child: const Text(
          //       'Cancel',
          //       style: TextStyle(
          //         color: Color(0xFF3742FA),
          //         fontSize: 16,
          //         fontFamily: "PoppinsSemiBold",
          //     ),
          //   ),
          // ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 20, 16, 10),
            child: Text(
              'Today',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: "PoppinsSemiBold",
                color: Colors.black,
              ),
            ),
          ),
          Expanded(
            child: _waterEntries.isEmpty
                ? const Center(
                    child: Text(
                      "No water records yet.",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: "PoppinsMedium",
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _waterEntries.length,
                    itemBuilder: (context, index) {
                      final entry = _waterEntries[index];
                      return Dismissible(
                        key: Key(entry['time'] + entry['amount'].toString() + index.toString()), // Unique key for dismissible
                        direction: DismissDirection.endToStart,
                        background: Container(
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          color: Colors.red,
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (direction) {
                          _removeWaterEntry(index);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("Entry deleted")),
                          );
                        },
                        child: _buildWaterEntryCard(
                          time: entry['time'],
                          amount: entry['amount'],
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _saveAndReturn,
                label: const Text(
                  "Save",
                  style: TextStyle(
                    fontFamily: "PoppinsSemiBold",
                    fontSize: 18,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3742FA),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWaterEntryCard({
    required String time,
    required int amount,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.blueAccent),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFFF1F4FF),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Image.asset(
              'assets/images/water_glass.png', // Ensure this asset exists
              width: 40,
              height: 40,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.local_drink,
                color: Color(0xFF3742FA),
                size: 40,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                time,
                style: const TextStyle(
                  fontSize: 14,
                  fontFamily: "PoppinsMedium",
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$amount',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: "PoppinsSemiBold",
                        color: Colors.black,
                      ),
                    ),
                    const TextSpan(
                      text: ' ml',
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: "PoppinsMedium",
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}