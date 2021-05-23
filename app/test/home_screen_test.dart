import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wits_overflow/screens/home_screen.dart';

void main() {
  testWidgets('Favorites Screen', (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new HomeScreen()));

    final changeTab = find.byIcon(Icons.auto_awesome);

    await tester.pumpWidget(testWidget);
    await tester.tap(changeTab);
    await tester.pump();

    final textFinder = find.text('no favorites to show');

    expect(textFinder, findsWidgets);
  });

  testWidgets('Notifications Screen', (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new HomeScreen()));

    final changeTab = find.byIcon(Icons.notifications_active);

    await tester.pumpWidget(testWidget);
    await tester.tap(changeTab);
    await tester.pump();

    final textFinder = find.text('Notifications');

    expect(textFinder, findsWidgets);
  });

  testWidgets('floating search bar', (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new HomeScreen()));

    final searchBar = find.byIcon(Icons.home);
    //  final searchForItem = find.byKey(ValueKey('search for item'));

    await tester.pumpWidget(testWidget);
    await tester.tap(searchBar);
    //await tester.enterText(searchBar, 'COMS1');
    ///// await tester.pump();

    // final textFinder = find.text('COMS1 has been found');

    expect(searchBar, findsOneWidget);
  });
}
