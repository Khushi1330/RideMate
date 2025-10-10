// lib/screens/starting_location_screen.dart

import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import 'ending_location_screen.dart';

class StartingLocationScreen extends StatefulWidget {
  const StartingLocationScreen({super.key});

  @override
  State<StartingLocationScreen> createState() => _StartingLocationScreenState();
}

class _StartingLocationScreenState extends State<StartingLocationScreen> {
  final TextEditingController pickupController = TextEditingController();
  bool _isInputValid = false;

  @override
  void initState() {
    super.initState();
    // Listen for changes in the text field to enable the button
    pickupController.addListener(_validateInput);
  }

  void _validateInput() {
    setState(() {
      // Button is enabled as soon as the text field is not empty
      _isInputValid = pickupController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    pickupController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Define the style using the theme
    final titleStyle = Theme.of(context).textTheme.headlineLarge;

    // Retrieve custom color defined in app_theme.dart (assuming rideMateLightTeal is accessible)
    const Color fabColor = rideMateLightTeal;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close), // 'x' icon
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 1. Title
            Text('Pick-up', style: titleStyle),
            const SizedBox(height: 32.0),

            // 2. Search Input Field (Editable)
            TextFormField(
              controller: pickupController, // Use the controller
              decoration: const InputDecoration(
                hintText: 'Enter the full address',
                prefixIcon: Icon(Icons.search, color: Colors.grey),
              ),
            ),

            const SizedBox(height: 40.0),
          ],
        ),
      ),

      // 3. Floating Action Button (FAB) logic
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _isInputValid
            ? () {
          // PASS the pickup location to the Drop-off screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EndingLocationScreen(
                pickupLocation: pickupController.text, // <--- PASS DATA
              ),
            ),
          );
        }
            : null, // Button is disabled if input is invalid
        backgroundColor: _isInputValid ? fabColor : Colors.grey,
        shape: const CircleBorder(),
        child: const Icon(Icons.arrow_forward, color: Colors.white, size: 30),
      ),
    );
  }
}