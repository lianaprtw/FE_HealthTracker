import 'package:flutter/material.dart';
import 'package:health_tracker/views/daily_activity_screen.dart';
import 'package:health_tracker/views/progressStepDay.dart';
import 'package:health_tracker/views/profile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [const HomeContent(), const ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Color.fromARGB(255, 57, 67, 255),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        elevation: 10,
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  double _waterDrank = 200; // Initial water drank
  final double _waterTarget = 2000; // Daily water target
  double _currentDrinkAmount = 500; // Default value for the slider

  void _showWaterTrackerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              title: const Text(
                'How Much Do You Drink',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "PoppinsSemiBold",
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
                ),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${_currentDrinkAmount.round()}',
                        style: const TextStyle(
                          fontFamily: "PoppinsSemiBold",
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 57, 67, 255),
                        ),
                      ),
                      const Text(
                        ' ml',
                        style: TextStyle(
                          fontFamily: "PoppinsSemiBold",
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 57, 67, 255),
                        ),
                      ),
                    ],
                  ),
                  Slider(
                    value: _currentDrinkAmount,
                    min: 0,
                    max: 2000,
                    divisions: 40, // 2000 / 50 = 40 divisions for 50ml steps
                    label: '${_currentDrinkAmount.round()} ml',
                    activeColor: const Color.fromARGB(255, 57, 67, 255),
                    inactiveColor: const Color.fromARGB(255, 180, 187, 255),
                    onChanged: (double value) {
                      setDialogState(() {
                        _currentDrinkAmount = value;
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        '0 ml',
                        style: TextStyle(
                          fontFamily: "PoppinsSemiBold",
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        '2000 ml',
                        style: TextStyle(
                          fontFamily: "PoppinsSemiBold",
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _waterDrank += _currentDrinkAmount;
                        if (_waterDrank > _waterTarget) {
                          _waterDrank = _waterTarget; // Cap at target
                        }
                      });
                      Navigator.of(context).pop(); // Close the dialog
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 57, 67, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 40,
                        vertical: 12,
                      ),
                    ),
                    child: const Text(
                      'Add',
                      style: TextStyle(
                        fontFamily: "PoppinsSemiBold",
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Holla, Enno!',
              style: TextStyle(
                fontFamily: "PoppinsSemiBold",
                fontSize: 25,
                fontWeight: FontWeight.w600,
                color: Color.fromARGB(219, 21, 42, 120),
              ),
            ),
            const SizedBox(height: 10),
            // Progress Card
            Card(
              color: const Color.fromARGB(255, 57, 67, 255),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Container(
                width: double.infinity,
                height: 170,
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Your Progress',
                          style: TextStyle(
                            fontFamily: "PoppinsSemiBold",
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProgressStepDayPage(),
                              ),
                            );
                          },
                          child: const Text(
                            'Show More',
                            style: TextStyle(
                              fontFamily: "PoppinsSemiBold",
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFFFEAA7),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          "assets/images/Woman doing sports with dumbbells.png",
                          width: 200,
                          height: 217,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Daily Activity
            Card(
              color: const Color.fromARGB(255, 57, 67, 255),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Daily Activity',
                          style: TextStyle(
                            fontFamily: "PoppinsSemiBold",
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DailyActivityScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            'View History',
                            style: TextStyle(
                              fontFamily: "PoppinsSemiBold",
                              color: Color(0xFFFFEAA7),
                              fontSize: 13,
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Modified section for Daily Activity items
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Expanded(child: ActivityItem(icon: Icons.directions_run, label: 'Run')),
                            SizedBox(width: 16), // Memberikan jarak antar item
                            Expanded(child: ActivityItem(icon: Icons.directions_bike, label: 'Bicycle')),
                          ],
                        ),
                        const SizedBox(height: 16), // Memberikan jarak antar baris
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Expanded(child: ActivityItem(icon: Icons.directions_walk, label: 'Walk')),
                            SizedBox(width: 16), // Memberikan jarak antar item
                            Expanded(child: ActivityItem(icon: Icons.add, label: 'Add New')),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Water Tracker
            Card(
              color: const Color.fromARGB(255, 57, 67, 255),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Water Tracker',
                          style: TextStyle(
                            fontFamily: "PoppinsSemiBold",
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          // You might want to update this time dynamically
                          '10:00 AM',
                          style: TextStyle(
                            fontFamily: "PoppinsSemiBold",
                            color: Colors.amberAccent,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          // Update this to reflect current water drank
                          '${_waterDrank.round()}ml water (${(_waterDrank / 200).round()} Glass)',
                          style: const TextStyle(
                            fontFamily: "PoppinsSemiBold",
                            color: Colors.white70,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: _showWaterTrackerDialog, // Call the dialog here
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24,
                              vertical: 10,
                            ),
                          ),
                          child: const Text(
                            'Drink',
                            style: TextStyle(
                              fontFamily: "PoppinsSemiBold",
                              color: Color.fromARGB(255, 57, 67, 255),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/glass water.png",
                            width: 132,
                            height: 104,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 10),
                          Text(
                            '${_waterDrank.round()} / ${_waterTarget.round()} ml', // Update this text
                            style: const TextStyle(
                              fontFamily: "PoppinsSemiBold",
                              color: Colors.white,
                              fontSize: 13,
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
      ),
    );
  }
}

class ActivityItem extends StatelessWidget {
  final IconData icon;
  final String label;

  const ActivityItem({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 16, color: Colors.black),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontFamily: "PoppinsSemiBold",
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}