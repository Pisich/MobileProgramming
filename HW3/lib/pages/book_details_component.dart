import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';

class BookDetailsComponent extends StatelessWidget {
  final bookObj;
  const BookDetailsComponent({super.key, this.bookObj});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 66, 66, 66),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(FontAwesomeIcons.globe),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                  icon: Icon(FontAwesomeIcons.share),
                  onPressed: () {
                    Share.share(bookObj["preview"]);
                  }),
            )
          ],
          title: Text("Detalles del libro"),
        ),
        body: Center(
          child: Column(
            children: [
              Image.network(
                bookObj["image"],
                height: 260,
              ),
              Text(bookObj["title"],
                  style: TextStyle(fontStyle: FontStyle.italic, fontSize: 20)),
              Divider(
                color: Colors.white,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    bookObj["date"],
                    textAlign: TextAlign.left,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Páginas: ${bookObj['pageCount']}",
                  textAlign: TextAlign.left,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(bookObj["description"],
                    style: TextStyle(fontStyle: FontStyle.italic)),
              )
            ],
          ),
        ));
  }
}
