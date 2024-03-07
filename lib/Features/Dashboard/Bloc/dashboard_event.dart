part of 'dashboard_bloc.dart';

@immutable
abstract class DashboardEvent {}

class DashboardLoadingEvent extends DashboardEvent{}

class DashboardInitialEvent extends DashboardEvent{
  List<ExerciseCategory> exerciseCategory = [];
  DashboardInitialEvent({required this.exerciseCategory});

}

class exerciseCateoryClickedEvent extends DashboardEvent{
  List<Exercise> exercisesRelatedToCategory = [];
  exerciseCateoryClickedEvent({required this.exercisesRelatedToCategory});



}

