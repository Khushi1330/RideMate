// lib/screens/add_stop_screen.dart

import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import 'final_route_display_screen.dart'; // Import the next screen

class AddStopScreen extends StatefulWidget {
  // RECEIVE locations
  final String pickupLocation;
  final String dropoffLocation;
  const AddStopScreen({
    super.key,
    required this.pickupLocation,
    required this.dropoffLocation,
  });

  @override
  State<AddStopScreen> createState() => _AddStopScreenState();
}

class _AddStopScreenState extends State<AddStopScreen> {
  // Dummy data for stopovers
  final Map<String, bool> stopovers = {
    'North West Delhi': false,
    'Baghpat': false,
    'Sonipat': false,
    'Panipat': false,
    'Shamli': false,
    'Saharanpur': false,
  };

  @override
  Widget build(BuildContext context) {
    // Retrieve custom colors defined in app_theme.dart
    const Color rideMateTeal = Color(0xFF0D5E6A);
    const Color rideMateLightTeal = Color(0xFF1397A8);
    const Color rideMateGrey = Color(0xFF555555);
    const Color rideMateLightGrey = Color(0xFFE0E0E0);

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
            Text(
              'Add stopovers to get\nmore passengers',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: rideMateTeal,
              ),
            ),
            const SizedBox(height: 16.0),

            // 2. Stopover Checkbox List
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  ...stopovers.keys.map((city) {
                    return Column(
                      children: [
                        CheckboxListTile(
                          value: stopovers[city],
                          onChanged: (bool? newValue) {
                            setState(() {
                              stopovers[city] = newValue!;
                            });
                          },
                          title: Text(city, style: const TextStyle(color: rideMateGrey, fontSize: 16)),
                          controlAffinity: ListTileControlAffinity.leading,
                          contentPadding: EdgeInsets.zero,
                          activeColor: rideMateTeal,
                        ),
                        const Divider(color: rideMateLightGrey, height: 1.0),
                      ],
                    );
                  }).toList(),

                  // 'Add city' Text Link
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: InkWell(
                      onTap: () { /* Add custom city logic */ },
                      child: const Text(
                        'Add city',
                        style: TextStyle(
                          color: rideMateTeal,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
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

      // 3. Floating Action Button (FAB) navigation
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // PASS locations to the Final screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FinalRouteDisplayScreen(
                pickupLocation: widget.pickupLocation,
                dropoffLocation: widget.dropoffLocation,
                // Hardcode one stopover for the mock display
                stopoverLocation: 'The Green Avenue, Panipat',
              ),
            ),
          );
        },
        backgroundColor: rideMateLightTeal,
        shape: const CircleBorder(),
        child: const Icon(Icons.arrow_forward, color: Colors.white, size: 30),
      ),
    );
  }
}