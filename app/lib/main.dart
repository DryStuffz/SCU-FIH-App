import 'package:app/home_page.dart';
import 'package:flutter/material.dart';
import 'package:app/test.dart';

void main() => runApp(const FluentFocusApp());

class FluentFocusApp extends StatelessWidget {
  const FluentFocusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //remove debugger flag
      theme: ThemeData(primarySwatch: Colors.green //appbar theme
          ),
      home: const RootPage(),
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int indexpage = 0;
  static const List<Widget> indexPageOptions = <Widget>[
    Test(),
    HomePage(),
    Text(
      'Index 2: School',
    ),
  ];

  void tappedPage(int index) {
    setState(() {
      indexpage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fluent Focus'),
      ),
      body: Center(
        child: indexPageOptions.elementAt(indexpage),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'Settings'),
        ],
        currentIndex: indexpage,
        selectedItemColor: const Color(0xFF2E2E50),
        backgroundColor: const Color(0xFFF8F7F7),
        onTap: tappedPage,

      ),
    );
  }
}
