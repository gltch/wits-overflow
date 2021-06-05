// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wits_overflow/utils/wits_overflow_data.dart';
import 'package:wits_overflow/widgets/side_drawer.dart';

class HomeScreen extends StatefulWidget {
  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {

  late Future<List<Map<String, dynamic>>> questions;

  @override
  void initState() {
    super.initState();

    questions = WitsOverflowData().fetchQuestions();

    //WitsOverflowData().addQuestion({ 'title': 'This is a test 1 2 3' });
    
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: SideDrawer(),
      body: FutureBuilder<List<Map<String, dynamic>>>(
                        future: questions,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data?.length,
                              itemBuilder: (context, index) {
                                Map<String, dynamic>? question = snapshot.data?[index];

                                if (question != null) {
                                  return Text(
                                      "Question ${question['title']}'");
                                } else {
                                  return Text('Could not load titles');
                                }
                              },
                            );
                          } else if (snapshot.hasError) {
                            return Text("${snapshot.error}");
                          }

                          // By default, show a loading spinner.
                          return CircularProgressIndicator();
                        },
                      )

    );
  }

}
