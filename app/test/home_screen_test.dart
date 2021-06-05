import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wits_overflow/screens/home_screen.dart';
//import 'package:wits_overflow/widgets/floatingSearchBar.dart';
import 'package:wits_overflow/widgets/searchResultView.dart';

void main() {
  group("testing the navigation on the home screen", () {
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

    testWidgets(
        'when we press the make post button in the posted questions tab we should be able to go to the post questions window',
        (WidgetTester tester) async {
      Widget testWidget = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(home: new HomeScreen()));

      final changeTab = find.byIcon(Icons.post_add_outlined);

      await tester.pumpWidget(testWidget);
      await tester.tap(changeTab);
      await tester.pump();

      final gotoPostScreen = find.byKey(ValueKey("GoToPostquestion"));

      await tester.pumpWidget(testWidget);
      await tester.tap(gotoPostScreen);
      await tester.pump();

      final findPostButton = find.byIcon(Icons.add);

      expect(findPostButton, findsOneWidget);
    });

    testWidgets(
        'when pressing the posted tab icon you should navigate from home screen to users posted questions',
        (WidgetTester tester) async {
      Widget testWidget = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(home: new HomeScreen()));

      final changeTab = find.byIcon(Icons.post_add_outlined);

      await tester.pumpWidget(testWidget);
      await tester.tap(changeTab);
      await tester.pump();

      final textFinder = find.text("No posted questions");

      expect(textFinder, findsOneWidget);
    });
  });

  /* group("testing the floating search bar in home screen", () {
    MySearchBar mySearchBar = new MySearchBar();

    testWidgets(
        'when we enter a search item in the search bar we should get questions that relate to the search item',
        (WidgetTester tester) async {
      Widget testWidget = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(home: new Scaffold(body: mySearchBar)));

      await tester.pumpWidget(testWidget);

      final searchBar = find.byKey(Key("Search here"));

      await tester.tap(searchBar);
      await tester.enterText(searchBar, "My name");
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pump();

      final searchForItem = find.byKey(Key("Search item"));
      // await tester.tap(searchForItem);
      //  await tester.pump();

      // final textFinder = find.text('My name has been found');

      expect(searchForItem, findsWidgets);
    });
  });*/

  group("testing the listing of questions", () {
    SearchResultsListView listT =
        new SearchResultsListView(searchTerm: 'robotics');

    testWidgets(
        'when we enter a search item in the search bar we should get questions that relate to the search item',
        (WidgetTester tester) async {
      Widget testWidget = new MediaQuery(
          data: new MediaQueryData(),
          child: new MaterialApp(home: new Scaffold(body: listT)));

      await tester.pumpWidget(testWidget);
      // await tester.tap(searchBar);
      // await tester.enterText(searchBar, 'My name');
      // await tester.pump();

      final searchBar = find.text("robotics has been found");

      // final searchForItem = find.byIcon(Icons.search);
      // await tester.tap(searchForItem);
      //  await tester.pump();

      // final textFinder = find.text('My name has been found');

      expect(searchBar, findsWidgets);
    });
  });
}
