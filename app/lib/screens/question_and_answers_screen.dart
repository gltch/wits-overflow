

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:wits_overflow/forms/question_answer_form.dart';
import 'package:wits_overflow/forms/question_comment_form.dart';
import 'package:wits_overflow/utils/functions.dart';
import 'package:wits_overflow/utils/wits_overflow_data.dart';
import 'package:wits_overflow/widgets/question.dart';
import 'package:wits_overflow/widgets/wits_overflow_scaffold.dart';
import 'package:wits_overflow/widgets/answer.dart';
import 'package:wits_overflow/widgets/comment.dart';


// ---------------------------------------------------------------------------
//             Dashboard class
// ---------------------------------------------------------------------------
class QuestionAndAnswersScreen extends StatefulWidget{

  final String id; //question id

  QuestionAndAnswersScreen(this.id);

  @override
  _QuestionState createState() => _QuestionState(this.id);
}

class _QuestionState extends State<QuestionAndAnswersScreen> {

  final String id; // question id

  DocumentSnapshot<Map<String, dynamic>> ? question;

  QuerySnapshot<Map<String, dynamic>> ? questionVotes;
  QuerySnapshot<Map<String, dynamic>> ? questionComments;
  QuerySnapshot<Map<String, dynamic>> ? questionAnswers;

  DocumentSnapshot<Map<String, dynamic>> ? questionUser;

  Map<String, DocumentSnapshot<Map<String, dynamic>>> commentsUsers = Map<String, DocumentSnapshot<Map<String, dynamic>>>();
  Map<String, DocumentSnapshot<Map<String, dynamic>>> answersUsers = Map<String, DocumentSnapshot<Map<String, dynamic>>>();
  Map<String, QuerySnapshot> answerVotes = Map<String, QuerySnapshot>();

  bool isBusy = true;

  _QuestionState(this.id){
    this.getData();
  }

  Future<void> getData() async {

    // retrieve necessary data from firebase to view this page

    print('[-------------------------------------------- [RETRIEVING DATA FROM FIREBASE] --------------------------------------------]');

    // get votes information for each answer
    Future<Map<String, QuerySnapshot>> getAnswerVotes() async{
      Map<String, QuerySnapshot> votes = Map();
      for(var i = 0; i < this.questionAnswers!.docs.length; i++){
        votes.addAll({
          this.questionAnswers!.docs[i].id: await FirebaseFirestore.instance.collection('questions-2')
          .doc(this.id).collection('answers')
          .doc(this.questionAnswers!.docs[i].id)
          .collection('votes').get()
        });
      }
      return votes;
    }

    // get user information for each comment
    Future<Map<String, DocumentSnapshot<Map<String, dynamic>>>> getCommentsUsers() async{
      Map<String, DocumentSnapshot<Map<String, dynamic>>> commentsUsers = Map();
      for(var i = 0; i < this.questionComments!.docs.length; i++){
        commentsUsers.addAll({this.questionComments!.docs[i].id: await FirebaseFirestore.instance.collection('users').doc(this.questionComments!.docs[i].get('authorId')).get()});
      }
      return commentsUsers;
    }


    // get user information for each answer
    Future<Map<String, DocumentSnapshot<Map<String, dynamic>>>> getAnswersUsers() async{
      Map<String, DocumentSnapshot<Map<String, dynamic>>> answersUsers = Map();
      for(var i = 0; i < this.questionAnswers!.docs.length; i++){
        print('[ADDING USER INFORMATION TO ANSWER WITH ID: ${this.questionAnswers!.docs[i].id}]');
        DocumentSnapshot<Map<String, dynamic>> user = await FirebaseFirestore.instance.collection('users').doc(this.questionAnswers!.docs[i].get('authorId')).get();
        answersUsers.addAll({this.questionAnswers!.docs[i].id: user});
        print('[USER: id: ${user.id}]');
        // print('[USER INFORMATION ADDED TO ANSWER WITH ID: ${this.answers!.docs[i].id}, user.uid: ${answersUsers[this.answers!.docs[i].id]!.id}, user.displayName: ${answersUsers[this.answers!.docs[i].id]!.get('displayName')}]');
      }
      return answersUsers;
    }

    this.question = await FirebaseFirestore.instance.collection("questions-2").doc(this.id).get();

    // stores information of the user that first asked the question
    this.questionUser = await FirebaseFirestore.instance.collection('users').doc(this.question!.get('authorId')).get();
    this.questionVotes = await FirebaseFirestore.instance.collection('questions-2').doc(this.id).collection('votes').get();
    this.questionComments = await FirebaseFirestore.instance.collection('questions-2').doc(this.id).collection('comments').get();
    this.questionAnswers = await FirebaseFirestore.instance.collection('questions-2').doc(this.id).collection('answers').get();

    this.answerVotes = await getAnswerVotes();
    this.answersUsers = await getAnswersUsers();
    this.commentsUsers = await getCommentsUsers();

    print('[-------------------------------------------- [RETRIEVED DATA FROM FIREBASE] --------------------------------------------]');
    setState(() {
      this.isBusy = false;
    });
  }

  Widget buildCommentsWidget(){


    print('[QUESTION COMMENTS LENGTH : ${this.questionComments!.docs.length.toString()}]');
    List<Widget> comments = <Widget>[];
    for(var i = 0; i < this.questionComments!.docs.length; i++){
    // this.comments!.docs.forEach((commentDoc) {
      QueryDocumentSnapshot<Map<String, dynamic>> commentDoc = this.questionComments!.docs[i];
      print('[CREATING COMMENT WIDGET]');
      DocumentSnapshot<Map<String, dynamic>> commentUser = this.commentsUsers[commentDoc.id]!;
      String displayName;
      if(commentUser.data() == null){
        displayName = '[user information not in database]';
      }
      else{
        displayName = getField(commentUser.data()!, 'displayName', onNull: '?display name?', onError: '?display name?');

      }
      String body = getField(commentDoc.data(), 'body', onError: '[error, body not found for this comment]');
      DateTime createdAt = getField(commentDoc.data(), 'createAt', onError:DateTime.now(), onNull:DateTime.now());
      comments.add(CommentWidget(body: body, displayName: displayName, createdAt: createdAt));
    }

    comments.add(
      Container(
        child:TextButton(
          child: Text('add comment'),
          onPressed: (){
            print('[ADD COMMENT BUTTON PRESSED]');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context){
                  return QuestionCommentForm(this.question!.id, this.question!.get('title'), question!.get('body'));
                },
              ),
            );
          },
        ),
      )
    );

     return Container(
       padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
       child: Column(
         children:comments,
       ),
     );
  }

  void _addFavouriteQuestion() {

    if (FirebaseAuth.instance.currentUser != null) {

      String questionId = this.id;
      String userId = FirebaseAuth.instance.currentUser!.uid;

      WitsOverflowData().addFavouriteQuestion(
        userId: userId, 
        questionId: questionId
      ).then((result) {
          showNotification(context, 'Favourite added.');
      });
    }
  }

  // void changeAnswerStatus({required String answerId}) async{
  //   setState(() {
  //     this.isBusy = true;
  //   });
  //   // if the user is the author of the question
  //
  //   // retrieve answer from database
  //   CollectionReference<Map<String, dynamic>> questionAnswersCollection = FirebaseFirestore.instance.collection('questions-2').doc(this.id).collection('answers');
  //   DocumentSnapshot<Map<String, dynamic>> answer = await questionAnswersCollection.doc(answerId).get();
  //   bool accepted = (answer.data()!['accepted'] == null)  ? false : answer.data()!['accepted'];
  //
  //   bool value = false;
  //   if( accepted == true){
  //     // change answer
  //     value = false;
  //   }
  //   else{
  //     value = true;
  //     // all other answer should change status
  //     QuerySnapshot<Map<String, dynamic>> acceptedAnswer = await questionAnswersCollection.where('accepted', isEqualTo: true).get();
  //     for(var i = 0; i < acceptedAnswer.docs.length; i++){
  //       acceptedAnswer.docs.elementAt(i).reference.update({'accepted': false});
  //     }
  //   }
  //
  //   answer.reference.update({'accepted': value}).then((value){
  //     showNotification('Changed answer status');
  //     Navigator.push(context, MaterialPageRoute(
  //         builder: (BuildContext context){
  //           return QuestionAndAnswersScreen(this.id);
  //         }
  //     ))
  //     .catchError((error){
  //       showNotification('Error occurred');
  //     });
  //   });
  //
  //   setState(() {
  //     this.isBusy = false;
  //   });
  // }


  // QueryDocumentSnapshot getAnswer({required String answerId}){
  //   // returns answer (as QuerySnapsShot) from answers
  //   for(var i = 0; i < this.questionAnswers!.docs.length; i++){
  //     if(this.questionAnswers!.docs.elementAt(i).id == answerId){
  //       return this.questionAnswers!.docs.elementAt(i);
  //     }
  //   }
  //   throw Exception("Could not find answer(id: $answerId) from available answers");
  // }

  Widget buildAnswersWidget(){

    List<Widget> answers = <Widget>[];
    for(var i = 0; i < this.questionAnswers!.docs.length; i++){
      // print('[GETTING QUESTION ANSWER VOTES WITH ID: ${this.questionAnswers!.docs[i].id.toString()}, this.answerVotes.keys().toString: ${this.answerVotes.keys.toString()}]');
      bool ? accepted = this.questionAnswers!.docs.elementAt(i).data()['accepted'];
      String answerId = this.questionAnswers!.docs.elementAt(i).id;
      String authorDisplayName = this.answersUsers[answerId]!.data()!['displayName'];
      answers.add(
        new AnswerWidget(
          id: this.questionAnswers!.docs.elementAt(i).id,
          authorDisplayName: authorDisplayName,
          votes: this.answerVotes[this.questionAnswers!.docs[i].id.toString()]!.docs.length.toString(),
          body: this.questionAnswers!.docs[i].get('body'),
          answeredAt: formatDateTime(DateTime.fromMillisecondsSinceEpoch((this.questionAnswers!.docs.elementAt(i).get('answeredAt') as Timestamp).millisecondsSinceEpoch)),
          accepted: accepted == null ? false : accepted,
          authorId: this.questionAnswers!.docs[i].get('authorId'),
          questionId: this.question!.id,
          questionAuthorId: this.question!.get('authorId'),
        ),
      );
    }
    
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: answers,
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    print('_QuestionState.build');
    //
    if(this.isBusy){
      return WitsOverflowScaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }


    return WitsOverflowScaffold(
      body: Center(
        child:Container(
          child: ListView(
            children: <Widget>[

              /// question title and body
              /// votes, up-vote and down-vote
              QuestionWidget(
                  id: this.id,
                  title: this.question!.get('title'),
                  body: this.question!.get('title'),
                  votes: this.questionVotes!.docs.length,
                  createdAt: this.question!.get('createdAt'),
                  authorDisplayName: this.questionUser!.get('displayName'),
              ),


              // divider
              // Divider(),


              /// comments
              /// comments header
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(239, 240, 241, 1),
                  border: Border(
                    bottom: BorderSide(
                      color: Color.fromRGBO(214, 217, 220, 1),
                    ),
                  ),
                ),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 15),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Comments',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                  ],
                ),
              ),

              /// comments list
              this.buildCommentsWidget(),

              /// answers
              /// answers header
              Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(239, 240, 241, 1),
                  border: Border(
                    bottom: BorderSide(
                      color: Color.fromRGBO(214, 217, 220, 1),
                    ),
                  ),
                ),
                // color: Color(0xff2980b9),
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '${this.questionAnswers!.docs.length.toString()} answers',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    TextButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context){
                                return QuestionAnswerForm(this.question!.id, this.question!.get('title'), this.question!.get('body'));
                              }
                          ),
                        );
                      },
                      child: Icon(Icons.add),)
                  ],
                ),
              ),

              /// answers list
              this.buildAnswersWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
