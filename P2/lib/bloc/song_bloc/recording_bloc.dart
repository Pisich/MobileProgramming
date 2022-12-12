import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:practica2/favorites/songClass.dart';
import 'package:practica2/home/Audd_repository.dart';
import 'package:record/record.dart';

part 'recording_event.dart';
part 'recording_state.dart';

class RecordingBloc extends Bloc<RecordingEvent, RecordingState> {
  final record = Record();
  RecordingBloc() : super(RecordingInitialState()) {
    on<RecordingOnSearchEvent>(_onSearch);
    on<RecordingSaveFavoritesEvent>(_saveFavorite);
    on<RecordingGetAllFavoritesEvent>(_getFavorites);
    on<RecordingRemoveFavoriteEvent>(_deleteFavorite);
  }

  FutureOr<void> _onSearch(RecordingOnSearchEvent event, emit) async {
    await record.hasPermission();

    await record.start();
    await Future.delayed(Duration(seconds: 4));
    final String? path = await record.stop();

    final String bytesFile = base64Encode(File(path!).readAsBytesSync());

    final response = await SongRecognitionHttpRepo().findSong(bytesFile);

    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);

      if (res["status"] == "success" && res["result"] != null) {
        emit(RecordingFoundState(
            artist: res["result"]['artist'],
            name: res["result"]['title'],
            date: res["result"]['release_date'],
            album: res["result"]['album'],
            spotifyLink: res["result"]['spotify']['external_urls']['spotify'],
            appleMusicLink: res["result"]['apple_music']['url'],
            listnLink: res["result"]['song_link'],
            image: res['result']['spotify']['album']['images'][0]['url']));
      } else {
        print("Ocurrió un error, no se encontró la canción");
        emit(RecordingNotRecognizedState());
      }
    }
  }

  FutureOr<void> _saveFavorite(RecordingSaveFavoritesEvent event, emit) async {
    var collection = FirebaseFirestore.instance.collection('favoriteSongs');
    var querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> datos = queryDocumentSnapshot.data();
      var name = datos['titulo'];
      if (name == event.name) {
        print("Ya se encuentra en tu lista!");
        emit(FavoriteAlreadyExistsState());
      }
    }
    var response =
        await FirebaseFirestore.instance.collection("favoriteSongs").add({
      "artista": event.artist,
      "imagen": event.image,
      "link": event.listnLink,
      "titulo": event.name
    });
    final user = await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    var favoriteArray = user.data()!["favorites"];
    if (!favoriteArray.contains(response.id)) {
      favoriteArray.add(response.id);
    }
    await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'favorites': favoriteArray});
  }

  _getFavorites(RecordingGetAllFavoritesEvent event, emit) {
    final usersQuery = FirebaseFirestore.instance
        .collection('favoriteSongs')
        .withConverter<Song>(
          fromFirestore: (snapshot, _) => Song.fromJson(snapshot.data()!),
          toFirestore: (song, _) => song.toJson(),
        );
    print(usersQuery);
    emit(FavoritesLoadedState(query: usersQuery));
  }

  FutureOr<void> _deleteFavorite(RecordingRemoveFavoriteEvent event, emit) async {
    final user = await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    var favorites = user.data()!["favorites"];
    favorites.remove(event.id);

    await FirebaseFirestore.instance
        .collection("user")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'favorites': favorites});
    await FirebaseFirestore.instance
        .collection("favoriteSongs")
        .doc(event.id)
        .delete();
  }
}
