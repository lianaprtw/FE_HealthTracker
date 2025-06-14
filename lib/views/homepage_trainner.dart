import 'package:flutter/material.dart';
import 'package:health_tracker/views/Profile_Trainner.dart';
import 'package:health_tracker/views/chat_screen.dart';
import 'package:health_tracker/views/user_trainer.dart';
import 'package:health_tracker/views/trainee_details.dart';

class HomepageTrainner extends StatefulWidget {
  const HomepageTrainner({Key? key}) : super(key: key);

  @override
  _HomepageTrainnerState createState() => _HomepageTrainnerState();
}

class _HomepageTrainnerState extends State<HomepageTrainner> {
  int _selectedIndex = 0;
  final blueColor = Color(0xFF3742FA);

  final List<Widget> _pages = [
    HomePageContent(),
    ChatScreen(recipientName: 'Enno Lerebulan'),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _pages[_selectedIndex],
      floatingActionButton: Container(
        height: 65,
        width: 65,
        child: FloatingActionButton(
          backgroundColor: blueColor,
          elevation: 4,
          onPressed: () {
            _onItemTapped(1);
          },
          child: Icon(Icons.chat_bubble_outline, color: Colors.white, size: 32),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          backgroundColor: Colors.white,
          currentIndex: _selectedIndex == 1 ? 0 : _selectedIndex,
          onTap: (index) {
            if (index == 0) {
              _onItemTapped(0);
            } else if (index == 1) {
              _onItemTapped(2);
            }
          },
          selectedItemColor: blueColor,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _selectedIndex == 0 ? blueColor : Colors.grey,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.person,
                color: _selectedIndex == 2 ? blueColor : Colors.grey,
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}

class HomePageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final blueColor = Color(0xFF3742FA);

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Health Tracker',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: blueColor,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.notifications_none, size: 28),
                    onPressed: () {},
                  ),
                ],
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: blueColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Enno Lerebulan',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Female, 23 y.o',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Height: 155 cm',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Weight: 50 kg',
                            style: TextStyle(color: Colors.white, fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 100,
                      width: 100,
                      child: Image.asset(
                        'images/avatar.png',
                        fit: BoxFit.cover,
                        errorBuilder:
                            (context, error, stackTrace) => Icon(
                              Icons.image,
                              color: Colors.white,
                              size: 50,
                            ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: blueColor,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Your Trainee',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            // Navigasi ke list trainee
                          },
                          child: Row(
                            children: [
                              Text(
                                'Show more',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                                size: 14,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    _traineeCard('Bambang'),
                    SizedBox(height: 12),
                    _traineeCard('Piwo'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _traineeCard(String name) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.orange,
            child: Icon(Icons.person, color: Colors.white),
          ),
          SizedBox(width: 12),
          Expanded(child: Text(name, style: TextStyle(fontSize: 16))),
        ],
      ),
    );
  }
}
