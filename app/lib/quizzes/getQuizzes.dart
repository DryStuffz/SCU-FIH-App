import 'package:app/dataBases/db_connect.dart';
import 'package:app/quizzes/question_model.dart';
import "package:flutter/material.dart";
import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' as root_bundle;
  
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
  
  //final List<Question> questions = [];
  final Quiz quiz = Quiz(quizName: quizName);
  //print('sdsdsd');
  //LETS BUILD ALL THE ANSWERS
  for(int questionIndex = 0 ; questionIndex < dbValues[quizName].length; questionIndex++){
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
    //tempQuest.setAnswerSet(answers);
     //print(tempQuest);
     //questions.add(tempQuest);
     
     quiz.addQuestion(tempQuest);
     
  } 

  return quiz;

}