part of 'play_audio_bloc.dart';

@immutable
abstract class PlayAudioEvent {}

class PlayAudio extends PlayAudioEvent{}

class stopAudio extends PlayAudioEvent{}
