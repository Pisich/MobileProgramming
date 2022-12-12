import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica1/pages/result_screen.dart';

import 'pages/bloc/song_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Material App',
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.purple,
            appBarTheme:
                AppBarTheme(backgroundColor: Color.fromARGB(255, 76, 76, 76))),
        theme: ThemeData(
            brightness: Brightness.dark,
            primaryColor: Colors.purple,
            appBarTheme:
                AppBarTheme(backgroundColor: Color.fromARGB(255, 76, 76, 76))),
        home: MultiBlocProvider(providers: [
          BlocProvider<SongBloc>(create: (BuildContext context) => SongBloc())
        ], child: ResultScreen()));
  }
}
