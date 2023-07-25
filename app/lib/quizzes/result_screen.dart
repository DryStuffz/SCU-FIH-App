import "package:app/constants/colors.dart";
import "package:flutter/material.dart";



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
                    (correctAnswers >= totalQuestions *0.8) ? correct : incorrect,
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

void increaseLevelIndex(int total, int correct){
  //if user gets at least 80% of the way done, upadte the index
  if(correct >= total *0.8){

  }
}