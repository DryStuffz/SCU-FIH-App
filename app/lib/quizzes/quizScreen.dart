// ignore_for_file: library_private_types_in_public_api
import 'dart:async';
import 'package:app/constants/colors.dart';
import 'package:app/dataBases/hive.dart';
import 'package:app/main.dart';
import 'package:app/quizzes/addQuestions/saveData.dart';
import 'package:app/quizzes/getQuizzes.dart';
import 'package:app/quizzes/questionIndex.dart';
import 'package:app/quizzes/question_model.dart';
import 'package:app/quizzes/result_screen.dart';
import 'package:app/tts.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key, required this.quizName, required this.saveData});
  final String quizName;
  final bool saveData;

  Future<Quiz> fetchQuizData() {
    // Simulate fetching quiz data asynchronously (you should fetch it from your data source)
    return getQuizzes(quizName);
  }

  Future<List<int>> fetchDailyQuizData() async {
    if (quizName != 'Daily Quiz') {
      return [0, 0];
    } else {
      print('DQ SEEN');
      DateTime now = DateTime.now();
      final prefs = await SharedPreferences.getInstance();
      int? questionIndex = prefs.getInt('${now.month}-${now.day}-${now.year}');
      int? savedScore = prefs.getInt('score');
      if (questionIndex == null) {
        prefs.clear();
        return [0, 0];
      } else {
        if (savedScore != null) {
          return [questionIndex, savedScore];
        } else {
          return [questionIndex, 0];
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blueDark,
      body: Center(
        child: FutureBuilder<Quiz>(
          future: fetchQuizData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text('Error loading quiz data');
            } else if (snapshot.hasData) {
              return FutureBuilder<List<int>>(
                future: fetchDailyQuizData(),
                builder: (context, snapshot2) {
                  if (snapshot2.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot2.hasError) {
                    return const Text('Error loading quiz data');
                  } else if (snapshot2.data![0] >=
                      snapshot.data!.questions.length) {
                    return ResultsScreen(
                      totalQuestions: snapshot.data!.questions.length,
                      correctAnswers: snapshot2.data![1],
                      addToData: true,
                      data:
                          Hive.box<ListData>('DailyScoresList').get('Scores') ??
                              ListData([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]),
                      goHome: () {
                        // Restart the quiz
                        // You can navigate back to the first question or reset the state of the quiz
                        Navigator.popUntil(context, (route) => false);
                        //Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const RootPage(), // Replace AnotherScreen with your desired screen
                          ),
                        );
                      },
                    );

                    //return Container(child: Text("sdadasdas"));
                  } else if (snapshot2.hasData) {
                    print("number  ${snapshot2.data!}");
                    return QuizWidget(
                      quiz: snapshot.data!,
                      isSaved: saveData,
                      startingQuestionAndScore: snapshot2.data!,
                      quizID: quizName,
                    );
                  } else {
                    return const Text('No quiz data available');
                  }
                },
              );
            } else {
              return const Text('No quiz data available');
            }
          },
        ),
      ),
    );
  }
}

class QuizWidget extends StatefulWidget {
  final Quiz quiz;
  final bool isSaved;
  final List<int> startingQuestionAndScore;
  final String quizID;
  const QuizWidget(
      {super.key,
      required this.quiz,
      required this.isSaved,
      required this.startingQuestionAndScore,
      required this.quizID});

  @override
  _QuizWidgetState createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  late int currentQuestionIndex = widget.startingQuestionAndScore[0];
  // bool canProceed = false;
  // bool isCorrectlySelected = false;
  // bool showCorrectAnswer = false; // Added variable to control revealing the correct answer
  int currentlySelected = -1;
  bool isFinished = false;
  late int score = widget.startingQuestionAndScore[1];

  @override
  void initState() {
    super.initState();
  }

  void saveIndexData() async {
    DateTime now = DateTime.now();
    final prefs = await SharedPreferences.getInstance();
    // Add more data if needed
    prefs.setInt('${now.month}-${now.day}-${now.year}', currentQuestionIndex);
    prefs.setInt('score', score);
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Question currentQuestion =
        widget.quiz.getQuestionIndex(currentQuestionIndex);

    void increaseLevelIndex(int total, int correct, String qName) async {
      //if user gets at least 80% of the way done, upadte the index
      int levelIndex = await getLevelIndex(qName);
      if (correct >= total * 0.8 && await readLevelIndex() <= levelIndex) {
        writeLevelIndex(await readLevelIndex() + 1);
      }
    }

    confirmAnswer() {
      if (currentlySelected != -1) {
        currentQuestion.setColorIndex(
            currentlySelected,
            currentQuestion.answers[currentlySelected].isCorrect
                ? correct
                : incorrect);
        if (currentQuestion.getColorIndex(currentlySelected) == correct) {
          isFinished = true;
          currentlySelected = -1;
        }
      }
    }

    updateScore() {
      for (int i = 0; i < currentQuestion.getColorList().length; i++) {
        if (currentQuestion.getColorIndex(i) == incorrect) {
          return false;
        }
      }
      return true;
    }

    submitAnswer() {
      //print(readJsonData(completedQuestions));

      //print(currentQuestion.toNewData());
      updateJsonData(currentQuestion, 'data.json');

      //check if we update score or not
      if (updateScore()) {
        score++;
      }
      if (widget.isSaved) {
        saveIndexData();
        //updateJsonData(currentQuestion, 'data.json');
      }
      isFinished = false;
      currentQuestionIndex++;
      currentlySelected = -1;
      if (currentQuestionIndex == widget.quiz.questions.length) {
        if (widget.quiz.quizName != "Daily Quiz") {
          //increase the levelcap for the user
          increaseLevelIndex(
              widget.quiz.questions.length, score, widget.quiz.quizName);
        }
        if (widget.quizID == "Daily Quiz") {
          print('HIVEEEEEEEE');
          final box = Hive.box<ListData>('DailyScoresList');
          final listData = box.get('Scores');
          if (listData != null) {
            listData.integers[score]++;
            box.put('Scores', listData);
          }
        }

        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ResultsScreen(
                totalQuestions: widget.quiz.questions.length,
                correctAnswers: score,
                addToData: widget.isSaved,
                data: Hive.box<ListData>('DailyScoresList').get('Scores') ??
                    ListData([0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]),
                goHome: () {
                  // Restart the quiz
                  // You can navigate back to the first question or reset the state of the quiz
                  Navigator.popUntil(context, (route) => false);
                  //Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const RootPage(), // Replace AnotherScreen with your desired screen
                    ),
                  );
                },
              ),
            ));
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: blueGrey,
        title: Text(widget.quiz.quizName),
        shadowColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // When the back button is pressed, navigate back to the previous page.
            Navigator.pop(context, true);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text(
              'Score: $score',
              style: const TextStyle(fontSize: 18.0),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: height * 0.3,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
              color: blueGrey,
            ),
          ),
          QuestionIndex(
              currentQuestion: currentQuestionIndex + 1,
              numQuestion: widget.quiz.questions.length,
              question: currentQuestion.title),
          Column(
            children: [
              SizedBox(
                height: 0.42 * height,
              ),
              for (int i = 0; i < currentQuestion.answers.length; i++)
                AnswerButton(
                  answer: currentQuestion.answers[i],
                  onPressed: () {
                    setState(() {
                      currentlySelected = i;
                      if (currentQuestion.getColorIndex(i) == netral) {
                        for (int j = 0;
                            j < currentQuestion.answers.length;
                            j++) {
                          if (currentQuestion.getColorIndex(j) == selected) {
                            currentQuestion.setColorIndex(j, netral);
                          }
                        }
                        currentQuestion.setColorIndex(i, selected);
                      }
                    });
                  },
                  isCorrectAnswer: currentQuestion.answers[i].isCorrect,
                  buttonColor: currentQuestion.getColorIndex(i),
                  // Pass the variable to the AnswerButton
                ),
              SizedBox(height: height * 0.03),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isFinished ? submitAnswer() : confirmAnswer();
                  });
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: blueGrey,
                    minimumSize: Size(width * 0.90, height * 0.08)),
                child: Text(
                  isFinished ? 'Next' : 'Confirm',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontFamily: 'inter',
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class AnswerButton extends StatelessWidget {
  final Answer answer;
  final VoidCallback onPressed;
  final bool isCorrectAnswer;
  final Color buttonColor;

  const AnswerButton({
    super.key,
    required this.answer,
    required this.onPressed,
    required this.isCorrectAnswer,
    required this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: double.infinity,
      height: height * 0.08,
      padding: EdgeInsets.symmetric(
          horizontal: width * 0.07, vertical: height * 0.01),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              textAlign: TextAlign.left,
              answer.option,
              style: const TextStyle(
                  fontSize: 18.0, fontFamily: 'inter', color: Colors.black),
            ),
            GestureDetector(
              onTap: () {
                speakText(answer.option);
              },
              child: const Icon(Icons.volume_up_rounded, color: blueGrey),
            ),
          ],
        ),
      ),
    );
  }
}
