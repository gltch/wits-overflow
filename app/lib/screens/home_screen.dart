import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:universal_html/html.dart';

import 'package:wits_overflow/widgets/navigation.dart';
import 'package:wits_overflow/forms/question_create_form.dart';
import 'package:wits_overflow/screens/question_screen.dart';
import 'package:wits_overflow/utils/functions.dart';



// -----------------------------------------------------------------------------
//            HOME SCREEN CLASS
// -----------------------------------------------------------------------------
class HomeScreen extends StatefulWidget {

  HomeScreen(){
    print('[DASHBOARD CONSTRUCTOR]');
  }

  @override
  HomeScreenState createState() => HomeScreenState();

}


// -----------------------------------------------------------------------------
//    HOME SCREEN STATE CLASS
// -----------------------------------------------------------------------------
class HomeScreenState extends State<HomeScreen> {

  bool isBusy = true;

  List<DocumentSnapshot<Map<String, dynamic>>> userFavoriteCourses = [];
  List<DocumentSnapshot<Map<String, dynamic>>> userFavoriteQuestions = [];

  // hold user information for every userFavoriteQuestion in userFavouriteQuestion
  // index - question.id
  Map<String, DocumentSnapshot<Map<String, dynamic>>> userFavoriteQuestionsUsers = {};
  Map<String, QuerySnapshot<Map<String, dynamic>>> userFavoriteQuestionsAnswers = {};
  Map<String, QuerySnapshot<Map<String, dynamic>>> userFavoriteQuestionsVotes = {};

  HomeScreenState() {
    this.getData();
  }

  void getData() async{
    print('[------------------------------------ RETRIEVING DATA FROM FIREBASE ------------------------------------]');
    // get questions from favourite courses
    //
    // Future<DocumentSnapshot<Map<String, dynamic>>> getQuestionUser({required String questionId}) async{
    //   FirebaseFirestore.instance.collection('users').doc()
    // }

    // get favourite courses
    CollectionReference coursesReference = FirebaseFirestore.instance.collection('courses');
    String userUid = FirebaseAuth.instance.currentUser!.uid;

    // query favorites from favorites collection
    // each document contains fields : ['user', 'course', 'datetime']
    QuerySnapshot<Map<String, dynamic>> userFavoritesIds = await FirebaseFirestore.instance.collection('favorites').where('user', isEqualTo: userUid).get();


    List<String> userFavoriteCoursesIds = [];
    String courseId;
    for(var i = 0; i < userFavoritesIds.docs.length; i++){
      courseId = userFavoritesIds.docs.elementAt(i).get('course');
      userFavoriteCoursesIds.add(courseId);
      // retrieve course information for this course id
      DocumentSnapshot<Map<String, dynamic>> course = await coursesReference.doc(courseId).get() as DocumentSnapshot<Map<String, dynamic>>;
      this.userFavoriteCourses.add(course);
    }

    // get questions from database
    CollectionReference<Map<String, dynamic>> questionsReference = FirebaseFirestore.instance.collection('questions');
    print('[GETTING QUESTIONS FROM COURSES WITH IDS: ${userFavoriteCoursesIds.toString()}]');
    QuerySnapshot<Map<String, dynamic>> questions = await FirebaseFirestore.instance.collection('questions').where('course', whereIn: userFavoriteCoursesIds).orderBy('createAt').get();
    this.userFavoriteQuestions.addAll(questions.docs);


    // for every question, get user information
    DocumentSnapshot<Map<String, dynamic>> user;
    QuerySnapshot<Map<String, dynamic>> votes;
    QuerySnapshot<Map<String, dynamic>> answers;

    for(var i = 0; i < questions.docs.length; i++){

      user = await FirebaseFirestore.instance.collection('users').doc(questions.docs.elementAt(i).data()['user']).get();
      votes = await questions.docs.elementAt(i).reference.collection('votes').get();
      answers = await questions.docs.elementAt(i).reference.collection('answers').get();

      String questionId = questions.docs.elementAt(i).id;

      print('[ADDING QUESTION (id: ${questions.docs.elementAt(i).id}) INFORMATION (user:${user.exists ? 'USER EXIST': '!!! DOEST NOT EXIST !!!' })]');

      this.userFavoriteQuestionsUsers.addAll({questionId: user });
      this.userFavoriteQuestionsVotes.addAll({questionId: votes});
      this.userFavoriteQuestionsAnswers.addAll({questionId: answers});
    }


    setState(() {
      this.isBusy = false;
    });


    print('[------------------------------------ RETRIEVED DATA FROM FIREBASE ------------------------------------]');

  }

  @override
  Widget build(BuildContext context) {
    print('[HOME SCREEN BUILD]');
    if(this.isBusy == true){
      print('[APPLICATION IS BUSY]');
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

    // tabs
    // favorites - questions from favorite courses
    // all (latest, newest) - all questions from the platform sorted by date
    // all (unanswered) - all questions that don't have answers

    List<Widget> listViewChildren = <Widget>[
      Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
        decoration: BoxDecoration(
          color: Color.fromRGBO(239, 240, 241, 1),
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Color.fromRGBO(214, 217, 220, 1),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(

              child: Text(
                'Questions',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  color: Colors.black54,
                ),
              )
            ),

            Icon(
              Icons.favorite,
              color: Colors.blue,
              // color: Color.fromRGBO(128, 128, 255, 1),
              // color: Color.fromRGBO(199, 200, 201, 1),
            ),
          ],
        ),
      ),
    ];

    this.userFavoriteQuestions.forEach((question) {
      var questionVotes = this.userFavoriteQuestionsVotes[question.id];

      listViewChildren.add(
        GestureDetector(
          onTap: (){
            // navigate to question screen page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context){
                  return Question(question.id);
                },
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              // color: Colors.black12,
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: Color.fromRGBO(228, 230, 232, 1)
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              // crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                // votes and number of answers
                Expanded(
                  flex: 1,
                  child: Container(
                    // decoration: BoxDecoration(
                    //   color: Colors.black26,
                    // ),
                    width: 50,
                    color: Color.fromRGBO(214,217,220,0.2),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          // color: Colors.red,
                          margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              // number of up-votes
                              Text(
                                this.userFavoriteQuestionsVotes[question.id]!.docs.length.toString(),
                              ),
                              // icon
                              SvgPicture.asset(
                                'assets/icons/caret_up.svg',
                                semanticsLabel: 'Feed button',
                                placeholderBuilder: (context) {
                                  return Icon(Icons.error, color: Colors.deepOrange);
                                },
                                height: 10,
                              ),
                            ],
                          ),
                        ),

                        Container(
                          // color: Colors.red,
                          margin: EdgeInsets.fromLTRB(5, 5, 5, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                this.userFavoriteQuestionsAnswers[question.id]!.docs.length.toString(),
                              ),
                              SvgPicture.asset(
                                'assets/icons/answer.svg',
                                semanticsLabel: 'Feed button',
                                placeholderBuilder: (context) {
                                  return Icon(Icons.error, color: Colors.deepOrange);
                                },
                                height: 15,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),


                //
                Expanded(
                  flex: 8,
                  child:Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(255,245,222, 0.7),
                    ),
                    // height: double.maxFinite,

                    padding: EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // question title
                        Container(
                          child: Text(
                            question.data()!['title'].toString(),
                            style: TextStyle(
                              fontSize: 17,
                              color: Colors.blue,
                            ),
                          ),
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                        ),


                        // question tags
                        Row(),

                        // question post date and user displayName
                        Row(
                          children: [
                            // date
                            Container(
                              child: Text(
                                formatDateTime(DateTime.fromMillisecondsSinceEpoch((question.data()!['createAt'] as Timestamp).millisecondsSinceEpoch)),
                                style: TextStyle(
                                  fontSize: 12.5,
                                  color: Color.fromRGBO(159, 166, 173, 1,),
                                ),
                              ),
                              padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                            ),
                            // user displayName
                            Container(
                              child: Text(
                                this.userFavoriteQuestionsUsers[question.id]!.data() == null ? '*display name*' : this.userFavoriteQuestionsUsers[question.id]!.data()!['displayName'],
                                style: TextStyle(
                                  fontSize: 12.5,
                                  color: Colors.blue,
                                ),
                              ),
                              padding: EdgeInsets.fromLTRB(2, 0, 2, 0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )

              ],
            ),
          ),
        ),
      );
    });

    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Wits overflow'),
      ),
      body: ListView(
        children: listViewChildren,
      ),
    );
  }
  //
}



