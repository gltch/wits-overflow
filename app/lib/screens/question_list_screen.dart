import 'package:flutter/material.dart';
import 'package:wits_overflow/screens/question_section.dart';
import 'package:wits_overflow/utils/wits_overflow_api.dart';
import 'package:wits_overflow/models/question.dart';

class QuestionListScreen extends StatefulWidget {
  final String module;
  QuestionListScreen({Key? key, required this.module}) : super(key: key);
  @override
  _QuestionListState createState() => new _QuestionListState();
}

class _QuestionListState extends State<QuestionListScreen> {
  late Future<List<Question>> questions;

  @override
  void initState() {
    super.initState();
    questions = WitsOverflowApi.fetchQuestions(widget.module);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Wits Overflow'),
        ),
        body: SizedBox(
            child: FutureBuilder<List<Question>>(
          future: questions,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                padding: EdgeInsets.only(top: 10, left: 10),
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  Question? question = snapshot.data?[index];
                  Container q;
                  QuestionSection qs;
                  if (question != null) {
                    q = new Container(
                      child: Text(question.title,
                          style: TextStyle(fontSize: 26.0)),
                      margin: const EdgeInsets.all(15.0),
                      padding: const EdgeInsets.all(3.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueAccent)),
                    );
                    qs = QuestionSection(question.title, "Answer");
                  } else {
                    q = new Container(
                        child: Text('Could not load titles',
                            style: TextStyle(fontSize: 26.0)));
                    qs = QuestionSection('Could not load titles', "Answer");
                  }
                  return GestureDetector(
                    child: q,
                    onTap: () => ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: qs)),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        )));
  }
}
