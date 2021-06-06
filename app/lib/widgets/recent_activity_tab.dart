import 'package:flutter/material.dart';
import 'package:wits_overflow/utils/wits_overflow_data.dart';
import 'package:wits_overflow/widgets/question_summary.dart';

class RecentActivityTab extends StatelessWidget {

  late Future<List<Map<String, dynamic>>> questions;

  RecentActivityTab() {

    questions = WitsOverflowData().fetchLatestQuestions(3);

  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder<List<Map<String, dynamic>>>(
      future: questions,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data?.length,
            itemBuilder: (context, index) {
              Map<String, dynamic>? data = snapshot.data?[index];
              if (data != null) {
                return QuestionSummary(data: data);
              }
              else {
                return SizedBox.shrink();
              }

            }
          );
        }
        else {
          return Text('No recent activity3');
        }
      }
    );

  }

}

