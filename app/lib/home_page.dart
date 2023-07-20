import 'package:app/dataBases/db_connect.dart';
import 'package:app/quizzes/getQuizzes.dart';
import 'package:app/quizzes/question_model.dart';
import 'package:app/quizzes/quizScreen.dart';
import 'package:flutter/material.dart';
import 'package:app/level1.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double height =
        MediaQuery.of(context).size.height; //get the height of the screen
    double width =
        MediaQuery.of(context).size.width; //get the width of the screen

    return SingleChildScrollView(
      child: Column(children: [
        const SizedBox(
          // spacing inbetween rows
          height: 20,
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (BuildContext context) {
                return  const QuizScreen(quizName: 'Daily Quiz', saveData: true);
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
        const SizedBox(
          // spacing inbetween rows
          height: 20,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) {
                  return  const QuizScreen(quizName: 'level1', saveData: false);
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
                  return  const QuizScreen(quizName: 'level2', saveData: false);
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
        const SizedBox(
          // spacing inbetween rows
          height: 20,
        ),
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
        ]),
        const SizedBox(
          // spacing inbetween rows
          height: 20,
        ),
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
            child: const Text('Level 5'),
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
            child: const Text('Level 6'),
          ),
        ]),
        const SizedBox(
          // spacing inbetween rows
          height: 20,
        ),
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
            child: const Text('Level 7'),
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
            child: const Text('Level 8'),
          ),
        ]),
        const SizedBox(
          // spacing inbetween rows
          height: 20,
        ),
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
            child: const Text('Level 9'),
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
            child: const Text('Level 10'),
          ),
        ]),
        const SizedBox(
          // spacing inbetween rows
          height: 20,
        ),
      ]),
    );
  }
}
