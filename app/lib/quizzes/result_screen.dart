import "package:app/constants/colors.dart";
import "package:flutter/material.dart";

class ResultScreen extends StatelessWidget {
  const ResultScreen(
      {super.key, required this.numberCorrect, required this.questionLength});
  final int questionLength;
  final int numberCorrect;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: blueGrey,
      content: Padding(
        padding: const EdgeInsets.all(70),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Result',
              style: TextStyle(color: netral, fontSize: 22.0),
            ),
            const SizedBox(
              height: 20.0,
            ),
            CircleAvatar(
              radius: 70.0,
              backgroundColor:
                  (numberCorrect > questionLength / 2) ? correct : incorrect,
              child: Text(
                '$numberCorrect/$questionLength',
                style: const TextStyle(fontSize: 30.0),
              ),
            ),
            const SizedBox(
              height: 20.0,
            ),
            Text((numberCorrect <= questionLength / 2)
                ? 'Try Again'
                : 'Good Job!'),
            const SizedBox(height: 25),
            GestureDetector(
              onTap: () {
                print('WIP');
              },
              child: const Text(
                'Home',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 20.0,
                  letterSpacing: 1.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ResultsScreen extends StatelessWidget {
  final int totalQuestions;
  final int correctAnswers;
  final VoidCallback onRestartQuiz; // Callback to restart the quiz

  const ResultsScreen({
    super.key,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.onRestartQuiz,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey,
      appBar: AppBar(
        backgroundColor: blueGrey,
        title: const Text('Quiz Results'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Quiz Completed!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20.0,
              ),
              CircleAvatar(
                radius: 70.0,
                backgroundColor:
                    (correctAnswers > totalQuestions / 2) ? correct : incorrect,
                child: Text(
                  '$correctAnswers/$totalQuestions',
                  style: const TextStyle(fontSize: 30.0),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text((correctAnswers <= totalQuestions / 2)
                  ? 'Try Again'
                  : 'Good Job!'),
              const SizedBox(height: 25),
              
              ElevatedButton(
                onPressed: onRestartQuiz,
                style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(blueGrey)),
                child: const Text('Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
