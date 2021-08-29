import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wits_overflow/screens/home_screen.dart';
import 'package:wits_overflow/widgets/comment.dart';
import 'package:wits_overflow/widgets/question.dart';
import 'package:wits_overflow/utils/functions.dart';

void main() {


  // testWidgets('Test Home Screen', (WidgetTester tester) async {
  //
  //   Widget testWidget = new MediaQuery(
  //     data: new MediaQueryData(),
  //       child: new MaterialApp(home: new HomeScreen(),
  //     ),
  //   // );
  //
  //   await tester.pumpWidget(testWidget);
  //
  //   final textFinder = find.textContaining('flow');
  //
  // expect(textFinder, findsWidgets);
  // });


  group('Test widgets', (){
    /// widgets to test:
    /// Question
    /// Comments
    ///   Comment
    ///   AnswerComment
    ///   AnswerComments
    ///   QuestionComments
    ///   QuestionComment
    /// Answer
    ///   Answers
    ///   Answer
    /// Meta
    ///   QuestionMeta - 
    ///   AnswerMeta
    /// QuestionSummary
    /// Sidebar
    /// UserCard
    ///   QuestionUserCard
    ///   QuestionUserUpdateCard
    ///   AnswerUserCard
    ///   


    /// test the question widget
    testWidgets('Test Question Widget', (WidgetTester tester) async {

      String title = 'test question title';
      String body = 'test question body';
      int votes = 10;
      String id = 'test question id';
      Timestamp createdAt = Timestamp.now();
      String authorDisplayName = 'test author display name';

      Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new Directionality(
          textDirection: TextDirection.rtl,
          child: new QuestionWidget(
            id: id,
            title: title,
            body: body,
            votes: votes,
            authorDisplayName: authorDisplayName,
            createdAt: createdAt,
          ),
        )
      );

      await tester.pumpWidget(testWidget);

      // Create the Finders.
      final titleFinder = find.text(title);
      final bodyFinder = find.text(body);
      final votesFinder = find.text(votes.toString());
      final authorDisplayNameFinder = find.text(authorDisplayName);

      expect(titleFinder, findsOneWidget);
      expect(bodyFinder, findsOneWidget);
      expect(votesFinder, findsOneWidget);
      expect(authorDisplayNameFinder, findsOneWidget);
    });


    /// test the answer widget
    testWidgets('Test Answer Widget', (WidgetTester tester) async {

      final String displayName = 'test answer display name';
      final String body = 'test answer body';
      final DateTime createdAt = DateTime.now();

      Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new Directionality(
          textDirection: TextDirection.rtl,
          child: CommentWidget(
            body:body,
            displayName: displayName,
            createdAt: createdAt,
          )
        )
      );


      await tester.pumpWidget(testWidget);

      // Create the Finders.
      final titleFinder = find.text(displayName);
      final messageFinder = find.text(body);

      expect(titleFinder, findsOneWidget);
      expect(messageFinder, findsOneWidget);
    });


    /// test the comment widget
    testWidgets('Test Answer Widget', (WidgetTester tester) async {

      final String body = 'test comment body';
      final DateTime createdAt = DateTime.now();

      Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new Directionality(
          textDirection: TextDirection.rtl,
          child: CommentWidget(
            body: body,
            createdAt: createdAt,
            displayName: 'test display name',
          )
        )
      );

      await tester.pumpWidget(testWidget);

      // Create the Finders.
      final bodyFinder = find.text(body);
      // final messageFinder = find.text(body);

      expect(bodyFinder, findsOneWidget);
      // expect(messageFinder, findsOneWidget);
    });

    /// test the user card widget display in question, answers
    /// the user card should display:
    ///   * user's display name
    ///   * date time
    // testWidgets('Test user card', (){

    // });

    /// test the question summary widget
    ///  TEST:
    ///   * test that relevent information is displayed
    ///   * test that the question title is displayed in title form
    ///   * Date should be displayed in a correct format
    testWidgets('Test QuestionSummary Widget', (WidgetTester tester){
      // data should have these kesy:
      //  * tags      (list)
      //  * votes     (int)
      //  * title     (String)
      //  * createdAt (Timestamp)

      // data
      String title = 'test question summary title'; 
      Datetime datetime = Datetime(2021, 1, 1, 10, 23);
      List<String> badgets = ['One', 'Two', 'Three'];
      int votes = 5;

      // correct values
      String correctTitleFormat = 'Test Question Summary Title';
      String correctDataFormat = 'Jan 1 \'21 at 10:23';
      
      Map data = {
        'title': title,
        'createdAt': createdAt,
        'badges': badges,
        'votes': votes,
      };

      QuestionSummary questionSummary = QuestionSummary(data: data);

      Widget testWidget = new MediaQuery(
        data: new MediaQueryData(),
        child: new Directionality(
          textDirection: TextDirection.rtl,
          child: questionSummary,
        )
      );

      //
      final titleFinder = find.text(correctTitleFormat);
      
      final votesFinder = find.text(data['votes'].tostring());

      final badgeOneFinder = find.text(data['badgets'][0]);
      final badgeTwoFinder = find.text(data['badgets'][1]);
      final badgeThreeFinder = find.text(data['badgets'][2]);

      final createdAtFinder = find.text(correctDataFormat);
      

      expect(titleFinder, findsOneWidget);
      expect(votesFinder, findsOneWidget);

      expect(badgeOneFinder, findsOneWidget);
      expect(badgeTwoFinder, findsOneWidget);
      expect(badgeThreeFinder, findsOneWidget);

      expect(createdAtFilnder, findsOneWidget);

    });
  });

  /// ----------------------------------------------------------------------------------------------
  /// TEST WitsOverflowData class
  ///   * fetchQuestions
  ///   * fetchUserQuestions
  ///   * fetchModuleQuestions
  ///   * fetchLatestQuestions
  ///   * fetchCourses
  ///   * fetchModules
  ///   * fetchUserFavouriteQuestions
  ///   * addQuestion

  // group('Test WitsOverflowData class', () {
  //   test('Test fetch questions', () {

  //     // add question to the database

  //     wits_overflow_data = WitsOverflowData();
  //     var questions = wits_overflow_data.fetchQuestions();

  //     expect(Counter().value, 0);

  //     // delete questions
  //   });

  //   test('test fetch user questions', () {
  //     final counter = Counter();

  //     counter.increment();

  //     expect(counter.value, 1);
  //   }); 

  /// testing utils/functions.dart
  ///   * toTitleCase
  ///   * capitaliseChar
  ///   * formatDateTime


  /// test witsoverflow/utils/functions.dart
  group('Testing functions', (){
    ///
    test('Test toTitleCase', (){
      String line = 'test to title case';
      String titleLine = 'Test To Title Case';
      String toTitleCaseResult = toTitleCase(line);

      expect(toTitleCaseResult, titleLine);
        
    });

    ///
    test('Test formatDateTime', (){
      DateTime datetime = DateTime(2021, 8, 1, 2, 3, 4);

      String formatedDatetime = formatDateTime(datetime);

      expect(formatedDatetime.contains('21'), true);
      expect(formatedDatetime.contains('Aug'), true);
      expect(formatedDatetime.contains('1'), true);
    });


    /// if the time is earlier, (like in latest question)
    /// the time display should be like: 
    /// '2 hours' ago / '21 min' ago 
    /// 
    // test('', (){
      
    // });
  });





}
