import 'dart:convert';

import 'package:wits_overflow/models/question.dart';
import 'package:http/http.dart' as http;
import 'package:wits_overflow/utils/storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class WitsOverflowApi {

  static Future<List<Question>> fetchQuestions() async {

  // Get the list of questions from the api
  final token = await SecureStorage.read('user.token');

  // Get the api url from the environmental variables
  String apiBaseUrl = env['API_BASE_URL'].toString();

  final response = await http.get(
    Uri.parse("$apiBaseUrl/questions"),
    headers: { 'token': token ?? '' }
  );
  
  if (response.statusCode == 200) {
    
    // Parse the results
    Iterable results = json.decode(response.body);

    List<Question> questions = <Question>[];

    for (var result in results) {

      Question question = Question.fromJson(result);
      questions.add(question);

    }

    return questions;

  }
  else if (response.statusCode == 403) {
    throw Exception('Not authorized!');
  } else {
    throw Exception('Failed to load questions');
  }
}

}