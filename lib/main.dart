// lib/main.dart

import 'package:flutter/material.dart';
import 'themes/app_theme.dart';
import 'screens/starting_location_screen.dart';
// NOTE: We no longer need to import the other screens here.

void main() {
  runApp(const RideMateApp());
}

class RideMateApp extends StatelessWidget {
  const RideMateApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RideMate Frontend Mockup',
      theme: AppTheme.lightTheme,

      // REMOVE THE ENTIRE 'routes' SECTION.
      // The navigation is handled dynamically using Navigator.push() in each screen's code.

      // Start the app directly with the initial screen using 'home'.
      home: const StartingLocationScreen(),
    );
  }
}