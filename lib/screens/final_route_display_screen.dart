// lib/screens/final_route_display_screen.dart

import 'package:flutter/material.dart';
import '../themes/app_theme.dart';

class FinalRouteDisplayScreen extends StatelessWidget {
  // 1. RECEIVE all location data
  final String pickupLocation;
  final String dropoffLocation;
  final String stopoverLocation;

  const FinalRouteDisplayScreen({
    super.key,
    required this.pickupLocation,
    required this.dropoffLocation,
    required this.stopoverLocation,
  });

  // Reusable widget for the location display
  Widget _buildLocationItem({
    required String title,
    required String subtitle, // This will be the user-entered text
    required IconData icon,
    required Color iconColor,
    bool showDivider = true,
  }) {
    // ... (Widget implementation remains the same) ...
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Icon(icon, color: iconColor, size: 24.0),
              const SizedBox(width: 16.0),
              // Text Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0, color: rideMateGrey),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      subtitle,
                      style: const TextStyle(fontSize: 14.0, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (showDivider)
            const Padding(
              padding: EdgeInsets.only(top: 16.0, bottom: 8.0),
              child: Divider(color: rideMateLightGrey, height: 1.0),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Final Route'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // 1. Title
              Text(
                'Your Route is Finalized',
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: rideMateTeal,
                  fontSize: 26.0,
                ),
              ),
              const SizedBox(height: 24.0),

              // 2. Location Details (Using the passed data)
              _buildLocationItem(
                icon: Icons.place,
                iconColor: Colors.green.shade600,
                title: 'Pick-up Location',
                subtitle: pickupLocation, // <--- DISPLAY PASSED DATA
              ),
              _buildLocationItem(
                icon: Icons.pin_drop,
                iconColor: rideMateTeal,
                title: 'Stopover',
                subtitle: stopoverLocation, // <--- DISPLAY PASSED DATA
              ),
              _buildLocationItem(
                icon: Icons.flag,
                iconColor: Colors.red.shade600,
                title: 'Drop-off Location',
                subtitle: dropoffLocation, // <--- DISPLAY PASSED DATA
                showDivider: false,
              ),

              // ... (Route Summary remains the same) ...
              const SizedBox(height: 32.0),
              const Text(
                'Route Details',
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 20.0, color: rideMateTeal),
              ),
              const SizedBox(height: 12.0),
              const Text(
                'Total Time: 5 hr 16 min - Tolls\nDistance: 282 km (via Delhi - Haridwar Rd)',
                style: TextStyle(fontSize: 16.0, color: rideMateGrey),
              ),
            ],
          ),
        ),
      ),
      // 3. Confirm Button at the bottom
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            // Stop the workflow by navigating back to the very first screen
            Navigator.popUntil(context, (route) => route.isFirst);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: rideMateLightTeal,
            minimumSize: const Size(double.infinity, 56),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          child: const Text(
            'Confirm',
            style: TextStyle(fontSize: 18.0, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}