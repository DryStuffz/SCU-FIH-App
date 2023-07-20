import 'package:app/quizzes/question_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

var db = FirebaseFirestore.instance;

void addToDB(Question ques, DateTime date) {
  var map = ques.toJson();
  db.collection("dailyQuestions").doc('${date.month}-${date.day}-${date.year}').collection('questions').add(map);
  // Create a new user with a first and last name
// final user = <String, dynamic>{
//   "first": "Alan",
//   "middle": "Mathison",
//   "last": "Turing",
//   "born": 1912
// };

// // Add a new document with a generated ID
// db.collection("users").add(user).then((DocumentReference doc) =>
//     print('DocumentSnapshot added with ID: ${doc.id}'));
}

Future<Quiz> getFirebaseData() async{
  DateTime now =  DateTime.now();
  Quiz quiz = Quiz(quizName: 'Quiz: ${now.month}-${now.day}-${now.year}');
  
  final docRef = db.collection('dailyQuestions').doc('${now.month}-${now.day}-${now.year}');
  await docRef.collection("questions").get().then(
  (querySnapshot) {
    print("Successfully completed");
    
    for (var docSnapshot in querySnapshot.docs) {
      //print('${docSnapshot.id} => ${docSnapshot.data()}');
      Question test = Question.fromFirestore(docSnapshot);
      quiz.addQuestion(test);
      //print(quiz);
    }
  },
  
  onError: (e) => print("Error completing: $e"),
  
  );
  //print('ERRORR');
  print(quiz);
  return quiz;
  
  
}

// Future<void> initFireBase() async {
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
// }



// void updateJsonData() async {
//   // Step 1: Read existing JSON data
//   Map<String, dynamic> jsonData = await readJsonFile();

//   if (jsonData != null) {
//     // Step 2: Update the data as per your requirements
//     jsonData['key'] = 'new_value'; // Replace 'key' and 'new_value' with your data to update.

//     // Step 3: Write the updated JSON data back to the file
//     await writeJsonFile(jsonData);

//     print('JSON data updated successfully!');
//   }
// }