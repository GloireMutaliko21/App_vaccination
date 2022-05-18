import 'dart:async' show Stream;

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:v_connect/app/source/data_source.dart';

part 'login_event.dart';
part 'login_state.dart';

//ici ce pour l'excution
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    //Ici on appel l'evenemenet qu'on va execute
    if (event is LoginSing) {
      yield LoginProgress(); //ici on test la progression
      var resultat = await DataSource.getInstance
          .sendData(elements: {event.username, event.password});
      if (resultat) {
        yield LoginSucces();
      } else {
        yield LoginFailed();
      }
    } // Facilement test bcp de truc je suis d'entre de vous monte comment ca marche
  }
}
