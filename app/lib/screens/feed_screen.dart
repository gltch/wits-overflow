

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:wits_overflow/widgets/navigation.dart';
import 'package:wits_overflow/forms/question_create_form.dart';
import 'package:wits_overflow/utils/static.dart';
import 'package:wits_overflow/utils/functions.dart';


// -----------------------------------------------------------------------------
//             FEED PAGE
// -----------------------------------------------------------------------------
class Feed extends StatefulWidget{

  @override
  State<StatefulWidget> createState() {
    return _FeedState();
  }
}

// -----------------------------------------------------------------------------
//             FEED STATE
// -----------------------------------------------------------------------------
class _FeedState extends State<Feed>{

  QuerySnapshot<Map<String, dynamic>> ? questions;
  QuerySnapshot<Map<String, dynamic>> ? courses;

  bool isBusy = true;

  String filterSchool = 'all';
  String filterFaculty = 'all';
  String filterYear = 'all';

  List<String >facultyDropdownMenuOptions = <String>['all'];


  _FeedState(){
    getData();
    this.facultyDropdownMenuOptions.addAll(FACULTIES);
  }


  void getData() async{
    /// get necessary data to view this page
    // get initial data

    // get courses list
    print('[------------------------------------ [RETRIEVING DATA] -----------------------------------]');
    this.courses = await FirebaseFirestore.instance.collection('courses').get();
    this.questions = await FirebaseFirestore.instance.collection('questions').limit(50).get();
    print('[==================================== [RETRIEVED DATA] ====================================]');

    setState(() {
      this.isBusy = false;
    });

  }


  Future<void> filter() async {
    print(
        '[---------------------------- STARTING FILTER ----------------------------]');
    CollectionReference questionsCollection = FirebaseFirestore.instance
        .collection('questions');

    int limit = 100;
    QuerySnapshot<Map<String, dynamic>> ? filterByYearQuestions;
    QuerySnapshot<Map<String, dynamic>> ? filterBySchoolQuestions;
    QuerySnapshot<Map<String, dynamic>> ? filterByFacultyQuestions;


    Query query = questionsCollection;

    setState(() {
      isBusy = true;
    });

    // filter by a year
    if (this.filterYear != 'all' && limit > 0) {
      query = query.where('year', isEqualTo: this.filterYear);
    }

    // filter by school name
    if (this.filterSchool != 'all' && limit > 0) {
      query = query.where('school', isEqualTo: this.filterSchool);

    }

    // filter by faculty
    if (this.filterFaculty != 'all' && limit > 0) {
      query = query.where('faculty', isEqualTo: this.filterFaculty);

    }


    this.questions = await query.get() as QuerySnapshot<Map<String, dynamic>>;


    setState(() {
      isBusy = false;
    });


  }
    
    
  // Future<void> filter() async {
  //   print('[---------------------------- STARTING FILTER ----------------------------]');
  //   CollectionReference questionsCollection = FirebaseFirestore.instance.collection('questions');
  //
  //   int limit = 100;
  //   QuerySnapshot<Map<String, dynamic>> ? filterByYearQuestions;
  //   QuerySnapshot<Map<String, dynamic>> ? filterBySchoolQuestions;
  //   QuerySnapshot<Map<String, dynamic>> ? filterByFacultyQuestions;
  //
  //
  //   Query query = questionsCollection;
  //
  //   setState(() {
  //     isBusy = true;
  //   });
  //
  //   // filter by a year
  //   if (this.filterYear != 'all' && limit > 0) {
  //     // get courses for the selected year
  //     // then get questions that belong to theses courses
  //     List yearCoursesIds = <String>[];
  //     for (var i = 0; i < this.courses!.docs.length; i++) {
  //       if (this.courses!.docs[i].get('year') == this.filterYear) {
  //         yearCoursesIds.add(this.courses!.docs[i].id);
  //       }
  //     }
  //     if(yearCoursesIds.length == 0){
  //       yearCoursesIds.add('----------------');
  //     }
  //
  //     query = query.where('year', whereIn: yearCoursesIds);
  //   }
  //
  //
  //   // filter by school name
  //   if (this.filterSchool != 'all' && limit > 0) {
  //     // get courses that belong to this school
  //
  //     List schoolCoursesIds = <String>[];
  //     for (var i = 0; i < this.courses!.docs.length; i++) {
  //       if (this.courses!.docs[i].get('school') == this.filterSchool) {
  //         schoolCoursesIds.add(this.courses!.docs[i].id);
  //       }
  //     }
  //     if(schoolCoursesIds.length == 0){
  //       schoolCoursesIds.add('----------------');
  //     }
  //     query = query.where('year', whereIn: schoolCoursesIds);
  //   }
  //
  //   // filter by faculty
  //   if (this.filterFaculty != 'all' && limit > 0) {
  //     // get courses that belong to this school
  //
  //     List facultyCoursesIds = <String>[];
  //     for (var i = 0; i < this.courses!.docs.length; i++) {
  //       if (this.courses!.docs[i].get('school') == this.filterSchool) {
  //         facultyCoursesIds.add(this.courses!.docs[i].id);
  //       }
  //     }
  //
  //     if(facultyCoursesIds.length == 0){
  //       facultyCoursesIds.add('----------------');
  //     }
  //     query = query.where('year', whereIn: facultyCoursesIds);
  //   }
  //
  //
  //   this.questions = await query.limit(50).get() as QuerySnapshot<Map<String, dynamic>>;
  //
  //   setState(() {
  //     isBusy = false;
  //   });
  //
  //
  //   // filterByYearQuestions!.docs.addAll(filterBySchoolQuestions!.docs.addAll(filterByFacultyQuestions!.docs));
  //   print('================================== [ FILTER FINISHED ] ==================================');
  // }
  //


  Widget buildQuestionsWidget() {
    //

    List<Widget> questionWidgets = <Widget>[];
    this.questions!.docs.forEach((questionDoc) {
      questionWidgets.add(ListTile(
        title: Text(getField(questionDoc.data(), 'title', onError:'[QUESTION DOES NOT HAVE TITLE]', onNull: '[QUESTION DOES NOT HAVE TITLE]'),),
        subtitle: Text(getField(questionDoc.data(), 'body', onError: 'QUESTION DOES NOT HAVE BODY', onNull: 'QUESTION DOES NOT HAVE BODY'),),
      ));
      questionWidgets.add(Divider());
    });

    return Column(
      children: questionWidgets,
    );
  }


  @override
  Widget build(BuildContext context) {
    /*
    20 questions sorted by datetime
     */

    // TODO: get faculty, course name, and course code list

    if(this.isBusy){
      return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('Wits overflow'),
        ),
        body: Center(
            child: CircularProgressIndicator(),
        ),
      );
    }
    

    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('wits-overflow'),
      ),
      body: ListView(
        children: <Widget>[

          // header
          Container(
            padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
            child: Text(
              'Questions',
              style: TextStyle(
                fontSize: 25,

              ),
            ),
          ),

          Divider(),


          // filter
          Container(
            color: Color.fromARGB(100, 220, 220, 220),
            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                // year selector
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      /// filter questions by year
                      Align(

                        child: Text(
                          'Year',
                        ),
                        alignment: Alignment.centerLeft,
                      ),


                      Container(
                        alignment: Alignment.centerLeft,
                        // color: Color.fromARGB(100, 220, 220, 220),
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: DropdownButton<String>(
                          hint: Text('year'),
                          value: filterYear,
                          isDense: true,
                          onChanged: (newValue) {
                            setState(() {
                              filterYear = newValue!;
                              print('[FILTER BY YEAR: $filterYear]');
                              filter();
                            });
                          },
                          items: <DropdownMenuItem<String>>[
                            DropdownMenuItem(
                              child: Text('all'), value: 'all',
                            ),

                            DropdownMenuItem(
                              child: Text('first'), value: 'first',
                            ),
                            DropdownMenuItem(
                                child: Text('second'), value: 'second'
                            ),
                            DropdownMenuItem(
                              child: Text('third'), value: 'third',
                            ),
                            DropdownMenuItem(
                              child: Text('honours'), value: 'honours',
                            ),
                            DropdownMenuItem(
                              child: Text('masters'), value: 'masters',
                            ),
                            DropdownMenuItem(
                              child: Text('doctorate'), value: 'doctorate',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      /// filter questions by year
                      Align(
                        child: Text(
                          'Faculty',
                        ),
                        alignment: Alignment.centerLeft,
                      ),

                      Container(
                        alignment: Alignment.centerLeft,

                        // color: Color.fromARGB(100, 220, 220, 220),
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        child: DropdownButton<String>(
                          isExpanded: true, // from stack overflow, when this is added, not overflow occurs
                          hint: Text('faculty'),
                          value: filterFaculty,
                          isDense: true,
                          onChanged: (newValue) {
                            setState(() {
                              print('[FILTER BY FACULTY: $newValue]');
                              filterFaculty = newValue!;
                              filter();
                            });
                          },

                          items: this.facultyDropdownMenuOptions.map((String value) {
                            return new DropdownMenuItem<String>(
                              value: value.toLowerCase(),
                              child: new Text(value),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          Divider(),


          // questions
          // header
          Container(
            child: buildQuestionsWidget(),
          ),
        ],
      ),
    );
  }
}
//