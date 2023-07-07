import "package:flutter/material.dart";
import 'package:app/constants/colors.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key, required this.nextQuestion});
  final VoidCallback nextQuestion;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: nextQuestion,
        child: Container(
            width: double.infinity,
            height: 30.0,
            decoration: BoxDecoration(
              color: netral,
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: const Text(
              'Next',
              textAlign: TextAlign.center,
              
            )));
  }
}
