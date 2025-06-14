import 'package:flutter/material.dart';
import 'package:health_tracker/views/Trainee/home.dart';

class WeightScreen extends StatefulWidget {
  const WeightScreen({super.key});

  @override
  State<WeightScreen> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<WeightScreen> {
  double _selectedHeight = 170;
  double _selectedWeight = 58;

  final List<double> heightOptions = List.generate(
    151,
    (index) => 120 + index.toDouble(),
  );
  final List<double> weightOptions = List.generate(
    131,
    (index) => 30 + index.toDouble(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'My Profil',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3D50FF),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'To ensure accuracy, please provide the correct information. '
                'We will not share your information with third parties.',
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 32),
              const Text('Height', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 8),
              _buildDropdown(
                value: _selectedHeight,
                items: heightOptions,
                unit: 'cm',
                onChanged:
                    (value) => setState(
                      () => _selectedHeight = value ?? _selectedHeight,
                    ),
              ),
              const SizedBox(height: 24),
              const Text('Weight', style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 8),
              _buildDropdown(
                value: _selectedWeight,
                items: weightOptions,
                unit: 'kg',
                onChanged:
                    (value) => setState(
                      () => _selectedWeight = value ?? _selectedWeight,
                    ),
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
                    backgroundColor: const Color(0xFF3742FA),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 6,
                    shadowColor: Colors.blueAccent,
                  ),
                  child: const Text(
                    'Next',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required double value,
    required List<double> items,
    required String unit,
    required ValueChanged<double?>? onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF3D50FF)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButton<double>(
        value: value,
        isExpanded: true,
        icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF3D50FF)),
        underline: const SizedBox(),
        onChanged: onChanged,
        items:
            items.map<DropdownMenuItem<double>>((double val) {
              return DropdownMenuItem<double>(
                value: val,
                child: Text('${val.toStringAsFixed(1)} $unit'),
              );
            }).toList(),
      ),
    );
  }
}
