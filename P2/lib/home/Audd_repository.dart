import 'package:http/http.dart' as http;
import 'package:practica2/home/secret.dart';

class SongRecognitionHttpRepo {
  findSong(String bytesfile) async {
    return await http.post(Uri.parse('https://api.audd.io/'), body: {
      'api_token': api_key,
      'audio': bytesfile,
      'return': "lyrics, apple_music, spotify"
    });
  }
}
