import 'package:flutter/material.dart';

void main() => runApp(WaterTrackerApp());

class WaterTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WaterTrackerPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WaterTrackerPage extends StatefulWidget {
  @override
  _WaterTrackerPageState createState() => _WaterTrackerPageState();
}

class _WaterTrackerPageState extends State<WaterTrackerPage> {
  double totalWater = 200; // Initial value
  double selectedAmount = 500; // Default selected amount for pop-up

  void _showDrinkPopup() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Center(child: Text("How Much Do You Drink")),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "${selectedAmount.toInt()} ml",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Slider(
                value: selectedAmount,
                min: 0,
                max: 2000,
                divisions: 20,
                label: "${selectedAmount.toInt()} ml",
                onChanged: (value) {
                  setState(() {
                    selectedAmount = value;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    totalWater += selectedAmount;
                  });
                  Navigator.of(context).pop(); // Close the popup
                },
                child: Text("Add"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 40, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Water Tracker"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${totalWater.toInt()}/2000 ml",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _showDrinkPopup,
              child: Text("Drink"),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
