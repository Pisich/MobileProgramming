import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:equatable/equatable.dart';
import 'dart:async';
import 'package:practica2/authentication/auth_logic.dart';
part 'auth_logic_state.dart';
part 'auth_logic_event.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  UserAuthRepository _authRepo = UserAuthRepository();
  AuthBloc() : super(AuthInitialState()) {
    on<GoogleAuthEvent>(_authUser);
    on<SignOutEvent>(_signOut);
  }

  FutureOr<void> _signOut(event, emit) async {
    if (FirebaseAuth.instance.currentUser!.isAnonymous) {
      await _authRepo.signOutFirebaseUser();
    } else {
      await _authRepo.signOutGoogleUser();
      await _authRepo.signOutFirebaseUser();
    }
    emit(SignOutSuccessState());
  }

  FutureOr<void> _authUser(event, emit) async {
    emit(AuthAwaitingState());
    try {
      await _authRepo.signInWithGoogle();
      emit(AuthSuccessState());
    } catch (e) {
      print("Error al autenticar: $e");
      emit(AuthErrorState());
    }
  }
}
