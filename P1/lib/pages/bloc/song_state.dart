part of 'song_bloc.dart';

abstract class SongState extends Equatable {
  const SongState();

  @override
  List<Object> get props => [];
}

class SongInitial extends SongState {}

class WritingAudioState extends SongState {}

class SuccessWritingState extends SongState {}

class IdentifiedSuccessState extends SongState {
  final String body;

  IdentifiedSuccessState({required this.body});

  @override
  List<Object> get props => [body];
}
