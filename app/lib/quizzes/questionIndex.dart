import 'dart:math';
import "package:app/constants/colors.dart";
import "package:app/quizzes/arc.dart";
import "package:flutter/material.dart";

class QuestionIndex extends StatefulWidget {
  const QuestionIndex(
      {super.key, required this.currentQuestion, required this.numQuestion});
  final int currentQuestion;
  final int numQuestion;

  @override
  State<QuestionIndex> createState() => _QuestionIndexState();
}

class _QuestionIndexState extends State<QuestionIndex> {
  @override
  Widget build(BuildContext context) {
    return Center(
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