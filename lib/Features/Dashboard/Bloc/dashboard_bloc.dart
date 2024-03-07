import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../Data/Models/ExerciseCategory.dart';
import '../../../Data/Models/exercise.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(DashboardInitial()) {
    on<DashboardInitialEvent>(_dashboardLoaded);
    on<exerciseCateoryClickedEvent>(_categoryClicked);
  }

  FutureOr<void> _dashboardLoaded(DashboardInitialEvent event, Emitter<DashboardState> emit) {
    print("ok");
    emit(DashboardLoaded(categories: event.exerciseCategory));
  }


  FutureOr<void> _categoryClicked(exerciseCateoryClickedEvent event, Emitter<DashboardState> emit) {
    print("emitting the state");
  emit(LoadExercises(exercisesRelatedToCategory: event.exercisesRelatedToCategory));

  }
}
