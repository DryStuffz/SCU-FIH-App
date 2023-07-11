import 'package:app/constants/test_strings.dart';
import "package:flutter/material.dart";
import 'package:app/constants/colors.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key, required this.nextQuestion, required this.isPressed});
  final bool isPressed;
  final VoidCallback nextQuestion;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: nextQuestion,
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
}
