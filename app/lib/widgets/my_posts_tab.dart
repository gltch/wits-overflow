import 'package:flutter/material.dart';
import 'package:wits_overflow/widgets/question_summary.dart';

class MyPostsTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return ListView(
      padding: EdgeInsets.all(10),
      children: [
        QuestionSummary()
      ],
    );

  }

}

