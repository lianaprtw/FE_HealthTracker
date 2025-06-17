import 'package:flutter/material.dart';
import 'package:health_tracker/views/Trainee/home.dart';

class WeightScreen extends StatefulWidget {
  const WeightScreen({super.key});

  @override
  State<WeightScreen> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<WeightScreen> {
  // Initialize selected height and weight with default values
  double _selectedHeight = 170;
  double _selectedWeight = 58;

  // Generate a list of height options from 120cm to 270cm (151 options)
  final List<double> heightOptions = List.generate(
    151,
    (index) => 120 + index.toDouble(),
  );

  // Generate a list of weight options from 30kg to 160kg (131 options)
  final List<double> weightOptions = List.generate(
    131,
    (index) => 30 + index.toDouble(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5), // Light grey background
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 'My Profil' title
              const Text(
                'My Profil',
                style: TextStyle(
                  fontSize: 38,
                  fontFamily: 'PoppinsBold', // Custom font for bold text
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF3D50FF), // Custom blue color
                ),
              ),
              const SizedBox(height: 8),
              // Description text
              const Text(
                'To ensure accuracy, please provide the correct information. '
                'We will not share your information with third parties.',
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'PoppinsMedium', // Custom font for medium text
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 75),
              // Height label
              const Text(
                'Height',
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'PoppinsMedium',
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 8),
              // Height dropdown
              _buildDropdown(
                value: _selectedHeight,
                items: heightOptions,
                unit: 'cm',
                isHeight: true, // Indicate this is for height to format value without decimal
                onChanged: (value) => setState(
                  () => _selectedHeight = value ?? _selectedHeight,
                ),
              ),
              const SizedBox(height: 24),
              // Weight label
              const Text(
                'Weight',
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: 'PoppinsMedium',
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 8),
              // Weight dropdown
              _buildDropdown(
                value: _selectedWeight,
                items: weightOptions,
                unit: 'kg',
                isHeight: false, // Indicate this is for weight to format with one decimal
                onChanged: (value) => setState(
                  () => _selectedWeight = value ?? _selectedWeight,
                ),
              ),
              const Spacer(), // Pushes the button to the bottom
              // Start button
              SizedBox(
                width: double.infinity, // Makes the button take full available width
                height: 60,
                child: ElevatedButton(
                  onPressed: () {
                    // Navigate to HomePage when button is pressed
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF3742FA), // Button background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10), // Rounded corners
                    ),
                    elevation: 6, // Adds shadow
                    shadowColor: const Color(0xFF3742FA), // Shadow color
                  ),
                  child: const Text(
                    'Start',
                    style: TextStyle(
                      fontFamily: 'PoppinsBold',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white, // White text color
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

  // Helper widget to build the custom dropdowns
  Widget _buildDropdown({
    required double value,
    required List<double> items,
    required String unit,
    required ValueChanged<double?>? onChanged,
    bool isHeight = false, // New parameter to differentiate height/weight formatting
  }) {
    return Container(
      // Padding inside the container to give space around the dropdown content
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF3D50FF)), // Blue border
        borderRadius: BorderRadius.circular(12), // Rounded corners for the container
      ),
      child: DropdownButton<double>(
        value: value,
        isExpanded: true, // Makes the dropdown take the full width of its parent
        icon: const Icon(Icons.arrow_drop_down, color: Color(0xFF3D50FF)), // Dropdown arrow icon
        underline: const SizedBox(), // Removes the default underline
        onChanged: onChanged,
        // Map each item to a DropdownMenuItem
        items: items.map<DropdownMenuItem<double>>((double val) {
          // Format the value based on whether it's height (no decimal) or weight (one decimal)
          String displayValue = isHeight ? val.toInt().toString() : val.toStringAsFixed(1);

          return DropdownMenuItem<double>(
            value: val,
            // Custom child widget to display value and unit side-by-side
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center, // Center the content horizontally
              crossAxisAlignment: CrossAxisAlignment.baseline, // Align text baselines
              textBaseline: TextBaseline.alphabetic, // Required for baseline alignment
              children: [
                // Text for the numerical value (e.g., 170, 58.0)
                Text(
                  displayValue,
                  style: const TextStyle(
                    fontSize: 24, // Larger font size for the value
                    fontFamily: 'PoppinsBold', // Bold font
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Text color for the value
                  ),
                ),
                const SizedBox(width: 4), // Small space between value and unit
                // Text for the unit (e.g., cm, kg)
                Text(
                  unit,
                  style: const TextStyle(
                    fontSize: 14, // Smaller font size for the unit
                    fontFamily: 'PoppinsMedium', // Medium font
                    color: Colors.grey, // Grey color for the unit
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}
