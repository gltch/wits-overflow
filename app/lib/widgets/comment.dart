
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
import 'package:wits_overflow/widgets/wits_overflow_scaffold.dart';
import 'package:wits_overflow/screens/question_and_answers_screen.dart';


class CommentWidget extends StatelessWidget{

  final String displayName;
  final String body;
  final DateTime createdAt;

  CommentWidget({required this.displayName, required this.body, required this.createdAt });

  @override
  Widget build(BuildContext context) {
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
                    formatDateTime(createdAt),
                    style:TextStyle(
                      fontSize: 11,
                      color: Colors.blue,
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
}