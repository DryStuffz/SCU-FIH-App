import 'package:flutter/material.dart';

class DailyProblem extends StatefulWidget {
  const DailyProblem({super.key});

  @override
  State<DailyProblem> createState() => _DailyProblemState();
}

class _DailyProblemState extends State<DailyProblem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('This is the Daily Probelm'),
      ),
      body: const Center(child: Text('Daily Problem')),
    );
  }
}
