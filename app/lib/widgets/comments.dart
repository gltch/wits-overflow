import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wits_overflow/utils/functions.dart';

class Comments extends StatefulWidget {
  /// just displays a list of comments

  final List<Map<String, dynamic>> comments;
  final Map<String, Map<String, dynamic>> commentsAuthors;
  final onAddComments;

  Comments(
      {required this.comments,
      required this.commentsAuthors,
      required this.onAddComments});

  @override
  _CommentsState createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  List<Widget> listComments = <Widget>[];
  late TextButton button;

  void initState() {
    super.initState();
    // add comments to a list of comments
    int numComments = this.widget.comments.length;
    numComments = numComments > 5 ? 5 : numComments;
    for (var i = 0; i < numComments; i++) {
      Map<String, dynamic> comment = this.widget.comments[i];
      this.listComments.add(Comment(
            body: comment['body'],
            commentedAt: comment['commentedAt'] as Timestamp,
            displayName:
                this.widget.commentsAuthors[comment['id']]!['displayName'],
          ));
    }

    // building show more comments / Add a comment button
    late Text text;
    late var onPressedCallback;
    if (this.widget.comments.length > 5) {
      text = Text(
        'Show ${this.widget.comments.length - 5} more comments',
        style: TextStyle(
          color: Colors.blue,
        ),
      );
      onPressedCallback = this._showMoreComments;
    } else {
      text = Text(
        'Add a comment',
        style: TextStyle(
          color: Colors.blue,
        ),
      );
      onPressedCallback = this.widget.onAddComments;
    }

    this.button = TextButton(
      onPressed: onPressedCallback,
      child: text,
    );

    this.listComments.add(
          Container(
            color: Color.fromRGBO(0, 0, 0, 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[this.button],
            ),
          ),
        );
  }

  void _showMoreComments() {
    setState(() {
      this.listComments = [];
      for (var i = 0; i < this.widget.comments.length; i++) {
        Map<String, dynamic> comment = this.widget.comments[i];
        this.listComments.add(Comment(
              body: comment['body'],
              commentedAt: comment['commentedAt'] as Timestamp,
              displayName:
                  this.widget.commentsAuthors[comment['id']]!['displayName'],
            ));
      }

      this.button = TextButton(
        child: Text('Add a comment'),
        onPressed: this.widget.onAddComments,
      );
      this.listComments.add(
            Container(
              color: Color.fromRGBO(100, 0, 0, 0.02),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  this.button,
                ],
              ),
            ),
          );
    });
  }

  @override
  build(BuildContext buildContext) {
    return Column(
      children: listComments,
    );
  }
}

class Comment extends StatelessWidget {
  final String displayName;
  final String body;
  final Timestamp commentedAt;

  Comment(
      {required this.displayName,
      required this.body,
      required this.commentedAt});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          // Container(
          //   width: 20,
          //   color: Color.fromRGBO(0, 0, 0, 0.02),
          // ),
          Expanded(
              flex: 1,
              child: Container(
                padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                child: RichText(
                  text: TextSpan(
                    text: this.body + ' - ',
                    style: DefaultTextStyle.of(context).style,
                    children: <TextSpan>[
                      TextSpan(
                        text: this.displayName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      TextSpan(
                        text: ' ' + formatDateTime(this.commentedAt.toDate()),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
