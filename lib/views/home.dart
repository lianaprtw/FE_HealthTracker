import 'package:flutter/material.dart';
import 'package:health_tracker/views/daily_activity_screen.dart';
import 'package:health_tracker/views/progressStepDay.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Holla, Enno!',
                style: TextStyle(
                    fontFamily: "PoppinsSemiBold",
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(219, 21, 42, 120),
                ),
              ),
              SizedBox(height: 10),

              // Progress Card
              Card(
                color: Color.fromARGB(255, 57, 67, 255),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Container(
                  width: double.infinity,
                  height: 170,
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your Progress',
                            style: TextStyle(
                                fontFamily: "PoppinsSemiBold",
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          Spacer(),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                 MaterialPageRoute(
                                  builder: (context) =>
                                    ProgressStepDayPage(),
                                    ),
                                    );
                            },
                            child: Text(
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
                    Padding(padding: const EdgeInsets.only(top: 16.0),
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
              SizedBox(height: 20),

              // Daily Activity
              Card(
                color: Color.fromARGB(255, 57, 67, 255),
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
                          Text(
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
                            child: Text(
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
                      SizedBox(height: 12),
                      Wrap(
                        spacing: 16,
                        runSpacing: 16,
                        children: [
                          _buildActivityItem(Icons.directions_run, 'Run'),
                          _buildActivityItem(Icons.directions_bike, 'Bicycle'),
                          _buildActivityItem(Icons.directions_walk, 'Walk'),
                          _buildActivityItem(Icons.add, 'Add New'),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Water Tracker
              Card(
                color: Color.fromARGB(255, 57, 67, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Water Tracker',
                            style: TextStyle(
                                fontFamily: "PoppinsSemiBold",
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            '10:00 AM',
                            style: TextStyle(
                                fontFamily: "PoppinsSemiBold",
                              color: Colors.amberAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            '200ml water (2 Glass)',
                            style: TextStyle(
                                fontFamily: "PoppinsSemiBold",
                              color: Colors.white70,
                              fontSize: 13,
                            ),
                          ),
                          SizedBox(height: 12),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 24, vertical: 10),
                            ),
                            child: Text(
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
                            SizedBox(height: 10),
                            Text(
                              '200 / 2000 ml',
                              style: TextStyle(
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
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
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

  Widget _buildActivityItem(IconData icon, String label) {
    return Container(
      width: 140,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 16, color: Colors.black),
          SizedBox(width: 8),
          Text(
            label,
            style: TextStyle(
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
