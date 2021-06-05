
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

  Future<List<Map<String, dynamic>>> fetchModules() async {

    List<Map<String, dynamic>> results = List.empty(growable: true);

    await modules
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

    await courses.add({ 'name': 'Computer Science' }).then((doc) {
      courseId = doc.id;
    });

    await modules.add({ 'courseId': courseId, 'name': 'Software Design' });
    await modules.add({ 'courseId': courseId, 'name': 'Machine Learning' });
    await modules.add({ 'courseId': courseId, 'name': 'Computer Graphics and Visualization' });
    await modules.add({ 'courseId': courseId, 'name': 'Formal Languages and Automata' });

    await courses.add({ 'name': 'Mathematics' }).then((doc) {
      courseId = doc.id;
    });

    await modules.add({ 'courseId': courseId, 'name': 'Abstract Mathematics' });
    await modules.add({ 'courseId': courseId, 'name': 'Basic Analysis' });
    await modules.add({ 'courseId': courseId, 'name': 'Number Theory' });
    await modules.add({ 'courseId': courseId, 'name': 'Calculus' });

  }

  // Singleton stuff
  static final WitsOverflowData _singleton = WitsOverflowData._internal();
  factory WitsOverflowData() => _singleton;

}