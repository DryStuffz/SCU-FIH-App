import 'dart:convert';
import 'dart:io';
import 'package:app/constants/test_strings.dart';
import 'package:app/quizzes/question_model.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

Future<String> readJsonData(String name) async {
  try {
    Directory appDir = await getApplicationDocumentsDirectory();
    print(appDir);
    File file = File('${appDir.path}/$name');
    return await file.readAsString();
  } catch (e) {
    print("Error reading file: $e");
    return Future(() => "");
  }
}

Future<void> writeJsonData(Map<String, dynamic> data, String name) async {
  try {
    Directory appDir = await getApplicationDocumentsDirectory();
    File file = File('${appDir.path}/$name');
    String jsonData = json.encode(data);
    await file.writeAsString(jsonData);
  } catch (e) {
    print("Error writing file: $e");
  }
}

Future<void> updateJsonData(Question ques, String name) async {
  // Read the JSON data from the file
  String jsonDataString = await readJsonData(name);

  // If the file was read successfully
  if (jsonDataString != "") {
    // Parse the JSON string into a map
    Map<String, dynamic> jsonData = json.decode(jsonDataString);
    print('sdsdsdsd');
    print(jsonData);
    // Check if the "completed" key exists in the JSON data
    if (jsonData.containsKey("completed") && jsonData["completed"] is List) {
      // If the "completed" key is an array, add the new data to it
      (jsonData["completed"] as List)
          .addAll(ques.toNewData()["completed"] as Iterable);
    } else {
      // If the "completed" key doesn't exist or is not an array, create it with the new data
      jsonData["completed"] = ques.toNewData()["completed"];
    }

    // Write the updated JSON data back to the file
    await writeJsonData(jsonData, name);
  } else {
    await writeJsonData({'completed': []}, name);
  }
}

Future<void> eraseFileData(String name) async {
  try {
    // Get the application documents directory
    Directory appDir = await getApplicationDocumentsDirectory();

    // Create a file object for the JSON file
    File file = File('${appDir.path}/$name');

    // Check if the file exists
    if (file.existsSync()) {
      // Erase the file by overwriting it with an empty string
      await file.writeAsString('');
      print("File data erased successfully.");
    } else {
      print("JSON file does not exist.");
    }
  } catch (e) {
    print("Error erasing file data: $e");
  }
}

//data.json
Future<Map<String, dynamic>> getCompletedJsonHistory() async {
  String jsonDataString = await readJsonData(completedQuestions);

  if (jsonDataString != "") {
    Map<String, dynamic> jsonData = json.decode(jsonDataString);
    print(jsonData);
    return jsonData;
  } else {
    return Future(() => {});
  }
}

Future<void> writeLevelIndex(int data) async {
  try {
    Directory appDir = await getApplicationDocumentsDirectory();
    File file = File('${appDir.path}/$levelIndex');
    String jsonData = json.encode(data);
    await file.writeAsString(jsonData);
  } catch (e) {
    print("Error writing file: $e");
  }
}

Future<int> readLevelIndex() async {
  try {
    Directory appDir = await getApplicationDocumentsDirectory();
    //print(appDir);
    File file = File('${appDir.path}/$levelIndex');
    try {
      int indexNum = int.parse(await file.readAsString());
      return indexNum;
    } catch (e) {
      print("Error parsing the string as an integer: $e");
    }
    return 0;
  } catch (e) {
    print("Error reading file: $e");
    return Future(() => 1);
  }
}
