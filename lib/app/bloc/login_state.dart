part of 'login_bloc.dart';

//pour les etats
@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginLoaded extends LoginState {}

class LoginIsEmpty extends LoginState {}

class LoginFailed extends LoginState {}

class LoginConnected extends LoginState {}

class LoginProgress extends LoginState {}

class LoginSucces extends LoginState {}
