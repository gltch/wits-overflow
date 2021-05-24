import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wits_overflow/widgets/floatingSearchBar.dart';

void main() {
  testWidgets('Favorites Screen', (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new MySearchBar(myTab: 0)));

    //final textField = find.byKey(ValueKey('Search field'));

    await tester.pumpWidget(testWidget);

    final textFinder = find.text('');

    expect(textFinder, findsNothing);
  });
}
