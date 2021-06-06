
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wits_overflow/screens/questions_and_answers_screen.dart';

class QuestionSummary extends StatelessWidget {

  final Map<String, dynamic> data;

  QuestionSummary({required this.data}) ;
  
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
          onTap: () => {
            Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => QuestionsAndAnswersScreen())),
          },
          child:
          Center(
          
            child: Container(
                width: double.infinity,
                height: 115,
                decoration: BoxDecoration(
                  border: Border(
                  bottom: BorderSide(color: Colors.grey.shade300),
                  top: BorderSide(color: Colors.grey.shade200)
                )
              ),
              child: Row(children: [
                
                Container(
                  color: Colors.grey.shade100,
                  height: double.infinity,
                  width: 100,
                  child: Center(child: 
                    Text("${(this.data['votes'] != null) ? this.data['votes'] : 0}\nvotes", textAlign: TextAlign.center
                  )),
                ),

                Expanded(child: Container(
                  padding: EdgeInsets.all(10),
                  height: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text(
                        this.data['title'],
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).primaryColorDark,
                          //fontWeight: FontWeight.bold
                      )),

                      Divider(color: Colors.white, height: 4),

                      Row(children: [

                        Container(
                          margin: EdgeInsets.only(right: 5),
                          color: Colors.lightBlue.shade50,
                          child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Text('CSAM')
                            ),
                        ),

                        Container(
                          margin: EdgeInsets.only(right: 5),
                          color: Colors.lightBlue.shade50,
                          child: Padding(
                              padding: EdgeInsets.all(5),
                              child: Text('COMS3007')
                            ),
                        ),
                        
                      ]),

                      Divider(color: Colors.white, height: 5),

                      Text((this.data['updatedAt'] as Timestamp).toDate().toString(), style: TextStyle(
                        color: Theme.of(context).disabledColor
                      ))

                  ])
                ))

              ])
            ),
          )
        );
    
  }

}