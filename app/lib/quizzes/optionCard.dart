import "package:app/constants/colors.dart";
import "package:flutter/material.dart";

class OptionCard extends StatelessWidget {
  const OptionCard({super.key, required this.option, required this.color});
  final String option;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: const BorderSide(
              color: grey,
              width: 2.0,
            )),
        margin: const EdgeInsets.symmetric(vertical: 7.0),
        color: color,
        child: ListTile(
          title: Text(
            option,
            style: const TextStyle(fontSize: 22.0),
          ),
        ));
  }
}

class QuestionCard extends StatelessWidget {
  const QuestionCard(
      {super.key,
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
      child: Align(
        alignment: Alignment.center,
        child: Text(
          question,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

