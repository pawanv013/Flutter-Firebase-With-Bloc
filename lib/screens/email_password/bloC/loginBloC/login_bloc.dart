import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginBloc() : super(LoginInitialState()) {
    on<LoginTextChangeEvent>((event, emit) {
      if (event.loginEmailValue == '' || event.loginEmailValue.isEmpty) {
        emit(LoginFormErrorState('Enter email address'));
      } else if (event.loginPasswordValue == '' ||
          event.loginPasswordValue.isEmpty) {
        emit(LoginFormErrorState('Enter password'));
      } else {
        emit(LoginFormValidState());
      }
    });

    on<LoginSubmitEvent>((event, emit) async {
      emit(LoginLoadingState());
      try {
        final UserCredential user = await _auth.signInWithEmailAndPassword(
            email: event.loginEmail, password: event.loginPassword);

        if (user.user != null) {
          emit(LoginSuccessState('Login Successfully'));
        }
      } on FirebaseAuthException catch (e) {
        emit(LoginErrorState(e.message.toString()));
      }
    });
  }
}
