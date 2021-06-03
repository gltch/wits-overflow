import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:wits_overflow/widgets/navigation.dart';
import 'package:wits_overflow/screens/question_screen.dart';



// -----------------------------------------------------------------------------
//                      QUESTION CREATE FORM
// -----------------------------------------------------------------------------
class QuestionCommentForm extends StatefulWidget {

  final String questionId;
  final String questionTitle;
  final String questionBody;

  QuestionCommentForm(this.questionId, this.questionTitle, this.questionBody);

  @override
  _QuestionCommentFormState createState() {
    return _QuestionCommentFormState(this.questionId, this.questionTitle, this.questionBody);
  }
}

// -----------------------------------------------------------------------------
//                      QUESTION CREATE FORM STATE
// -----------------------------------------------------------------------------
class _QuestionCommentFormState extends State<QuestionCommentForm> {


  final _formKey = GlobalKey<FormState>();
  final String questionId;
  final String questionTitle;
  final String questionBody;

  bool isBusy = true;
  DocumentSnapshot<Map<String, dynamic>> ? question;


  final bodyController = TextEditingController();


  void getData() async{
    this.question = await FirebaseFirestore.instance.collection('questions').doc(this.questionId).get();

    setState(() {
      this.isBusy = false;
    });
  }


  _QuestionCommentFormState(this.questionId, this.questionTitle, this.questionBody){
    this.getData();
  }

  DocumentReference ? submitAnswer(String body) {

    DocumentReference ? answer;

    setState(() {
      isBusy = true;
    });
    Map<String, dynamic> data = {
      'user': FirebaseAuth.instance.currentUser!.uid,
      'body': body,
    };
    CollectionReference questionAnswersCollection = FirebaseFirestore.instance.collection('questions').doc(this.questionId).collection('comments');
    questionAnswersCollection.add(data).then((onValue) {
      answer = onValue;
      print("[COMMENT ADDED]");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Successfully posted comment'),
        ),
      );

      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context){
              return Question(this.questionId);
            },
          )
      );
    }).catchError((error){
      // if error occurs while submitting user answer
        print("[FAILED TO ADD COMMENT]: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error occurred'),
        ),
      );
    });
    setState(() {
      isBusy = false;
    });
    return answer;
  }


  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    // TODO: include courses dropdown list

    if(this.isBusy){
      return Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('wits overflow'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // for (var dropdownMenuItem in this.dropdownButtonMenuItems) {
    //   print('[QuestionCreateFormState.build dropDownMenuItem: text: ${dropdownMenuItem.child.toString()}, value: ${dropdownMenuItem.value}]');
    // }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Wits overflow'),
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
            color: Color.fromARGB(100, 220, 220, 220),
            child:Text(
              'Post answer',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(100, 16, 16, 16)
              ),
            ),
          ),

          Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 5),
            alignment: Alignment.centerLeft,
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 5),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    this.questionTitle,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w600,
                      color: Color.fromARGB(1000, 70, 70, 70),

                    ),
                  ),
                ),

                Text(
                  this.questionBody,
                  style: TextStyle(
                    color: Color.fromARGB(1000, 70, 70, 70),
                  ),
                ),
              ],
            ),
          ),

          Center(
            child: Form(
              key: _formKey,
              child: Container(
                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                // margin: EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Container(
                      // color:Color.fromARGB(1000, 100, 100, 100),
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: TextFormField(
                        controller: this.bodyController,
                        maxLines: 15,
                        minLines: 10,
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          labelText: 'comment',

                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                    ),

                    Container(

                      width: double.infinity,
                      // color:Color.fromARGB(1000, 100, 100, 100),
                      // alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: ElevatedButton(
                        onPressed: (){
                          // when the user wants to submit his/her answer to the question
                          if(submitAnswer(bodyController.text.toString()) != null){
                            // redirect to question page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context){
                                    return Question(this.questionId);
                                  }
                              ),
                            );
                          }
                        },
                        child: Text('post'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


