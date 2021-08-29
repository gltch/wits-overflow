


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:wits_overflow/forms/question_answer_form.dart';
import 'package:wits_overflow/forms/question_comment_form.dart';
import 'package:wits_overflow/startup/wits_overflow_app.dart';
import 'package:wits_overflow/utils/functions.dart';
import 'package:wits_overflow/utils/wits_overflow_data.dart';
import 'package:wits_overflow/widgets/wits_overflow_scaffold.dart';
import 'package:wits_overflow/screens/question_and_answers_screen.dart';


class QuestionWidget extends StatelessWidget{


  final int votes;
  final String id;
  final String title;
  final String body;
  final Timestamp createdAt;
  final String authorDisplayName;

  QuestionWidget({
    required this.id, required this.title, required this.body, required this.votes, required this.createdAt, required this.authorDisplayName});


  Widget build(BuildContext context){
    return Column(
      children: [

        Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1, color: Color.fromRGBO(228, 230, 232, 1.0)),
            ),
          ),
          // padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
          child:Row(
            children: <Widget>[

              /// up vote button, down vote button
              /// number of votes
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    color: Color.fromRGBO(214, 217, 220, 0.2),
                    child: Column(
                      // mainAxisSize: MainAxisSize.min,
                      children: <Widget>[

                        TextButton(
                          onPressed: () {
                            WitsOverflowData().voteQuestion(context: context, value: 1, questionId: this.id, userId: FirebaseAuth.instance.currentUser!.uid);
                          },
                          style: TextButton.styleFrom(
                            minimumSize: Size(0, 0),
                            padding: EdgeInsets.all(0.5),
                            // backgroundColor: Colors.black12,
                          ),

                          child: SvgPicture.asset(
                            'assets/icons/caret_up.svg',
                            semanticsLabel: 'Feed button',
                            placeholderBuilder: (context) {
                              return Icon(Icons.error, color: Colors.deepOrange);
                            },
                            height: 12.5,
                          ),
                        ),

                        Text(
                          // this.questionVotes!.docs.length.toString(),
                          this.votes.toString(),
                          style: TextStyle(
                            // backgroundColor: Colors.black12,
                            // fontSize: 20,
                          ),
                        ),

                        TextButton(

                          onPressed: () {
                            WitsOverflowData().voteQuestion(context: context, questionId: this.id, value: -1, userId: FirebaseAuth.instance.currentUser!.uid);
                          },
                          style: TextButton.styleFrom(
                            minimumSize: Size(0, 0),
                            padding: EdgeInsets.all(0.5),
                            // backgroundColor: Colors.black12,
                          ),

                          child: SvgPicture.asset(
                            'assets/icons/caret_down.svg',
                            semanticsLabel: 'Feed button',
                            placeholderBuilder: (context) {
                              return Icon(Icons.error, color: Colors.deepOrange);
                            },
                            height: 12.5,
                          ),
                        ),

                      ],
                    ),
                  ),
                ],
              ),



              /// question title
              Expanded(
                child: Container(
                  // color: Colors.black12,
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(5),
                  child: Text(
                    this.title,
                    // this.getQuestionTitle(),
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 20,
                      // fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                    softWrap: true,
                  ),
                ),
              ),

              // Expanded(
              //   child: Row(
              //     children: <Widget>[
              //       // date posted
              //       Text(
              //         this.question!.get('createAt').toString(),
              //       ),
              //
              //       Text(
              //         this.questionUser!.get('displayName').toString(),
              //       ),
              //       // user information
              //     ],
              //   ),
              // ),
            ],
          ),
        ),


        /// question body
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Color.fromARGB(100, 214, 217, 220),
              ),
            ),
          ),
          padding: EdgeInsets.all(15),
          child: Text(
            this.body,
            // this.getQuestionBody(),
          ),
        ),

        Padding(
          padding: EdgeInsets.only(left: 10),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            // mainAxisSize: MainAxisSize.,
            children: [

              // share button
              TextButton.icon(
                icon: Icon(Icons.favorite),
                label: Text(
                  "Favourite",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                ),
                onPressed: () => {
                  WitsOverflowData().addFavouriteQuestion(
                    userId: FirebaseAuth.instance.currentUser!.uid,
                    questionId: this.id,
                  ).then((result) {
                    showNotification(context, 'Favourite added.');
                  })
                },
                style: TextButton.styleFrom(
                  minimumSize: Size(0, 0),
                  padding: EdgeInsets.all(1),
                  // backgroundColor: Colors.black12,
                  primary: Color.fromRGBO(32, 141, 149, 1),
                ),
              ),

              // edit button
              // TextButton(
              //   child: Text(
              //     "Edit",
              //     style: TextStyle(
              //       fontSize: 12,
              //     ),
              //   ),
              //   onPressed: (){
              //     print("[QUESTION EDIT BUTTON PRESSED]");
              //   },
              //   style: TextButton.styleFrom(
              //     minimumSize: Size(0, 0),
              //     padding: EdgeInsets.all(1),
              //     primary: Color.fromRGBO(32, 141, 149, 1.0),
              //     // backgroundColor: Colors.black12,

              //   ),
              // ),

              // // follow button
              // TextButton(
              //   child: Text(
              //     "Follow",
              //     style: TextStyle(
              //       fontSize: 12,
              //     ),
              //   ),
              //   onPressed: (){
              //     print("[QUESTION FOLLOW BUTTON PRESSED]");
              //   },
              //   style: TextButton.styleFrom(
              //     minimumSize: Size(0, 0),
              //     padding: EdgeInsets.all(1),
              //     // backgroundColor: Colors.black12,
              //     primary: Color.fromRGBO(32, 141, 149, 1.0),
              //   ),
              // ),
            ],
          ),
        ),

        /// user who asked question
        Container(
          color: Color.fromRGBO(242, 249, 255, 1),
          padding: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // user information
              Container(
                child: Row(
                  children: [
                    // user avatar image
                    Container(
                        child: Image(
                            height: 25,
                            width: 25,

                            image: AssetImage('assets/images/default_avatar.png'))
                    ),

                    // user information (display name, metadata)
                    Column(
                      children: [
                        // user display name
                        Text(
                            this.authorDisplayName,
                            // this.questionUser!.get('displayName'),
                            style: TextStyle(
                              color: Colors.blue,
                            )
                        ),
                        // user metadata
                        Row(
                          children: [

                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // datetime
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'asked',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        // backgroundColor: Colors.black12,
                      ),
                    ),
                    Text(
                      // formatDateTime(DateTime.fromMillisecondsSinceEpoch((this.question!.get('createdAt') as Timestamp).millisecondsSinceEpoch)),
                      formatDateTime(DateTime.fromMillisecondsSinceEpoch((this.createdAt).millisecondsSinceEpoch)),
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),


        /// user who updated question
        Container(


        ),
      ],
    );
  }

}