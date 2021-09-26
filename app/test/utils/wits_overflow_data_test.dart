import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:firebase_auth_mocks/firebase_auth_mocks.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wits_overflow/utils/functions.dart';
import 'package:wits_overflow/utils/wits_overflow_data.dart';

import '../utils.dart';

void main() {
  group('Wits over flow data', () {
    late FakeFirebaseFirestore firestore;
    late MockFirebaseAuth auth;
    late Map<String, dynamic> userInfo;
    late WitsOverflowData witsOverflowData;

    setUp(() async {
      firestore = FakeFirebaseFirestore();
      userInfo = {
        'uid': 'testUserUid1',
        'displayName': 'testFirstName testLastName',
        'email': 'testEmail@domain.com',
      };

      await firestore
          .collection(COLLECTIONS['users'])
          .add(userInfo)
          .then((value) {
        userInfo['id'] = value.id;
      });

      MockUser mockUser = MockUser(
        uid: userInfo['uid'],
        displayName: userInfo['displayName'],
        email: userInfo['email'],
        isAnonymous: false,
        isEmailVerified: true,
      );
      auth = await loginUser(mockUser);
      witsOverflowData = WitsOverflowData();
      witsOverflowData.initialize(firestore: firestore, auth: auth);
    });

    test('Mock fetches correct data', () async {
      await firestore.collection('test').add({'field_1': 'value_1'});

      QuerySnapshot<Map<String, dynamic>> tests =
          await firestore.collection('test').get();
      expect(tests.docs.length > 0, true);
    });

    test('fetch user information', () async {
      // add user information to the database
      Map<String, dynamic>? fUserInfo =
          await witsOverflowData.fetchUserInformation(userInfo['id']);
      expect(userInfo['displayName'], fUserInfo?['displayName']);
      expect(userInfo['uid'], fUserInfo?['uid']);
      expect(userInfo['email'], fUserInfo?['email']);
    });
  });

  // group('wits overflow data questions related', (){
  //   late final firestore;
  //   late final auth;
  //   late Map<String, dynamic> userInfo;
  //   WitsOverflowData witsOverflowData = WitsOverflowData();
  //   late Map<String, dynamic> question;
  //   late Map<String, dynamic> course;
  //   late Map<String, dynamic> module;
  //
  //   setUp(() async {
  //     firestore = FakeFirebaseFirestore();
  //     userInfo = {
  //       'uid': 'testUserUid1',
  //       'displayName': 'testFirstName testLastName',
  //       'email': 'testEmail@domain.com',
  //     };
  //
  //     await firestore.collection(COLLECTIONS['users']).add(userInfo);
  //     MockUser mockUser = MockUser(
  //       uid: userInfo['uid'],
  //       displayName: userInfo['displayName'],
  //       email: userInfo['email'],
  //       isAnonymous: false,
  //       isEmailVerified: true,
  //
  //     );
  //     auth = loginUser(mockUser);
  //     witsOverflowData.initialize(firestore: firestore, auth: auth);
  //
  //     course = {
  //       'name': 'Computer Science',
  //       'code': 'COMS',
  //     };
  //
  //     await firestore.collection(COLLECTIONS['courses']).add(course).then((
  //         value) {
  //       course['id'] = value.id;
  //     });
  //
  //     module = {
  //       'name': 'Software Design Project',
  //       'code': 'COMS3011',
  //       'courseId': course['id'],
  //     };
  //
  //     await firestore.collection(COLLECTIONS['modules']).add(module).then((
  //         value) {
  //       module['id'] = value.id;
  //     });
  //
  //     // 2 - add question to the database
  //     question = {
  //       'title': 'test question title 1',
  //       'body': 'test question body 1',
  //       'createdAt': DateTime(2021, 3, 21, 34, 19),
  //       'authorId': userInfo['uid'],
  //       'tags': ['testTag1', 'testTag2', 'testTag3',],
  //       'courseId': course['id'],
  //       'moduleId': module['id'],
  //     };
  //
  //     await firestore.collection(COLLECTIONS['questions']).add(question).then((
  //         value) {
  //       question['id'] = value.id;
  //     });
  //
  //   });
  //
  //   /// test that the fetchQuestion method return valid question information
  //   test("fetchQuestion method return valid question data", () async {
  //     // add question tot he database
  //     Map<String, dynamic>? fQuestion = await witsOverflowData.fetchQuestion(question['id']);
  //
  //     List<String> fields = [
  //       'id',
  //       'title',
  //       'body',
  //       'authorId',
  //       // 'editorId',
  //     ];
  //     for(int i = 0; i < fields.length; i++){
  //       expect(question[fields[i]], fQuestion?[fields[i]]);
  //     }
  //   });
  //
  //   test('fetch question method returns valid question', () async {
  //
  //     Map<String, dynamic> question = {
  //       'title': 'test question title 1',
  //       'body': 'test question body 1',
  //       'authorId': userInfo['id'],
  //       'tags': <String>[
  //         'testTag1',
  //         'testTag2',
  //         'testTag3',
  //       ],
  //       'createdAt': Timestamp.fromDate(DateTime(2021, 2, 12, 4, 23)),
  //     };
  //     await firestore
  //         .collection(COLLECTIONS['questions'])
  //         .add(question)
  //         .then((value) {
  //       question.addAll({'id': value.id});
  //     });
  //
  //     Map<String, dynamic>? fQuestion =
  //     await witsOverflowData.fetchQuestion(question['id']);
  //
  //     expect(question['title'], fQuestion?['title']);
  //     expect(question['body'], fQuestion?['body']);
  //     expect(question['authorId'], fQuestion?['authorId']);
  //   });
  //
  //
  // });
}
