import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wits_overflow/models/question.dart';
import 'package:wits_overflow/utils/wits_overflow_api.dart';

class ApiRequestExampleScreen extends StatefulWidget {
  ApiRequestExampleScreen({Key? key}) : super(key: key);

  @override
  _ApiRequestExampleScreenState createState() =>
      _ApiRequestExampleScreenState();
}

class _ApiRequestExampleScreenState extends State<ApiRequestExampleScreen> {
  late Future<List<Question>> questions;

  @override
  void initState() {
    super.initState();
    questions = WitsOverflowApi.fetchQuestions("");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
            padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
            child: Column(
                //mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('API Request Example'),
                  SizedBox(
                      height: 200,
                      child: FutureBuilder<List<Question>>(
                        future: questions,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                              itemCount: snapshot.data?.length,
                              itemBuilder: (context, index) {
                                Question? question = snapshot.data?[index];

                                if (question != null) {
                                  return Text(
                                      "Question Id '${question.id} : ${question.title}'");
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
                      ))
                ]))),
    );
  }
}
