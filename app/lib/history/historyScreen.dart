import 'dart:convert';
import 'package:app/constants/colors.dart';
import 'package:app/history/flashCards.dart';
import 'package:app/quizzes/addQuestions/saveData.dart';
import 'package:app/quizzes/getQuizzes.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

List<String> getOptions(List<dynamic> items, int index) {
  List<String> options = [];
  for (int i = 0; i < items[index]['options'].length; i++) {
    for (var entry in items[index]['options'][i].entries) {
      options.add(entry.key.toString());
    }
  }
  return options;
}

String getCorrectAnswer(List<dynamic> items, int index) {
  String correctAns = "";
  for (int i = 0; i < items[index]['options'].length; i++) {
    for (var entry in items[index]['options'][i].entries) {
      if (entry.value == true) {
        correctAns = entry.key.toString();
      }
    }
  }
  return correctAns;
}

class History extends StatelessWidget {
  final newData = getCompletedJsonHistory();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Map<String, dynamic>>(
        future: newData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final data = snapshot.data!;
            try {
              List<dynamic> itemsToShow = data["completed"];
              print(itemsToShow);

              return Stack(
                children: [
                  Column(
                    children: [

                      SizedBox(
                        width: double.infinity,
                        child: IconButton(
                      
                          alignment: Alignment.centerRight,
                          icon: const Icon(Icons.search),
                          onPressed: () async {
                            final selected = await showSearch(
                              context: context,
                              delegate: SearchHistoryDelegate(itemsToShow),
                            );
                            if (selected != null) {
                              // Handle the selected item, if needed.
                            }
                          },
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: itemsToShow.length,
                          itemBuilder: (context, index) {
                            // Access the data for each card
                            var cardData = itemsToShow[index];

                            return Card(
                              child: ListTile(
                                title: Text(cardData['title']),
                                subtitle: Text(cardData['date']),
                                onTap: () {
                                  //getting the correct cardData
                                  List<String> options =
                                      getOptions(itemsToShow, index);
                                  String correctAns =
                                      getCorrectAnswer(itemsToShow, index);
                                  // print(cardData['options']);
                                  // for (int i = 0;i < cardData['options'].length;i++) {
                                  //   for (var entry in cardData['options'][i].entries) {
                                  //     options.add(entry.key.toString());
                                  //     if (entry.value == true) {
                                  //       correctAns = entry.key.toString();
                                  //     }
                                  //   }
                                  // }

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          FlashcardApp(correctAnswers: [
                                        correctAns
                                      ], optionsList: [
                                        options
                                      ], titles: [
                                        cardData['title'].toString()
                                      ]), // Replace AnotherScreen with your desired screen
                                    ),
                                  );
                                  //print(cardData);

                                  //showOptionsAlertDialog(
                                  //  context, cardData['options']);
                                },
                                // Add other card content as needed...
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 16.0,
                    right: 16.0,
                    child: FloatingActionButton(
                      onPressed: () {
                        List<dynamic> completedQuestions =
                            generateRandomSublist(
                                itemsToShow, itemsToShow.length);
                        // Add your action here
                        List<String> questions = [];
                        List<String> correctAnswers = [];
                        List<List<String>> optionsList = [];

                        for (int i = 0; i < completedQuestions.length; i++) {
                          questions.add(completedQuestions[i]["title"]);
                          correctAnswers
                              .add(getCorrectAnswer(completedQuestions, i));
                          optionsList.add(getOptions(completedQuestions, i));
                        }
                        print(completedQuestions);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FlashcardApp(
                                correctAnswers: correctAnswers,
                                optionsList: optionsList,
                                titles:
                                    questions), // Replace AnotherScreen with your desired screen
                          ),
                        );
                      },

                      backgroundColor:
                          blueDark, // Background color of the button
                      foregroundColor: grey, // Color of the icon
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(8.0), // Rounded corners
                      ),
                      child: Text("Review"),
                    ),
                  ),
                ],
              );
            } catch (e) {
              print(e);
            }

            return const Text("NO HISTORY FOUND");
          }
        },
      ),
    );
  }

  //Function to show the AlertDialog with options
  void showOptionsAlertDialog(BuildContext context, List<dynamic> options) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Options'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: options.map((option) {
              String optionText = option.keys.first;
              return ListTile(
                title: Text(optionText),
                onTap: () {
                  // Handle the selected option, if needed.
                  print('Selected option: $optionText');
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}

class SearchHistoryDelegate extends SearchDelegate<dynamic> {
  final List<dynamic> searchList;

  SearchHistoryDelegate(this.searchList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<dynamic> results = searchList
        .where((item) => item['title']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        var cardData = results[index];
        return InkWell(
          onTap: () {
            List<String> options = getOptions(searchList, index);
            String correctAns = getCorrectAnswer(searchList, index);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FlashcardApp(correctAnswers: [
                  correctAns
                ], optionsList: [
                  options
                ], titles: [
                  cardData['title'].toString()
                ]), // Replace AnotherScreen with your desired screen
              ),
            );
          },
          child: Card(
            child: ListTile(
              title: Text(cardData['title']),
              subtitle: Text(cardData['date']),
              // Add other card content as needed...
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final results = searchList
        .where((item) => item['title']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        var cardData = results[index];
        return InkWell(
          onTap: () {
            List<String> options = getOptions(searchList, index);
            String correctAns = getCorrectAnswer(searchList, index);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => FlashcardApp(correctAnswers: [
                  correctAns
                ], optionsList: [
                  options
                ], titles: [
                  cardData['title'].toString()
                ]), // Replace AnotherScreen with your desired screen
              ),
            );
          },
          child: ListTile(
            title: Text(cardData['title']),
            subtitle: Text(cardData['date']),
            // Add other card content as needed...
          ),
        );
      },
    );
  }
}
