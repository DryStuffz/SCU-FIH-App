import 'package:app/constants/colors.dart';
import 'package:app/constants/test_strings.dart';
import 'package:app/dataBases/hive.dart';
import 'package:app/level1.dart';
import 'package:app/main.dart';
import 'package:app/quizzes/addQuestions/addQuestions.dart';
import 'package:app/quizzes/addQuestions/saveData.dart';
import 'package:app/quizzes/result_screen.dart';
import 'package:app/screens/splash_screen/help_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsDrawer extends StatefulWidget {
  const SettingsDrawer({super.key});

  @override
  State<SettingsDrawer> createState() => _SettingsDrawerState();
}

class _SettingsDrawerState extends State<SettingsDrawer> {

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmation'),
          content: const Text('Are you sure you want to perform this action?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel', style: TextStyle(color: blueGrey)),
            ),
            ElevatedButton(
              style: const ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(blueGrey),
              ),
              onPressed: () {
                final dte = DateTime.now().subtract(const Duration(days: 30));
              eraseFileData(completedQuestions);
              eraseFileData(levelIndex);
              writeLevelIndex(1);
              clearData();
              Hive.box<ListData>(dailyBoxName).put('Scores',ListData([0,0,0,0,0,0,0,0,0,0,0]));
              final streaksBox = Hive.box(boxName);
              streaksBox.put(keyStreak, 0);
              streaksBox.put(keymaxStreak, 0);
              streaksBox.put(keyGamesPlayed, 0);
              streaksBox.put(keyGamesWon, 0);
              streaksBox.put(keyLastDate, dte);
                Navigator.popUntil(context, (route) => false);
                  //Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const RootPage(), // Replace AnotherScreen with your desired screen
                    ),
                  );
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const SizedBox(
            height: 200.0,
            child: UserAccountsDrawerHeader(
              accountName: Text('UserName'),
              accountEmail: Text('UserEmail@gmail.com'),
              currentAccountPicture: CircleAvatar(),
              decoration: BoxDecoration(
                color: Color(0xFF4A4E69),
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(0),
                  bottom: Radius.circular(30),
                ),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.account_circle),
            title: const Text('Profile'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('Change Language'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('Notifications'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.accessibility),
            title: const Text('Accessibility'),
            onTap: () {
              // Update the state of the app
              // ...
              // Then close the drawer
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('Help'),
            onTap: () {
              
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HelpPage()),
              );
            },
          ),
           ListTile(
            leading: const Icon(Icons.delete),
            title: const Text('Restart All Data'),
            onTap: () {
              _showConfirmationDialog(context);
              // final dte = DateTime.now().subtract(const Duration(days: 30));
              // eraseFileData(completedQuestions);
              // eraseFileData(levelIndex);
              // writeLevelIndex(1);
              // clearData();
              // Hive.box<ListData>(dailyBoxName).put('Scores',ListData([0,0,0,0,0,0,0,0,0,0,0]));
              // final streaksBox = Hive.box(boxName);
              // streaksBox.put(keyStreak, 0);
              // streaksBox.put(keymaxStreak, 0);
              // streaksBox.put(keyGamesPlayed, 0);
              // streaksBox.put(keyGamesWon, 0);
              // streaksBox.put(keyLastDate, dte);
              
            },
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('ADD QUESTIONS'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const addQuestion()),
              );
            },
          ),
          // ListTile(
          //   leading: const Icon(Icons.add),
          //   title: const Text('Remove History'),
          //   onTap: () {
          //     eraseFileData(completedQuestions);
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(Icons.add),
          //   title: const Text('Remove LEvelIndex'),
          //   onTap: () {
          //     eraseFileData(levelIndex);
          //     writeLevelIndex(1);
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(Icons.add),
          //   title: const Text('ClearPrefData'),
          //   onTap: () {
          //     clearData();
          //   },
          // ),
          // ListTile(
          //   leading: const Icon(Icons.help),
          //   title: const Text('Teest'),
          //   onTap: () {
          //     // Navigator.push(
          //     //   context,
          //     //   MaterialPageRoute(builder: (context) => const Level1()),
          //     // );
          //     // final box = Hive.box<ListData>('DailyScoresList');
          //     // // final listData = ListData([0,0,0,0,0,0,0,0,0,0,0]);
          //     // // box.put('Scores', listData);
          //     // final listDataz = box.get('Scores');
          //     //     if (listDataz != null) {
          //     //       print('Retrieved List of integers from Hive: ${listDataz.integers}');
          //     //     } else {
          //     //       print('List of integers not found in Hive.');
          //     //     }
          //     // // Navigator.push(
          //     // //   context,
          //     // //   MaterialPageRoute(builder: (context) => const ResultsData()),
          //     // //);
          //   },
          // ),
        ],
      ),
    );
  }
}




  void clearData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();

  }
