import 'package:flutter/material.dart';
import '../themes/app_theme.dart';
import 'add_stop_screen.dart';

class SuggestedRouteScreen extends StatefulWidget {
  // RECEIVE locations
  final String pickupLocation;
  final String dropoffLocation;
  const SuggestedRouteScreen({
    super.key,
    required this.pickupLocation,
    required this.dropoffLocation,
  });

  @override
  State<SuggestedRouteScreen> createState() => _SuggestedRouteScreenState();
}

class _SuggestedRouteScreenState extends State<SuggestedRouteScreen> {
  int? _selectedRoute = 0; // State for radio button selection

  // Dummy data to mimic the route options
  final List<Map<String, String>> routes = [
    {"time": "5 hr 16 min", "tolls": "Tolls", "road": "Delhi - Haridwar Rd", "km": "282 km"},
    {"time": "5 hr 21 min", "tolls": "Tolls", "road": "NH 709B", "km": "296 km"},
    {"time": "5 hr 57 min", "tolls": "No Tolls", "road": "Upper Ganga Canal Rd", "km": "273 km"},
  ];

  @override
  Widget build(BuildContext context) {
    // Retrieve custom color defined in app_theme.dart
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
      body: Column(
        children: [
          // 1. Movable Map Image (InteractiveViewer)
          SizedBox(
            height: 300,
            child: InteractiveViewer(
              panEnabled: true,
              boundaryMargin: const EdgeInsets.all(50.0),
              minScale: 0.8,
              maxScale: 2.5,
              child: Image.asset(
                'assets/map_route.png', // <-- Must exist and be declared in pubspec.yaml
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.blueGrey.shade100,
                    alignment: Alignment.center,
                    child: const Text(
                      "Movable Map Image Placeholder",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.black54, fontSize: 18),
                    ),
                  );
                },
              ),
            ),
          ),

          // 2. Content Area (Route Options)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text('What is your route?',
                      style: Theme.of(context).textTheme.headlineLarge!.copyWith(color: rideMateTeal, fontSize: 24.0)),
                  const SizedBox(height: 16.0),

                  // Route Options List
                  Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: routes.length,
                      itemBuilder: (context, index) {
                        return RadioListTile<int>(
                          value: index,
                          groupValue: _selectedRoute,
                          onChanged: (int? value) {
                            setState(() {
                              _selectedRoute = value;
                            });
                          },
                          // Customizing the Radio button color
                          activeColor: rideMateTeal,
                          contentPadding: EdgeInsets.zero,
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${routes[index]['time']} - ${routes[index]['tolls']}',
                                style: const TextStyle(fontWeight: FontWeight.bold, color: rideMateGrey, fontSize: 16),
                              ),
                              Text(
                                '${routes[index]['km']} - ${routes[index]['road']}',
                                style: const TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                              if (index < routes.length - 1)
                                const Divider(color: rideMateLightGrey, height: 24.0),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // 3. Floating Action Button (FAB) navigation
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // PASS locations to the Add Stopovers screen
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddStopScreen(
                pickupLocation: widget.pickupLocation,
                dropoffLocation: widget.dropoffLocation,
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