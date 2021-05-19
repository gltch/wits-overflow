import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:wits_overflow/widgets/navigation.dart';
import 'package:wits_overflow/forms/question_create_form.dart';
import 'package:wits_overflow/screens/question_screen.dart';



// -----------------------------------------------------------------------------
//             Dashboard class
// -----------------------------------------------------------------------------
class HomeScreen extends StatefulWidget {

  // final logoutAction;

  final state = HomeScreenState(CircularProgressIndicator());


  HomeScreen(){
    print('[DASHBOARD CONSTRUCTOR]');
  }

  @override
  HomeScreenState createState() => state;

}


// -----------------------------------------------------------------------------
//    DASHBOARD STATE CLASS
// -----------------------------------------------------------------------------
class HomeScreenState extends State<HomeScreen> {

  Widget child;

  HomeScreenState(this.child);

  @override
  Widget build(BuildContext context) {
    print('[DASHBOARD STATE]');
    CollectionReference questions = FirebaseFirestore.instance.collection('questions');
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('wits-overflow'),
      ),
      body: Center(
        child:FutureBuilder<QuerySnapshot>(
          future: questions.get(),
          builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            // snapshot.error
            if (snapshot.hasError) {
              return Center(
                child:
                Container(
                  child: Column(

                    children: [
                      Text(
                        "Could not retrieve questions from database",
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

            // if (snapshot.hasData && snapshot.data.docs.) {
            //   return Text("Document does not exist");
            // }

            if (snapshot.connectionState == ConnectionState.done) {
              print('[FETCHED USER QUESTIONS]');
              var list = <Widget>[];
              list.add(
                Container(
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'My Questions',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      TextButton(
                        onPressed: (){
                          // TODO: update so that the user can add/post question
                          print('[QUESTION POST BUTTON CLICKED]');
                          Navigator.push(
                            this.context,
                            // MaterialPageRoute(builder: (context) => PostQuestionScreen()),
                            MaterialPageRoute(builder: (context) => QuestionCreateForm(null, null)),
                          );
                        },
                        child: Icon(Icons.add),
                      ),
                    ],
                  ),
                ),
              );

              snapshot.data!.docs.forEach((doc) {
                print('[ADDING QUESTION... doc.data().toString(): ${doc.data().toString()}], doc[\'course\']: ${doc['course']}');
                if(doc['user'] == FirebaseAuth.instance.currentUser!.uid) {
                  list.add(
                      ListTile(
                        title: Text(doc.get("title")),
                        subtitle: Text(doc.get("body")),
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context){
                                  return Question(doc.id);
                                },
                              )
                          );
                        },
                      )
                  );

                  list.add(
                    Divider(),
                  );
                }
              });


              return ListView(
                children: list,
              );
            }
            return Text("loading");
          },
        ),
      ),
    );
  }

  void show(Widget widget){
    this.setState(() {
      child = widget;
    });
  }
}


