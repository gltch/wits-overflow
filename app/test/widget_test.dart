// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:wits_overflow/main.dart';

void main() {
  testWidgets('Enter title and question body, then press post and clear fields',
      (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Finds text fields
    var textFieldTitle = find.byKey(ValueKey(1));
    expect(textFieldTitle, findsOneWidget);

    var textFieldBody = find.byKey(ValueKey(2));
    expect(textFieldBody, findsOneWidget);

    // Enters text into textfields
    await tester.enterText(textFieldTitle, 'Test Title');
    expect(find.text('Test Title'), findsOneWidget);

    await tester.enterText(textFieldBody, 'Test Question Body');
    expect(find.text('Test Question Body'), findsOneWidget);

    // Find post button
    var button = find.byIcon(Icons.add);
    expect(button, findsOneWidget);

    // Tap post button and expect cleared textfields
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();
    expect(find.text('Test Title'), findsNothing);
    expect(find.text('Test Question Body'), findsNothing);
  });
}
