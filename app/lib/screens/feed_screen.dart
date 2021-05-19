

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:wits_overflow/widgets/navigation.dart';
import 'package:wits_overflow/forms/question_create_form.dart';


// -----------------------------------------------------------------------------
//             FEED PAGE
// -----------------------------------------------------------------------------
class Feed extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return FeedState();
  }
}

// -----------------------------------------------------------------------------
//             FEED STATE
// -----------------------------------------------------------------------------
class FeedState extends State<Feed>{

  bool sortByDate = true;
  bool filterByCourseName = false;
  bool filterByCourseCode = false;
  bool filterByYear = false;
  bool filterByTags = false;
  // ---------------------------------------------------------------------------
  String? filterCourseName;
  String? filterCourseCode;
  String? filterCourseTags;
  String? filterSchool;
  String? filterFaculty;
  String? filterYear = 'all';


  @override
  Widget build(BuildContext context) {
    /*
    20 questions sorted by datetime
     */

    // TODO: get faculty, course name, and course code list

    var faculties = <String>['all'];
    var schools = <String>['all'];
    var courses = <String>['all'];
    var courseCodes = <String>['all'];

    FirebaseFirestore.instance.collection('courses').get().then((value){
      value.docs.forEach((doc) {
        if(!faculties.contains(doc['faculty'])){
          faculties.add(doc['faculty']);
        }
        if(!schools.contains(doc['school'])){
          schools.add(doc['school']);
        }
        courseCodes.add(doc['code']);
        courses.add(doc['name']);
      });

    }).catchError((error){
      print('[ERROR OCCURRED WHILE GETTING COURSES COLLECTION]');
    });


    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('wits-overflow'),
      ),
      body: Column(
        children: <Widget>[
          Container(
            child: Row(
              children: <Widget>[
                // year selector
                Column(
                  children: <Widget>[
                    Text(
                      'year',
                    ),
                    DropdownButton(
                      hint: Text('year'),
                      value: filterYear,
                      items: <DropdownMenuItem>[
                        DropdownMenuItem(
                          child: Text('all'),
                          onTap: (){
                            this.setState(() {
                              filterByYear = false;
                            });
                          },
                        ),

                        DropdownMenuItem(
                          child: Text('first'),
                          onTap: (){
                            this.setState(() {
                              filterByYear = true;
                            });
                          },
                        ),
                        DropdownMenuItem(
                          child: Text('second'),
                          onTap: (){
                            setState(() {
                              filterByYear = true;
                            });
                          },
                        ),
                        DropdownMenuItem(
                          child: Text('third'),
                          onTap: (){
                            setState(() {
                              filterByYear = true;
                            });
                          },
                        ),
                        DropdownMenuItem(
                          child: Text('honours'),
                          onTap: (){
                            setState(() {
                              filterByYear = true;
                            });
                          },
                        ),
                        DropdownMenuItem(
                          child: Text('masters'),
                          onTap: (){
                            setState(() {
                              filterByYear = true;
                            });
                          },
                        ),
                        DropdownMenuItem(
                          child: Text('doctrate'),
                          onTap: (){
                            setState(() {
                              filterByYear = true;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),

                //faculty selector
                Column(
                  children: [
                    Text('faculty'),
                    DropdownButton(
                      hint: Text('faculty'),
                      value: filterFaculty,
                      items: <DropdownMenuItem>[

                      ],
                    )
                  ],
                ),


                // date selector
                Column(
                  children: [
                    Text('course'),
                    DropdownButton(
                      items: <DropdownMenuItem>[

                      ],
                    )
                  ],
                ),


                // course code selector
                Column(
                  children: [
                    Text('course'),
                    DropdownButton(
                      items: <DropdownMenuItem>[

                      ],
                    )
                  ],
                ),


                // course name selector
                Column(
                  children: [
                    Text('course'),
                    DropdownButton(
                      items: <DropdownMenuItem>[

                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
          Center(
            child:FutureBuilder<QuerySnapshot>(
              future: FirebaseFirestore.instance.collection('questions').get(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                // snapshot.error
                if (snapshot.hasError) {
                  return Center(
                    child: Container(
                      child: Column(
                        children: [
                          Text(
                            "Could not retrive questions from database",
                            style: TextStyle(
                              color: Colors.red,
                              fontSize: 25,
                            ),
                          ),
                          Text(
                            snapshot.error.toString(),
                            style: TextStyle(
                              color: Colors.red,
                            ),
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
                  var list = <Widget>[];
                  list.add(DrawerHeader(
                      child: Row(
                          children: <Widget>[
                            Text(
                              'Feed',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            TextButton(
                              onPressed: (){
                                // TODO: update so that the user can add/post question
                                print('[QUESTION POST BUTTON CLICKED]');
                                Navigator.push(
                                  context,
                                  // MaterialPageRoute(builder: (context) => PostQuestionScreen()),
                                  MaterialPageRoute(builder: (context) => QuestionCreateForm(null, null)),
                                );
                              },
                              child: Icon(Icons.add),
                            )
                          ]
                      )
                  ));

                  snapshot.data!.docs.forEach((element) {
                    print('[ADDING QUESTION TO LIST...]');
                    list.add(
                        ListTile(
                          title: Text(element.get("title")),
                          subtitle: Text(element.get("body")),
                        )
                    );
                  });


                  return ListView(
                    children: list,
                  );
                }
                return Text("loading");
              },
            ),
          ),
        ],
      ),
    );
  }
}
//