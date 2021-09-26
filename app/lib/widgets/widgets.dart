import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wits_overflow/utils/functions.dart';

/// the UserCase widget is used to display the author and the editor of
/// questions and answers
class UserCard extends StatelessWidget {
  final String authorId;
  final String authorDisplayName;
  final Timestamp createdAt;

  final String? editorId;
  final String? editorDisplayName;
  final Timestamp? editedAt;

  UserCard(
      {required this.createdAt,
      required this.authorId,
      required this.authorDisplayName,
      this.editorId,
      this.editorDisplayName,
      this.editedAt});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // author information
        Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(240, 248, 225, 1),
            border: Border(
              bottom: BorderSide(
                width: 0.5,
                color: Color.fromRGBO(239, 240, 241, 1),
              ),
            ),
          ),
          padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
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
                            image: AssetImage(
                                'assets/images/default_avatar.png'))),

                    // user information (display name, metadata)
                    Column(
                      children: [
                        // user display name
                        Text(this.authorDisplayName,
                            // this.answersUsers[answerId]!.get('displayName'),
                            style: TextStyle(
                              color: Colors.blue,
                            )),
                        // user metadata
                        Row(
                          children: [],
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
                      'answered at',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        // backgroundColor: Colors.black12,
                      ),
                    ),
                    Text(
                      formatDateTime(this.createdAt.toDate()),
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

        // editor information
        this.editorDisplayName != null && this.editedAt != null
            ? Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 0.5,
                      color: Color.fromRGBO(239, 240, 241, 1),
                    ),
                  ),
                ),
                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // user information
                    Container(
                      child: Row(
                        children: [
                          // user avatar image
                          this.authorId != editorId
                              ? Container(
                                  child: Image(
                                      height: 25,
                                      width: 25,
                                      image: AssetImage(
                                          'assets/images/default_avatar.png')))
                              : Padding(
                                  padding: EdgeInsets.all(0),
                                ),

                          // user information (display name, metadata)
                          Column(
                            children: [
                              // user display name
                              Text(
                                  this.authorId == this.editorId
                                      ? ""
                                      : this.editorDisplayName!,
                                  // this.answersUsers[answerId]!.get('displayName'),
                                  style: TextStyle(
                                    color: Colors.blue,
                                  )),
                              // user metadata
                              Row(
                                children: [],
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
                            'edited at',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Colors.blueAccent,
                              // backgroundColor: Colors.black12,
                            ),
                          ),
                          Text(
                            formatDateTime(this.editedAt!.toDate()),
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : Padding(padding: EdgeInsets.all(0)),
      ],
    );
  }
}
