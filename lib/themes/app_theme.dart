import 'package:flutter/material.dart';

// Define the custom colors used in the now RideMate
const Color rideMateTeal = Color(0xFF0D5E6A); // Distinctive dark teal for titles/icons
const Color rideMateLightTeal = Color(0xFF1397A8); // Lighter teal for the bottom button
const Color rideMateGrey = Color(0xFF555555); // Dark grey for body text
const Color rideMateLightGrey = Color(0xFFE0E0E0); // For dividers

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    // 1. Core Colors
    primaryColor: rideMateTeal,
    hintColor: rideMateGrey,
    scaffoldBackgroundColor: Colors.white,

    // 2. AppBar Style
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: rideMateTeal, // Icon and text color on the AppBar
      elevation: 0,
    ),

    // 3. Text/Typography Style
    textTheme: const TextTheme(
      // Large title text (like "Pick-up", "Drop-off")
      headlineLarge: TextStyle(
        fontSize: 32.0,
        fontWeight: FontWeight.bold,
        color: rideMateTeal, // Distinctive teal color
      ),
      // Body text
      bodyMedium: TextStyle(
        fontSize: 16.0,
        color: rideMateGrey,
      ),
      // Smaller text/captions
      bodySmall: TextStyle(
        fontSize: 14.0,
        color: Colors.grey,
      ),
    ),

    // 4. Input Field (Search Box) Style
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: const Color(0xFFF0F0F0), // Very light grey fill for the search box
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0), // Rounded corners
        borderSide: BorderSide.none, // No border line
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 20.0),
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 16.0),
    ),
  );
}