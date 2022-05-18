part of 'login_bloc.dart';

//pour les evenement
@immutable
abstract class LoginEvent {}

class LoginSing extends LoginEvent {
  final username;
  final password;
  LoginSing({this.username, this.password});
}
