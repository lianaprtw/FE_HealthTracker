import 'package:flutter/material.dart';
import 'package:health_tracker/views/Trainee/home.dart';

class AddDailyActivityScreen extends StatefulWidget {
  const AddDailyActivityScreen({super.key});

  @override
  State<AddDailyActivityScreen> createState() => _AddDailyActivityScreenState();
}

class _AddDailyActivityScreenState extends State<AddDailyActivityScreen> {
  String? selectedActivity;
  String startTime = '';
  String duration = '00:00:01';
  int hours = 0;
  int minutes = 0;
  int seconds = 1;

  final TextEditingController distanceController = TextEditingController();
  final TextEditingController calorieController = TextEditingController();

  @override
  void dispose() {
    distanceController.dispose();
    calorieController.dispose();
    super.dispose();
  }

  void _showTimePicker(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          startTime =
              '${picked.hour.toString().padLeft(2, '0')}:${picked.minute.toString().padLeft(2, '0')}';
        }
      });
    }
  }

  void _showDurationPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Duration',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'PoppinsSemiBold',
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const Text('Hour'),
                          NumberPicker(
                            value: hours,
                            minValue: 0,
                            maxValue: 23,
                            onChanged:
                                (value) => setState(() {
                                  hours = value;
                                  _updateDuration();
                                }),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text('Minute'),
                          NumberPicker(
                            value: minutes,
                            minValue: 0,
                            maxValue: 59,
                            onChanged:
                                (value) => setState(() {
                                  minutes = value;
                                  _updateDuration();
                                }),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text('Second'),
                          NumberPicker(
                            value: seconds,
                            minValue: 0,
                            maxValue: 59,
                            onChanged:
                                (value) => setState(() {
                                  seconds = value;
                                  _updateDuration();
                                }),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    '${hours.toString().padLeft(2, '0')} : ${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF3333FF),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Save',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'PoppinsSemiBold',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _updateDuration() {
    setState(() {
      duration =
          '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '9:41',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add Daily Activity',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                fontFamily: 'PoppinsSemiBold',
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              'Choose activity',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                fontFamily: 'Poppins',
              ),
            ),
            const SizedBox(height: 15),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color(0xFFF5F6FF),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
              ),
              hint: const Text(
                'Select activity',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  color: Color(0xFF8C8C8C),
                ),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'Jump Rope',
                  child: Text(
                    'Jump Rope',
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                ),
                DropdownMenuItem(
                  value: 'Running',
                  child: Text(
                    'Running',
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                ),
                DropdownMenuItem(
                  value: 'Cycling',
                  child: Text(
                    'Cycling',
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                ),
                DropdownMenuItem(
                  value: 'Swimming',
                  child: Text(
                    'Swimming',
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                ),
              ],
              onChanged: (value) {
                setState(() {
                  selectedActivity = value;
                });
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Distance (km)',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: distanceController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFF5F6FF),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          hintText: '0.0',
                          hintStyle: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF8C8C8C),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Calorie (kcal)',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: calorieController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: const Color(0xFFF5F6FF),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                          hintText: '0',
                          hintStyle: const TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF8C8C8C),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => _showTimePicker(context, true),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Start',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F6FF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                startTime.isEmpty ? 'HH:MM' : startTime,
                                style: TextStyle(
                                  fontFamily: 'Poppins',
                                  color:
                                      startTime.isEmpty
                                          ? const Color(0xFF8C8C8C)
                                          : Colors.black,
                                ),
                              ),
                              const Icon(
                                Icons.access_time,
                                color: Color(0xFF8C8C8C),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: GestureDetector(
                    onTap: () => _showDurationPicker(context),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Duration',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Poppins',
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF5F6FF),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                duration,
                                style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Colors.black,
                                ),
                              ),
                              const Icon(
                                Icons.access_time,
                                color: Color(0xFF8C8C8C),
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
            const Spacer(),
            SizedBox(
              width: 357,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3333FF),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'SAVE',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'PoppinsSemiBold',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NumberPicker extends StatelessWidget {
  final int value;
  final int minValue;
  final int maxValue;
  final ValueChanged<int> onChanged;

  const NumberPicker({
    super.key,
    required this.value,
    required this.minValue,
    required this.maxValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_drop_up),
          onPressed: value < maxValue ? () => onChanged(value + 1) : null,
        ),
        Text(
          value.toString().padLeft(2, '0'),
          style: const TextStyle(fontSize: 18),
        ),
        IconButton(
          icon: const Icon(Icons.arrow_drop_down),
          onPressed: value > minValue ? () => onChanged(value - 1) : null,
        ),
      ],
    );
  }
}
