import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class FavoriteSongComponent extends StatelessWidget {
  const FavoriteSongComponent({super.key});

  Future<void> _alertDialog(context) {
    return showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
                title: Text('Ver canción'),
                content: Text(
                    '¿Quieres continuar a ver los detalles de la canción?'),
                actions: <Widget>[
                  TextButton(
                      child: Text('Atrás'),
                      onPressed: () => Navigator.pop(context, 'Cancelar')),
                  TextButton(
                      child: Text('Continuar'),
                      onPressed: () async {
                        await launchUrl(Uri.parse('https://lis.tn/Warriors'));
                        Navigator.pop(context);
                      })
                ]));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Positioned(
                child: GestureDetector(
              child: Placeholder(), // Cambiar a Image.network(artwork_link)
              onTap: () => {_alertDialog(context)},
            )),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Center(
                child: GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color:
                              Theme.of(context).primaryColor.withOpacity(0.85),
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(25),
                              bottomLeft: Radius.circular(5),
                              bottomRight: Radius.circular(5))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              "songTitle",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "artistName",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  onTap: () => {_alertDialog(context)},
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: IconButton(
                  icon: Icon(FontAwesomeIcons.heart), onPressed: () {}),
            ),
          ],
        ),
      ),
    );
  }
}
