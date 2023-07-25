import 'package:app/dataBases/db_connect.dart';
import 'package:app/quizzes/question_model.dart';
import "package:flutter/material.dart";
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' as root_bundle;
import 'dart:math';
  
class ReadJsonFile{
    static Future<Map> readJsonData({required String path}) async {
      
    // read json file
    final jsondata = await root_bundle.rootBundle.loadString(path);
      
    // decode json data as list
    final list = json.decode(jsondata) as Map<String, dynamic>;
  
    // map json and initialize
    // using DataModel
    return list;
  }
}


Future<Quiz> getQuizzes(String quizName) async{

  if (quizName == "Daily Quiz"){
    return getFirebaseData();
  }
  var dbValues =  await ReadJsonFile.readJsonData(path: 'assets/quizData/levels.json');
  //print(dbValues[quizName]);
  //print(dbValues[quizName].runtimeType);
  //print(dbValues[quizName][0]['options'][0].runtimeType);
  
  final List<Question> questions = [];
  final Quiz quiz = Quiz(quizName: quizName);
  //print('sdsdsd');
  //LETS BUILD ALL THE ANSWERS, we start at 1 because of the skill level
  for(int questionIndex = 1 ; questionIndex < dbValues[quizName].length; questionIndex++){
    final List<Answer> answers = [];
    //print(dbValues[quizName][questionIndex]);
     for(int optionMaps = 0; optionMaps < dbValues[quizName][questionIndex]['options'].length; optionMaps++ ){
        var optionValPair = dbValues[quizName][questionIndex]['options'][optionMaps];
        //print(optionValPair);

        //print(dbValues[quizName][questionIndex].length);
        for(var key in optionValPair.keys){
          if(optionValPair[key]){
            answers.add(Answer(option: key, isCorrect: true));
          }
          else{
            answers.add(Answer(option: key, isCorrect: false));
          }
        }
     }
     Question tempQuest = Question(title: dbValues[quizName][questionIndex]['title'], answers:answers);
     questions.add(tempQuest);
     //quiz.addQuestion(tempQuest);
     
  } 
  List<Question> filteredQuestions = generateRandomSublist(questions, 5);
  quiz.setQuestions(filteredQuestions);
  return quiz;

}


List<T> generateRandomSublist<T>(List<T> originalList, int sublistLength) {
  if (originalList.length <= sublistLength) {
    // If the original list is smaller than or equal to the requested sublist length,
    // return the original list as the sublist.
    return originalList;
  }

  // Create a copy of the original list to avoid modifying the original list.
  List<T> copiedList = List.from(originalList);

  // Shuffle the copied list to randomize the order.
  copiedList.shuffle();

  // Take the first 'sublistLength' items from the shuffled list as the sublist.
  List<T> sublist = copiedList.sublist(0, sublistLength);

  return sublist;
}

Future<int> getLevelIndex(String quizName) async{
  var dbValues =  await ReadJsonFile.readJsonData(path: 'assets/quizData/levels.json');
  return await dbValues[quizName][0]['skillLevel'];
}