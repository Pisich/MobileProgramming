import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:practica2/bloc/auth_bloc/auth_logic_bloc.dart';
import 'package:practica2/bloc/song_bloc/recording_bloc.dart';
import 'package:practica2/home/home_screen.dart';
import 'authentication/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc()..add(GoogleAuthEvent()),
        ),
        BlocProvider(
          create: (context) => RecordingBloc(),
        ),
      ],
      child: FindTrackApp(),
    ),
  );
}

class FindTrackApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FindTrackApp',
      home: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Usuario no autenticado"),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthSuccessState) {
            return homeScreen();
          }
          return loginScreen();
        },
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.dark,
    );
  }
}
