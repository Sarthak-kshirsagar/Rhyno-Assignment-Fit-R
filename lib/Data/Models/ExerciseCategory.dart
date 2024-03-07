import 'package:sub1/Data/Models/exercise.dart';


//class for exercises , it contains the list of exercises corresponding to classes
class ExerciseCategory {
  String? categoryName;
  String? imagePath;
  int? ExercisesCount;
  String? totalTime;
  List<Exercise> categoryWiseExercise = [];

  ExerciseCategory(
      {required this.categoryName,
      required this.imagePath,
      required this.categoryWiseExercise,
      required this.ExercisesCount,
      required this.totalTime});
}

//Exercises associated with category
List<Exercise> chestExercise = [
  Exercise(exerciseName: "Bench Press", exerciseGif: "assets/bench-gif.gif"),
  Exercise(exerciseName: "Cross Cable", exerciseGif: "assets/cabelCross-gi.gif"),
  Exercise(exerciseName: "Flys", exerciseGif: "assets/flys-gif.gif"),
];

List<Exercise> LegsExercise = [
  Exercise(exerciseName: "Leg Press", exerciseGif: "assets/leg-press-gif.gif"),
  Exercise(exerciseName: "Barbell Lift", exerciseGif: "assets/barbell-gif.gif"),
  Exercise(exerciseName: "Squat", exerciseGif: "assets/squat-gif.gif"),
];

List<Exercise> Yoga = [
  Exercise(exerciseName: "Vajrasana", exerciseGif: "assets/vajrasana.gif"),
  Exercise(exerciseName: "Vir-Bhadra", exerciseGif: "assets/vir-bhadra-gif.gif"),
  Exercise(exerciseName: "Balasana", exerciseGif: "assets/balasana.gif"),
  Exercise(exerciseName: "Triangle Pose", exerciseGif: "assets/trainglePose-gif.gif"),

];

List<ExerciseCategory> listone = [
  ExerciseCategory(
      categoryName: "Chest",
      imagePath: "assets/chest.png",
      categoryWiseExercise: chestExercise,ExercisesCount: 3,totalTime:"30 min"),
  ExerciseCategory(
      categoryName: "Legs",
      imagePath: "assets/leg.png",
      categoryWiseExercise: LegsExercise,ExercisesCount: 4,totalTime: "30min"),

];

// List<ExerciseCategory> legs = [
//   ExerciseCategory(
//       categoryName: "Legs",
//       imagePath: "Legs image",
//       categoryWiseExercise: LegsExercise)
// ];
