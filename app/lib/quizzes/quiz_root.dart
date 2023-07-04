import 'package:app/quizzes/next_button.dart';
import 'package:app/quizzes/optionCard.dart';
import 'package:app/quizzes/question_model.dart';
import 'package:app/quizzes/question_widget.dart';
import 'package:flutter/material.dart';
import 'package:app/constants/colors.dart';

class QuizRoot extends StatefulWidget {
  const QuizRoot({super.key});

  @override
  State<QuizRoot> createState() => _QuizRootState();
}

class _QuizRootState extends State<QuizRoot> {
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


  void nextQuestion() {
    if (questionIndex == questions.length - 1) {
      return;
    } else {
      if(isPressed){
        setState(() {
        questionIndex++;
        isPressed = false;
      });
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please selelct an option'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(vertical: 20.0),
          )
        );
      }
      
    }
  }
  void changeColor(){
    setState(() {
      isPressed = true;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blueGrey,
      appBar: AppBar(
        title: const Text('Level 1'),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              QuestionWidget(
                  question: questions[questionIndex].title,
                  indexAction: questionIndex,
                  totalQuestions: questions.length),
              const Divider(color: netral),
              //space between question and options
              const SizedBox(
                height: 25.0,
              ),
              for (int i = 0; i < questions[questionIndex].options.length; i++)
                OptionCard(
                    option: questions[questionIndex].options.keys.toList()[i],
                    color: isPressed ? (questions[questionIndex].options.values.toList()[i] == true ? correct: incorrect) : netral,
                    onTap: changeColor,
                    ),
                    
                    
            ],
          )),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: NextButton(
          nextQuestion: nextQuestion,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
