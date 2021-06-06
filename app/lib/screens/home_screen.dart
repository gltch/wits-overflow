// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wits_overflow/utils/wits_overflow_data.dart';
import 'package:wits_overflow/widgets/question_summary.dart';
import 'package:wits_overflow/widgets/side_drawer.dart';

class HomeScreen extends StatefulWidget {

  String? module;

  HomeScreen({Key? key, this.module}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

  late Future<List<Map<String, dynamic>>> questions;
  late Future<List<Map<String, dynamic>>> courses;
  late Future<List<Map<String, dynamic>>> modules;

  @override
  void initState() {
    super.initState();

    questions = WitsOverflowData().fetchQuestions();
    courses = WitsOverflowData().fetchCourses();
    modules = WitsOverflowData().fetchModules();

    //WitsOverflowData().seedDatabase();
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wits Overflow'),
        actions: [
          
          // IconButton(
          //   icon: Image.network(
          //     FirebaseAuth.instance.currentUser!.photoURL!
          //   ), 
          //   onPressed: () {
          //     ScaffoldMessenger.of(context).showSnackBar(
          //         const SnackBar(content: Text('This is a snackbar')));
          //   }),
            VerticalDivider(color: Colors.transparent,),
        ],
      ),
      drawer: SideDrawer(
        courses: courses, 
        modules: modules
      ),
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
               TabBar(
                  tabs: [
                    Tab(
                      text: 'Recent Activity'
                    ),
                    Tab(
                      text: 'Favourites'
                    ),
                    Tab(
                      text: 'My Posts'
                    ),
                  ],
                )
              ],
            ),
          ),
          body: TabBarView(
            children: [
              QuestionSummary(),
              Icon(Icons.directions_car),
              Icon(Icons.directions_transit),
            ],
          ),
        ),
      ),

    );
  }

}
