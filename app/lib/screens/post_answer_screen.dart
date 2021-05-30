import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:wits_overflow/utils/sidebar.dart';
//void main() async {
//WidgetsFlutterBinding.ensureInitialized();
//await Firebase.initializeApp();
//runApp(
//MaterialApp(
//home: AnswersPage(),

//));}

class AnswersPage extends StatefulWidget {
  final question_id;
  @override
  AnswersPage(this.question_id);
  _AnswersPageState createState() => _AnswersPageState(question_id);
}

class _AnswersPageState extends State<AnswersPage> {
  final question_id;
  _AnswersPageState(this.question_id);
  final answer = TextEditingController();
  dynamic questionBody = "Failed to retrieve question";
  dynamic authorId = "";
  @override
  Widget build(BuildContext context) {
    var get_answers = FirebaseFirestore.instance
        .collection('answers')
        .where("question", isEqualTo: this.question_id)
        .snapshots();
    // Future<DocumentSnapshot> question = FirebaseFirestore.instance
    //     .collection('questions')
    //     .doc(this.question_id)
    //     .get();
    _getQuestionId() {
      // dynamic temp = question.then((questionDocumentSnapshot) {
      //   this.questionBody = questionDocumentSnapshot["body"];
      //   this.authorId = questionDocumentSnapshot["user"];
      // });
    }

    _getQuestionId();

    return Scaffold(
        drawer: SideDrawer(),
        appBar: AppBar(
          title: Text("wits-overflow"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            Container(
              child: Column(children: <Widget>[
                Text(
                  questionBody.toString(),
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
              padding: EdgeInsets.all(10.0),
              width: 450,
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10.0, 0.0, 50.0, 0.0),
              child: StreamBuilder(
                stream: get_answers,
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      height: 500,
                      child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            DateTime now = snapshot.data!.docs[index]
                                .get('createdAt')
                                .toDate();
                            String convertedDateTime =
                                "${now.year.toString()}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')} ${now.hour.toString()}-${now.minute.toString()}";

                            return Container(
                              height: 100,
                              child: Card(
                                color: Colors.lightBlue,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20.0, 10, 20, 10),
                                      child: Text(
                                        snapshot.data!.docs[index].get('body'),
                                        style: TextStyle(
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(20.0, 10, 20, 10),
                                      child: Text(
                                        convertedDateTime,
                                        style: TextStyle(
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
            ),
            Container(
              margin: EdgeInsets.all(20.0),
              child: TextField(
                controller: answer,
                decoration: InputDecoration(
                  labelText: "Answer",
                  hintText: "Type your answer here",
                  border: OutlineInputBorder(),
                ),
                maxLength: 10000,
                maxLines: 2,
                showCursor: true,
              ),
            ),
            ElevatedButton.icon(
                onPressed: () {
                  FirebaseFirestore.instance.collection('answers').add({
                    'body': this.answer.text,
                    'user': '${this.authorId}',
                    'question':
                        '${this.question_id}', //update this to fit the current id
                    'createdAt': DateTime.now(),
                  });
                  answer.clear();
                  //print(query);
                },
                icon: Icon(
                  Icons.publish,
                ),
                label: Text("Post")),
          ]),
        ));
  }
}
