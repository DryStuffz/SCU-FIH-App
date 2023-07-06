import 'package:flutter/material.dart';
import 'package:app/constants/colors.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({Key? key}) : super(key: key);

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        AppBar(
          backgroundColor: blueGrey,
          title: const Text('Help'),
        ),
      ],
    );
  }
}
