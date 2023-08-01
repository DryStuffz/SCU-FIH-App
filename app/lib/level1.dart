import 'package:app/history/historyScreen.dart';
import 'package:app/quizzes/addQuestions/saveData.dart';
import 'package:app/quizzes/questionIndex.dart';
import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

String testString = "How do you say <lan>'thank you'</lan> in English?";

Future<String> lanConverter(String sentence) async {
  if (!sentence.contains("<lan>")) {
    print(sentence);
    return Future(() => sentence);
  } else {
    GoogleTranslator translator = GoogleTranslator();
    String sentenceSub = sentence;
    String finalString = "";
    int currentIndex = 0;
    while (true) {
      if (!sentence
          .substring(currentIndex, sentence.length)
          .contains('<lan>')) {
        //move the rest of the sentece to english
        finalString += sentence.substring(currentIndex, sentence.length);
        print(finalString);
        break;
      }
      if (!sentence
          .substring(currentIndex, sentence.length)
          .contains('</lan>')) {
        int lanStartIndex = currentIndex +
            sentence.substring(currentIndex, sentence.length).indexOf('<lan>');
        while (lanStartIndex > currentIndex) {
          finalString += sentence[currentIndex];
          currentIndex++;
        }
        //move the rest of the sentence to languiage
        var translation = await translator.translate(
            sentence.substring(currentIndex, sentence.length),
            to: 'pl');
        finalString += translation.toString();
        print(finalString);
        break;
      }

      int lanStartIndex = currentIndex +
          sentence.substring(currentIndex, sentence.length).indexOf('<lan>');
      int lanEndIndex = currentIndex +
          sentence.substring(currentIndex, sentence.length).indexOf('</lan>');
      // if (lanEndIndex == -1) {
      //   //conver the rest of the string to googles
      //   // sentenceSub = sentence.substring(lanStartIndex + 5, sentenceSub.length);
      //   // var translation = await translator.translate(sentenceSub, to: 'pl');
      //   // finalString += translation.toString();
      //   break;
      // } else {

      while (lanStartIndex > currentIndex) {
        finalString += sentence[currentIndex];
        currentIndex++;
      }
      sentenceSub = sentence.substring(currentIndex + 5, lanEndIndex);
      var translation = await translator.translate(sentenceSub, to: 'pl');
      finalString += translation.toString();
      currentIndex = lanEndIndex + 6;
    }
    print(finalString);
    return finalString;
  }
}

class Level1 extends StatefulWidget {
  const Level1({super.key});

  @override
  State<Level1> createState() => _Level1State();
}

class _Level1State extends State<Level1> {
  @override
  Widget build(BuildContext context) {
    GoogleTranslator translator = GoogleTranslator();
    return Scaffold(
      appBar: AppBar(
        title: const Text('This is A LEVEL'),
      ),
      body: ElevatedButton(
          onPressed: () {
            lanConverter(testString).then((value) {
              print(value);
            });
            translator
                .translate("I love Brazil!", from: 'en', to: 'pt')
                .then((s) {
              print(s);
            });
          },
          child: const Text("sadasdas")),
    );
  }
}
