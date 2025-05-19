import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:quiz/models/question_model.dart';

class DBConnect {
  final Uri url;

  DBConnect(String urlString) : url = Uri.parse(urlString);

  Future<List<Question>> fetchQuestion() async {
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      List<Question> newQuestions = [];
      data.forEach((key, value) {
        newQuestions.add(Question.fromJson(key, value));
      });
      return newQuestions;
    } else {
      throw Exception('Failed to fetch questions: ${response.statusCode}');
    }
  }
}