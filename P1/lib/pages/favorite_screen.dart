import 'package:flutter/material.dart';
import 'package:practica1/pages/component_favorite_song.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Canciones favoritas')),
      body: ListView(
        children: [
          FavoriteSongComponent(),
          FavoriteSongComponent(),
          FavoriteSongComponent()
        ],
      ),
    );
  }
}
