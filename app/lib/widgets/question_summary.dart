
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wits_overflow/screens/question_and_answers_screen.dart';

class QuestionSummary extends StatelessWidget {

  final Map<String, dynamic> data;

  QuestionSummary({required this.data}) ;
  
  @override
  Widget build(BuildContext context) {

    Widget _createBadges() {
      
      List<Widget> list = <Widget>[];

      if (this.data.containsKey('tags')) {
        for(var i = 0; i < this.data['tags'].length; i++){

          list.add(new Container(
            margin: EdgeInsets.only(right: 5),
            color: Colors.lightBlue.shade50,
            child: Padding(
                padding: EdgeInsets.all(5),
                child: Text(this.data['tags'][i])
              ),
          ));

        }
      }

      return new Row(children: list);

    }

    return GestureDetector(
          onTap: () => {
            Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => QuestionAndAnswersScreen(this.data['id']))),
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

                      _createBadges(),

                      Divider(color: Colors.white, height: 5),

                      (this.data['createdAt'] == null) ? SizedBox.shrink() : 
                      Text((this.data['createdAt'] as Timestamp).toDate().toString(), style: TextStyle(
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