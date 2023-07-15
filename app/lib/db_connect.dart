import 'package:app/quizzes/question_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DBconnect {
  final url = Uri.parse(
      'https://fluentfocus-b7c61-default-rtdb.firebaseio.com/questions.json');
  Future<void> addQuestion(Question question) async {
    http.post(url,
        body: json.encode({
          'title': question.title,
          'options': question.answers,
        }));
  }

  Future<void> fetchQuestions() async {
    http.get(url).then((response) {
      var data = json.decode(response.body) as Map<String, dynamic>;

      data.forEach((key, value) {
        var newQuestion =
            Question(title: value['title'], answers: value['options']);
      });
      print(data);
    });
  }
}
