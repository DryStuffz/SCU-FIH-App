import 'package:app/dataBases/db_connect.dart';
import 'package:app/quizzes/addQuestions/saveData.dart';
import 'package:app/quizzes/getQuizzes.dart';
import 'package:app/quizzes/question_model.dart';
import 'package:app/quizzes/quizScreen.dart';
import 'package:flutter/material.dart';
import 'package:app/level1.dart';

class MyHomePage extends StatelessWidget {
  // Example Future function that returns a Future<String>
  Future<int> fetchData() async {
    // Simulate an asynchronous operation (e.g., an HTTP request)
    await Future.delayed(Duration(seconds: 2));

    // Return the result (a string in this example)
    return await readLevelIndex();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<int>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While the Future is still running, show a loading indicator.
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // If there was an error while fetching data, show an error message.
            return Text('Error: ${snapshot.error}');
          } else {
            // If the Future is complete, display the fetched data.
            return HomePage(levelProgress: snapshot.data ?? 1);
          }
        },
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key, required this.levelProgress});
  final int levelProgress;
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
                return const QuizScreen(quizName: 'Daily Quiz', saveData: true);
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
            onPressed: () async {
              if ((levelProgress >= await getLevelIndex('Level 1'))) {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (BuildContext context) {
                    return const QuizScreen(
                        quizName: 'Level 1', saveData: false);
                  }),
                );
              }
            },
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E2E50),
                minimumSize: Size(0.38 * width, 0.2 * height)),
            child: const Text('Level 1'),
          ),
          ElevatedButton(
            onPressed: () async{
              if((levelProgress >= await getLevelIndex('Level 1'))){
                Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return const QuizScreen(
                            quizName: 'Level 2', saveData: false);
                      }),
                    );
              }   
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
            onPressed: (levelProgress >= 3)
                ? () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return const QuizScreen(
                            quizName: 'Level 3', saveData: false);
                      }),
                    );
                  }
                : null,
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E2E50),
                minimumSize: Size(0.38 * width, 0.2 * height)),
            child: const Text('Level 3'),
          ),
          ElevatedButton(
            onPressed: (levelProgress >= 4)
                ? () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return const QuizScreen(
                            quizName: 'Level 4', saveData: false);
                      }),
                    );
                  }
                : null,
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
            onPressed: (levelProgress >= 5)
                ? () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return const QuizScreen(
                            quizName: 'Level 5', saveData: false);
                      }),
                    );
                  }
                : null,
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E2E50),
                minimumSize: Size(0.38 * width, 0.2 * height)),
            child: const Text('Level 5'),
          ),
          ElevatedButton(
            onPressed: (levelProgress >= 6)
                ? () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return const QuizScreen(
                            quizName: 'Level 6', saveData: false);
                      }),
                    );
                  }
                : null,
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
            onPressed: (levelProgress >= 7)
                ? () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return const QuizScreen(
                            quizName: 'Level 7', saveData: false);
                      }),
                    );
                  }
                : null,
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E2E50),
                minimumSize: Size(0.38 * width, 0.2 * height)),
            child: const Text('Level 7'),
          ),
          ElevatedButton(
            onPressed: (levelProgress >= 8)
                ? () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return const QuizScreen(
                            quizName: 'Level 8', saveData: false);
                      }),
                    );
                  }
                : null,
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
            onPressed: (levelProgress >= 9)
                ? () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return const QuizScreen(
                            quizName: 'Level 9', saveData: false);
                      }),
                    );
                  }
                : null,
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E2E50),
                minimumSize: Size(0.38 * width, 0.2 * height)),
            child: const Text('Level 9'),
          ),
          ElevatedButton(
            onPressed: (levelProgress >= 10)
                ? () {
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (BuildContext context) {
                        return const QuizScreen(
                            quizName: 'Level 10', saveData: false);
                      }),
                    );
                  }
                : null,
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
