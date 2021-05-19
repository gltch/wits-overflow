

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:wits_overflow/widgets/navigation.dart';


// ---------------------------------------------------------------------------
//             Dashboard class
// ---------------------------------------------------------------------------
class Question extends StatelessWidget{

  final id;

  Question(this.id);

  @override
  Widget build(BuildContext context) {
    var questions = FirebaseFirestore.instance.collection("questions");
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('wits-overflow'),
      ),
      body: Center(
        child:FutureBuilder<DocumentSnapshot>(

          future: questions.doc(this.id).get(),
          builder:(BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            // snapshot.error
            if (snapshot.hasError) {
              print('[ERROR OCCURRED]');
              return Center(
                child:
                Container(
                  child: Column(

                    children: [
                      Text(
                        "Could not retrieve question information from database",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 25,
                        ),
                      ),
                      Text(
                        snapshot.error.toString(),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (snapshot.hasData && !snapshot.data!.exists) {
              print('[QUESTION DOES NOT EXIST]');
              return Text("Question does not exist");
            }

            if (snapshot.connectionState == ConnectionState.done) {
              print('[RETRIEVED QUESTION FROM DB]');
              print('[QUESTION: ${snapshot.data!.toString()}]');
              print('[QUESTION: TITLE: ${snapshot.data!.get('title')}, BODY: ${snapshot.data!.get('body')}]');
              print('[----------------------------------------------------------------------------------------]');
              return ListView(
                padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                children: [
                  Container(
                    decoration: BoxDecoration(
                      // color: Colors.lightBlue,
                    ),
                    // padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                    child:Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children:<Widget>[
                              Flexible(
                                // decoration: BoxDecoration(
                                //   color: Colors.black26,
                                // ),
                                child:
                                Text(
                                  snapshot.data!.get('title'),
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.left,
                                  softWrap: true,
                                  // textDirection: TextDirection.rtl,
                                ),
                              ),
                              Flexible(
                                child:Text(
                                    snapshot.data!.get('body',)
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            FutureBuilder<QuerySnapshot>(
                              future: FirebaseFirestore.instance.collection('votes').where('question', isEqualTo: 'questions/${snapshot.data!.id}').get(),
                              builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                // snapshot.error
                                if (snapshot.hasError) {
                                  return Center(
                                    child:
                                    Container(
                                      child: Column(

                                        children: [

                                          Text(
                                            "Could not retrieve question votes",
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 25,
                                            ),
                                          ),
                                          Text(
                                            snapshot.error.toString(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }

                                if (snapshot.connectionState == ConnectionState.done) {
                                  print('[RETRIEVED VOTES FROM DATABASE]');
                                  var votes = snapshot.data!.docs.length;
                                  return Container(
                                    child: Column(
                                      children: <Widget>[
                                        Icon(Icons.arrow_drop_up, size: 40,),
                                        Text(
                                          votes.toString(),
                                          style: TextStyle(
                                            // fontSize: 20,
                                          ),
                                        ),
                                        Icon(Icons.arrow_drop_down, size: 40,),

                                      ],
                                    ),
                                  );
                                }
                                return Icon(Icons.where_to_vote_sharp);
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Container(
                    child:Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Comments',
                          style: TextStyle(
                            fontSize: 25,

                          ),
                        ),
                        Icon(Icons.add),
                      ],
                    ),
                  ),
                  Container(
                    child:FutureBuilder<QuerySnapshot>(

                      future: FirebaseFirestore.instance.collection('comments').where('question', isEqualTo: 'questions/${snapshot.data!.id}').get(),
                      builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        // snapshot.error
                        if (snapshot.hasError) {
                          print('[ERROR OCCURRED WHILE RETRIEVING QUESTIONS COMMENTS]');
                          return Center(
                            child:
                            Container(
                              child: Column(

                                children: [
                                  Text(
                                    "Could not retrieve question comments",
                                    style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 25,
                                    ),
                                  ),
                                  Text(
                                    snapshot.error.toString(),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }

                        if (snapshot.hasData && snapshot.data!.docs.length == 0) {
                          print('[NO COMMENTS FOR THIS  DOES NOT EXIST]');
                          return Text(
                            '[No comments for this question]',
                            style: TextStyle(
                              color: Colors.deepOrangeAccent,
                            ),
                          );
                        }

                        if (snapshot.connectionState == ConnectionState.done) {
                          print('[RETRIEVED COMMENTS FROM DB]');
                          print('[---------------------------------------------------------------]');
                          var children = <Widget>[];
                          snapshot.data!.docs.forEach((doc) {
                            children.add(
                              Text(doc['body']),
                            );
                          });

                          return ListView(
                            children: children,
                          );
                        }
                        return Text("loading comments");
                      },
                    ),
                  ),
                ],
              );
            }
            return Text("loading");
          },
        ),
      ),
    );
  }


}
