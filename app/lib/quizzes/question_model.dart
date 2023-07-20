import "dart:collection";

import "package:app/constants/colors.dart";
import "package:flutter/material.dart";
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//All questions in our application will be modeled as a class
class Question {
  //unique identifier for each questio

  final String title; //question
  final List<Answer> answers;
  List<bool> alredlySelected = [];
  List<Color> colorIndex = [];

  Question({
    required this.title,
    required this.answers,
  });

  //operator overloading(question will print to console when calling this function)
  @override
  String toString() {
    return 'Question(title: $title, options: $answers, colors: $colorIndex, sel: $alredlySelected)';
  }

  void clearAll() {
    colorIndex = [];
    alredlySelected = [];
  }

  void clearalreadlyUsed() {
    alredlySelected = [];
  }

  void setDefaultColors() {
    print('DEFAULT CALLED');
    
    colorIndex = List.filled(answers.length, netral, growable: false);
  }

  List<Answer> getAlreadlySelected() {
    return answers;
  }

  void setAlreadlySelectedIndex(int i, bool val) {
    if (alredlySelected.length != answers.length) {
      alredlySelected = List.filled(answers.length, false, growable: false);
    } else if (alredlySelected == [] || i >= alredlySelected.length) {
      print('INDEX ERROR');
    }
    alredlySelected[i] = val;
  }

  bool getAlreadlySelectedIndex(int i) {
    if (alredlySelected.length != answers.length) {
      alredlySelected = List.filled(answers.length, false, growable: false);
    } else if (alredlySelected == [] || i >= alredlySelected.length) {
      return false;
    }
    return alredlySelected[i];
  }

  Color getColorIndex(int i) {
    if (colorIndex.length != answers.length) {
      setDefaultColors();
    } else if (i >= colorIndex.length) {
      return netral;
    }

    return colorIndex[i];
  }

  List<Color> getColorList() {
    if (colorIndex.length != answers.length) {
      setDefaultColors();
    }
    return colorIndex;
  }

  List<String> getTitles() {
    List<String> titles = [];
    for (int i = 0; i < answers.length; i++) {
      titles.add(answers[i].option);
    }

    return titles;
  }

  List<bool> getValues() {
    List<bool> vals = [];
    for (int i = 0; i < answers.length; i++) {
      vals.add(answers[i].isCorrect);
    }

    return vals;
  }

  void setColorIndex(int i, Color c) {
    if (colorIndex.length != answers.length) {
      setDefaultColors();
    }
    colorIndex[i] = c;
  }

  Map<String, dynamic> toJson() {
    var map1 = {for (var e in answers) e.option: e.isCorrect};
    Map<String, dynamic> jsonFile = {};
    jsonFile['title'] = title;
    jsonFile['options'] = map1;
    print(map1);
    return jsonFile;
  }
  List<MapEntry<String, bool>> ansToJson(){
    List<MapEntry<String, bool>> data = [];
    for(int i = 0 ; i < answers.length; i++){
      data.add(MapEntry(answers[i].option, answers[i].isCorrect));
    }

    return data;
  }


  factory Question.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    //SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    final List<Answer> ans = [];
    //if (data?['options'] is Iterable) {
      //print(data?['options']);
      for (var item in data?['options'].entries) {
        ans.add(Answer.fromMap(item));
       // print(item);
      }
    //}
    //print(ans);
    return Question(
      title: data?['title'],
      answers: ans,
    );
  }
}

class Answer {
  final String option;
  final bool isCorrect;
  Answer({required this.option, required this.isCorrect});

  @override
  String toString() {
    // TODO: implement toString
    return 'Answer(option: $option, value: $isCorrect)';
  }

  factory Answer.fromMap(MapEntry<String, dynamic> m) {
    return Answer(option: m.key, isCorrect: m.value);
  }
}

class Quiz {
  final String quizName;
  List<Question> questions = [];

  @override
  String toString() {
    // TODO: implement toString
    return 'Quiz(QuizName: $quizName, Questions: $questions)';
  }

  Quiz({
    required this.quizName,
  });

  void addQuestion(Question quest) {
    questions.add(quest);
  }

  void setQuestions(List<Question> quests) {
    questions = quests;
  }

  List<Question> getQuestions() {
    return questions;
  }

  Question getQuestionIndex(int i) {
    if (questions == [] || i >= questions.length) {
      return Question(title: "INDEX Error", answers: []);
    }

    return questions[i];
  }
}




