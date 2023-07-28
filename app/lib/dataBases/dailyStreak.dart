// daily_streak_manager.dart
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DailyStreakManager {
  final String _boxName = 'daily_streak_box';
  final String _keyStreak = 'daily_streak';
  final String _keyLastDate = 'last_date';
  final String _keymaxStreak = "max_streak";

  int _dailyStreak = 0;
  //int get dailyStreak => _dailyStreak;

  //DateTime get lastDate => _lastDate;

  int getStreak() {
    return Hive.box(_boxName).get(_keyStreak) ?? 0;
  }

  int getMaxStreak() {
    print(Hive.box(_boxName).get(_keymaxStreak));
    return Hive.box(_boxName).get(_keymaxStreak) ?? 0;
  }

  void updateStreak() {
    print("CALLED");
    final now = DateTime.now();
    final box = Hive.box(_boxName);
    _dailyStreak = box.get(_keyStreak, defaultValue: 0);
    int maxStreak = box.get(_keymaxStreak, defaultValue: 0);
    DateTime lastDate = box.get(_keyLastDate);

    //print(lastDate);
    // ignore: unnecessary_null_comparison
    // final box = Hive.box(_boxName);
    // box.put(_keyLastDate, now.subtract(new Duration(days: 1)));
    // box.put(_keyStreak, 0);
    //print(now.subtract(new Duration(days: 1)));

    //if the previous date was there
    if (_isSameDay(now.subtract(const Duration(days: 1)), lastDate)) {
      _dailyStreak++;

      box.put(_keyStreak, _dailyStreak);
      box.put(_keyLastDate, now);
     
    }
    //If its the same day, do nothing
    else if (_isSameDay(now, lastDate)) {

    }
    //set the streak back to 1
    else {
      _dailyStreak++;

      box.put(_keyStreak, _dailyStreak);
      box.put(_keyLastDate, now);
      
    }

    if (maxStreak < _dailyStreak) {
      
        maxStreak = _dailyStreak;
        box.put(_keymaxStreak, maxStreak);
    }


  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
