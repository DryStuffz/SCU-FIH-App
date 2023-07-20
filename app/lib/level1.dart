
import 'package:app/quizzes/questionIndex.dart';
import 'package:flutter/material.dart';

class Level1 extends StatefulWidget {
  const Level1({super.key});

  @override
  State<Level1> createState() => _Level1State();
}

class _Level1State extends State<Level1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('This is A LEVEL'),
        ),
        body: const Column(
          children: [
            //QuestionCard(question: "TESTING"),
            QuestionIndex(currentQuestion: 3, numQuestion: 10, question: 'Testing'),
          ],
        ));
  }
}
