
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class WitsOverflowData {

  late String userId;
  late CollectionReference<Map<String, dynamic>> questions;
  late CollectionReference<Map<String, dynamic>> courses;
  late CollectionReference<Map<String, dynamic>> modules;

  WitsOverflowData._internal() {
    // TODO: userId = FirebaseAuth.instance.currentUser!.uid;
    questions = FirebaseFirestore.instance.collection('questions');
    courses = FirebaseFirestore.instance.collection('courses-2');
    modules = FirebaseFirestore.instance.collection('modules-2');
  }

  //
  // METHODS

  Future<List<Map<String, dynamic>>> fetchQuestions() async {

    List<Map<String, dynamic>> results = List.empty(growable: true);

    await questions
    .get()
    .then((snapshot) => {
      snapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data();
        data['id'] = doc.id;
        results.add(data);
      })
    });

    return results;

  }

  Future<List<Map<String, dynamic>>> fetchCourses() async {

    List<Map<String, dynamic>> results = List.empty(growable: true);

    await courses
    .get()
    .then((snapshot) => {
      snapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data();
        data['id'] = doc.id;
        results.add(data);
      })
    });

    return results;

  }

  Future<List<Map<String, dynamic>>> fetchModules([String? courseId]) async {

    List<Map<String, dynamic>> results = List.empty(growable: true);

    Query<Map<String, dynamic>> ref = modules;

    if (courseId != null && courseId != "") {
       ref = ref.where("courseId", isEqualTo: courseId);
    }

    await ref
    .get()
    .then((snapshot) => {
      snapshot.docs.forEach((doc) {
        Map<String, dynamic> data = doc.data();
        data['id'] = doc.id;
        results.add(data);
      })
    });

    return results;

  }

  Future<void> addQuestion(Map<String, dynamic> data) async {

    await questions.add(data);

  }

  Future<void> seedDatabase() async {

    String? courseId;

    await courses.add({ 'code': 'COMS', 'name': 'Computer Science' }).then((doc) {
      courseId = doc.id;
    });

    await modules.add({ 'courseId': courseId, 'code': 'COMS3009', 'name': 'Software Design' });
    await modules.add({ 'courseId': courseId, 'code': 'COMS3007', 'name': 'Machine Learning' });
    await modules.add({ 'courseId': courseId, 'code': 'COMS3006', 'name': 'Computer Graphics and Visualization' });
    await modules.add({ 'courseId': courseId, 'code': 'COMS3003', 'name': 'Formal Languages and Automata' });

    await courses.add({ 'code': 'MATH', 'name': 'Mathematics' }).then((doc) {
      courseId = doc.id;
    });

    await modules.add({ 'courseId': courseId, 'code': 'MATH2007', 'name': 'Multivariable Calculus' });
    await modules.add({ 'courseId': courseId, 'code': 'MATH2019', 'name': 'Linear Algebra' });
    await modules.add({ 'courseId': courseId, 'code': 'MATH2025', 'name': 'Transition to Abstract Maths' });
    await modules.add({ 'courseId': courseId, 'code': 'MATH2001', 'name': 'Basic Analysis' });

  }

  // Singleton stuff
  static final WitsOverflowData _singleton = WitsOverflowData._internal();
  factory WitsOverflowData() => _singleton;

}