import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

final FlutterTts flutterTts = FlutterTts();

Future<void> speakText(String text) async {
  await flutterTts.setLanguage("en-US"); // Set the language (you can change it based on your requirement).
  await flutterTts.setPitch(0.75); // Set the pitch (range from 0.5 to 2.0).
  await flutterTts
      .setSpeechRate(0.45); // Set the speech rate (range from 0.0 to 2.0).
  await flutterTts.speak(text);
  await flutterTts.setVolume(1);
}
