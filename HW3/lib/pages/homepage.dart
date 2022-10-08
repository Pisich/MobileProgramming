// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tarea3/pages/bloc/books_bloc.dart';
import 'package:tarea3/pages/preview_book_component.dart';
import 'package:tarea3/pages/shimmer_component.dart';
import 'bloc/books_bloc.dart';

class HomePage extends StatelessWidget {
  var search_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Libreria free to play'),
          backgroundColor: Color.fromARGB(255, 66, 66, 66),
        ),
        body: BlocConsumer<BooksBloc, BooksState>(
          listener: ((context, state) {}),
          builder: ((context, state) {
            if (state is BooksInitial)
              return _defaultView(context);
            else if (state is BooksLoadingState)
              return _loadingView(context);
            else if (state is BooksResultState)
              return _booksView(context);
            else
              return _defaultView(context);
          }),
        ));
  }

  Widget _defaultView(BuildContext context) {
    return Container(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: search_controller,
                onSubmitted: (String val) {
                  BlocProvider.of<BooksBloc>(context)
                      .add(BooksSearchEvent(search_controller.text));
                },
                cursorColor: Colors.grey,
                decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey)),
                    border: OutlineInputBorder(),
                    labelText: "Ingresa Título",
                    suffixIcon: Icon(Icons.search)),
              ),
            )),
            Container(
              height: 350,
              child: Center(
                child: Text(
                  "Ingresa el título de un libro",
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ]),
    );
  }

  Widget _loadingView(BuildContext context) {
    return Container(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: search_controller,
            cursorColor: Colors.grey,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey)),
                border: OutlineInputBorder(),
                labelText: "Ingresa Título",
                suffixIcon: Icon(Icons.search)),
          ),
        )),
        Container(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ShimmerComponent(width: 110, height: 170),
                    ),
                    Shimmer.fromColors(
                        baseColor: Colors.black,
                        highlightColor: Colors.grey,
                        child: Text("Loading..."))
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ShimmerComponent(width: 110, height: 170),
                    ),
                    Shimmer.fromColors(
                        baseColor: Colors.black,
                        highlightColor: Colors.grey,
                        child: Text("Loading..."))
                  ],
                )
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ShimmerComponent(width: 110, height: 170),
                      ),
                      Shimmer.fromColors(
                          baseColor: Colors.black,
                          highlightColor: Colors.grey,
                          child: Text("Loading..."))
                    ],
                  ),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ShimmerComponent(width: 110, height: 170),
                      ),
                      Shimmer.fromColors(
                          baseColor: Colors.black,
                          highlightColor: Colors.grey,
                          child: Text("Loading..."))
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ]),
    );
  }

  Widget _booksView(BuildContext context) {
    return Container(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: search_controller,
            cursorColor: Colors.grey,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.grey)),
                border: OutlineInputBorder(),
                labelText: "Ingresa Título",
                suffixIcon: Icon(Icons.search)),
          ),
        )),
        Expanded(
            child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 16),
          scrollDirection: Axis.vertical,
          itemCount: context.read<BooksBloc>().getResultList.length,
          itemBuilder: (BuildContext context, index) {
            return PreviewBookComponent(
                bookObj: context.read<BooksBloc>().getResultList[index]);
          },
        )),
      ],
    ));
  }
}
