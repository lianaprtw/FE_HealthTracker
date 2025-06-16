// mainpage.dart
import 'package:flutter/material.dart';
import 'package:health_tracker/views/Trainee/home.dart';
import 'package:health_tracker/views/Trainee/chat_screen.dart';
import 'package:health_tracker/views/Trainee/profile.dart';

class MainPage extends StatefulWidget {
  final int initialIndex;

  const MainPage({super.key, this.initialIndex = 0});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late int _selectedIndex;
  Widget? _currentContent;

  final List<Widget> _pages = [
    const HomePage(),
    const ChatScreen(recipientName: "Trainer"),
    const ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _currentContent = null; // reset subpage
    });
  }

  void openSubPage(Widget page) {
    setState(() {
      _currentContent = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F6F6),
      body: _currentContent ?? _pages[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onItemTapped(1),
        backgroundColor: const Color(0xFF3333FF),
        child: const Icon(Icons.chat_bubble, color: Colors.white),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: const Icon(Icons.home),
                color:
                    _selectedIndex == 0 ? const Color(0xFF3333FF) : Colors.grey,
                onPressed: () => _onItemTapped(0),
              ),
              const SizedBox(width: 40),
              IconButton(
                icon: const Icon(Icons.person),
                color:
                    _selectedIndex == 2 ? const Color(0xFF3333FF) : Colors.grey,
                onPressed: () => _onItemTapped(2),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static _MainPageState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MainPageState>();
}
