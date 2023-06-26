import 'package:app/Test.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (BuildContext context) {
              return const Test();
            }),
          );
        },
        height: 300,
        child: const Text('Daily Problem'),
      ),
    );
  }
}
