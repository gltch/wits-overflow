import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:wits_overflow/widgets/navigation.dart';
import 'package:wits_overflow/screens/question_screen.dart';



// -----------------------------------------------------------------------------
//                      QUESTION CREATE FORM
// -----------------------------------------------------------------------------
class QuestionCreateForm extends StatefulWidget {

  final String ? courseId;
  final String ? courseName;

  QuestionCreateForm(this.courseId, this.courseName){
    // get course name
    print('[QuestionCreateForm.QuestionCreateForm(${this.courseId}, ${this.courseName})]');
  }

  @override
  QuestionCreateFormState createState() {
    return QuestionCreateFormState(this.courseId, this.courseName);
  }
}

// -----------------------------------------------------------------------------
//                      QUESTION CREATE FORM STATE
// -----------------------------------------------------------------------------
class QuestionCreateFormState extends State<QuestionCreateForm> {

  final String ? courseName;

  final _formKey = GlobalKey<FormState>();
  String courseController = 'general';
  final titleController = TextEditingController();
  final bodyController = TextEditingController();
  final String ? courseId;
  bool isBusy = true;
  List<DropdownMenuItem<String>> dropdownButtonMenuItems = [DropdownMenuItem(child: Text('general'), value: 'general')];
  List<DocumentSnapshot> ? userFavoriteCourses;



  QuestionCreateFormState(this.courseId, this.courseName){
    if(this.courseId != null){
      this.courseController = this.courseId!;
    }

    this.getData();
  }

  Future<void> getData() async {
    // var courses = <DocumentSnapshot>[];
    // var coursesFuture = <Future<DocumentSnapshot>>[];

    // get ids of courses the user has subscribed to
    // then from the ids, get each course information
    // Firebase is weak: for each course id, we have to make a request, that is,
    // we can fetch all documents at once

    // user favorites courses
    
    // dropdown button menu items
    var dmi = [
      DropdownMenuItem(value: 'general', child: Text('general')),
    ];


    QuerySnapshot favorites = await FirebaseFirestore.instance.collection('favorites').where('user', isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
    List<DocumentSnapshot<Map<String, dynamic>>> ufc = <DocumentSnapshot<Map<String, dynamic>>>[for(var i = 0 ; i < favorites.docs.length; i++) await FirebaseFirestore.instance.collection('courses').doc(favorites.docs[i].get('course')).get()];
  
    ufc.forEach((userFavoriteCourse) {
      print('[ADDING TO USER DROPDOWN BUTTON MENU ITEMS FAVOIRITE COURSES, userFavoriteCourse: ${userFavoriteCourse.get('name')}]');
      dmi.add(DropdownMenuItem(child: Text(userFavoriteCourse.get('name')), value: userFavoriteCourse.id));
    });

    print('[RETRIEVED USER FAVORITES FROM DATABASE, favorites.docs.length: ${favorites.docs.length}]');
    print('[RETRIEVED USER FAVORITES COURSES FROM DATABASE, favoriteCourses.docs.length: ${ufc.length}]');
    // favorites.docs.forEach((favoriteDoc) async {
    //   var courseDoc = await FirebaseFirestore.instance.collection('courses').doc(favoriteDoc.get('course')).get();
    //   print('[FETCHED FAVORITE COURSE, course.id: ${courseDoc.id}, course.name: ${courseDoc.get('name')}]');
    //   ufc.add(courseDoc);
    //   dbmi.add(DropdownMenuItem(value: courseDoc.id, child: Text(courseDoc.get('name'))));
    // });


    setState(() {
      print('[CHANGING STATE : dmi: ${dmi.length}]');
      for (var dropdownMenuItem in dmi) {
        print('[dropDownMenuItem: text: ${dropdownMenuItem.child.toString()}, value: ${dropdownMenuItem.value}]');
      }
      this.userFavoriteCourses = ufc;
      this.dropdownButtonMenuItems = dmi;
      this.isBusy = false;
      print('[--------------------------------------- CHANGE STATE CHANGED STATE CHANGED STATE ---------------------------------------------------]');
    });

    // .then((querySnapshot){
    //   print('[USER HAS ${querySnapshot.docs.length} FAVORITE COURSES]');
    //   querySnapshot.docs.forEach((favoriteDoc) {
    //     var a = FirebaseFirestore.instance.collection('courses').doc(favoriteDoc.get('course')).get();
    //     coursesFuture.add(a);
    //     a.then((courseDoc){
    //       print('[RETRIEVED COURSE : ${courseDoc.data().toString()}]');
    //       courses.add(courseDoc);
    //     });
    //   });
    //   print('[USER FAVORITE COURSES : ${courses.toString()}]');
    // });
  }
  // TODO: add a field where the user can choose for which subject is she/he posting question to

  DocumentReference ? addQuestion(String course, String title, String body) {
    CollectionReference questions = FirebaseFirestore.instance.collection('questions');
    print('[USER UID ' + FirebaseAuth.instance.currentUser!.uid.toString() +  ']');
    questions.add({
      'course': course,
      'user': FirebaseAuth.instance.currentUser!.uid,
      'title': title,
      'body': body,
      'votes': 0,
      'createAt': DateTime.now(),
      'updatedAt': DateTime.now(),
    })
        .then((value) {
      print("[QUESTION ADDED]");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Successfully posted question'),
        ),
      );
      return value;
    })
        .catchError((error){
      print("[FAILED TO ADD QUESTION]: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error occurred'),
        ),
      );
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.

    // TODO: include courses dropdown list

    if(this.isBusy){
      return Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('wits overflow'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    // for (var dropdownMenuItem in this.dropdownButtonMenuItems) {
    //   print('[QuestionCreateFormState.build dropDownMenuItem: text: ${dropdownMenuItem.child.toString()}, value: ${dropdownMenuItem.value}]');
    // }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('wits-overflow'),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Container(
            margin: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: DropdownButtonHideUnderline(
                    child: Flex(
                      direction: Axis.horizontal,
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            // decoration: InputDecoration(
                            //   border: UnderlineInputBorder(),
                            //   labelText: 'course (choose a course you want to post question to)',
                            // ),
                            hint: Text("Select the course you want to post your question to"),
                            value: courseController,
                            isDense: true,
                            onChanged: (newValue) {
                              print('[DROPDOWN BUTTON ON CHANGE, new value: $newValue]');
                              setState(() {
                                courseController = newValue!;
                              });
                              print('[DROP DOWN BUTTON ON CHANGE VALUE: $courseController]');
                            },
                            items: this.dropdownButtonMenuItems,
                          ),
                        ),
                      ],
                    )
                  ),
                ),
                TextFormField(
                  controller: titleController,
                  maxLines: null,
                  maxLength: null,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'title',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Enter title';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: this.bodyController,
                  maxLines: 15,
                  minLines: 10,
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    labelText: 'body',

                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(0, 50, 0, 10),
                  child: ElevatedButton(
                    onPressed:(){
                      print('[POST QUESTION BUTTON PRESSED]');
                      if (_formKey.currentState!.validate()) {
                        var course = this.courseController;
                        var title = this.titleController.text;
                        var body = this.bodyController.text;
                        print('[POST QUESTION course : $course, title: $title, body: $body]');


                        DocumentReference<Object?>? question = addQuestion(course, title, body);
                        if(question == null){

                        }
                        else{
                          // redirect to question page
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context){
                                return Question(question.id);
                              },
                            )
                          );
                        }

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Processing Data'),
                          ),
                        );
                      }
                      else{
                        print('[INVALID FORM DATA]');

                      }
                    },
                    child: Text('POST'),
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}


//   FutureBuilder(
//     future: Future.wait(coursesFuture),
//     builder: (BuildContext context, AsyncSnapshot<List<DocumentSnapshot>> snapshot) {
//       // snapshot.error
//       if (snapshot.hasError) {
//         return Center(
//           child: Container(
//             child: Column(
//               children: [
//                 Text(
//                   "Error occurred while fetching subscribed courses",
//                   style: TextStyle(
//                     color: Colors.red,
//                     fontSize: 25,
//                   ),
//                 ),
//                 Text(
//                   snapshot.error.toString(),
//                   style: TextStyle(
//                     color: Colors.red,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       }
//
//       // if (snapshot.hasData && snapshot.data!.docs.length == 0) {
//       //   return Text("Document does not exist");
//       // }
//
//       if (snapshot.connectionState == ConnectionState.done) {
//         var items = <DropdownMenuItem<String>>[];
//         print('[snapshot.data.toString(): ${snapshot.data.toString()}, doc.data.length: ${snapshot.data!.length}, snapshot.hasData: ${snapshot.hasData}, ${snapshot.data}]');
//         snapshot.data!.forEach((doc) {
//           items.add(
//               DropdownMenuItem(value: doc.id, child: Text(doc['name']))
//           );
//         });
//         // snapshot.data!.docs.forEach((doc) {
//         //   items.add(
//         //       DropdownMenuItem(value: doc.id, child: Text(doc['name']))
//         //   );
//         // });
//         return Container(
//           padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
//           child: DropdownButtonHideUnderline(
//             child: DropdownButtonFormField<String>(
//               decoration: InputDecoration(
//                 border: UnderlineInputBorder(),
//                 labelText: 'course',
//               ),
//               hint: Text("Select course you want to post question to"),
//               value: courseController,
//               isDense: true,
//               onChanged: (newValue) {
//                 setState(() {
//                   courseController = newValue!;
//                 });
//                 print('[DROP DOWN BUTTON ON CHANGE VALUE: $courseController]');
//               },
//               items: items,
//             ),
//           ),
//         );
//       }
//       return Text("loading courses");
//     },
//   ),

