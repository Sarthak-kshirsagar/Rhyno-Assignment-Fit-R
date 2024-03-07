import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'play_audio_event.dart';
part 'play_audio_state.dart';

class PlayAudioBloc extends Bloc<PlayAudioEvent, PlayAudioState> {
  PlayAudioBloc() : super(PlayAudioInitial()) {
    on<PlayAudio>(_startPlayingAudio);
    on<stopAudio>(_stopPlayingAudio);

  }

  FutureOr<void> _startPlayingAudio(PlayAudio event, Emitter<PlayAudioState> emit) {
  print("starting to play the audio");
  emit(StartPlayingAudioState());

  }

  FutureOr<void> _stopPlayingAudio(stopAudio event, Emitter<PlayAudioState> emit) {
  emit(AudioStoppedState());
  }

}
