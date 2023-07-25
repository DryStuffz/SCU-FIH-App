import 'package:app/history/historyScreen.dart';
import 'package:app/quizzes/addQuestions/saveData.dart';
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
    return History();
    // return Scaffold(
    //     appBar: AppBar(
    //       title: const Text('This is A LEVEL'),
    //     ),
    //     body: Column(
    //       children: [
    //         //QuestionCard(question: "TESTING"),
    //         const QuestionIndex(
    //             currentQuestion: 3, numQuestion: 10, question: 'Testing'),
    //         ElevatedButton(
    //             onPressed: () {
    //               eraseFileData();
    //               //updateJsonData();
    //               //writeJsonData({'test' : 3});
    //               //print(readJsonData());
    //             },
    //             child: Text('add')),
    //       ],
    //     ));
  }
}
