import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wits_overflow/screens/home_screen.dart';

void main() {
  testWidgets('Test Home Screen', (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
      data: new MediaQueryData(),
      child: new MaterialApp(
        home: new HomeScreen(),
      ),
    );

    await tester.pumpWidget(testWidget);

    final textFinder = find.textContaining('flow');

    expect(textFinder, findsWidgets);
  });
}
