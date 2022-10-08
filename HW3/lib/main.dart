import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarea3/pages/bloc/books_bloc.dart';
import 'package:tarea3/pages/homepage.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Libreria free to play',
        home: BlocProvider(
          create: (context) => BooksBloc(),
          child: HomePage(),
        ));
  }
}
