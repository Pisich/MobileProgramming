import 'package:flutter/material.dart';
import 'package:tarea3/pages/book_details_component.dart';

class PreviewBookComponent extends StatelessWidget {
  final bookObj;
  const PreviewBookComponent({super.key, this.bookObj});

  @override
  Widget build(BuildContext context) {
    String f = "";
    if (bookObj["title"].length < 30)
      f = bookObj["title"];
    else
      f = bookObj["title"].substring(0, 30) + "...";
    return Container(
        child: Column(
      children: [
        Image.network(
          bookObj["image"],
          height: 120,
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              BookDetailsComponent(bookObj: bookObj)));
                },
                child: Text(
                  f,
                  style: TextStyle(fontWeight: FontWeight.bold),
                )))
      ],
    ));
  }
}
