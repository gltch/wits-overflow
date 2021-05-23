/*
* list all available course on the flatform
*/
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:wits_overflow/widgets/navigation.dart';
import 'package:wits_overflow/utils/functions.dart';
import 'package:wits_overflow/forms/course_create_form.dart';
import 'package:wits_overflow/screens/course_screen.dart';



// -----------------------------------------------------------------------------
//             COURSES  PAGE
// -----------------------------------------------------------------------------
class Courses extends StatefulWidget{


  @override
  _CoursesState createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  QuerySnapshot ? courses;
  QuerySnapshot ? favoritesCourses;
  bool busy = true;


  _CoursesState(){
    this.getData();
  }


  void getData () async{
    // get courses and favorites courses
    this.courses  = await FirebaseFirestore.instance.collection('courses').get();
    this.favoritesCourses = await FirebaseFirestore.instance.collection('favorites').where('user', isEqualTo: FirebaseAuth.instance.currentUser!.uid).get();

    this.setState(() {
      this.busy = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    if(!busy){
      var listViewChildren = <Widget>[
        Container(
          // color: Colors.black12,
          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                'Courses',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context){
                        return CourseCreateForm();
                      },
                    ),
                  );
                },
                child: Icon(Icons.add),
              ),
            ]
          ),
        ),
        Divider(),
      ];

      this.courses!.docs.forEach((courseDoc) {
        listViewChildren.add(customiseCourseTile(context, courseDoc.id, courseDoc.get('name'), courseDoc.get('description')));
        listViewChildren.add(Divider());
      });

      return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('wits-overflow'),
        ),
        body: ListView(
          children: listViewChildren,
        ),
      );

    }
    else{
      return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('wits-overflow'),
        ),
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );

    }
  }

  void addUserFavourite(){
  }

  bool isUserFavourite(String courseId){
    // print('[_CoursesState.isUserFavourite: courseId: $courseId, this.favoritesCourses.docs.length: ${this.favoritesCourses!.docs.length}, this.favoritesCourses.docs: ${this.favoritesCourses!.docs.toString()}]');
    for (var favoriteCourse in this.favoritesCourses!.docs) {
      // print('[CHECKING FAVORITE, courseId: $courseId, favoriteCourse.id: ${favoriteCourse.id}]');
      if(favoriteCourse.get('course') == courseId){
        return true;
      }
    }
    return false;
  }

  Widget customiseCourseTile(BuildContext context, String courseId, String courseName, String courseDescription){
    // this function only add appropriate Icon depending on whether the course is user's favourite
    // print('[customiseCourseTile, courseId: $courseId, courseName: $courseName, courseDescription: $courseDescription]');

    Icon isUserFavoriteIcon;

    if(this.isUserFavourite(courseId)){
      isUserFavoriteIcon = Icon(Icons.favorite);
    }
    else{
      isUserFavoriteIcon = Icon(Icons.favorite_border);
    }
    return ListTile(
      trailing: TextButton(
        onPressed: () {
          print('[SUBSCRIBE BUTTON PRESSED, courseId: $courseId, user.uid: ${FirebaseAuth.instance.currentUser!.uid}]');

          FirebaseFirestore.instance.collection('favorites')
              .where('course', isEqualTo: courseId)
              .where('user', isEqualTo: FirebaseAuth.instance.currentUser!.uid).get()
              .then((querySnapshot) async {
                // if the subject is currently not on user's favorite list, then add it
                if(querySnapshot.docs.length == 0){
                  print('[SUBJECT IS NOT USER\'S FAVORITE]');
                  final data = {
                    'user': FirebaseAuth.instance.currentUser!.uid,
                    'course': courseId,
                    'datetime': DateTime.now(),
                  };
                  // TODO: add code to reload page after user has added subject to his/her favorites
                  // reload page
                  FirebaseFirestore.instance.collection('favorites').add(data).then((value){
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Successfully subscribed to the course')
                      ),
                    );
                    // refresh the page by getting courses and user favorite courses
                    this.getData();
                  }).onError((error, stackTrace){
                    print('[ERROR OCCURRED WHILE SUBSCRIBING USER TO A SUBJECT]');
                  });
                }
                // else if the subject is on user's favorite list, remote it
                else{
                  print('[SUBJECT IS USER\'S FAVORITE]');
                  querySnapshot.docs.forEach((favoriteCourseDoc) async {
                    await FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
                      Transaction deleteTransaction = transaction.delete(favoriteCourseDoc.reference);
                    });
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Successfully removed subject from favorites')
                    ),
                  );
                  // refresh the page by getting courses and user favorite courses
                  this.getData();
                }
            });
          },
        child: isUserFavoriteIcon,
      ),

      title: Text(toTitleCase(courseName)),
      subtitle: Text(courseDescription),

      onTap: (){
        // redirect user to course profile
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context){
              return CourseProfile(courseId);
            },
          ),
        );
      },
    );
  }
}
