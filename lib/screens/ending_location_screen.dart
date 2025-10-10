// lib/screens/ending_location_screen.dart

import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import 'suggested_route_screen.dart';

class EndingLocationScreen extends StatefulWidget {
  // 1. RECEIVE Pick-up location
  final String pickupLocation;
  const EndingLocationScreen({super.key, required this.pickupLocation});

  @override
  State<EndingLocationScreen> createState() => _EndingLocationScreenState();
}

class _EndingLocationScreenState extends State<EndingLocationScreen> {
  final TextEditingController dropoffController = TextEditingController();
  bool _isInputValid = false;

  @override
  void initState() {
    super.initState();
    // Listen for changes in the text field to enable the button
    dropoffController.addListener(_validateInput);
  }

  void _validateInput() {
    setState(() {
      // Button is enabled as soon as the text field is not empty
      _isInputValid = dropoffController.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    dropoffController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Define the style using the theme
    final titleStyle = Theme.of(context).textTheme.headlineLarge;

    // Retrieve custom color defined in app_theme.dart
    // (Assuming rideMateLightTeal is accessible via the theme or a local const)
    const Color fabColor = rideMateLightTeal;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 1. Title
            Text('Drop-off', style: titleStyle),
            const SizedBox(height: 32.0),

            // 2. Search Input Field (Editable)
            TextFormField(
              controller: dropoffController,
              decoration: const InputDecoration(
                hintText: 'Enter the full address',
                prefixIcon: Icon(Icons.search, color: Colors.grey),
              ),
            ),

            const SizedBox(height: 40.0),
            // Add other UI elements (like recent searches) here
          ],
        ),
      ),

      // 3. Floating Action Button (FAB) navigation logic
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: _isInputValid
            ? () {
          // 4. PASS *both* locations to the Route screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SuggestedRouteScreen(
                pickupLocation: widget.pickupLocation, // Passed from the previous screen
                dropoffLocation: dropoffController.text, // New data entered here
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