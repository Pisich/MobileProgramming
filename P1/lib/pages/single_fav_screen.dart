import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleFavScreen extends StatelessWidget {
  final String songTitle, albumTitle, artistName, publishDate;

  const SingleFavScreen(
      {super.key,
      required this.songTitle,
      required this.albumTitle,
      required this.artistName,
      required this.publishDate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Here you go'),
          actions: [Icon(FontAwesomeIcons.heart)],
        ),
        body: Center(
          child: Column(
            children: [
              Placeholder(), // Cambiar a Image.network
              SizedBox(height: 50),
              Text(songTitle,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0)),
              Text(albumTitle,
                  style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 18.0)),
              Text(artistName, style: TextStyle(fontSize: 16.0)),
              Text(publishDate, style: TextStyle(fontSize: 16.0)),
              SizedBox(height: 30),
              Divider(),
              Text('Abrir con:'),
              SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(FontAwesomeIcons.spotify),
                    iconSize: 48,
                    tooltip: 'Ver en Spotify',
                    onPressed: () async {
                      await launchUrl(Uri.parse(
                          'https://open.spotify.com/album/20r762YmB5HeofjMCiPMLv'));
                    },
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.podcast),
                    iconSize: 48,
                    tooltip: 'Ver links',
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.apple),
                    iconSize: 48,
                    tooltip: 'Ver en Apple Music',
                    onPressed: () {},
                  )
                ],
              )
            ],
          ),
        ));
  }
}
