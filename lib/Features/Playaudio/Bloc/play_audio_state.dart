part of 'play_audio_bloc.dart';

@immutable
abstract class PlayAudioState {}

class PlayAudioInitial extends PlayAudioState {}

class StartPlayingAudioState extends PlayAudioState{}

class AudioStoppedState extends PlayAudioState{}