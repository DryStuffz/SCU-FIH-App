import 'package:app/dataBases/dailyStreak.dart';
import 'package:app/dataBases/hive.dart';
import 'package:app/home_page.dart';
import 'package:app/constants/colors.dart';
import 'package:app/level1.dart';
import 'package:app/screens/splash_screen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:app/settings.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/adapters.dart';
import 'firebase_options.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(ListDataAdapter());
  await Hive.openBox<ListData>('DailyScoresList');
  await Hive.openBox("daily_streak_box");
  runApp(const FluentFocusApp());
}

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
  List<Widget> indexPageOptions = <Widget>[
    MyHomePage(),
    const Level1(),
  ];

  void tappedPage(int index) {
    setState(() {
      indexpage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: const Text('Fluent Focus'),
        backgroundColor: blueDark,
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
        unselectedItemColor: blueGreyLight,
        selectedItemColor: const Color(0xFFFFFFFF),
        backgroundColor: blueDark,
        onTap: tappedPage,
      ),
    );
  }
}
