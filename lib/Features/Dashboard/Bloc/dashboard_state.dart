part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardState {}

abstract class DashboardActionState extends DashboardState{}

class DashboardInitial extends DashboardState{}

class DashboardLoaded extends DashboardState {
  List<ExerciseCategory> categories = [];
  DashboardLoaded({required this.categories});
}

class LoadExercises extends DashboardActionState{
  List<Exercise> exercisesRelatedToCategory = [];
  LoadExercises({required this.exercisesRelatedToCategory});
}




