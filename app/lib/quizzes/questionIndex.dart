import 'dart:math';
import "package:app/constants/colors.dart";
import "package:app/quizzes/arc.dart";
import "package:app/quizzes/question_model.dart";
import "package:app/tts.dart";
import "package:flutter/material.dart";


class QuestionCard extends StatelessWidget {
  const QuestionCard({
    super.key,
    required this.question,
  });
  final String question;

  @override
  Widget build(BuildContext context) {
    double height =
        MediaQuery.of(context).size.height; //get the height of the screen
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.symmetric(horizontal: width * 0.175, vertical: 60),
      width: width * 0.65,
      height: height * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(42.0),
        color: netral,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF000000).withOpacity(0.25),

            blurRadius: 4,
            offset: const Offset(0, 4),
            spreadRadius: 3, // Shadow position
          ),
        ],
      ),
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: width *0.03),
        child: Align(
          alignment: Alignment.center, 
          child: Text(
            question,
            textAlign: TextAlign.center,
            style: const TextStyle(fontFamily: 'inter', fontSize: 16),
          ),
        ),
      ),
    );
  }
}

class QuestionIndex extends StatefulWidget {
  const QuestionIndex(
      {super.key, required this.currentQuestion, required this.numQuestion, required this.question,});
  final int currentQuestion;
  final int numQuestion;
  final String question;

  @override
  State<QuestionIndex> createState() => _QuestionIndexState();
}

class _QuestionIndexState extends State<QuestionIndex> {
  @override
  Widget build(BuildContext context) {
    double height =
        MediaQuery.of(context).size.height; //get the height of the screen
    double width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        QuestionCard(question: widget.question),
        Center(
          heightFactor: 0.4,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration:  BoxDecoration(
                  color: netral,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  width: 300,
                  height: 300,
                  child: AnimationBar(endvalue:widget.currentQuestion / widget.numQuestion)
                    //painter: ArcProgressPainter(
                        //arcColor: purple, arclength: widget.currentQuestion / widget.numQuestion),
                  //)
                  ),
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  
                ),
                
              ),
              Text(
                  '${widget.currentQuestion} / ${widget.numQuestion}',
                  textAlign: TextAlign.center,
                  
                ),
            ],
          ),
        ),

        Padding(
          padding:  EdgeInsets.only(left: width *0.7, top: height *0.1),
          child: GestureDetector(
            onTap: (){
                speakText(widget.question);
            },
            child: const Icon(Icons.volume_up_rounded, color: blueGrey),
          ),
        )
      ],
    );
  }
}


class AnimationBar extends StatelessWidget {
  const AnimationBar({super.key, required this.endvalue});
  final double endvalue;
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
  tween: Tween<double>(begin: 0, end: endvalue),
  duration: const Duration(milliseconds: 500),
  curve:Curves.fastOutSlowIn ,
  builder: (context, endvalue, _){
    return CustomPaint(
                painter: ArcProgressPainter(
                    arcColor: purple, arclength: endvalue),
              );
  },

);
  }
}