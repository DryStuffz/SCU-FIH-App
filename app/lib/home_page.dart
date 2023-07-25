// ignore_for_file: prefer_const_constructors
import 'package:app/quizzes/getQuizzes.dart';
import 'package:app/quizzes/questionIndex.dart';
import 'package:app/quizzes/quizScreen.dart';
import 'package:app/quizzes/getQuizzes.dart';
import 'package:app/constants/colors.dart';
import 'package:app/dataBases/db_connect.dart';
import 'package:app/quizzes/quizScreen.dart';
import 'package:app/quizzes/question_model.dart';
import 'package:flutter/material.dart';
import 'package:app/level1.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<Quiz> dq = getFirebaseData();
    double height =
        MediaQuery.of(context).size.height; //get the height of the screen
    double width =
        MediaQuery.of(context).size.width; //get the width of the screen

    return Align(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Column(children: [
          const SizedBox(
            // spacing inbetween rows
            height: 20,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (BuildContext context) {
                  return Container();
                }),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: blueDark,
              fixedSize: Size(0.9 * width, 0.3 * height),
            ),
            child: Stack(children: [
              Container(
                  height: 30,
                  width: double.infinity,
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: const Text(
                    'Daily Problem',
                  ))
            ]),
          ),
          const SizedBox(
            // spacing inbetween rows
            height: 20,
          ),
          ExpansionTile(
            childrenPadding: EdgeInsets.only(top: 12, bottom: 12),
            title: Text(
              'Beginner',
              style: TextStyle(
                fontSize: 18,
                color: blueDark,
              ),
            ),
            backgroundColor: lightGrey,
            collapsedBackgroundColor: blueGreyLight,
            iconColor: blueGrey,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Stack(children: [
                  // button
                  SizedBox(
                    width: 0.25 * width,
                    height: 0.13 * height,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 180, 180, 213),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(147, 46, 46, 80),
                            spreadRadius: 1,
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: Align(
                        alignment: Alignment(0, 0.79),
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
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return Container();
                        }),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: blueDark,
                      minimumSize: Size(0.25 * width, 0.09 * height),
                      maximumSize: Size(0.25 * width, 0.09 * height),
                      shadowColor: Color.fromARGB(255, 0, 0, 0),
                      elevation: 10,
                    ),
                    child: Align(
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
                ]),
                Stack(children: [
                  // button
                  SizedBox(
                    width: 0.25 * width,
                    height: 0.13 * height,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 180, 180, 213),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(147, 46, 46, 80),
                            spreadRadius: 1,
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: Align(
                        alignment: Alignment(0, 0.79),
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
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return Container();
                        }),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: blueDark,
                      minimumSize: Size(0.25 * width, 0.09 * height),
                      maximumSize: Size(0.25 * width, 0.09 * height),
                      shadowColor: Color.fromARGB(255, 0, 0, 0),
                      elevation: 10,
                    ),
                    child: Align(
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
                ]),
                Stack(children: [
                  // button
                  SizedBox(
                    width: 0.25 * width,
                    height: 0.13 * height,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 180, 180, 213),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(147, 46, 46, 80),
                            spreadRadius: 1,
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: Align(
                        alignment: Alignment(0, 0.79),
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
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return Container();
                        }),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: blueDark,
                      minimumSize: Size(0.25 * width, 0.09 * height),
                      maximumSize: Size(0.25 * width, 0.09 * height),
                      shadowColor: Color.fromARGB(255, 0, 0, 0),
                      elevation: 10,
                    ),
                    child: Align(
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
                ]),
              ]),
            ],
          ),

          ///
          ///   INTERMEDIATE
          ///
          ExpansionTile(
            childrenPadding: EdgeInsets.only(top: 12, bottom: 12),
            title: Text(
              'Intermediate',
              style: TextStyle(
                fontSize: 18,
                color: blueDark,
              ),
            ),
            backgroundColor: lightGrey,
            collapsedBackgroundColor: blueGreyLight,
            iconColor: blueGrey,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Stack(children: [
                  // button
                  SizedBox(
                    width: 0.25 * width,
                    height: 0.13 * height,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 180, 180, 213),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(147, 46, 46, 80),
                            spreadRadius: 1,
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: Align(
                        alignment: Alignment(0, 0.79),
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
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return Container();
                        }),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: blueDark,
                      minimumSize: Size(0.25 * width, 0.09 * height),
                      maximumSize: Size(0.25 * width, 0.09 * height),
                      shadowColor: Color.fromARGB(255, 0, 0, 0),
                      elevation: 10,
                    ),
                    child: Align(
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
                ]),
                Stack(children: [
                  // button
                  SizedBox(
                    width: 0.25 * width,
                    height: 0.13 * height,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 180, 180, 213),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(147, 46, 46, 80),
                            spreadRadius: 1,
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: Align(
                        alignment: Alignment(0, 0.79),
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
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return Container();
                        }),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: blueDark,
                      minimumSize: Size(0.25 * width, 0.09 * height),
                      maximumSize: Size(0.25 * width, 0.09 * height),
                      shadowColor: Color.fromARGB(255, 0, 0, 0),
                      elevation: 10,
                    ),
                    child: Align(
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
                ]),
                Stack(children: [
                  // button
                  SizedBox(
                    width: 0.25 * width,
                    height: 0.13 * height,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 180, 180, 213),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(147, 46, 46, 80),
                            spreadRadius: 1,
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: Align(
                        alignment: Alignment(0, 0.79),
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
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return Container();
                        }),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: blueDark,
                      minimumSize: Size(0.25 * width, 0.09 * height),
                      maximumSize: Size(0.25 * width, 0.09 * height),
                      shadowColor: Color.fromARGB(255, 0, 0, 0),
                      elevation: 10,
                    ),
                    child: Align(
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
                ]),
              ]),
            ],
          ),

          ///
          ///
          /// Advanced
          ///
          ExpansionTile(
            childrenPadding: EdgeInsets.only(top: 12, bottom: 12),
            title: Text(
              'Advanced',
              style: TextStyle(
                fontSize: 18,
                color: blueDark,
              ),
            ),
            backgroundColor: lightGrey,
            collapsedBackgroundColor: blueGreyLight,
            iconColor: blueGrey,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                Stack(children: [
                  // button
                  SizedBox(
                    width: 0.25 * width,
                    height: 0.13 * height,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 180, 180, 213),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(147, 46, 46, 80),
                            spreadRadius: 1,
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: Align(
                        alignment: Alignment(0, 0.79),
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
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return Container();
                        }),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: blueDark,
                      minimumSize: Size(0.25 * width, 0.09 * height),
                      maximumSize: Size(0.25 * width, 0.09 * height),
                      shadowColor: Color.fromARGB(255, 0, 0, 0),
                      elevation: 10,
                    ),
                    child: Align(
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
                ]),
                Stack(children: [
                  // button
                  SizedBox(
                    width: 0.25 * width,
                    height: 0.13 * height,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 180, 180, 213),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(147, 46, 46, 80),
                            spreadRadius: 1,
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: Align(
                        alignment: Alignment(0, 0.79),
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
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return Container();
                        }),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: blueDark,
                      minimumSize: Size(0.25 * width, 0.09 * height),
                      maximumSize: Size(0.25 * width, 0.09 * height),
                      shadowColor: Color.fromARGB(255, 0, 0, 0),
                      elevation: 10,
                    ),
                    child: Align(
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
                ]),
                Stack(children: [
                  // button
                  SizedBox(
                    width: 0.25 * width,
                    height: 0.13 * height,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 180, 180, 213),
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: const [
                          BoxShadow(
                            color: Color.fromARGB(147, 46, 46, 80),
                            spreadRadius: 1,
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: Align(
                        alignment: Alignment(0, 0.79),
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
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (BuildContext context) {
                          return Container();
                        }),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      backgroundColor: blueDark,
                      minimumSize: Size(0.25 * width, 0.09 * height),
                      maximumSize: Size(0.25 * width, 0.09 * height),
                      shadowColor: Color.fromARGB(255, 0, 0, 0),
                      elevation: 10,
                    ),
                    child: Align(
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
                ]),
              ]),
            ],
          ),
        ]),
      ),
    );
  }
}
