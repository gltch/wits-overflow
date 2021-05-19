import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:wits_overflow/widgets/navigation.dart';
import 'package:wits_overflow/forms/question_create_form.dart';
import 'package:wits_overflow/screens/question_screen.dart';
import 'package:wits_overflow/utils/functions.dart';


// -----------------------------------------------------------------------------
//             COURSE PROFILE PAGE
// -----------------------------------------------------------------------------
class CourseProfile extends StatefulWidget{

  final String courseId; // courseId

  CourseProfile(this.courseId){
    print('[CourseProfile.CourseProfile(), courseId: ${this.courseId}]');
  }

  @override
  _CourseProfileState createState() => _CourseProfileState(this.courseId);
}

class _CourseProfileState extends State<CourseProfile> {

  String courseId;
  bool isBusy = true;
  QuerySnapshot<Map<String, dynamic>> ? questions;
  DocumentSnapshot<Map<String, dynamic>> ? course;

  _CourseProfileState(this.courseId){
    this.getData();
  }

  void getData() async{
    print('[_CourseProfileState.getData(), this.widget.courseId: ${this.courseId}]');
    this.course = await FirebaseFirestore.instance.collection('courses').doc(this.courseId).get();
    this.questions = await FirebaseFirestore.instance.collection('questions').where('course', isEqualTo: '${this.courseId}').get();
    print('[RETRIEVED COURSE INFORMATION AND COURSE QUESTIONS]');
    setState(() {
      isBusy = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('[_CourseProfileState.build]');

    if(isBusy){
      return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('wits-overflow'),
        ),
        body: Center(child:CircularProgressIndicator()),
      );
    }
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('wits-overflow'),
      ),
      body: Center(
        child:Container(
          child: Column(
            children: <Widget>[
              // heading
              Container(
                // color: Colors.black12,
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(10, 20, 10, 5),
                child: Text(
                  toTitleCase(this.course!.get('name').toString()),
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
              ),

              // COURSE DESCRIPTION
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                width: double.infinity,
                // color: Colors.black26,
                child: Text(
                  this.course!.get('description'),
                  textAlign: TextAlign.left,
                )
              ),

              // LIST OF COURSE QUESTIONS
              // Divider(),
              Container(

                padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                child:Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(

                        child:Text(
                          'Questions',
                          style: TextStyle(
                            fontSize: 25,
                            ),
                        )
                      ),
                      Column(
                        children: <Widget>[
                          TextButton(
                            onPressed: (){
                              // redirect to question create page
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context){
                                  // TODO: update to return
                                  return QuestionCreateForm(this.courseId, this.course!.get('name'));
                                  }
                                ),
                              );
                            },
                            child: Icon(
                            Icons.add,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Divider(),
              Column(
                children: <Widget>[for (var i = 0; i < this.questions!.docs.length; i++) ListTile(
                  title: Text(this.questions!.docs[i].get('title')),
                  subtitle: Text(this.questions!.docs[i].get('body')),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return Question(this.questions!.docs[i].id);
                    }));
                  },
                )],
              ),
            ],
          ),
        )
      )
    );
  }
}

// FutureBuilder<DocumentSnapshot>(
//     future: FirebaseFirestore.instance.collection('courses').doc(this.courseId).get(),
//     builder:(BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//
//       if (snapshot.hasError) {
//         return Center(
//           child:
//           Container(
//             child: Column(
//
//               children: [
//                 Text(
//                   "Could not retrieve course information from database",
//                   style: TextStyle(
//                     color: Colors.red,
//                     fontSize: 25,
//                   ),
//                 ),
//                 Text(
//                   snapshot.error.toString(),
//                 ),
//               ],
//             ),
//           ),
//         );
//       }
//
//       if (snapshot.hasData && !snapshot.data!.exists) {
//         return Text(
//           "Could not find the course specified",
//           style: TextStyle(
//             color: Colors.red,
//           ),
//         );
//       }
//
//       if (snapshot.connectionState == ConnectionState.done) {
//         var courseName = snapshot.data!.get("name");
//         var courseDescription = snapshot.data!.get("description");
//         // var courseQuestions = <Widget>[];
//
//         return Container(

// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------




// FutureBuilder(
// future: FirebaseFirestore.instance.collection('questions').where('course', isEqualTo: '${this.widget.courseId}').get(),
// // future: snapshot.data!.get('').get(),
// builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
// if (snapshot.hasError) {
// return Center(
// child: Container(
// child: Column(
//
// children: [
// Text(
// "Could not retrieve course information from database",
// style: TextStyle(
// color: Colors.red,
// fontSize: 25,
// ),
// ),
// Text(
// snapshot.error.toString(),
// ),
// ],
// ),
// ),
// );
// }
// if(snapshot.connectionState == ConnectionState.done){
// print('[RETRIEVED COURSE QUESTIONS, COUNT: ${snapshot.data!.docs.length}, where: course=${this.widget.courseId}]');
// var questions = <Widget>[];
// snapshot.data!.docs.forEach((doc) {
// questions.add(ListTile(
// title: Text(doc['title']),
// subtitle: Text(doc['body']),
// ));
// questions.add(Divider());
// });
// return Column(
// children: <Widget>[
// Divider(),
// Row(
// children: [
// Column(
// children: <Widget>[
// Text(
// 'Questions',
// style: TextStyle(
// fontSize: 25,
// ),
// )
// ],
// ),
// Column(
// children: <Widget>[
// TextButton(
// onPressed: (){
// // redirect to question create page
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context){
// // TODO: update to return
// return QuestionCreateForm(this.widget.courseId, courseName);
// }
// ),
// );
// },
// child: Icon(
// Icons.add,
// ),
// )
// ],
// ),
// ],
// ),
// Divider(),
// Column(
// children: questions,
// ),
// ],
// );
// }
// return Text('Loading course questions');
// },
// ),
