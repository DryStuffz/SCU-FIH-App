import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Test Page'),
        ),
        body: Column(
          children: [
            Image.asset('assets/images/image.png'),
            const SizedBox(height: 10),
            const Divider(color: Colors.red),
            Container(
              color: Colors.green,
              width: double.infinity,
              height: 100,
              child: const Text(
                "This is a text widget!",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ));
  }
}
