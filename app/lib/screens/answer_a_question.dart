// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
//
// import 'package:flutter/material.dart';
//
// import 'package:wits_overflow/widgets/navigation.dart';
// import 'package:wits_overflow/screens/question_screen.dart';
//
//
//
// // -----------------------------------------------------------------------------
// //                      QUESTION CREATE FORM
// // -----------------------------------------------------------------------------
// class QuestionAnswer extends StatefulWidget {
//
//   final String ? questionId;
//   final bool isBusy = true;
//   DocumentSnapshot<Map<String, dynamic>> ? question;
//
//   QuestionAnswer(this.questionId){
//     this.getData();
//   }
//
//
//   void getData() async{
//     this.question = await FirebaseFirestore.instance.collection('questions').doc(this.questionId).get();
//   }
//
//   @override
//   QuestionCreateFormState createState() {
//     return QuestionCreateFormState(this.courseId, this.courseName);
//   }
// }
//
// // -----------------------------------------------------------------------------
// //                      QUESTION CREATE FORM STATE
// // -----------------------------------------------------------------------------
// class QuestionCreateFormState extends State<QuestionCreateForm> {
//
//   final String ? courseName;
//
//   final _formKey = GlobalKey<FormState>();
//   String courseController = 'general';
//   final titleController = TextEditingController();
//   final bodyController = TextEditingController();
//   final String ? courseId;
//   bool isBusy = true;
//   List<DropdownMenuItem<String>> dropdownButtonMenuItems = [DropdownMenuItem(child: Text('general'), value: 'general')];
//   List<DocumentSnapshot> ? userFavoriteCourses;
//
//
//
//   QuestionCreateFormState(this.courseId, this.courseName){
//     if(this.courseId != null){
//       this.courseController = this.courseId!;
//     }
//
//     this.getData();
//   }
//
//   Future<void> getData() async {
//     // var courses = <DocumentSnapshot>[];
//     // var coursesFuture = <Future<DocumentSnapshot>>[];
//
//     // get ids of courses the user has subscribed to
//     // then from the ids, get each course information
//     // Firebase is weak: for each course id, we have to make a request, that is,
//     // we can fetch all documents at once
//
//     // user favorites courses
//
//     // dropdown button menu items
//     var dmi = [
//       DropdownMenuItem(value: 'general', child: Text('general')),
//     ];
//
//
//     QuerySnapshot favorites = await FirebaseFirestore.instance.collection('favorites').where('user', isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();
//     List<DocumentSnapshot<Map<String, dynamic>>> ufc = <DocumentSnapshot<Map<String, dynamic>>>[for(var i = 0 ; i < favorites.docs.length; i++) await FirebaseFirestore.instance.collection('courses').doc(favorites.docs[i].get('course')).get()];
//
//     ufc.forEach((userFavoriteCourse) {
//       print('[ADDING TO USER DROPDOWN BUTTON MENU ITEMS FAVORITE COURSES, userFavoriteCourse: ${userFavoriteCourse.get('name')}]');
//       dmi.add(DropdownMenuItem(child: Text(userFavoriteCourse.get('name')), value: userFavoriteCourse.id));
//     });
//
//     print('[RETRIEVED USER FAVORITES FROM DATABASE, favorites.docs.length: ${favorites.docs.length}]');
//     print('[RETRIEVED USER FAVORITES COURSES FROM DATABASE, favoriteCourses.docs.length: ${ufc.length}]');
//
//     setState(() {
//       print('[CHANGING STATE : dmi: ${dmi.length}]');
//       for (var dropdownMenuItem in dmi) {
//         print('[dropDownMenuItem: text: ${dropdownMenuItem.child.toString()}, value: ${dropdownMenuItem.value}]');
//       }
//       this.userFavoriteCourses = ufc;
//       this.dropdownButtonMenuItems = dmi;
//       this.isBusy = false;
//       print('[--------------------------------------- CHANGE STATE CHANGED STATE CHANGED STATE ---------------------------------------------------]');
//     });
//   }
//   // TODO: add a field where the user can choose for which subject is she/he posting question to
//
//   DocumentReference ? addQuestion(String courseId, String title, String body) {
//     CollectionReference questions = FirebaseFirestore.instance.collection('questions');
//     print('[USER UID ' + FirebaseAuth.instance.currentUser!.uid.toString() +  ']');
//     DocumentSnapshot course;
//     for(var i = 0; i < this.userFavoriteCourses!.length; i++){
//       if(this.userFavoriteCourses!.elementAt(i).id == courseId){
//         course = this.userFavoriteCourses!.elementAt(i);
//         questions.add({
//           'school': course.get('school'),
//           'year': course.get('year'),
//           'faculty': course.get('faculty'),
//           'course': courseId,
//           'user': FirebaseAuth.instance.currentUser!.uid,
//           'title': title,
//           'body': body,
//           'votes': 0,
//           'createAt': DateTime.now(),
//           'updatedAt': DateTime.now(),
//         })
//             .then((value) {
//           print("[QUESTION ADDED]");
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Successfully posted question'),
//             ),
//           );
//
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                 builder: (context){
//                   return Question(value.id);
//                 },
//               )
//           );
//
//           return value;
//         })
//             .catchError((error){
//           print("[FAILED TO ADD QUESTION]: $error");
//           ScaffoldMessenger.of(context).showSnackBar(
//             SnackBar(
//               content: Text('Error occurred'),
//             ),
//           );
//         });
//       }
//     }
//     return null;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // Build a Form widget using the _formKey created above.
//
//     // TODO: include courses dropdown list
//
//     if(this.isBusy){
//       return Scaffold(
//         resizeToAvoidBottomInset: false,
//         drawer: NavDrawer(),
//         appBar: AppBar(
//           title: Text('wits overflow'),
//         ),
//         body: Center(
//           child: CircularProgressIndicator(),
//         ),
//       );
//     }
//
//     // for (var dropdownMenuItem in this.dropdownButtonMenuItems) {
//     //   print('[QuestionCreateFormState.build dropDownMenuItem: text: ${dropdownMenuItem.child.toString()}, value: ${dropdownMenuItem.value}]');
//     // }
//
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       drawer: NavDrawer(),
//       appBar: AppBar(
//         title: Text('wits-overflow'),
//       ),
//       body: ListView(
//         children: [
//           Container(
//             padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
//             color: Color.fromARGB(100, 220, 220, 220),
//             child:Text(
//               'Post question',
//               style: TextStyle(
//                   fontSize: 25,
//                   fontWeight: FontWeight.w600,
//                   color: Color.fromARGB(100, 16, 16, 16)
//               ),
//             ),
//           ),
//
//
//           Center(
//             child: Form(
//               key: _formKey,
//               child: Container(
//                 padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
//                 // margin: EdgeInsets.all(20),
//                 child: Column(
//                   children: <Widget>[
//                     Container(
//                       padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
//                       child: DropdownButtonHideUnderline(
//                           child: Flex(
//                             direction: Axis.horizontal,
//                             children: [
//                               Expanded(
//                                 child: DropdownButtonFormField<String>(
//                                   isExpanded: true, // from stack overflow, when this is added, not overflow occurs
//                                   hint: Text("Select the course you want to post your question to"),
//                                   value: courseController,
//                                   isDense: true,
//                                   onChanged: (newValue) {
//                                     setState(() {
//                                       courseController = newValue!;
//                                     });
//                                   },
//                                   items: this.dropdownButtonMenuItems,
//                                 ),
//                               ),
//                             ],
//                           )
//                       ),
//                     ),
//                     TextFormField(
//                       controller: titleController,
//                       maxLines: null,
//                       maxLength: null,
//                       keyboardType: TextInputType.multiline,
//                       decoration: InputDecoration(
//                         border: UnderlineInputBorder(),
//                         labelText: 'title',
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Enter title';
//                         }
//                         return null;
//                       },
//                     ),
//                     TextFormField(
//                       controller: this.bodyController,
//                       maxLines: 15,
//                       minLines: 10,
//                       decoration: InputDecoration(
//                         border: UnderlineInputBorder(),
//                         labelText: 'body',
//
//                       ),
//                       validator: (value) {
//                         if (value == null || value.isEmpty) {
//                           return 'Please enter some text';
//                         }
//                         return null;
//                       },
//                     ),
//                     Container(
//                         margin: EdgeInsets.fromLTRB(0, 50, 0, 10),
//                         child: ElevatedButton(
//                           onPressed:(){
//                             print('[POST QUESTION BUTTON PRESSED]');
//                             if (_formKey.currentState!.validate()) {
//                               var course = this.courseController;
//                               var title = this.titleController.text;
//                               var body = this.bodyController.text;
//                               print('[POST QUESTION course : $course, title: $title, body: $body]');
//
//
//                               DocumentReference<Object?>? question = addQuestion(course, title, body);
//                               if(question == null){
//
//                               }
//                               else{
//                                 // redirect to question page
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context){
//                                         return Question(question.id);
//                                       },
//                                     )
//                                 );
//                               }
//
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Text('Processing Data'),
//                                 ),
//                               );
//                             }
//                             else{
//                               print('[INVALID FORM DATA]');
//
//                             }
//                           },
//                           child: Text('POST'),
//                         )
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
//
