import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DailyActivityScreen extends StatefulWidget {
  const DailyActivityScreen({super.key});

  @override
  State<DailyActivityScreen> createState() => _DailyActivityScreenState();
}

class _DailyActivityScreenState extends State<DailyActivityScreen> {
  final List<Activity> activities = [
    Activity(
      date: 'Sunday, 1 June 2025',
      activity: 'Running',
      time: '05.00–06.00',
      location: 'Guwang Jogging Track',
      trainer: '',
    ),
    Activity(
      date: 'Sunday, 1 June 2025',
      activity: 'Boxing',
      time: '07.00–08.00',
      location: 'Guwang Jogging Track',
      trainer: 'Bli Bagus Rejuna Tiang',
    ),
  ];

  IconData getIconForActivity(String activity) {
    switch (activity.toLowerCase()) {
      case 'running':
        return Icons.directions_run;
      case 'boxing':
        return Icons.sports_mma;
      case 'cycling':
        return Icons.directions_bike;
      case 'swimming':
        return Icons.pool;
      case 'yoga':
        return Icons.self_improvement;
      default:
        return Icons.fitness_center;
    }
  }

  void _showActivityDialog({Activity? activityToEdit, int? editIndex}) {
    final dateController = TextEditingController(text: activityToEdit?.date ?? '');
    final timeController = TextEditingController(text: activityToEdit?.time ?? '');
    final activityController = TextEditingController(text: activityToEdit?.activity ?? '');
    final placeController = TextEditingController(text: activityToEdit?.location ?? '');
    final trainerController = TextEditingController(text: activityToEdit?.trainer ?? '');

    DateTime? selectedDate;
    TimeOfDay? selectedStartTime;
    TimeOfDay? selectedEndTime;

    // Initialize selectedDate, selectedStartTime, selectedEndTime if editing
    if (activityToEdit != null) {
      try {
        selectedDate = DateFormat('EEEE, d MMMM yyyy').parse(activityToEdit.date);
        final timeParts = activityToEdit.time.split('–');
        if (timeParts.length == 2) {
          final startTimeString = timeParts[0].replaceAll('.', ':');
          final endTimeString = timeParts[1].replaceAll('.', ':');

          // A bit tricky to parse TimeOfDay directly from string without a full DateTime object
          // For simplicity, let's just re-pick them or handle them carefully.
          // For now, we'll leave them null so the user has to pick them again for editing.
          // A more robust solution would involve parsing the time strings into TimeOfDay.
        }
      } catch (e) {
        print('Error parsing date or time for editing: $e');
      }
    }


    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            // Add listeners to update the dialog state when text fields change
            void addListeners() {
              dateController.addListener(() => setStateDialog(() {}));
              timeController.addListener(() => setStateDialog(() {}));
              activityController.addListener(() => setStateDialog(() {}));
              placeController.addListener(() => setStateDialog(() {}));
              trainerController.addListener(() => setStateDialog(() {})); // Optional for trainer
            }

            // Remove listeners
            void removeListeners() {
              dateController.removeListener(() => setStateDialog(() {}));
              timeController.removeListener(() => setStateDialog(() {}));
              activityController.removeListener(() => setStateDialog(() {}));
              placeController.removeListener(() => setStateDialog(() {}));
              trainerController.removeListener(() => setStateDialog(() {}));
            }

            // Call addListeners once when dialog is built
            // Ensure this is called only once
            WidgetsBinding.instance.addPostFrameCallback((_) {
              addListeners();
            });

            bool isFormValid() {
              return dateController.text.isNotEmpty &&
                  timeController.text.isNotEmpty &&
                  activityController.text.isNotEmpty &&
                  placeController.text.isNotEmpty;
            }

            Future<void> pickDate() async {
              final now = DateTime.now();
              final date = await showDatePicker(
                context: context,
                initialDate: selectedDate ?? now,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
              );
              if (date != null) {
                selectedDate = date;
                dateController.text = DateFormat('EEEE, d MMMM yyyy').format(date); // Corrected format
                setStateDialog(() {});
              }
            }

            Future<void> pickTimeRange() async {
              final start = await showTimePicker(
                context: context,
                initialTime: selectedStartTime ?? const TimeOfDay(hour: 6, minute: 0),
              );
              if (start != null) {
                selectedStartTime = start;
                final end = await showTimePicker(
                  context: context,
                  initialTime: selectedEndTime ?? TimeOfDay(hour: start.hour + 1, minute: start.minute),
                );
                if (end != null) {
                  selectedEndTime = end;
                  final startFormatted = start.format(context).replaceAll(':', '.');
                  final endFormatted = end.format(context).replaceAll(':', '.');
                  timeController.text = '$startFormatted–$endFormatted';
                  setStateDialog(() {});
                }
              }
            }

            return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                padding: const EdgeInsets.all(24),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          activityToEdit == null
                              ? 'Create Your Daily Activity'
                              : 'Edit Your Daily Activity',
                          style: const TextStyle(
                            color: Color(0xFF3D5AFE),
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const Text('Date*', style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 6),
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
                      const Text('Time*', style: TextStyle(fontWeight: FontWeight.w600)),
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
                      const Text('Activity*', style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 6),
                      TextField(
                        controller: activityController,
                        decoration: _inputDecoration(''),
                      ),
                      const SizedBox(height: 16),
                      const Text('Place*', style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 6),
                      TextField(
                        controller: placeController,
                        decoration: _inputDecoration(''),
                      ),
                      const SizedBox(height: 16),
                      const Text('Trainer', style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 6),
                      TextField(
                        controller: trainerController,
                        decoration: _inputDecoration(''),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isFormValid()
                              ? () {
                                  final newActivity = Activity(
                                    date: dateController.text,
                                    activity: activityController.text,
                                    time: timeController.text,
                                    location: placeController.text,
                                    trainer: trainerController.text,
                                  );

                                  setState(() {
                                    if (editIndex != null) {
                                      activities[editIndex] = newActivity;
                                    } else {
                                      activities.add(newActivity);
                                    }
                                  });

                                  // Remove listeners before popping
                                  removeListeners();
                                  Navigator.pop(context);
                                }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF3D5AFE),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                          ),
                          child: Text(
                            activityToEdit == null ? 'Add' : 'Save',
                            style: const TextStyle(
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
      // Auto dispose controller biar aman
      dateController.dispose();
      timeController.dispose();
      activityController.dispose();
      placeController.dispose();
      trainerController.dispose();
    });
  }

  void _showDeleteConfirmation(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Are you sure?'),
          content: const Text('Do you want to delete this activity?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  activities.removeAt(index);
                });
                Navigator.pop(context);
              },
              child: const Text(
                'Yes',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  static InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: const Color(0xFFE8EDFF),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Activity"),
        centerTitle: false,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: activities.length,
        itemBuilder: (context, index) {
          final activity = activities[index];
          return ActivityCard(
            activity: activity,
            icon: getIconForActivity(activity.activity),
            onEdit: () {
              _showActivityDialog(activityToEdit: activity, editIndex: index);
            },
            onDelete: () {
              _showDeleteConfirmation(index);
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showActivityDialog(),
        backgroundColor: const Color(0xFF3D5AFE),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        selectedItemColor: const Color(0xFF3D5AFE),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_rounded), label: ''),
        ],
      ),
    );
  }
}

class ActivityCard extends StatelessWidget {
  final Activity activity;
  final IconData icon;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

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
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildInfoRow(
                  icon: Icons.calendar_today,
                  iconColor: const Color(0xFF3D5AFE),
                  content: activity.date,
                  contentStyle: const TextStyle(
                    color: Color(0xFF3D5AFE),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                _buildInfoRow(
                  icon: icon,
                  iconColor: const Color(0xFF3D5AFE),
                  content: activity.activity,
                  contentStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  subContent: activity.time,
                ),
                const SizedBox(height: 12),
                _buildInfoRow(
                  icon: Icons.location_on,
                  iconColor: Colors.grey,
                  content: activity.location,
                ),
                if (activity.trainer != null && activity.trainer!.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  _buildInfoRow(
                    icon: Icons.person,
                    iconColor: Colors.grey,
                    content: 'Trainer: ${activity.trainer}',
                  ),
                ],
              ],
            ),
          ),
          Positioned(
            top: 8,
            right: 8,
            child: PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert, color: Colors.grey),
              onSelected: (value) {
                if (value == 'edit' && onEdit != null) {
                  onEdit!();
                } else if (value == 'delete' && onDelete != null) {
                  onDelete!();
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'edit', child: Text('Edit')),
                const PopupMenuItem(value: 'delete', child: Text('Delete')),
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Icon(icon, size: 20, color: iconColor),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                content,
                style: contentStyle ?? const TextStyle(color: Colors.grey),
              ),
              if (subContent != null) ...[
                const SizedBox(height: 4),
                Text(
                  subContent,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class Activity {
  final String date;
  final String activity;
  final String time;
  final String location;
  final String? trainer;

  Activity({
    required this.date,
    required this.activity,
    required this.time,
    required this.location,
    this.trainer,
  });
}