import 'package:flutter/material.dart';
import 'package:wits_overflow/screens/post_question_screen.dart';

class PostedQuestionsTab extends StatefulWidget {
  @override
  _PostedQuestionsTab createState() => _PostedQuestionsTab();
}

class _PostedQuestionsTab extends State<PostedQuestionsTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Posted Questions")),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.post_add_outlined,
              size: 64,
            ),
            Text(
              'No posted questions',
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        key: ValueKey(4),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => PostQuestionScreen()));
        },
        tooltip: 'Post Question',
        label: Text('Make a post'),
        icon: Icon(Icons.add),
      ),
    );
  }
}
