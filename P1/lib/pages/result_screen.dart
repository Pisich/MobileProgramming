import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica1/pages/favorite_screen.dart';

import 'bloc/song_bloc.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SongBloc, SongState>(
          listener: ((context, state) {}),
          builder: ((context, state) {
            if (state is WritingAudioState)
              return _recordingView(context);
            else if (state is SuccessWritingState)
              return _resultLoad();
            else
              return _defaultView(context);
          })),
    );
  }

  Widget _defaultView(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 220,
            child: Center(
              child: Text("Toque para escuchar",
                  textAlign: TextAlign.center, style: TextStyle(fontSize: 18)),
            ),
          ),
          Container(
            height: 300,
            child: Center(
              child: AvatarGlow(
                  glowColor: Theme.of(context).primaryColor,
                  endRadius: 90.0,
                  repeat: true,
                  showTwoGlows: true,
                  child: CircleAvatar(
                    child: IconButton(
                      icon: Icon(FontAwesomeIcons.music),
                      onPressed: () {
                        BlocProvider.of<SongBloc>(context)
                            .add(SongAudioEvent());
                      },
                    ),
                    radius: 70,
                  )),
            ),
          ),
          Container(
            child: Center(
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircleAvatar(
                      child: IconButton(
                    icon: Icon(FontAwesomeIcons.heart),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FavoriteScreen()));
                    },
                  )),
                ),
                Text("Ver favoritos")
              ]),
            ),
          )
        ],
      ),
    );
  }

  Widget _recordingView(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Padding(
          padding: EdgeInsets.only(top: 80, bottom: 80),
          child: Text('Escuchando',
              style: Theme.of(context).textTheme.headlineSmall),
        ),
        AvatarGlow(
          endRadius: 90,
          glowColor: Theme.of(context).primaryColor,
          child: CircleAvatar(child: Icon(FontAwesomeIcons.music), radius: 70),
        ),
        SizedBox(
          height: 40,
        )
      ]),
    );
  }

  Widget _resultLoad() {
    return Center(
      child: Container(child: Text('Cargando resultado')),
    );
  }
}
