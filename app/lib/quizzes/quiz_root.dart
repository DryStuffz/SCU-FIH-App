import 'package:app/quizzes/next_button.dart';
import 'package:app/quizzes/optionCard.dart';
import 'package:app/quizzes/questionIndex.dart';
import 'package:app/quizzes/question_model.dart';
import 'package:app/quizzes/question_widget.dart';
import 'package:app/quizzes/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:app/constants/colors.dart';

class QuizRoot extends StatefulWidget {
  const QuizRoot({super.key});

  @override
  State<QuizRoot> createState() => _QuizRootState();
}

class _QuizRootState extends State<QuizRoot>{
  //List of question to add to the quiz
  List<Question> questions = [
    Question(id: '101', title: 'Click on the second option', options: {
      'First block': false,
      'Second Block': true,
      'Third block': false,
      'Fourth block': false,
    }),
    Question(id: '101', title: 'Click on the Third option', options: {
      'First block': false,
      'Second Block': false,
      'Third block': true,
      'Fourth block': false,
    }),
    Question(id: '101', title: 'Click on the Fourth option', options: {
      'First block': false,
      'Second Block': false,
      'Third block': false,
      'Fourth block': true,
    }),
    Question(id: '101', title: 'Click on the second option', options: {
      'First block': false,
      'Second Block': true,
      'Third block': false,
      'Fourth block': false,
    })
  ];
  int questionIndex = 0; //index to loop through questions
  bool isPressed = false;

  int score = 0;

  void nextQuestion() {
    if (questionIndex == questions.length - 1) {
      showDialog(
          context: context,
          builder: (ctx) => ResultScreen(
                questionLength: questions.length,
                numberCorrect: score,
              ));
    } else {
      if (isPressed) {
        setState(() {
          questionIndex++;
          isPressed = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please selelct an option'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(vertical: 20.0),
        ));
      }
    }
  }

  void updateOption(bool value) {
    if (!isPressed) {
      if (value == true) {
        score++;
      }
      setState(() {
        isPressed = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height =
        MediaQuery.of(context).size.height; //get the height of the screen
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        title: const Text('Level 1'),
        backgroundColor: blueGrey,
        shadowColor: Colors.transparent,
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
          Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 0.42 * height,
                  ),
                  //QuestionWidget(
                  //question: questions[questionIndex].title,
                  //indexAction: questionIndex,
                  //totalQuestions: questions.length),

                  //space between question and options
                  const SizedBox(
                    height: 25.0,
                  ),
                  for (int i = 0;
                      i < questions[questionIndex].options.length;
                      i++)
                    GestureDetector(
                      onTap: () => updateOption(
                          questions[questionIndex].options.values.toList()[i]),
                      child: OptionCard(
                        option:
                            questions[questionIndex].options.keys.toList()[i],
                        color: isPressed
                            ? (questions[questionIndex]
                                        .options
                                        .values
                                        .toList()[i] ==
                                    true
                                ? correct
                                : incorrect)
                            : netral,
                      ),
                    ),
                ],
              )),
          QuestionCard(question: questions[questionIndex].title),
          QuestionIndex(currentQuestion: questionIndex + 1, numQuestion: questions.length),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: NextButton(
          nextQuestion: nextQuestion,
          isPressed: isPressed,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
