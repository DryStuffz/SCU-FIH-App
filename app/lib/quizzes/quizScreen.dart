// ignore_for_file: library_private_types_in_public_api

import 'dart:async';
import 'dart:collection';

import 'package:app/constants/colors.dart';
import 'package:app/dataBases/db_connect.dart';
import 'package:app/quizzes/addQuestions/saveData.dart';
import 'package:app/quizzes/getQuizzes.dart';
import 'package:app/quizzes/questionIndex.dart';
import 'package:app/quizzes/question_model.dart';
import 'package:app/quizzes/result_screen.dart';
import 'package:app/tts.dart';
import 'package:flutter/material.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key, required this.quizName, required this.saveData});
  final String quizName;
  final bool saveData;

  Future<Quiz> fetchQuizData() {
    // Simulate fetching quiz data asynchronously (you should fetch it from your data source)
    return getQuizzes(quizName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      body: Center(
        child: FutureBuilder<Quiz>(
          future: fetchQuizData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return const Text('Error loading quiz data');
            } else if (snapshot.hasData) {
              return QuizWidget(
                quiz: snapshot.data!,
                isSaved: saveData,
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
  const QuizWidget({super.key, required this.quiz, required this.isSaved});

  @override
  _QuizWidgetState createState() => _QuizWidgetState();
}

class _QuizWidgetState extends State<QuizWidget> {
  int currentQuestionIndex = 0;
  // bool canProceed = false;
  // bool isCorrectlySelected = false;
  // bool showCorrectAnswer = false; // Added variable to control revealing the correct answer
  int currentlySelected = -1;
  bool isFinished = false;
  int score = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    Question currentQuestion =
        widget.quiz.getQuestionIndex(currentQuestionIndex);

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
      //check if we update score or not
      if (updateScore()) {
        score++;
      }
      if(widget.isSaved){
        //addQuizData(currentQuestion);
      }
      isFinished = false;
      currentQuestionIndex++;
      currentlySelected = -1;
      if (currentQuestionIndex == widget.quiz.questions.length) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => ResultsScreen(
                totalQuestions: widget.quiz.questions.length,
                correctAnswers: score,
                onRestartQuiz: () {
                  // Restart the quiz
                  // You can navigate back to the first question or reset the state of the quiz
                  Navigator.pop(context);
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

// ... (other code remains unchanged)


// ... (other code remains unchanged)




