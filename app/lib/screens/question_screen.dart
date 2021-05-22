

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

import 'package:wits_overflow/widgets/navigation.dart';


// ---------------------------------------------------------------------------
//             Dashboard class
// ---------------------------------------------------------------------------
class Question extends StatefulWidget{

  final String id; //question id

  Question(this.id);

  @override
  _QuestionState createState() => _QuestionState(this.id);
}

class _QuestionState extends State<Question> {

  final String id; // question id
  DocumentSnapshot ? question;
  QuerySnapshot<Map<String, dynamic>> ? questionVotes;
  QuerySnapshot<Map<String, dynamic>> ? comments;
  QuerySnapshot<Map<String, dynamic>> ? answers;
  Map<String, dynamic> answerVotes = Map();
  bool isBusy = true;

  _QuestionState(this.id){
    this.getData();
  }

  Future<void> getData() async {
    // retrieve necessary data from firebase to view this page
    // this.votes = await FirebaseFirestore.instance.collection('votes').where('question', isEqualTo: this.id).get();
    // this.comments = await FirebaseFirestore.instance.collection('comments').where('question', isEqualTo: this.id).get();

    print('[_QuestionState.getData(), RETRIEVING DATA FROM FIREBASE]');

    this.question = await FirebaseFirestore.instance.collection("questions").doc(this.id).get();
    this.questionVotes = await FirebaseFirestore.instance.collection('questions').doc(this.id).collection('votes').get();
    this.comments = await FirebaseFirestore.instance.collection('questions').doc(this.id).collection('comments').get();
    this.answers = await FirebaseFirestore.instance.collection('questions').doc(this.id).collection('answers').get();
    // this.answerVotes = await FirebaseFirestore.instance.collection('questions').doc(this.id).collection('answers').get();

    // List answer_votes = <Map>[for(var i = 0; i < this.answers!.docs.length; i++)
    //   {this.answers!.docs[i].id: await FirebaseFirestore.instance.collection('questions').doc(this.id).collection('answers').doc(this.answers!.docs[i].id).get()},
    //   ];

    // this.answerVotes!.addEntries(answer_votes);
    // this.answerVotes.
    this.answers!.docs.forEach((answerDoc) async {
      print('[RETRIEVING ANSWER VOTE FROM DATABASE]');
      this.answerVotes.addAll({answerDoc.id: await FirebaseFirestore.instance.collection('questions').doc(this.id).collection('answers').doc(answerDoc.id).get()});
      print('[RETRIEVED ANSWER VOTE FROM DATABASE]');
    });
    // print(this.answers!.docs[0].);
    // print('this.answers!.docs.asMap().keys.toString(): ${this.answers!.docs.asMap().keys.toString()}');
    print('[RETRIEVED DATA FROM FIREBASE]');
    setState(() {
      this.isBusy = false;
    });
  }


  Widget getComments(){

    // TODO: remote the following lines in production

     return Container(
       padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
       child: Column(
         children:
           <Widget>[
            Divider(),
            Column(

              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// user first and last names
                /// user comment
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('I\'m just gonna say blah blah blah blah blah blah blah')
                ),

                /// comment: time and user
                Container(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Row(

                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      // datetime
                      /// comment datetime
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                        child: Text(
                          DateTime(2021, 4, 23, 19, 43, 01).toString(),
                          style:TextStyle(
                            fontSize: 11,
                            color: Colors.black26,
                          ),
                        ),
                      ),

                      // user
                      /// comment user
                      Container(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Text(
                          'test username',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Divider(),

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('the following are comments placeholders. You should not be reading this, they are inserted to make this page look cool, so stop now because it\'s useless')
                ),
                /// comment: time and user
                Container(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Row(

                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      // datetime
                      /// comment datetime
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                        child: Text(
                          DateTime(2021, 4, 23, 19, 43, 01).toString(),
                          style:TextStyle(
                            fontSize: 11,
                            color: Colors.black26,
                          ),
                        ),
                      ),

                      // user
                      /// comment user
                      Container(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Text(
                          'another-username',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Divider(),


            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('Your question is very unclear. Be more specific.')
                ),

                /// comment: time and user
                Container(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Row(

                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      // datetime
                      /// comment datetime
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                        child: Text(
                          DateTime(2021, 4, 23, 19, 43, 01).toString(),
                          style:TextStyle(
                            fontSize: 11,
                            color: Colors.black26,
                          ),
                        ),
                      ),

                      // user
                      /// comment user
                      Container(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Text(
                          'bestmanintheworld',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
             Divider(),

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('Try google TensorFlow. Its what most people use and I personally think it\'s awesome.')
                ),

                /// comment: time and user
                Container(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Row(

                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      // datetime
                      /// comment datetime
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                        child: Text(
                          DateTime(2021, 4, 23, 19, 43, 01).toString(),
                          style:TextStyle(
                            fontSize: 11,
                            color: Colors.black26,
                          ),
                        ),
                      ),

                      // user
                      /// comment user
                      Container(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Text(
                          'icancode',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Divider(),

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('Do you also want that framework to include deep learning?')
                ),

                /// comment: time and user
                Container(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Row(

                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      // datetime
                      /// comment datetime
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                        child: Text(
                          DateTime(2021, 4, 23, 19, 43, 01).toString(),
                          style:TextStyle(
                            fontSize: 11,
                            color: Colors.black26,
                          ),
                        ),
                      ),

                      // user
                      /// comment user
                      Container(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Text(
                          'helloworld',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Divider(),

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('I suggest Keras')
                ),

                /// comment: time and user
                Container(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Row(

                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      // datetime
                      /// comment datetime
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                        child: Text(
                          DateTime(2021, 4, 23, 19, 43, 01).toString(),
                          style:TextStyle(
                            fontSize: 11,
                            color: Colors.black26,
                          ),
                        ),
                      ),

                      // user
                      /// comment user
                      Container(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Text(
                          'reuben-matlala',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Divider(),

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /// comment text/body
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text('You definitely don\'t want to start from the beginning, using fa framework is a good idea.')
                ),
                /// comment: time and user
                Container(
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: Row(

                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      // datetime
                      /// comment datetime
                      Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                        child: Text(
                          DateTime(2021, 4, 23, 19, 43, 01).toString(),
                          style:TextStyle(
                            fontSize: 11,
                            color: Colors.black26,
                          ),
                        ),
                      ),

                      // user
                      /// comment user
                      Container(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                        child: Text(
                          'reuben-matlala',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            Divider(),
          ],
       ),
     );
  }


  String getQuestionBody(){
    // TODO: get body field properly
    // check whether 'body' field exist in the document snapshot question
    // if you try to access it and its not there, it will give error
    return this.question!.get('body');
  }


  String getQuestionTitle() {
    // TODO: get title field properly
    // check whether 'title' field exist in the document snapshot question
    // if you try to access it and its not there, it will give error
    return this.question!.get('title');
  }


  Widget getAnswers(){
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Column(
        children: <Widget>[
          Divider(),
          /// answer widget
          Column(
            children: [
              /// update vote button, down vote button, votes, question body
              Row(
                mainAxisSize: MainAxisSize.min,
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// answer up vote button, down vote button, votes vote button
                  Container(
                    padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                    child: Column(
                      children: [
                        Container(
                          // color: Colors.black12,
                          // padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                          child:Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              /// up vote button, down vote button
                              /// number of votes
                              Column(
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Container(
                                    child: Column(
                                      children: <Widget>[
                                        Icon(Icons.arrow_drop_up, size: 40,),
                                        Text(
                                          // TODO: insert real votes
                                          '0',
                                          // this.votes!.docs.length.toString(),
                                          style: TextStyle(
                                            // fontSize: 20,
                                          ),
                                        ),
                                        Icon(Icons.arrow_drop_down, size: 40,),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),


                  /// answer body
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children:<Widget>[
                        Flexible(
                          child: Align(
                            alignment: Alignment.topLeft,
                            // child: Container(
                            //   color: Colors.black12,
                              // padding: EdgeInsets.fromLTRB(0, 0, 10, 10),
                              child: Text(
                                'This is just a placeholder for a question answer, I\'m just tyring to make the answer long enough to look like a real answer. Don\'t read',
                                // style: TextStyle(
                                //   fontSize: 20,
                                //   fontWeight: FontWeight.w600,
                                // ),
                                textAlign: TextAlign.left,
                                softWrap: true,
                              ),
                            // ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Container(
                  //
                  //   padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                  //   child: Flex(
                  //     mainAxisSize: MainAxisSize.min,
                  //     direction: Axis.horizontal,
                  //     children: [
                  //       Flexible(
                  //
                  //         child:
                  //         Text(
                  //           'This is just a placeholder for a question answer, I\'m just tyring to make the answer long enough to look like a real answer. Don\'t read',
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),


              /// creator information
              Row(),


              /// update information
              Row(),
            ],
          ),
        ],
      ),
    );



  }

  @override
  Widget build(BuildContext context) {
    print('_QuestionState.build');
    //
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


    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Wits overflow'),
      ),
      body: Center(
        child:Container(
          child: ListView(
            children: <Widget>[

              /// question title and body
              /// votes, up-vote and down-vote
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 5),
                    child:Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[

                        /// question title and body
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children:<Widget>[
                              Flexible(
                                child: Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 10, 10),
                                  child: Text(
                                    this.getQuestionTitle(),
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    textAlign: TextAlign.left,
                                    softWrap: true,
                                  ),
                                ),
                              ),
                              /// question body
                              Flexible(
                                child:Container(
                                  padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                                  child: Text(
                                    this.getQuestionBody(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        /// up vote button, down vote button
                        /// number of votes
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Container(
                              child: Column(
                                children: <Widget>[
                                  Icon(Icons.arrow_drop_up, size: 40,),
                                  Text(
                                    // this.votes!.docs.length.toString(),
                                    // TODO: insert real votes
                                    '0',
                                    style: TextStyle(
                                      // fontSize: 20,
                                    ),
                                  ),
                                  Icon(Icons.arrow_drop_down, size: 40,),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              // divider
              Divider(),


              /// comments
              /// comments header
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 15),
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

              /// comments list
              this.getComments(),

              /// answers
              /// answers header
              Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 15),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Answers',
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    Icon(Icons.add),
                  ],
                ),
              ),

              /// answers list
              this.getAnswers(),
            ],
          ),
        ),
      ),
    );
  }
}
