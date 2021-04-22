import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // On tap handler to dimiss keyboard when focus is shifted away from current widget.
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        title: 'Wits Overflow',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        // Remove red debug banner
        debugShowCheckedModeBanner: false,
        home: MyPostQuestionsPage(title: 'Wits Overflow'),
      ),
    );
  }
}

// Sidebar Code
class SideDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          SizedBox(height: 25),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Courses'),
            // On tap should open a dropdown menu of ...
            onTap: () => {},
          ),
          Spacer(flex: 4),
          Expanded(
            child: Column(
              children: <Widget>[
                ListTile(
                  leading: Icon(Icons.logout),
                  title: Text('Logout'),
                  onTap: () => {Navigator.of(context).pop()},
                ),
                ListTile(
                  leading: Icon(Icons.account_circle_outlined),
                  title: Text('Profile'),
                  onTap: () => {Navigator.of(context).pop()},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyPostQuestionsPage extends StatefulWidget {
  MyPostQuestionsPage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyPostQuestionsPageState createState() => _MyPostQuestionsPageState();
}

class _MyPostQuestionsPageState extends State<MyPostQuestionsPage> {
  String text = "";

  // Controllers for text fields, functions such as clear text fields & get text from text fields.
  TextEditingController questionController = new TextEditingController();
  TextEditingController titleController = new TextEditingController();

  void _postQuestion() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.

      // Do database stuff here
      // String questionBody = questionController.text;
      // String questionTitle = titleController.text;
      questionController.clear();
      titleController.clear();
    });
  }

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

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      drawer: SideDrawer(),
      appBar: AppBar(
        // Here we take the value from the MyPostQuestionsPage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
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
        onPressed: _postQuestion,
        tooltip: 'Post Question',
        label: Text('Post'),
        icon: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
