import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  // debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const EdgeInsets.all(32);

    Widget buttonSection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          OutlinedButton(child: Text('Back'), onPressed: () {}),
          Text('Question Heading\nDate'),
        ],
      ),
    );

    Widget textSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              icon: Icon(Icons.thumb_up_sharp),
              color: Colors.black26,
              iconSize: 24.0,
              onPressed: () {}),
          Text('0'),
          IconButton(
              icon: Icon(Icons.thumb_down_sharp),
              color: Colors.black26,
              iconSize: 24.0,
              onPressed: () {}),
          Text('Question Body'),
          IconButton(
              icon: Icon(Icons.flag),
              color: Colors.red,
              iconSize: 24.0,
              onPressed: () {}),
        ],
      ),
    );

    Widget courseSection = Container(
      padding: const EdgeInsets.all(32),
      child: Text(
        'Course Module Class',
        softWrap: true,
      ),
    );

    Widget answerSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        children: [
          OutlinedButton(child: Text('Answer This Question'), onPressed: () {}),
          Text('Author'),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
    );

    Widget answerBodySection = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              icon: Icon(Icons.check),
              color: Colors.green,
              iconSize: 24.0,
              onPressed: () {}),
          IconButton(
              icon: Icon(Icons.thumb_up_sharp),
              color: Colors.black26,
              iconSize: 24.0,
              onPressed: () {}),
          Text('0'),
          IconButton(
              icon: Icon(Icons.thumb_down_sharp),
              color: Colors.black26,
              iconSize: 24.0,
              onPressed: () {}),
          Text('Answer Body'),
          Text('Author'),
          IconButton(
              icon: Icon(Icons.flag),
              color: Colors.red,
              iconSize: 24.0,
              onPressed: () {}),
        ],
      ),
    );

    Widget commentSection = Container(
      padding: const EdgeInsets.all(32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('Comment Body'),
          Text('Author'),
          IconButton(
              icon: Icon(Icons.flag),
              color: Colors.red,
              iconSize: 24.0,
              onPressed: () {}),
        ],
      ),
    );

    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Wits Overflow App'),
        ),
        body: ListView(
          children: [
            buttonSection,
            courseSection,
            textSection,
            answerSection,
            answerBodySection,
            commentSection,
          ],
        ),
      ),
    );
  }
}
