import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart'; // Ensure this import path is correct

void main() {
  testWidgets('Verify RideMate UI initial screen content', (WidgetTester tester) async {
    // Build your app using the correct class name: RideMateApp
    // This resolves the error: "The function 'PublishRideApp' isn't defined."
    await tester.pumpWidget(const RideMateApp());

    // Trigger a frame to render the widget tree
    await tester.pumpAndSettle();

    // Verify the title of the initial screen ("Pick-up") is present.
    expect(find.text('Pick-up'), findsOneWidget);

    // Verify the placeholder text in the search bar is present.
    expect(find.text('Enter the full address'), findsOneWidget);

    // Verify the closing 'X' icon (used as a leading icon on the Pick-up screen) is present.
    expect(find.byIcon(Icons.close), findsOneWidget);

    // Since you removed the counter app logic, we remove the old counter assertions:
    // expect(find.text('0'), findsOneWidget); // Removed
    // expect(find.text('1'), findsNothing); // Removed
  });
}