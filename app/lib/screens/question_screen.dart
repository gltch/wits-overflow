

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:wits_overflow/widgets/navigation.dart';
import 'package:wits_overflow/utils/functions.dart';


// ---------------------------------------------------------------------------
//             Dashboard class
// ---------------------------------------------------------------------------
class Question extends StatefulWidget{

  final String id; //question id

  Question(this.id);

  @override
  _QuestionState createState() => _QuestionState(this.id);
}

class _QuestionState extends State<Question> {

  final String id; // question id

  DocumentSnapshot ? question;

  QuerySnapshot<Map<String, dynamic>> ? questionVotes;
  QuerySnapshot<Map<String, dynamic>> ? comments;
  QuerySnapshot<Map<String, dynamic>> ? answers;

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
      for(var i = 0; i < this.answers!.docs.length; i++){
        votes.addAll({this.answers!.docs[i].id: await FirebaseFirestore.instance.collection('questions').doc(this.id).collection('answers').doc(this.answers!.docs[i].id).collection('votes').get()});
      }
      return votes;
    }

    // get user information for each comment
    Future<Map<String, DocumentSnapshot<Map<String, dynamic>>>> getCommentsUsers() async{
      Map<String, DocumentSnapshot<Map<String, dynamic>>> commentsUsers = Map();
      for(var i = 0; i < this.comments!.docs.length; i++){
        commentsUsers.addAll({this.comments!.docs[i].id: await FirebaseFirestore.instance.collection('users').doc(this.comments!.docs[i].get('user')).get()});
      }
      return commentsUsers;
    }


    // get user information for each answer
    Future<Map<String, DocumentSnapshot<Map<String, dynamic>>>> getAnswersUsers() async{
      Map<String, DocumentSnapshot<Map<String, dynamic>>> answersUsers = Map();
      for(var i = 0; i < this.answers!.docs.length; i++){
        answersUsers.addAll({this.answers!.docs[i].id: await FirebaseFirestore.instance.collection('users').doc(this.comments!.docs[i].get('user')).get()});
      }
      return answersUsers;
    }

    this.question = await FirebaseFirestore.instance.collection("questions").doc(this.id).get();
    this.questionVotes = await FirebaseFirestore.instance.collection('questions').doc(this.id).collection('votes').get();
    this.comments = await FirebaseFirestore.instance.collection('questions').doc(this.id).collection('comments').get();
    this.answers = await FirebaseFirestore.instance.collection('questions').doc(this.id).collection('answers').get();

    this.answerVotes = await getAnswerVotes();
    this.answersUsers = await getAnswersUsers();
    this.commentsUsers = await getCommentsUsers();

    print('[-------------------------------------------- [RETRIEVED DATA FROM FIREBASE] --------------------------------------------]');
    setState(() {
      this.isBusy = false;
    });
  }


  Widget buildCommentsWidget(){

    // TODO: remote the following lines in production


    Widget buildCommentWidget({required String displayName, required String body, required DateTime createdAt }){
      return Container(
        padding: EdgeInsets.fromLTRB(0, 3, 0, 3),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              // color: Color,
              color: Color.fromARGB(50, 100, 100, 100),
            ),
          ),
        ),
        child: Column(

          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// user first and last names
            /// user comment
            Container(
                alignment: Alignment.centerLeft,
                child: Text(body)
            ),

            /// comment: time and user
            Container(
              padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
              child: Row(

                // mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  // datetime
                  /// comment datetime
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                    child: Text(
                      createdAt.toString(),
                      style:TextStyle(
                        fontSize: 11,
                        color: Colors.black26,
                      ),
                    ),
                  ),

                  // user
                  /// comment user
                  Container(
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Text(
                      displayName,
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    }

    List<Widget> comments = <Widget>[];
    for(var i = 0; i < this.comments!.docs.length; i++){
    // this.comments!.docs.forEach((commentDoc) {
      QueryDocumentSnapshot<Map<String, dynamic>> commentDoc = this.comments!.docs[i];
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
      comments.add(buildCommentWidget(body: body, displayName: displayName, createdAt: createdAt));
      // comments.add(Divider());
      if(i == this.comments!.docs.length - 1 ){
        comments.add(
          Container(
            child:TextButton(
              child: Text('add comment'),
              onPressed: (){
                print('[ADD COMMENT BUTTON PRESSED]');
              },
            ),
          )
        );
      }

    }

     return Container(
       padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
       child: Column(
         children:comments,
       ),
     );
  }


  String getQuestionBody(){
    // TODO: get body field properly
    // check whether 'body' field exist in the document snapshot question
    // if you try to access it and its not there, it will give error
    return this.question!.get('body');
  }


  String getQuestionTitle() {
    // TODO: get title field properly
    // check whether 'title' field exist in the document snapshot question
    // if you try to access it and its not there, it will give error
    return this.question!.get('title');
  }


  Widget buildAnswersWidget(){
    
    
    Widget buildAnswerWidget(String votes, String body, ){
      /// answer widget
      return Column(
        children: [
          /// update vote button, down vote button, votes, question body
          Row(
            mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// answer up vote button, down vote button, votes vote button
              Container(
                // color: Colors.black26,
                padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                child: Column(
                  children: [
                    Container(
                      // color: Colors.black12,
                      // padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                      child:Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          /// up vote button, down vote button
                          /// number of votes
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Icon(Icons.arrow_drop_up, size: 40,),
                                    Text(
                                      // TODO: insert real votes
                                      votes,
                                      // this.votes!.docs.length.toString(),
                                      style: TextStyle(
                                        // fontSize: 20,
                                      ),
                                    ),
                                    Icon(Icons.arrow_drop_down, size: 40,),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),


              /// answer body
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children:<Widget>[
                    Flexible(
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          body,
                          textAlign: TextAlign.left,
                          softWrap: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),


          /// creator information
          Row(),


          /// update information
          Row(),
        ],
      );
    }
    
    
    List<Widget> answers = <Widget>[];
    for(var i = 0; i < this.answers!.docs.length; i++){
      print('[GETTING QUESTION ANSWER VOTES WITH ID: ${this.answers!.docs[i].id.toString()}, this.answerVotes.keys().toString: ${this.answerVotes!.keys.toString()}]');
      answers.add(buildAnswerWidget(this.answerVotes[this.answers!.docs[i].id.toString()]!.docs.length.toString(), this.answers!.docs[i].get('body')));
      answers.add(Divider());
    }
    
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Column(
        children: answers,
      ),
    );



  }

  @override
  Widget build(BuildContext context) {
    print('_QuestionState.build');
    //
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


    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Wits overflow'),
      ),
      body: Center(
        child:Container(
          child: ListView(
            children: <Widget>[

              /// question title and body
              /// votes, up-vote and down-vote
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                    child:Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[

                        /// question title and body
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children:<Widget>[
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 10, 10),
                                  child: Text(
                                    this.getQuestionTitle(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.left,
                                    softWrap: true,
                                  ),
                                ),
                              ),
                              /// question body
                              Flexible(
                                child:Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: Text(
                                    this.getQuestionBody(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// up vote button, down vote button
                        /// number of votes
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.arrow_drop_up, size: 40,),
                                  Text(
                                    // this.votes!.docs.length.toString(),
                                    // TODO: insert real votes
                                    this.questionVotes!.docs.length.toString(),
                                    style: TextStyle(
                                      // fontSize: 20,
                                    ),
                                  ),
                                  Icon(Icons.arrow_drop_down, size: 40,),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // divider
              // Divider(),


              /// comments
              /// comments header
              Container(
                decoration: BoxDecoration(
                  color: Color.fromARGB(100, 239, 240, 241),
                  border: Border(
                    bottom: BorderSide(
                      color: Color.fromARGB(100, 214, 217, 220),
                    ),
                    // top: BorderSide(
                    //   color: Color.fromARGB(100, 214, 217, 220),
                    // ),
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
                  color: Color.fromARGB(100, 239, 240, 241),
                  border: Border(
                    bottom: BorderSide(
                      color: Color.fromARGB(100, 214, 217, 220),
                    ),
                    // top: BorderSide(
                    //   color: Color.fromARGB(100, 214, 217, 220),
                    // ),
                  ),
                ),
                // color: Color(0xff2980b9),
                padding: EdgeInsets.fromLTRB(10, 10, 10, 15),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      '${this.answers!.docs.length.toString()} answers',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    Icon(Icons.add),
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
