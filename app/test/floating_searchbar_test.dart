import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wits_overflow/screens/home_screen.dart';

void main() {
  testWidgets('Floating search bar', (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new HomeScreen()));

    //final textField = find.byKey(ValueKey('Search field'));

    await tester.pumpWidget(testWidget);

    final textFinder = find.text('hey');

    expect(textFinder, findsNothing);
  });
}
