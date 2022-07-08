import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/screens/email_password/bloC/signUpBloC/signup_event.dart';
import 'package:firebase_flutter/screens/email_password/bloC/signUpBloC/signup_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  SignUpBloc() : super(SignUpInitialState()) {
    on<SignUpTextValueChangeEvent>((event, emit) {
      if (event.emailValue == '' || event.emailValue.isEmpty) {
        emit(SignUpFormErrorState('Please enter email address'));
      } else if (event.passwordValue.length < 8) {
        emit(SignUpFormErrorState('Please enter passwords'));
      } else if (event.passwordValue != event.conformPasswordValue) {
        emit(SignUpFormErrorState('Password not match'));
      } else {
        emit(SignUpFormValidState());
      }
    });

    on<SignUpSubmitEvent>((event, emit) async {
      emit(SignUpFormLoadingState());
      try {
        final UserCredential newUser =
            await _auth.createUserWithEmailAndPassword(
                email: event.email, password: event.conformPassword);
        if (newUser.user != null) {
          emit(SignUpSuccessState('User created successfully'));
        }
      } on FirebaseAuthException catch (e) {
        emit(SignUpErrorState(e.message.toString()));
      }
    });
  }
}
