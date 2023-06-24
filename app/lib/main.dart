import 'package:flutter/material.dart';

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
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fluent Focus'),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            debugPrint('Floating Action Button');
          },
          child: const Icon(Icons.book_online_rounded)),
      bottomNavigationBar: NavigationBar(
        destinations:const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Search'),
        
        ],
        onDestinationSelected:(int index){
          setState(() {
            currentPage = index;
          });
          
        } ,
        selectedIndex: currentPage,
      ),
    );
  }
}
