// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:wits_overflow/screens/sign_in_screen.dart';

void main() {

  testWidgets('Test Home Screen', (WidgetTester tester) async {

    Widget testWidget = new MediaQuery(
      data: new MediaQueryData(),
      child: new MaterialApp(home: new SignInScreen())
    );

    await tester.pumpWidget(testWidget);

    final textFinder = find.text('Wits Overflow');

    expect(textFinder, findsWidgets);

  });

}
