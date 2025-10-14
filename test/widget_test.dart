// Basic widget test for the expense tracker app
// TODO: Add more comprehensive tests as you build features

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:expense_tracker/main.dart';

void main() {
  testWidgets('App loads with welcome message', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the welcome message is displayed
    expect(find.text('Welcome to Expense Tracker!'), findsOneWidget);
    expect(find.text('Expense Tracker'), findsOneWidget);
  });
}
