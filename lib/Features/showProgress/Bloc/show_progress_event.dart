part of 'show_progress_bloc.dart';

@immutable
abstract class ShowProgressEvent {}

class addExerciseToDashboardEvent extends ShowProgressEvent{
  String? ExerciseName;
  addExerciseToDashboardEvent({required this.ExerciseName});

}
