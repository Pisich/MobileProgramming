import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';

part 'song_event.dart';
part 'song_state.dart';

class SongBloc extends Bloc<SongEvent, SongState> {
  final record = Record();
  SongBloc() : super(SongInitial()) {
    on<SongAudioEvent>(_findSong);
  }

  FutureOr<void> _findSong(SongAudioEvent event, emit) async {
    emit(WritingAudioState());

    await _recordMp3Song();
    emit(SuccessWritingState());

    var _mp3File = await getApplicationDocumentsDirectory();
    var _requestApi = await post(Uri.parse('https://api.audd.io/recognize'),
        headers: <String, String>{
          'api_token': "58680a5681eb37d3684ab921f8aadceb",
          'file': _mp3File.path,
        });

    emit(IdentifiedSuccessState(body: _requestApi.body));
  }

  Future<bool> _requestStoragePermission() async {
    var storagePermission = await Permission.storage.status;
    if (storagePermission == PermissionStatus.denied)
      await Permission.storage.request();

    return storagePermission == PermissionStatus.granted;
  }

  Future<void> _recordMp3Song() async {
    if (!await _requestStoragePermission() || !await record.hasPermission()) {
      throw FileSystemException();
    }

    final app_dir_path = await getApplicationDocumentsDirectory();
    await record.start(path: '${app_dir_path.path}/send_song.mp3');

    Timer(Duration(seconds: 8), () async {
      await record.stop();
    });
  }
}
