import 'package:flutter/material.dart';
import 'package:health_tracker/utils/colors.dart';
import 'package:health_tracker/views/Trainee/onboarding.dart';
import 'package:health_tracker/views/Trainer/onboarding_trainer.dart';

void main() => runApp(WhichScreen());

class WhichScreen extends StatelessWidget {
  const WhichScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Health Tracker',
      debugShowCheckedModeBanner: false,
      home: RoleSelectionScreen(),
    );
  }
}

class RoleSelectionScreen extends StatelessWidget {
  static const Color blueColor = Color(0xFF3742FA);

  RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(backgroundColor: whiteColor, elevation: 0),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(height: 20),
            Text(
              'Which One\nAre You?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: blueColor,
                fontFamily: 'PoppinsBold',
                fontSize: 40,
                // fontWeight: FontWeight.bold,
              ),
            ),
            Image.asset('images/which_one.png', height: 500),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 32.0,
                vertical: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OnboardingScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: blueColor,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                      ),
                      child: Text(
                        'Trainer',
                        style: TextStyle(
                          color: whiteColor,
                          fontFamily: 'PoppinsSemiBold',
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const OnboardingView(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: Colors.grey.shade300),
                        ),
                        elevation: 4,
                      ),
                      child: Text(
                        'Trainee',
                        style: TextStyle(
                          color: blueColor,
                          fontFamily: 'PoppinsSemiBold',
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
