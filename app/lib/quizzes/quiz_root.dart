import 'package:app/constants/test_strings.dart';
import 'package:app/quizzes/optionCard.dart';
import 'package:app/quizzes/questionIndex.dart';
import 'package:app/quizzes/question_model.dart';
import 'package:app/quizzes/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:app/constants/colors.dart';

class QuizRoot extends StatefulWidget {
  const QuizRoot({super.key});

  @override
  State<QuizRoot> createState() => _QuizRootState();
}

class _QuizRootState extends State<QuizRoot> {
  //List of question to add to the quiz
  static List<Question> questions = [
    Question(id: '101', title: 'Click on the second option', options: {
      'First block': false,
      'Second Block': true,
      'Third block': false,
      'Fourth block': false,
    }),
    Question(id: '101', title: 'What us 2 + 2', options: {
      '4': true,
      '7': false,
      '34': false,
      '9': false,
    }),
    Question(id: '101', title: 'this is a ____ application', options: {
      'Python': false,
      'JAVASCRIPT': false,
      'HTML': false,
      'Flutter': true,
    }),
    Question(id: '101', title: 'Click on the third option', options: {
      'First block': false,
      'Second Block': false,
      'Third block': true,
      'Fourth block': false,
    })
  ];
  int questionIndex = 0; //index to loop through questions
  bool isFinished = false;
  int currentlySelected = -1;

  List<bool> alreadlyUsed =
      List.filled(questions[0].options.length, false, growable: false);
  List<Color> colorsIndex =
      List.filled(questions[0].options.length, netral, growable: false);
  List<String> titles = questions[0].options.keys.toList();
  List<bool> isCorrect = questions[0].options.values.toList();
  int score = 0;

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
                  _optionList(),
                ],
              )),
          QuestionCard(question: questions[questionIndex].title),
          QuestionIndex(
              currentQuestion: questionIndex + 1,
              numQuestion: questions.length),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: isFinished ? _nextButton() : _confirmAnswer(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _nextButton() {
    return GestureDetector(
        onTap: () {
          nextQuestion();
          isFinished = false;
        },
        child: Container(
            width: double.infinity,
            height: 35.0,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: blueGrey,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Text(
              'Next',
              textAlign: TextAlign.center,
              style: CustomTextStyle.confirm,
            )));
  }

  _confirmAnswer() {
    return GestureDetector(
        onTap: () {
          setState(() {
            //If nothing isSelected
            if (currentlySelected == -1) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Please select an option'),
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.symmetric(vertical: 20.0),
              ));
            } else if (alreadlyUsed[currentlySelected]) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text('Please select an option'),
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.symmetric(vertical: 20.0),
              ));
            } else {
              alreadlyUsed[currentlySelected] = true;
              isCorrect[currentlySelected]
                  ? colorsIndex[currentlySelected] = correct
                  : colorsIndex[currentlySelected] = incorrect;
              if (isCorrect[currentlySelected]) {
                isFinished = true;
              }
            }
          });
        },
        child: Container(
            width: double.infinity,
            height: 35.0,
            margin: const EdgeInsets.symmetric(horizontal: 15),
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: blueGrey,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Text(
              'Confirm',
              textAlign: TextAlign.center,
              style: CustomTextStyle.confirm,
            )));
  }

  bool addScore() {
    int counter = 0;
    for (int i = 0; i < questions[questionIndex].options.length; i++) {
      if (alreadlyUsed[i]) {
        counter++;
      }
    }
    if (counter <= 1) {
      return true;
    }
    return false;
  }

  void resetLists() {
    alreadlyUsed = List.filled(questions[questionIndex].options.length, false,
        growable: false);
    colorsIndex = List.filled(questions[questionIndex].options.length, netral,
        growable: false);
    currentlySelected = -1;
    titles = questions[questionIndex].options.keys.toList();
    isCorrect = questions[questionIndex].options.values.toList();
  }

  void nextQuestion() {
    if (addScore()) {
      setState(() {
        score++;
      });
    }
    if (questionIndex == questions.length - 1) {
      showDialog(
          context: context,
          builder: (ctx) => ResultScreen(
                questionLength: questions.length,
                numberCorrect: score,
              ));
    } else {
      if (isFinished) {
        setState(() {
          questionIndex++;
        });

        resetLists();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please selelct an option'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(vertical: 20.0),
        ));
      }
    }
  }

  _optionList() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
      width: 0.8 * width,
      height: 0.3 * height,
      child: ListView.builder(
        itemCount: questions[questionIndex].options.length,
        prototypeItem: ListTile(
          title: Text(titles.first),
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              currentlySelected = index;
              if (!alreadlyUsed[currentlySelected]) {
                setState(() {
                  for (int i = 0;
                      i < questions[questionIndex].options.length;
                      i++) {
                    if (alreadlyUsed[i] == false && i != currentlySelected) {
                      colorsIndex[i] = netral;
                    }
                  }
                  if (colorsIndex[currentlySelected] == selected) {
                    colorsIndex[currentlySelected] = netral;
                    currentlySelected = -1;
                  } else {
                    colorsIndex[currentlySelected] = selected;
                  }
                });
              }
            },
            child: OptionCard(option: titles[index], color: colorsIndex[index]),
          );
        },
      ),
    );
  }
}
