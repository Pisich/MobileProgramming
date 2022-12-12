part of 'auth_logic_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object> get props => [];
}

class GoogleAuthEvent extends AuthEvent {}

class SignOutEvent extends AuthEvent {}
