
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class WitsOverflowData {

  late String userId;
  late CollectionReference<Map<String, dynamic>> questions;

  WitsOverflowData._internal() {
    //userId = FirebaseAuth.instance.currentUser!.uid;
    questions = FirebaseFirestore.instance.collection('questions');
  }

  //
  // METHODS

  Future<List<Map<String, dynamic>>> fetchQuestions() async {

    List<Map<String, dynamic>> results = List.empty(growable: true);

    await questions
    .get()
    .then((questions) => {
      questions.docs.forEach((doc) => {
        results.add(doc.data())
      })
    });

    return results;

  }

  Future<void> addQuestion(Map<String, dynamic> data) async {

    await questions.add(data);

  }

  // Singleton stuff
  static final WitsOverflowData _singleton = WitsOverflowData._internal();
  factory WitsOverflowData() => _singleton;

}