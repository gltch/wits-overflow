import 'package:flutter/material.dart';
import 'package:wits_overflow/utils/wits_overflow_api.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PostQuestionScreen extends StatefulWidget {
  PostQuestionScreen({Key? key}) : super(key: key);

  @override
  _PostQuestionState createState() => _PostQuestionState();
}

// GLobal Variable
String valueChoose = "None";

List listItem = [
  "None",
  "COMS1015",
  "COMS1016",
  "COMS1017",
  "COMS1018",
  "MATH1036"
];

Map<String, int> moduleMap = {
  "None": 0,
  "COMS1015": 1,
  "COMS1016": 2,
  "COMS1017": 3,
  "COMS1018": 4,
  "MATH1036": 5
};

class _PostQuestionState extends State<PostQuestionScreen> {
  // Setting value of valueCHoose for dropdown button
  void _setValueChoose(String nV) {
    setState(() {
      valueChoose = nV.toString();
    });
  }

  // Variable Declarations
  final titleController = new TextEditingController();
  final questionController = new TextEditingController();

  // Post Question Function
  void _postQuestion() {
    setState(() {
      // Check for empty fields
      if (titleController.text == "") {
        // Show error toast message
        Fluttertoast.showToast(
            msg: 'Missing Title',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1);
      } else if (questionController.text == "") {
        // Show error toast message
        Fluttertoast.showToast(
            msg: 'Missing Question Body',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1);
      } else if (valueChoose == "None") {
        // Show error toast message
        Fluttertoast.showToast(
            msg: 'Select A Module',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1);
      } else {
        int module = moduleMap[valueChoose]!;
        // Actually post the question
        WitsOverflowApi.postQuestions(
            titleController.text, questionController.text, module);
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
            maxLines: 40,
          ),
        ),
      );
    }

    // Drop down button build widget

    Widget _buildDropdownMenu() {
      return Expanded(
        child: Padding(
          key: ValueKey(2),
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: DropdownButton(
              hint: Text("Select Module: "),
              dropdownColor: Colors.blue,
              isExpanded: true,
              value: valueChoose,
              onChanged: (newValue) {
                _setValueChoose(newValue.toString());
              },
              items: listItem.map((valueItem) {
                return DropdownMenuItem(
                  value: valueItem,
                  child: Text(valueItem),
                );
              }).toList(),
            ),
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
                // SizedBox(height: 10),
                _buildDropdownMenu(),
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
