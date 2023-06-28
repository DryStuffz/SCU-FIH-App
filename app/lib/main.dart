import 'package:app/home_page.dart';
import 'package:app/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:app/test.dart';
import 'package:app/settings.dart';

void main() => runApp(const FluentFocusApp());

class FluentFocusApp extends StatelessWidget {
  const FluentFocusApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, //remove debugger flag
      theme: ThemeData(primarySwatch: Colors.green //appbar theme
          ),
      home: const SplashScreen(),
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
    HomePage(),
    Test(),
  ];

  void tappedPage(int index) {
    setState(() {
      indexpage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7E7E7),
      appBar: AppBar(
        title: const Text('Fluent Focus'),
        backgroundColor: const Color(0xFF4A4E69),
      ),
      body: Center(
        child: indexPageOptions.elementAt(indexpage),
      ),
      drawer: const SettingsDrawer(),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
        ],
        currentIndex: indexpage,
        selectedItemColor: const Color(0xFF4A4E69),
        backgroundColor: const Color(0xFFF8F7F7),
        onTap: tappedPage,
      ),
    );
  }
}
