import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica2/bloc/song_bloc/recording_bloc.dart';

import '../home/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class foundScreen extends StatefulWidget {
  final String artist;
  final String name;
  final String date;
  final String album;
  final String spotifyLink;
  final String appleMusicLink;
  final String listnLink;
  final String image;
  foundScreen(
      {Key? key,
      required this.artist,
      required this.name,
      required this.date,
      required this.album,
      required this.spotifyLink,
      required this.appleMusicLink,
      required this.listnLink,
      required this.image})
      : super(key: key);

  @override
  State<foundScreen> createState() => _foundScreenState();
}

class _foundScreenState extends State<foundScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text("Here you go"),
          actions: [
            BlocConsumer<RecordingBloc, RecordingState>(
                builder: (context, state) {
              return Container();
            }, listener: (context, state) {
              if (state is FavoriteAlreadyExistsState) {
                showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Favorito ya existe'),
                    content: const Text(
                        'La canción que eligio ya se encuentra en su lista de favoritos!'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'OK'),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              }
            }),
            RawMaterialButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text("Se agregó la canción a tu lista de Favoritos!"),
                  ),
                );
                BlocProvider.of<RecordingBloc>(context).add(
                    RecordingSaveFavoritesEvent(
                        artist: widget.artist,
                        name: widget.name,
                        listnLink: widget.listnLink,
                        image: widget.image));
              },
              elevation: 3.35,
              child: Icon(Icons.favorite, color: Colors.white),
            )
          ],
          leading: IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => homeScreen()));
              },
              icon: const Icon(Icons.arrow_back))),
      body: Center(
          child: ListView(
        children: [
          Image.network(
            widget.image,
            fit: BoxFit.contain,
          ),
          Container(
            height: MediaQuery.of(context).size.height *
                .3, // A third of the screen
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
            ),
            child: Center(
              child: Column(
                children: [
                  Text(
                    widget.name,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    widget.album,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    widget.artist,
                    style: TextStyle(fontSize: 20),
                  ),
                  Text(
                    widget.date,
                    style: TextStyle(fontSize: 20),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15),
            child: Center(
              child: Text(
                "Abrir con",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 25),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                    iconSize: 50,
                    onPressed: () async {
                      await launchUrl(Uri.parse(widget.spotifyLink));
                    },
                    icon: Image.asset("assets/images/spotifyIcon.png")),
                IconButton(
                    iconSize: 50,
                    onPressed: () async {
                      await launchUrl(Uri.parse(widget.listnLink));
                    },
                    icon: Icon(Icons.music_note)),
                IconButton(
                    iconSize: 50,
                    onPressed: () async {
                      await launchUrl(Uri.parse(widget.appleMusicLink));
                    },
                    icon: Image.asset("assets/images/appleIcon.png")),
              ],
            ),
          )
        ],
      )),
    );
  }
}
