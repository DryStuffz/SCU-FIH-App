// ignore_for_file: use_build_context_synchronously

import 'package:app/constants/colors.dart';
import 'package:app/constants/test_strings.dart';
import 'package:app/dataBases/db_connect.dart';
import 'package:app/quizzes/addQuestions/saveData.dart';
import 'package:app/quizzes/getQuizzes.dart';
import 'package:app/quizzes/question_model.dart';
import 'package:app/quizzes/quizScreen.dart';
import 'package:flutter/material.dart';
import 'package:app/level1.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Example Future function that returns a Future<String>
  Future<int> fetchData() async {
    // Return the result (a string in this example)
    return await readLevelIndex();
  }

  Future<Map<String, int>> fetchLevelData() async {
    // Return the result (a string in this example)
    return await getLevelIndexMap();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<int>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // While the Future is still running, show a loading indicator.
            return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ); 
            
            //const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            // If there was an error while fetching data, show an error message.
            return Text('Error: ${snapshot.error}');
          } else {
            // If the Future is complete, display the fetched data.
            return FutureBuilder<Map<String, int>>(
              future: fetchLevelData(),
              builder: (context, snapshot2) {
                if (snapshot2.connectionState == ConnectionState.waiting) {
                  // While the Future is still running, show a loading indicator.
                  return const CircularProgressIndicator();
                } else if (snapshot2.hasError) {
                  // If there was an error while fetching data, show an error message.
                  return Text('Error: ${snapshot2.error}');
                } else {
                  // If the Future is complete, display the fetched data.
                  return HomePage(
                    levelProgress: snapshot.data ?? 1,
                    LevelIndexValues: snapshot2.data ?? {},
                  );
                }
              },
            );
            //return HomePage(levelProgress: snapshot.data ?? 1);
          }
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage(
      {super.key, required this.levelProgress, required this.LevelIndexValues});
  final int levelProgress;
  final Map<String, int> LevelIndexValues;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double height =
        MediaQuery.of(context).size.height; //get the height of the screen
    double width =
        MediaQuery.of(context).size.width; //get the width of the screen
    getLevelIndexMap();
    bool isEnabled(String qName) {
      if ((widget.levelProgress >= widget.LevelIndexValues[qName]!)) {
        return true;
      }
      return false;
    }

    // @override
    // void initState() {
    //   super.initState();
    //   Navigator.pushAndRemoveUntil(
    //     context,
    //     MaterialPageRoute(
    //         builder: (context) =>
    //             MyHomePage()), // this mainpage is your page to refresh
    //     (Route<dynamic> route) => false,
    //   );
    // }

    disabledMessage(String qName) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            "This level is disabled. Please complete ${levelPrefix(qName)} to unlock it"),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(vertical: 20.0),
      ));
    }

    return Stack(children: [
      Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/background2.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
      Align(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(children: [
            const Align(
              alignment: Alignment.center,
              child: Text(
                'Daily Problem',
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontFamily: 'Serifs',
                    letterSpacing: 2,
                    shadows: [
                      Shadow(
                          // bottomLeft
                          offset: Offset(-1.5, -1.5),
                          color: blueDark),
                      Shadow(
                          // bottomRight
                          offset: Offset(1.5, -1.5),
                          color: blueDark),
                      Shadow(
                          // topRight
                          offset: Offset(1.5, 1.5),
                          color: blueDark),
                      Shadow(
                          // topLeft
                          offset: Offset(-1.5, 1.5),
                          color: blueDark),
                    ]),
              ),
            ),
            const SizedBox(
              // spacing inbetween rows
              height: 15,
            ),
            Stack(children: [
              SizedBox(
                width: 0.6 * width,
                height: 0.26 * height,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: blueGreyLight,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(147, 46, 46, 80),
                        spreadRadius: 1,
                        blurRadius: 10,
                      )
                    ],
                  ),
                  child: const Align(
                    alignment: Alignment(0, 0.84),
                    child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child: Text(
                        'Test Your Knowledge!',
                        style: TextStyle(
                          fontSize: 15,
                          color: Color.fromARGB(221, 0, 5, 12),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) {
                      return const QuizScreen(
                          quizName: 'Daily Quiz', saveData: true);
                    }),
                  );
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  backgroundColor: blueDark,
                  minimumSize: Size(0.6 * width, 0.2 * height),
                  maximumSize: Size(0.6 * width, 0.2 * height),
                  shadowColor: const Color.fromARGB(255, 0, 0, 0),
                  elevation: 5,
                ),
                child: const Align(
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      'Go',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ]),
            const SizedBox(
              // spacing inbetween rows
              height: 30,
            ),
            const Align(
              child: Text(
                'Levels',
                style: TextStyle(
                    fontFamily: 'Serifs',
                    fontSize: 35,
                    letterSpacing: 2,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                          // bottomLeft
                          offset: Offset(-1.5, -1.5),
                          color: blueDark),
                      Shadow(
                          // bottomRight
                          offset: Offset(1.5, -1.5),
                          color: blueDark),
                      Shadow(
                          // topRight
                          offset: Offset(1.5, 1.5),
                          color: blueDark),
                      Shadow(
                          // topLeft
                          offset: Offset(-1.5, 1.5),
                          color: blueDark),
                    ]),
              ),
            ),
            const SizedBox(
              // spacing inbetween rows
              height: 10,
            ),
            ExpansionTile(
              childrenPadding: const EdgeInsets.only(top: 12, bottom: 12),
              title: const Text(
                'Beginner',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              collapsedBackgroundColor: blueGrey,
              collapsedIconColor: lightGrey,
              collapsedTextColor: lightGrey,
              backgroundColor: blueGreyLight,
              iconColor: blueDark,
              textColor: blueDark,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Stack(children: [
                        // button
                        SizedBox(
                          width: 0.25 * width,
                          height: 0.13 * height,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: lightGrey,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(147, 46, 46, 80),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                )
                              ],
                            ),
                            child: const Align(
                              alignment: Alignment(0, 0.84),
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  'Vocab',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: blueDark,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: (isEnabled('Vocab'))
                              ? () {
                                  //                 Navigator.of(context).push( MaterialPageRoute(builder: (_)=> const QuizScreen( quizName: "Vocab", saveData: false)),)
                                  // .then((val)=>val?_getRequests():null);
                                  // Navigator.push( context, MaterialPageRoute( builder: (context) => const QuizScreen(
                                  //         quizName: "Vocab", saveData: false)), ).then((value) => setState(() {}));
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const QuizScreen(
                                            quizName: "Vocab",
                                            saveData: false)),
                                  );
                                  // Navigator.of(context).push(
                                  //   MaterialPageRoute(builder: (BuildContext context) {
                                  //     return const QuizScreen(
                                  //         quizName: "Vocab", saveData: false);
                                  //   }),
                                  // );
                                }
                              : () {},
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor:
                                isEnabled('Vocab') ? blueDark : grey,
                            minimumSize: Size(0.25 * width, 0.09 * height),
                            maximumSize: Size(0.25 * width, 0.09 * height),
                            shadowColor: const Color.fromARGB(255, 0, 0, 0),
                            elevation: 5,
                          ),
                          child: const Align(
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                'Level 1',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                      Stack(children: [
                        // button
                        SizedBox(
                          width: 0.25 * width,
                          height: 0.13 * height,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: lightGrey,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(147, 46, 46, 80),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                )
                              ],
                            ),
                            child: const Align(
                              alignment: Alignment(0, 0.84),
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  'Communication',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: blueDark,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: (isEnabled('Communication'))
                              ? () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) {
                                      return const QuizScreen(
                                          quizName: "Communication",
                                          saveData: false);
                                    }),
                                  );
                                }
                              : () {
                                  disabledMessage("Communication");
                                },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor:
                                isEnabled('Communication') ? blueDark : grey,
                            minimumSize: Size(0.25 * width, 0.09 * height),
                            maximumSize: Size(0.25 * width, 0.09 * height),
                            shadowColor: const Color.fromARGB(255, 0, 0, 0),
                            elevation: 5,
                          ),
                          child: const Align(
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                'Level 2',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                      Stack(children: [
                        // button
                        SizedBox(
                          width: 0.25 * width,
                          height: 0.13 * height,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: lightGrey,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(147, 46, 46, 80),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                )
                              ],
                            ),
                            child: const Align(
                              alignment: Alignment(0, 0.84),
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  'Future/Past',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: blueDark,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: isEnabled('Future/Past')
                              ? () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) {
                                      return const QuizScreen(
                                          quizName: "Future/Past",
                                          saveData: false);
                                    }),
                                  );
                                }
                              : () {
                                  disabledMessage("Future/Past");
                                },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor:
                                isEnabled('Future/Past') ? blueDark : grey,
                            minimumSize: Size(0.25 * width, 0.09 * height),
                            maximumSize: Size(0.25 * width, 0.09 * height),
                            shadowColor: const Color.fromARGB(255, 0, 0, 0),
                            elevation: 5,
                          ),
                          child: const Align(
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                'Level 3',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ]),
              ],
            ),

            ///
            ///   INTERMEDIATE
            ///
            ExpansionTile(
              childrenPadding: const EdgeInsets.only(top: 12, bottom: 12),
              title: const Text(
                'Intermediate',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              collapsedBackgroundColor: blueGrey,
              collapsedIconColor: lightGrey,
              collapsedTextColor: lightGrey,
              backgroundColor: blueGreyLight,
              iconColor: blueDark,
              textColor: blueDark,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Stack(children: [
                        // button
                        SizedBox(
                          width: 0.25 * width,
                          height: 0.13 * height,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: lightGrey,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(147, 46, 46, 80),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                )
                              ],
                            ),
                            child: const Align(
                              alignment: Alignment(0, 0.84),
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  'Comparative',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: blueDark,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: isEnabled('Comparative')
                              ? () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) {
                                      return const QuizScreen(
                                          quizName: "Comparative",
                                          saveData: false);
                                    }),
                                  );
                                }
                              : () {
                                  disabledMessage("Comparative");
                                },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor:
                                isEnabled('Comparative') ? blueDark : grey,
                            minimumSize: Size(0.25 * width, 0.09 * height),
                            maximumSize: Size(0.25 * width, 0.09 * height),
                            shadowColor: const Color.fromARGB(255, 0, 0, 0),
                            elevation: 5,
                          ),
                          child: const Align(
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                'Level 4',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                      Stack(children: [
                        // button
                        SizedBox(
                          width: 0.25 * width,
                          height: 0.13 * height,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: lightGrey,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(147, 46, 46, 80),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                )
                              ],
                            ),
                            child: const Align(
                              alignment: Alignment(0, 0.84),
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  'Exceptions',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: blueDark,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: isEnabled('Exceptions')
                              ? () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) {
                                      return const QuizScreen(
                                          quizName: "Exceptions",
                                          saveData: false);
                                    }),
                                  );
                                }
                              : () {
                                  disabledMessage("Exceptions");
                                },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor:
                                isEnabled('Exceptions') ? blueDark : grey,
                            minimumSize: Size(0.25 * width, 0.09 * height),
                            maximumSize: Size(0.25 * width, 0.09 * height),
                            shadowColor: const Color.fromARGB(255, 0, 0, 0),
                            elevation: 5,
                          ),
                          child: const Align(
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                'Level 5',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                      Stack(children: [
                        // button
                        SizedBox(
                          width: 0.25 * width,
                          height: 0.13 * height,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: lightGrey,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(147, 46, 46, 80),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                )
                              ],
                            ),
                            child: const Align(
                              alignment: Alignment(0, 0.84),
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  'Formal',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: blueDark,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: isEnabled('Formal')
                              ? () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) {
                                      return const QuizScreen(
                                          quizName: "Formal", saveData: false);
                                    }),
                                  );
                                }
                              : () {
                                  disabledMessage("Formal");
                                },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor:
                                isEnabled('Formal') ? blueDark : grey,
                            minimumSize: Size(0.25 * width, 0.09 * height),
                            maximumSize: Size(0.25 * width, 0.09 * height),
                            shadowColor: const Color.fromARGB(255, 0, 0, 0),
                            elevation: 5,
                          ),
                          child: const Align(
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                'Level 6',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ]),
              ],
            ),

            ///
            ///
            /// Advanced
            ///
            ExpansionTile(
              childrenPadding: const EdgeInsets.only(top: 12, bottom: 12),
              title: const Text(
                'Advanced',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              collapsedBackgroundColor: blueGrey,
              collapsedIconColor: lightGrey,
              collapsedTextColor: lightGrey,
              backgroundColor: blueGreyLight,
              iconColor: blueDark,
              textColor: blueDark,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Stack(children: [
                        // button
                        SizedBox(
                          width: 0.25 * width,
                          height: 0.13 * height,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: lightGrey,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(147, 46, 46, 80),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                )
                              ],
                            ),
                            child: const Align(
                              alignment: Alignment(0, 0.84),
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  'Idioms',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: blueDark,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: isEnabled('Idioms')
                              ? () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) {
                                      return const QuizScreen(
                                          quizName: "Idioms", saveData: false);
                                    }),
                                  );
                                }
                              : () {
                                  disabledMessage("Idioms");
                                },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor:
                                isEnabled('Idioms') ? blueDark : grey,
                            minimumSize: Size(0.25 * width, 0.09 * height),
                            maximumSize: Size(0.25 * width, 0.09 * height),
                            shadowColor: const Color.fromARGB(255, 0, 0, 0),
                            elevation: 5,
                          ),
                          child: const Align(
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                'Level 7',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                      Stack(children: [
                        // button
                        SizedBox(
                          width: 0.25 * width,
                          height: 0.13 * height,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: lightGrey,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(147, 46, 46, 80),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                )
                              ],
                            ),
                            child: const Align(
                              alignment: Alignment(0, 0.84),
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  'Analysis',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: blueDark,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: isEnabled('Analysis')
                              ? () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) {
                                      return const QuizScreen(
                                          quizName: "Analysis",
                                          saveData: false);
                                    }),
                                  );
                                }
                              : () {
                                  disabledMessage("Analysis");
                                },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor:
                                isEnabled('Analysis') ? blueDark : grey,
                            minimumSize: Size(0.25 * width, 0.09 * height),
                            maximumSize: Size(0.25 * width, 0.09 * height),
                            shadowColor: const Color.fromARGB(255, 0, 0, 0),
                            elevation: 5,
                          ),
                          child: const Align(
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                'Level 8',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                      Stack(children: [
                        // button
                        SizedBox(
                          width: 0.25 * width,
                          height: 0.13 * height,
                          child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: lightGrey,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: const [
                                BoxShadow(
                                  color: Color.fromARGB(147, 46, 46, 80),
                                  spreadRadius: 1,
                                  blurRadius: 10,
                                )
                              ],
                            ),
                            child: const Align(
                              alignment: Alignment(0, 0.84),
                              child: FittedBox(
                                fit: BoxFit.fitWidth,
                                child: Text(
                                  'Fluent',
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: blueDark,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: isEnabled('Fluent')
                              ? () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) {
                                      return const QuizScreen(
                                          quizName: "Fluent", saveData: false);
                                    }),
                                  );
                                }
                              : () {
                                  disabledMessage("Fluent");
                                },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            backgroundColor:
                                isEnabled('Fluent') ? blueDark : grey,
                            minimumSize: Size(0.25 * width, 0.09 * height),
                            maximumSize: Size(0.25 * width, 0.09 * height),
                            shadowColor: const Color.fromARGB(255, 0, 0, 0),
                            elevation: 5,
                          ),
                          child: const Align(
                            child: FittedBox(
                              fit: BoxFit.fitWidth,
                              child: Text(
                                'Level 9',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 21,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]),
                    ]),
              ],
            ),
          ]),
        ),
      ),
    ]);
    // return SingleChildScrollView(
    //   child: Column(children: [
    //     const SizedBox(
    //       // spacing inbetween rows
    //       height: 20,
    //     ),
    //     ElevatedButton(
    //       onPressed: () {
    //         Navigator.of(context).push(
    //           MaterialPageRoute(builder: (BuildContext context) {
    //             return const QuizScreen(quizName: 'Daily Quiz', saveData: true);
    //           }),
    //         );
    //       },
    //       style: ElevatedButton.styleFrom(
    //         backgroundColor: const Color(0xFF2E2E50),
    //         fixedSize: Size(0.9 * width, 0.3 * height),
    //       ),
    //       child: Stack(children: [
    //         Container(
    //             height: 30,
    //             width: double.infinity,
    //             padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
    //             child: const Text(
    //               'Daily Problem',
    //             ))
    //       ]),
    //     ),
    //     const SizedBox(
    //       // spacing inbetween rows
    //       height: 20,
    //     ),
    //     Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
    //       ElevatedButton(
    //         onPressed: () async {
    //           if ((levelProgress >= await getLevelIndex('Level 1'))) {
    //             Navigator.of(context).push(
    //               MaterialPageRoute(builder: (BuildContext context) {
    //                 return const QuizScreen(
    //                     quizName: 'Level 1', saveData: false);
    //               }),
    //             );
    //           }
    //         },
    //         style: ElevatedButton.styleFrom(
    //             backgroundColor: const Color(0xFF2E2E50),
    //             minimumSize: Size(0.38 * width, 0.2 * height)),
    //         child: const Text('Level 1'),
    //       ),
    //       ElevatedButton(
    //         onPressed: () async{
    //           if((levelProgress >= await getLevelIndex('Level 1'))){
    //             Navigator.of(context).push(
    //                   MaterialPageRoute(builder: (BuildContext context) {
    //                     return const QuizScreen(
    //                         quizName: 'Level 2', saveData: false);
    //                   }),
    //                 );
    //           }
    //               },
    //         style: ElevatedButton.styleFrom(
    //           backgroundColor: const Color(0xFF2E2E50),
    //           minimumSize: Size(0.38 * width, 0.2 * height),
    //         ),
    //         child: const Text('Level 2'),
    //       ),
    //     ]),
    //     const SizedBox(
    //       // spacing inbetween rows
    //       height: 20,
    //     ),
    //     Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
    //       ElevatedButton(
    //         onPressed: (levelProgress >= 3)
    //             ? () {
    //                 Navigator.of(context).push(
    //                   MaterialPageRoute(builder: (BuildContext context) {
    //                     return const QuizScreen(
    //                         quizName: 'Level 3', saveData: false);
    //                   }),
    //                 );
    //               }
    //             : null,
    //         style: ElevatedButton.styleFrom(
    //             backgroundColor: const Color(0xFF2E2E50),
    //             minimumSize: Size(0.38 * width, 0.2 * height)),
    //         child: const Text('Level 3'),
    //       ),
    //       ElevatedButton(
    //         onPressed: (levelProgress >= 4)
    //             ? () {
    //                 Navigator.of(context).push(
    //                   MaterialPageRoute(builder: (BuildContext context) {
    //                     return const QuizScreen(
    //                         quizName: 'Level 4', saveData: false);
    //                   }),
    //                 );
    //               }
    //             : null,
    //         style: ElevatedButton.styleFrom(
    //             backgroundColor: const Color(0xFF2E2E50),
    //             minimumSize: Size(0.38 * width, 0.2 * height)),
    //         child: const Text('Level 4'),
    //       ),
    //     ]),
    //     const SizedBox(
    //       // spacing inbetween rows
    //       height: 20,
    //     ),
    //     Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
    //       ElevatedButton(
    //         onPressed: (levelProgress >= 5)
    //             ? () {
    //                 Navigator.of(context).push(
    //                   MaterialPageRoute(builder: (BuildContext context) {
    //                     return const QuizScreen(
    //                         quizName: 'Level 5', saveData: false);
    //                   }),
    //                 );
    //               }
    //             : null,
    //         style: ElevatedButton.styleFrom(
    //             backgroundColor: const Color(0xFF2E2E50),
    //             minimumSize: Size(0.38 * width, 0.2 * height)),
    //         child: const Text('Level 5'),
    //       ),
    //       ElevatedButton(
    //         onPressed: (levelProgress >= 6)
    //             ? () {
    //                 Navigator.of(context).push(
    //                   MaterialPageRoute(builder: (BuildContext context) {
    //                     return const QuizScreen(
    //                         quizName: 'Level 6', saveData: false);
    //                   }),
    //                 );
    //               }
    //             : null,
    //         style: ElevatedButton.styleFrom(
    //             backgroundColor: const Color(0xFF2E2E50),
    //             minimumSize: Size(0.38 * width, 0.2 * height)),
    //         child: const Text('Level 6'),
    //       ),
    //     ]),
    //     const SizedBox(
    //       // spacing inbetween rows
    //       height: 20,
    //     ),
    //     Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
    //       ElevatedButton(
    //         onPressed: (levelProgress >= 7)
    //             ? () {
    //                 Navigator.of(context).push(
    //                   MaterialPageRoute(builder: (BuildContext context) {
    //                     return const QuizScreen(
    //                         quizName: 'Level 7', saveData: false);
    //                   }),
    //                 );
    //               }
    //             : null,
    //         style: ElevatedButton.styleFrom(
    //             backgroundColor: const Color(0xFF2E2E50),
    //             minimumSize: Size(0.38 * width, 0.2 * height)),
    //         child: const Text('Level 7'),
    //       ),
    //       ElevatedButton(
    //         onPressed: (levelProgress >= 8)
    //             ? () {
    //                 Navigator.of(context).push(
    //                   MaterialPageRoute(builder: (BuildContext context) {
    //                     return const QuizScreen(
    //                         quizName: 'Level 8', saveData: false);
    //                   }),
    //                 );
    //               }
    //             : null,
    //         style: ElevatedButton.styleFrom(
    //             backgroundColor: const Color(0xFF2E2E50),
    //             minimumSize: Size(0.38 * width, 0.2 * height)),
    //         child: const Text('Level 8'),
    //       ),
    //     ]),
    //     const SizedBox(
    //       // spacing inbetween rows
    //       height: 20,
    //     ),
    //     Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
    //       ElevatedButton(
    //         onPressed: (levelProgress >= 9)
    //             ? () {
    //                 Navigator.of(context).push(
    //                   MaterialPageRoute(builder: (BuildContext context) {
    //                     return const QuizScreen(
    //                         quizName: 'Level 9', saveData: false);
    //                   }),
    //                 );
    //               }
    //             : null,
    //         style: ElevatedButton.styleFrom(
    //             backgroundColor: const Color(0xFF2E2E50),
    //             minimumSize: Size(0.38 * width, 0.2 * height)),
    //         child: const Text('Level 9'),
    //       ),
    //       ElevatedButton(
    //         onPressed: (levelProgress >= 10)
    //             ? () {
    //                 Navigator.of(context).push(
    //                   MaterialPageRoute(builder: (BuildContext context) {
    //                     return const QuizScreen(
    //                         quizName: 'Level 10', saveData: false);
    //                   }),
    //                 );
    //               }
    //             : null,
    //         style: ElevatedButton.styleFrom(
    //             backgroundColor: const Color(0xFF2E2E50),
    //             minimumSize: Size(0.38 * width, 0.2 * height)),
    //         child: const Text('Level 10'),
    //       ),
    //     ]),
    //     const SizedBox(
    //       // spacing inbetween rows
    //       height: 20,
    //     ),
    //   ]),
    // );
  }
}
