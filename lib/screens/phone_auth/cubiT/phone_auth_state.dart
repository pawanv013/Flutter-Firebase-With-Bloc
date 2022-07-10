import 'package:firebase_auth/firebase_auth.dart';

abstract class PhoneAuthState {}

class PhoneAuthInitialState extends PhoneAuthState {}

class PhoneAuthLoadingState extends PhoneAuthState {}

class PhoneAuthErrorState extends PhoneAuthState {
  late String phoneAuthErrorMessage;
  PhoneAuthErrorState(this.phoneAuthErrorMessage);
}

class PhoneAuthCodeSentState extends PhoneAuthState {}

class PhoneAuthCodeVerifiedState extends PhoneAuthState {}

class PhoneAuthLoggedInState extends PhoneAuthState {
  late final User firebaseUser;
  PhoneAuthLoggedInState(this.firebaseUser);
}

class PhoneAuthLoggedOutState extends PhoneAuthState {}
