import 'package:flutter/material.dart';
import 'package:wits_overflow/models/question.dart';
import 'package:wits_overflow/utils/wits_overflow_api.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PostQuestionScreen extends StatefulWidget {
  PostQuestionScreen({Key? key}) : super(key: key);

  @override
  _PostQuestionState createState() => _PostQuestionState();
}

class _PostQuestionState extends State<PostQuestionScreen> {
  // Variable Declarations
  final titleController = new TextEditingController();
  final questionController = new TextEditingController();

  // Post Question Function
  void _postQuestion() {
    setState(() {
      // Check for empty fields
      if (titleController.text == "") {
        // Show toast message saying posted or not posted
        Fluttertoast.showToast(
            msg: 'Missing Title',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1);
      } else if (questionController.text == "") {
        // Show toast message saying posted or not posted
        Fluttertoast.showToast(
            msg: 'Missing Question Body',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1);
      } else {
        // Actually post the question
        WitsOverflowApi.postQuestions(
            titleController.text, questionController.text);
        // Show toast message saying posted or not posted
        Fluttertoast.showToast(
            msg: 'Posted',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1);

        questionController.clear();
        titleController.clear();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Declare global variable posted
    // Question Title SingleText Field
    Widget _buildTitleTextField() {
      return Padding(
        key: ValueKey(1),
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: titleController,
          decoration: InputDecoration(
              labelText: 'Title',
              hintText: 'Enter title here',
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(35))),
        ),
      );
    }

    // Main Question MultipleText Field
    Widget _buildMultipleTextField() {
      return Expanded(
        child: Padding(
          key: ValueKey(2),
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: questionController,
            decoration: InputDecoration(
                labelText: 'Question',
                alignLabelWithHint: true,
                hintText: 'Enter question here',
                border: OutlineInputBorder()),
            maxLines: 20,
          ),
        ),
      );
    }

    // Gesture Detector is an on tap listener to dismiss the keyboard
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);

          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            // Here we take the value from the MyPostQuestionsPage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: Text('Wits Overflow'),
          ),
          body: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
              // Column is also a layout widget. It takes a list of children and
              // arranges them vertically. By default, it sizes itself to fit its
              // children horizontally, and tries to be as tall as its parent.
              //
              // Invoke "debug painting" (press "p" in the console, choose the
              // "Toggle Debug Paint" action from the Flutter Inspector in Android
              // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
              // to see the wireframe for each widget.
              //
              // Column has various properties to control how it sizes itself and
              // how it positions its children. Here we use mainAxisAlignment to
              // center the children vertically; the main axis here is the vertical
              // axis because Columns are vertical (the cross axis would be
              // horizontal).
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(height: 10),
                _buildTitleTextField(),
                SizedBox(height: 10),
                _buildMultipleTextField(),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton.extended(
            key: ValueKey(4),
            onPressed: _postQuestion,
            tooltip: 'Post Question',
            label: Text('Post'),
            icon: Icon(Icons.add),
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }
}
