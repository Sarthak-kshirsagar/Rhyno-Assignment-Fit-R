// import 'package:flutter/foundation.dart';
//
// class ExerciseTrack extends ChangeNotifier {
//   List<String> completedExercises = [];
//
//   void addToCompletedExercise(String exerciseName) {
//     completedExercises.add(exerciseName);
//     notifyListeners();
//   }
// }


import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ExerciseTrack extends ChangeNotifier {
  Map<String, List<String>> completedExercisesByDate = {};

  ExerciseTrack() {
    // Load completed exercises from shared preferences during initialization
    print("inside constructor of exercise track");
    _loadCompletedExercises();
  }

  void addToCompletedExercise(String exerciseName) {
    // Get the current date in a formatted string
    String currentDate = _getCurrentFormattedDate();

    // Add the exercise to the list for the current date
    completedExercisesByDate.putIfAbsent(currentDate, () => []);
    completedExercisesByDate[currentDate]!.add(exerciseName);

    // Save the updated list to shared preferences
    _saveCompletedExercises();
    notifyListeners();
  }

  List<String> getCompletedExercisesForDate(String date) {
    return completedExercisesByDate[date] ?? [];
  }

  String _getCurrentFormattedDate() {
    DateTime now = DateTime.now();
    return DateFormat('yyyy-MM-dd').format(now);
  }

  Future<void> _loadCompletedExercises() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedData = prefs.getString('completedExercisesByDate');

    if (storedData != null) {
      try {
        Map<String, dynamic> decodedData = jsonDecode(storedData);

        if (decodedData is Map<String, dynamic>) {
          completedExercisesByDate = decodedData.map(
                (key, value) {
              if (value is List<dynamic>) {
                return MapEntry(key, List<String>.from(value.cast<String>()));
              }
              return MapEntry(key, <String>[]);
            },
          );
          notifyListeners();
        } else {
          print('Error: Decoded data has unexpected type: $decodedData');
        }
      } catch (e) {
        print('Error decoding and casting data: $e');
      }
    }
  }



  Future<void> _saveCompletedExercises() async {
    // Save the completed exercises to shared preferences
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('completedExercisesByDate', jsonEncode(completedExercisesByDate));
  }
}

