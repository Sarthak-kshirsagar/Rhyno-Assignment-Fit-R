import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'show_progress_event.dart';
part 'show_progress_state.dart';

class ShowProgressBloc extends Bloc<ShowProgressEvent, ShowProgressState> {
  ShowProgressBloc() : super(ShowProgressInitial()) {
    on<addExerciseToDashboardEvent>(_addExerciseToDashobard);
  }

  FutureOr<void> _addExerciseToDashobard(addExerciseToDashboardEvent event, Emitter<ShowProgressState> emit) {
  print("inside to add the exercise");

  emit(AddExerciseToDashboardState());

  }
}
