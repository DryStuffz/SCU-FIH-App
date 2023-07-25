import 'dart:convert';
import 'package:app/quizzes/addQuestions/saveData.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class History extends StatelessWidget {
  final newData = getCompletedJsonHistory();

  // Future<Map<String, dynamic>>.delayed(Duration(seconds: 1), () {
  //   // Simulating loading data asynchronously
  //   return {
  //     "completed": [
  //       {
  //         "title": "What is the correct greeting to use when meeting someone for the first time?",
  //         "date": "7-19-2023",
  //         "options": [
  //           {"Goodbye": false},
  //           {"Thank you": false},
  //           {"Hello": true},
  //           {"Sorry": false}
  //         ]
  //       },
  //       // More completed items...
  //     ],
  //     "incompleted": [
  //       {
  //         "title": "Which word means a male sibling?",
  //         "date": "7-19-2023",
  //         "options": [
  //           {"Sister": false},
  //           {"Brother": true},
  //           {"Mother": false},
  //           {"Friend": false}
  //         ]
  //       },
  //       // More incompleted items...
  //     ]
  //   };
  // });

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
            try{
              List<dynamic> itemsToShow = data["completed"];
            print(itemsToShow); 
            return Column(
              children: [

                IconButton(
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
                          onTap: (){showOptionsAlertDialog(context, cardData['options']);},
                          // Add other card content as needed...
                        ),
                      );
                    },
                  ),
                ),
              ],
            );
            }
            catch(e){
              print(e);
            }
          //   finally{
          //     // ignore: control_flow_in_finally
          //     return const Text('NO HISTORY');
          //   }
          return Text("NO HISTORY FOUND");
            
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
          title: Text('Options'),
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
// Rest of the code...

class SearchHistoryDelegate extends SearchDelegate<dynamic> {
  final List<dynamic> searchList;

  SearchHistoryDelegate(this.searchList);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<dynamic> results = searchList.where((item) => item['title']
            .toString()
            .toLowerCase()
            .contains(query.toLowerCase()) ).toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        var cardData = results[index];
        return InkWell(
          onTap: () {
            // Handle the selected item, if needed.
            //close(context, cardData);
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
            // Handle the selected item, if needed.
            //close(context, cardData);
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