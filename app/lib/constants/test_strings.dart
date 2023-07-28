import "package:app/constants/colors.dart";
import "package:flutter/material.dart";

class CustomTextStyle {
  static const TextStyle confirm = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    fontFamily: 'Inter',
    color: netral,
  );

}

const String completedQuestions = "data.json";
const String levelIndex = "unlockedLevels.json";
const int questionsPerLevel = 20;


const String dailyBoxName = 'DailyScoresList';
const String boxName = 'daily_streak_box';
const String keyStreak = 'daily_streak';
const String keyLastDate = 'last_date';
const String keymaxStreak = "max_streak";
const String keyGamesPlayed = "games_played"; 
const String keyGamesWon = "games_won"; 



String levelPrefix(String qName) {
      String level = "";
      switch (qName) {
        case "Communication":
          level = "Vocab";
        case "Future/Past":
          level = "Communication";
        case "Comparative":
          // Code to execute if variable matches value2
          level = "Future/Past";
        case "Exceptions":
          // Code to execute if variable matches value2
          level = "Comparative";
        case "Idioms":
          // Code to execute if variable matches value2
          level = "Exceptions";
        case "Formal":
          // Code to execute if variable matches value2
          level = "Idioms";
        case "Analysis":
          // Code to execute if variable matches value2
          level = "Formal";
        case "Fluent":
          // Code to execute if variable matches value2
          level = "Analysis";

        default:
          // Code to execute if variable doesn't match any of the cases above
          level = "Error";
      }

      return level;

    }