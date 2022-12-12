part of 'recording_bloc.dart';

abstract class RecordingEvent extends Equatable {
  const RecordingEvent();

  @override
  List<Object> get props => [];
}

class RecordingOnSearchEvent extends RecordingEvent {}

class RecordingGetAllFavoritesEvent extends RecordingEvent {}

class RecordingRemoveFavoriteEvent extends RecordingEvent {
  final String id;

  RecordingRemoveFavoriteEvent({required this.id});

  @override
  List<Object> get props => [this.id];
}

class RecordingSaveFavoritesEvent extends RecordingEvent {
  final String artist;
  final String name;
  final String listnLink;
  final String image;

  // Just save the necessary details for "Favorite" display
  RecordingSaveFavoritesEvent(
      {required this.artist,
      required this.name,
      required this.listnLink,
      required this.image});

  @override
  List<Object> get props =>
      [this.artist, this.name, this.listnLink, this.image];
}