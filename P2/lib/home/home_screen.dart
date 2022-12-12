import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica2/bloc/auth_bloc/auth_logic_bloc.dart';
import 'package:practica2/bloc/song_bloc/recording_bloc.dart';
import 'package:practica2/favorites/favorite_screen.dart';
import 'package:practica2/foundSong/foundScreen.dart';
import 'package:avatar_glow/avatar_glow.dart';

class homeScreen extends StatefulWidget {
  homeScreen({Key? key}) : super(key: key);

  @override
  State<homeScreen> createState() => _homeScreenState();
}

var avatarGlowOn = false;

class _homeScreenState extends State<homeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(children: [
      Container(height: 70),
      Text(
        "Toque para escuchar",
        style: const TextStyle(fontSize: 20),
      ),
      Container(
        height: 100,
      ),
      BlocConsumer<RecordingBloc, RecordingState>(builder: (context, state) {
        return Container();
      }, listener: (context, state) {
        if (state is RecordingFoundState) {
          setState(() {
            avatarGlowOn = false;
          });
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => foundScreen(
                      album: state.album,
                      spotifyLink: state.spotifyLink,
                      appleMusicLink: state.appleMusicLink,
                      artist: state.artist,
                      image: state.image,
                      date: state.date,
                      listnLink: state.listnLink,
                      name: state.name)));
        } else if (state is FavoritesLoadedState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => favoriteScreen(query: state.query)));
        } else if (state is RecordingNotRecognizedState) {
          setState(() {
            avatarGlowOn = false;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                    "No se encontró la canción! Asegurate de no tener ruido de fondo y que la canción a identificar tenga volumen alto"),
              ),
            );
          });
        }
      }),
      AvatarGlow(
        endRadius: 165,
        repeat: true,
        animate: avatarGlowOn,
        glowColor: Colors.white,
        showTwoGlows: true,
        child: RawMaterialButton(
          onPressed: () {
            BlocProvider.of<RecordingBloc>(context).add(RecordingOnSearchEvent());
          },
          elevation: 3.33,
          fillColor: Colors.white,
          child: Image.asset(
            'assets/images/icon.png',
            height: 200,
            width: 200,
          ),
          shape: CircleBorder(),
        ),
      ),
      SizedBox(height: 100),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: () {
              BlocProvider.of<RecordingBloc>(context)
                  .add(RecordingGetAllFavoritesEvent());
            },
            elevation: 3.33,
            fillColor: Colors.white,
            child: Icon(Icons.favorite, color: Colors.black),
            shape: CircleBorder(),
          ),
          RawMaterialButton(
            onPressed: () {
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Cerrar sesión'),
                  content: const Text(
                      'Al cerrar sesión de su cuenta será redirigido a la pantalla de Log In, ¿Quiere continuar?',
                      textAlign: TextAlign.justify),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'Cancelar'),
                      child: const Text('Cancelar'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context, 'Cerrar sesión');
                        BlocProvider.of<AuthBloc>(context).add(SignOutEvent());
                      },
                      child: const Text('Cerrar sesión'),
                    ),
                  ],
                ),
              );
            },
            elevation: 3.33,
            fillColor: Colors.white,
            child: Icon(Icons.logout, color: Colors.black),
            shape: CircleBorder(),
          ),
        ],
      )
    ])));
  }
}
