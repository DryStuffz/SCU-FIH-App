import 'package:app/Test.dart';
import 'package:app/daily_problem.dart';
import 'package:flutter/material.dart';
import 'package:app/level1.dart';
import 'package:app/quizzes/quiz_root.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double height =
        MediaQuery.of(context).size.height; //get the height of the screen
    double width =
        MediaQuery.of(context).size.width; //get the width of the screen
    return Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) {
              return const DailyProblem();
            }),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF2E2E50),
          fixedSize: Size(0.9 * width, 0.3 * height),
        ),
        child: Stack(children: [
          
          Container(
              height: 30,
              width: double.infinity,

              padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
              child: const Text(
                'Daily Problem',
              ))
        ]),
      ),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) {
                return const  QuizRoot(quizName: 'level1',);
              }),
            );
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E2E50),
              minimumSize: Size(0.38 * width, 0.2 * height)),
          child: const Text('Level 1'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) {
                return  const QuizRoot(quizName: 'level2',);
              }),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF2E2E50),
            minimumSize: Size(0.38 * width, 0.2 * height),
          ),
          child: const Text('Level 2'),
        ),
      ]),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) {
                return const Level1();
              }),
            );
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E2E50),
              minimumSize: Size(0.38 * width, 0.2 * height)),
          child: const Text('Level 3'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) {
                return const Level1();
              }),
            );
          },
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF2E2E50),
              minimumSize: Size(0.38 * width, 0.2 * height)),
          child: const Text('Level 4'),
        ),
      ])
    ]);
  }
}
