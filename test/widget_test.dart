import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:slot_booking_app/main.dart';

void main() {
  testWidgets('App starts without crashing', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the app starts without crashing
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
