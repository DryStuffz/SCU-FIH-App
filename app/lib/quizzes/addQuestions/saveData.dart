// import 'dart:convert';
// import 'dart:io';
// import 'package:app/quizzes/getQuizzes.dart';
// import 'package:flutter/material.dart';
// import 'package:app/quizzes/question_model.dart';
// import 'package:flutter/services.dart';

// void addQuizData(Question question) async {
//   // Step 1: Read existing JSON data
//   Map<String, dynamic> jsonData = await readJsonFile();
//   DateTime now =  DateTime.now();
//   // Check if the JSON data is not null
//   if (jsonData != null) {
//     // Step 2: Update the data by adding the new content to the "completed" array
//     List<Map<String, dynamic>> newQuizData = [
//       {
//         "title": question.title,
//         "date": '${now.month}-${now.day}-${now.year}',
//         "options": question.ansToJson(),
//       },
//       // Add more quiz data here if needed
//     ];

//     if (jsonData['completed'] == null) {
//       jsonData['completed'] = newQuizData;
//     } else {
//       jsonData['completed'].addAll(newQuizData);
//     }
//     print(jsonData);
//     // Step 3: Write the updated JSON data back to the file
//     await writeJsonFile(jsonData);

//     print('Quiz data added successfully!');
//   }
// }

// // Function to read JSON data from the file
// Future<Map<String, List<Map<dynamic,dynamic>>>> readJsonFile() async {
//   ReadJsonFile.readJsonData(path: 'assets/quizData/completedLevels.json');
// }

// // Function to write JSON data to the file
// Future<void> writeJsonFile(Map<String, dynamic> jsonData) async {
//   try {
//     File file = File('assets/quizData/completedLevels.json'); // Replace with the path to your JSON file
//     String content = json.encode(jsonData);
//     await file.writeAsString(content);
//   } catch (e) {
//     print('Error writing JSON file: $e');
//   }
// }