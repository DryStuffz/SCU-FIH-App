import 'package:app/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Flashcard {
  final String question;
  final String answer;
  final List<String> options;
  Flashcard(
      {required this.question, required this.answer, required this.options});
}

class FlashcardApp extends StatelessWidget {
  const FlashcardApp(
      {super.key,
      required this.titles,
      required this.optionsList,
      required this.correctAnswers});
  final List<String> titles;
  final List<String> correctAnswers;
  final List<List<String>> optionsList;

  @override
  Widget build(BuildContext context) {
    List<Flashcard> flashcards = [];

    for (int i = 0; i < titles.length; i++) {
      flashcards.add(Flashcard(
          question: titles[i],
          answer: correctAnswers[i],
          options: optionsList[i]));
    }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flashcards'),
          automaticallyImplyLeading: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context)
                  .pop(); // This is the function to navigate back
            },
          ),
          backgroundColor: blueDark,
        ),
        body: FlashcardScreen(flashcards: flashcards),
        backgroundColor: blueDark,
      ),
    );
  }
}

class FlashcardScreen extends StatefulWidget {
  final List<Flashcard> flashcards;

  const FlashcardScreen({super.key, required this.flashcards});

  @override
  _FlashcardScreenState createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  int currentIndex = 0;

  void showNextCard() {
    setState(() {
      currentIndex = (currentIndex + 1) % widget.flashcards.length;
    });
  }

  void showPreviousCard() {
    setState(() {
      currentIndex = (currentIndex - 1 + widget.flashcards.length) %
          widget.flashcards.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FlipCard(
            front: FlashcardTile(
                text: widget.flashcards[currentIndex].question,
                options: widget.flashcards[currentIndex].options),
            back: FlashcardTile(
                text: widget.flashcards[currentIndex].answer, options: []),
          ),
          const SizedBox(height: 20),
          (widget.flashcards.length > 1)
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.blueGrey), // Set the background color
                        // Other style properties can be added here
                      ),
                      onPressed: showPreviousCard,
                      child: const Text("Previous"),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.blueGrey), // Set the background color
                        // Other style properties can be added here
                      ),
                      onPressed: showNextCard,
                      child: const Text("Next"),
                    ),
                  ],
                )
              : const SizedBox(
                  width: 0,
                  height: 0,
                ),
        ],
      ),
    );
  }
}

class FlashcardTile extends StatelessWidget {
  final String text;
  final List<String> options;
  const FlashcardTile({super.key, required this.text, required this.options});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.all(16),
      width: width * 0.8,
      height: height * 0.3,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Colors.black, fontSize: 20),
        textAlign: TextAlign.center,
      ),
    );
  }
}
