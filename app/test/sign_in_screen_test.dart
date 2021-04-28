import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:wits_overflow/screens/sign_in_screen.dart';

void main() {
  testWidgets('Test Sign-In Screen', (WidgetTester tester) async {
    Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new MaterialApp(home: new SignInScreen()));

    await tester.pumpWidget(testWidget);

    expect(find.text('Wits Overflow'), findsOneWidget);
    expect(find.text('Welcome to Wits Overflow.  The ultimate in high-tech question answering goodness.  Enter for all your knowledge seeking needs.'), findsOneWidget);
    expect(find.text('Currently we\'re catering exclusively to Wits students (lucky you), so click the button below to sign in with your student gmail account and get started on your journey to unlimited knowledge...'), findsOneWidget);

  });
}
